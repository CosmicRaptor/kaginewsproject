import 'package:go_router/go_router.dart';
import 'package:kaginewsproject/screens/home_screen.dart';

final routerConf = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ]
);