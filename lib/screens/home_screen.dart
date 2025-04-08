import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import '../providers/api_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final Set<int> _loadedTabs = {};

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _initTabController(int length) {
    _tabController?.dispose();
    _tabController = TabController(length: length, vsync: this);
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) return;

      final currentIndex = _tabController!.index;
      if (!_loadedTabs.contains(currentIndex)) {
        setState(() {
          _loadedTabs.add(currentIndex); // Mark tab as loaded
        });
      }
    });

    // Preload the first tab
    _loadedTabs.add(0);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, stacktrace) => Center(
            child: Text(
              l10n.errorOccured,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      data: (data) {
        if (_tabController == null ||
            _tabController!.length != data.categories.length) {
          _initTabController(data.categories.length);
        }
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return <Widget>[
                SliverAppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 5,
                      height: 5,
                      child: Image.asset(
                        'assets/kagi_logo_yellow.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  title: Text(l10n.appNameShort),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    tabs:
                        data.categories
                            .map((category) => Tab(text: category.name))
                            .toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: List.generate(data.categories.length, (index) {
                if (!_loadedTabs.contains(index)) {
                  // Placeholder before tab is visited
                  return const Center(child: Text("Waiting..."));
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
                      () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text(l10n.errorOccured)),
                  data: (detail) {
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children:
                          detail.clusters.map((cluster) {
                            return Text(
                              cluster.title,
                            ); // Replace with your custom UI
                          }).toList(),
                    );
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
