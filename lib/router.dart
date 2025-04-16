import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'models/categories_model.dart';
import 'providers/storage_providers.dart';
import 'screens/settings_screen.dart';
import 'screens/onboarding_screen.dart';
import 'models/category_articles_stuff.dart';
import 'screens/home_screen.dart';
import 'screens/news_screen.dart';
import 'util/circular_navigation_clipper.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingComplete = ref.watch(getFirstTimeProvider);

  return onboardingComplete.when(
    data: (isFirstTime) {
      return GoRouter(
        initialLocation: isFirstTime ? "/onboarding" : "/",
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              final Offset? origin = state.extra as Offset?;

              return CustomTransitionPage(
                child: const HomeScreen(),
                transitionDuration: const Duration(milliseconds: 1000),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return ClipPath(
                    clipper: CircularRevealClipper(
                      center: origin ?? Offset.zero,
                      fraction: animation.value,
                    ),
                    child: child,
                  );
                },
              );
            },
            routes: [
              GoRoute(
                path: 'news',
                pageBuilder: (context, state) {
                  final cluster = state.extra as NewsCluster;
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: NewsScreen(cluster: cluster),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      const begin = Offset(
                        0.0,
                        1.0,
                      ); // Slide in from the bottom
                      const end = Offset.zero; // End at its final position
                      const curve = Curves.ease;

                      final tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/onboarding',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) {
              final selectedCats = state.extra as List<Category>;
              return SettingsScreen(selectedCats: selectedCats);
            },
          ),
        ],
      );
    },
    error: (error, _) => GoRouter(routes: []),
    loading: () => GoRouter(routes: []),
  );
});
