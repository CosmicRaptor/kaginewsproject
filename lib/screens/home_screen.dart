import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/widgets/home_widget.dart';
import 'package:kaginewsproject/widgets/onthisday_widget.dart';
import 'package:kaginewsproject/widgets/shimmer_loader_home_screen.dart';
import '../providers/api_provider.dart';
import '../providers/storage_providers.dart';
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
    final userSavedCategories = ref.watch(getSavedCategoriesProvider);

    return userSavedCategories.when(
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
          length: data.length,
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
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.push('/settings', extra: data);
                        },
                        icon: Icon(Icons.settings),
                      ),
                    ],
                    title: Text(l10n.appNameShort),
                    pinned: true,
                    floating: true,
                    snap: true,
                    bottom: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: List.generate(data.length, (index) {
                        final categoryName = data[index].name;
                        return Tab(text: categoryName);
                      }),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: List.generate(data.length, (index) {
                  if (!_loadedTabs.contains(index)) {
                    // Updates after current frame has finished displaying
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _loadedTabs.add(index);
                      });
                    });
                    return ShimmerLoaderHomeScreen(loadAppBar: false);
                  }

                  final categoryName = data[index].file;
                  final categoryAsync =
                      categoryName != "onthisday.json"
                          ? ref.watch(getCategoryProvider(categoryName))
                          : ref.watch(getOnThisDayProvider);

                  return categoryAsync.when(
                    loading:
                        () => const ShimmerLoaderHomeScreen(loadAppBar: false),
                    error: (e, _) {
                      return Center(child: Text(l10n.errorOccured));
                    },
                    data: (detail) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: haptics,
                        child:
                            categoryName != "onthisday.json"
                                ? HomeWidget(
                                  detail: detail as NewsCategoryDetail,
                                )
                                : OnthisdayWidget(events: detail as OnThisDay),
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
