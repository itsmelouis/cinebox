import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/media/presentation/pages/home_page.dart';
import '../../features/media/presentation/pages/media_detail_page.dart';
import '../../features/media/presentation/pages/my_list_page.dart';
import '../../features/media/presentation/pages/search_page.dart';
import '../widgets/main_navigation_shell.dart';

/// App router with bottom navigation and public access
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';

      // Only redirect from splash after auth state is loaded
      if (isSplash && authState.hasValue) {
        return '/'; // Go to home after splash
      }

      return null; // No redirect needed - pages handle auth themselves
    },
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Auth route (full screen, no navbar)
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const AuthPage(),
      ),

      // Media detail (full screen, no navbar)
      GoRoute(
        path: '/media/:type/:id',
        name: 'media-detail',
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          final id = int.parse(state.pathParameters['id']!);
          return MediaDetailPage(
            mediaId: id,
            mediaType: type,
          );
        },
      ),

      // Main shell with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),

          // Branch 2: Search
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                name: 'search',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SearchPage(),
                ),
              ),
            ],
          ),

          // Branch 3: My List
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-list',
                name: 'my-list',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: MyListPage(),
                ),
              ),
            ],
          ),

          // Branch 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page non trouvée: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    ),
  );
});
