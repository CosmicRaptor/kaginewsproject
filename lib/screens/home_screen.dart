import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/widgets/home_widget.dart';
import 'package:kaginewsproject/widgets/onthisday_widget.dart';
import 'package:kaginewsproject/widgets/shimmer_loader_home_screen.dart';
import '../providers/viewmodel_providers.dart';
import '../util/scroll_haptics.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vm = ref.watch(homeVMProvider);
    final categoriesAsync = vm.categories;

    return categoriesAsync.when(
      loading: () => const ShimmerLoaderHomeScreen(loadAppBar: true),
      error:
          (error, _) => Center(
            child: Text(
              l10n.errorOccured,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      data:
          (categories) => DefaultTabController(
            length: categories.length,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (_, __) => [
                      SliverAppBar(
                        leading: Image.asset('assets/kite.png'),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed:
                                () => context.push(
                                  '/settings',
                                  extra: categories,
                                ),
                          ),
                        ],
                        title: Text(l10n.appNameShort),
                        pinned: true,
                        floating: true,
                        snap: true,
                        bottom: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          tabs: [
                            for (final category in categories)
                              Tab(text: category.name),
                          ],
                        ),
                      ),
                    ],
                body: TabBarView(
                  children: [
                    for (int index = 0; index < categories.length; index++)
                      _TabContent(
                        index: index,
                        fileName: categories[index].file,
                      ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class _TabContent extends ConsumerWidget {
  final int index;
  final String fileName;

  const _TabContent({required this.index, required this.fileName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeVMProvider);

    if (!vm.loadedTabs.contains(index)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(homeVMProvider.notifier).markTabAsLoaded(index);
      });
      return const ShimmerLoaderHomeScreen(loadAppBar: false);
    }

    final dataAsync = vm.getCategoryData(fileName);

    return dataAsync.when(
      loading: () => const ShimmerLoaderHomeScreen(loadAppBar: false),
      error: (e, _) => Center(child: Text(context.l10n.errorOccured)),
      data: (data) {
        return NotificationListener<ScrollNotification>(
          onNotification: haptics,
          child:
              fileName != "onthisday.json"
                  ? HomeWidget(detail: data as NewsCategoryDetail)
                  : OnthisdayWidget(events: data as OnThisDay),
        );
      },
    );
  }
}
