import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:reorderables/reorderables.dart';

import '../providers/api_provider.dart';
import '../providers/storage_providers.dart';
import '../widgets/shimmer_loader_home_screen.dart';
import '../models/categories_model.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  // We passed in the enabled categories from shared preferences via the home screen
  final List<Category> selectedCats;
  const SettingsScreen({super.key, required this.selectedCats});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Enabled is a copy of selectedCats initially, to allow reorder/removing/adding items
  late List<Category> enabled;
  // Available is the list of all categories, to allow adding items
  late List<Category> available;
  bool initialized = false;

  @override
  void initState() {
    enabled = widget.selectedCats;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ref
        .watch(categoriesProvider)
        .when(
          error:
              (error, stacktrace) => Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          loading: () => ShimmerLoaderHomeScreen(loadAppBar: true),
          data: (data) {
            if (!initialized) {
              available = [];
              for (int i = 0; i < data.categories.length; i++) {
                if (!enabled.contains(data.categories[i])) {
                  available.add(data.categories[i]);
                }
              }

              initialized = true;
            }
            return Scaffold(
              appBar: AppBar(title: Text(l10n.settingsPageTitle)),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Text(
                      l10n.settingsReorderText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),

                    // Reorderable active categories
                    ReorderableWrap(
                      spacing: 8,
                      runSpacing: 8,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          final item = enabled.removeAt(oldIndex);
                          enabled.insert(newIndex, item);
                        });
                        ref.watch(saveCategoriesProvider(enabled));
                        ref.invalidate(getSavedCategoriesProvider);
                      },
                      children:
                          enabled.map((cat) => _buildChip(cat, true)).toList(),
                    ),

                    const SizedBox(height: 24),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          available
                              .map((cat) => _buildChip(cat, false))
                              .toList(),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
  }

  Widget _buildChip(Category cat, bool isEnabled) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isEnabled) {
            enabled.remove(cat);
            available.add(cat);
          } else {
            available.remove(cat);
            enabled.add(cat);
          }
          ref.watch(saveCategoriesProvider(enabled));
          ref.invalidate(getSavedCategoriesProvider);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color:
              isEnabled
                  ? const Color(0xff2676FF)
                  : Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          cat.name,
          style: TextStyle(
            color:
                isEnabled
                    ? Colors.white
                    : Theme.of(context).textTheme.bodySmall!.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
