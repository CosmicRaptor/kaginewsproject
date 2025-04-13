import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void initState() {
    enabled = widget.selectedCats;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            available = data.categories;
            return Scaffold(
              appBar: AppBar(title: const Text('Settings')),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const Text(
                      "Tap to toggle. Drag enabled categories to reorder.",
                      style: TextStyle(color: Colors.white70),
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
                      },
                      children:
                          enabled.map((cat) => _buildChip(cat, true)).toList(),
                    ),

                    const SizedBox(height: 24),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          data.categories
                              .map((cat) => _buildChip(cat, false))
                              .toList(),
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(saveCategoriesProvider(enabled));
                      },
                      child: const Text('Save'),
                    ),
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
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isEnabled ? const Color(0xff2676FF) : Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          cat.name,
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
