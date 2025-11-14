import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
}

GoRouter createRouter() {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
        name: "splash",
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
        name: "login",
      ),
      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) {
      //     return BottomNavigationShell(navigationShell: navigationShell);
      //   },
      //   branches: [
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: AppRoutes.home,
      //           name: 'home',
      //           builder: (context, state) => const HomeScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: AppRoutes.favorites,
      //           name: 'favorite',
      //           builder: (context, state) => const FavoriteScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: AppRoutes.profile,
      //           name: 'profile',
      //           builder: (context, state) => const ProfileScreen(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('Path: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    ),
  );
}
