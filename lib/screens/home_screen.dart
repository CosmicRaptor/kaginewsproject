import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/widgets/news_card.dart';
import 'package:kaginewsproject/widgets/shimmer_loader_home_screen.dart';
import '../providers/api_provider.dart';
import '../util/scroll_haptics.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  final Set<int> _loadedTabs = {};

  @override
  void initState() {
    //Preload the first tab
    _loadedTabs.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      loading: () => const ShimmerLoaderHomeScreen(loadAppBar: true),
      error:
          (error, stacktrace) => Center(
            child: Text(
              l10n.errorOccured,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      data: (data) {
        return DefaultTabController(
          length: data.categories.length,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return <Widget>[
                  SliverAppBar(
                    leading: SizedBox(
                      width: 5,
                      height: 5,
                      child: Image.asset('assets/kite.png', fit: BoxFit.fill),
                    ),
                    title: Text(l10n.appNameShort),
                    pinned: true,
                    floating: true,
                    snap: true,
                    bottom: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs:
                          data.categories
                              .map((category) => Tab(text: category.name))
                              .toList(),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: List.generate(data.categories.length, (index) {
                  if (!_loadedTabs.contains(index)) {
                    // Updates after current frame has finished displaying
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _loadedTabs.add(index);
                      });
                    });
                    return ShimmerLoaderHomeScreen(loadAppBar: false);
                  }

                  final categoryName = data.categories[index].file.replaceAll(
                    ".json",
                    "",
                  );
                  final categoryAsync = ref.watch(
                    getCategoryProvider(categoryName),
                  );

                  return categoryAsync.when(
                    loading:
                        () => const ShimmerLoaderHomeScreen(loadAppBar: false),
                    error: (e, _) => Center(child: Text(l10n.errorOccured)),
                    data: (detail) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: haptics,
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children:
                              detail.clusters
                                  .map(
                                    (cluster) => NewsCard(newsCluster: cluster),
                                  )
                                  .toList(),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
