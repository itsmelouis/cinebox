import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Wait for splash animation
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check auth state
    final authState = ref.read(authStateProvider);

    authState.when(
      data: (user) {
        // Navigate based on auth state
        if (user != null) {
          context.go('/');
        } else {
          context.go('/login');
        }
      },
      loading: () {
        // Wait a bit more if still loading
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            context.go('/login');
          }
        });
      },
      error: (_, __) {
        // On error, go to login
        context.go('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie_rounded,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 24),
              Text(
                'CinéBox',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Découvre et gère ta liste de films',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 48),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
