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
    // Wait for splash animation (reduced to 500ms)
    await Future.delayed(const Duration(milliseconds: 500));

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
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.red.shade900.withOpacity(0.3),
              Colors.black,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo CineBox
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red.shade600, Colors.red.shade900],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.movie_outlined,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              // Titre avec gradient
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.red.shade400, Colors.red.shade600],
                ).createShader(bounds),
                child: const Text(
                  'CineBox',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Découvrez des milliers de films',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 48),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade600),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
