import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

/// App router with authentication guards
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.asData?.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/splash';

      // Protected routes that require authentication
      final protectedRoutes = ['/my-list', '/profile'];
      final isProtectedRoute = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      // If trying to access protected route without auth, redirect to login
      if (isProtectedRoute && !isAuthenticated) {
        return '/login';
      }

      // If authenticated and trying to access auth routes, redirect to home
      if (isAuthenticated && isAuthRoute && state.matchedLocation != '/splash') {
        return '/';
      }

      return null; // No redirect needed
    },
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpPage(),
      ),

      // Home / Discover (public)
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Search (public)
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Search Page - À implémenter par votre collègue'),
          ),
        ),
      ),

      // Media detail (public)
      GoRoute(
        path: '/media/:type/:id',
        name: 'media-detail',
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          final id = int.parse(state.pathParameters['id']!);
          return Scaffold(
            body: Center(
              child: Text('Media Detail Page - Type: $type, ID: $id\nÀ implémenter par votre collègue'),
            ),
          );
        },
      ),

      // My list (protected)
      GoRoute(
        path: '/my-list',
        name: 'my-list',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('My List Page - Protected\nÀ implémenter par votre collègue'),
          ),
        ),
      ),

      // Profile (protected)
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Profile Page - Protected\nÀ implémenter par votre collègue'),
          ),
        ),
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
