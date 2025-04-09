import 'package:go_router/go_router.dart';
import 'models/category_articles_stuff.dart';
import 'screens/home_screen.dart';
import 'screens/news_screen.dart';

final routerConf = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'news',
          builder: (context, state) {
            final cluster = state.extra as NewsCluster;
            return NewsScreen(cluster: cluster);
          },
        ),
      ],
    ),
  ],
);
