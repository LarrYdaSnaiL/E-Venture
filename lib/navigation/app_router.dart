import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
    ],
  );
}
