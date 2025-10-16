import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_github.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../providers/auth_providers.dart';

/// State for auth operations (loading, success, error)
class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

/// ViewModel for authentication operations
class AuthViewModel extends StateNotifier<AuthState> {
  final SignInWithGitHub _signInWithGitHub;
  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final SignOut _signOut;

  AuthViewModel(
    this._signInWithGitHub,
    this._signInWithEmail,
    this._signUpWithEmail,
    this._signOut,
  ) : super(const AuthState());

  /// Sign in with GitHub OAuth
  Future<void> signInWithGitHub() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _signInWithGitHub();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.when(
            network: (msg) => msg ?? 'Network error',
            server: (code, msg) => msg ?? 'Server error',
            cache: (msg) => msg ?? 'Cache error',
            auth: (msg) => msg ?? 'Authentication failed',
            unexpected: (msg) => msg ?? 'Unexpected error',
            validation: (msg) => msg,
          ),
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          successMessage: 'Welcome ${user.name}!',
        );
      },
    );
  }

  /// Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    // Validation
    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Email and password are required',
      );
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(
        errorMessage: 'Invalid email format',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _signInWithEmail(email: email, password: password);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.when(
            network: (msg) => msg ?? 'Network error',
            server: (code, msg) => msg ?? 'Server error',
            cache: (msg) => msg ?? 'Cache error',
            auth: (msg) => msg ?? 'Invalid credentials',
            unexpected: (msg) => msg ?? 'Unexpected error',
            validation: (msg) => msg,
          ),
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          successMessage: 'Welcome back ${user.name}!',
        );
      },
    );
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    // Validation
    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Email and password are required',
      );
      return;
    }

    if (!_isValidEmail(email)) {
      state = state.copyWith(
        errorMessage: 'Invalid email format',
      );
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        errorMessage: 'Password must be at least 6 characters',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.when(
            network: (msg) => msg ?? 'Network error',
            server: (code, msg) => msg ?? 'Server error',
            cache: (msg) => msg ?? 'Cache error',
            auth: (msg) => msg ?? 'Sign up failed',
            unexpected: (msg) => msg ?? 'Unexpected error',
            validation: (msg) => msg,
          ),
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          successMessage: 'Account created! Welcome ${user.name}!',
        );
      },
    );
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _signOut();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.when(
            network: (msg) => msg ?? 'Network error',
            server: (code, msg) => msg ?? 'Server error',
            cache: (msg) => msg ?? 'Cache error',
            auth: (msg) => msg ?? 'Sign out failed',
            unexpected: (msg) => msg ?? 'Unexpected error',
            validation: (msg) => msg,
          ),
        );
      },
      (_) {
        state = state.copyWith(
          isLoading: false,
          successMessage: 'Signed out successfully',
        );
      },
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Clear success message
  void clearSuccess() {
    state = state.copyWith(successMessage: null);
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}

/// Provider for AuthViewModel
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final signInWithGitHub = ref.watch(signInWithGitHubProvider);
  final signInWithEmail = ref.watch(signInWithEmailProvider);
  final signUpWithEmail = ref.watch(signUpWithEmailProvider);
  final signOut = ref.watch(signOutProvider);

  return AuthViewModel(
    signInWithGitHub,
    signInWithEmail,
    signUpWithEmail,
    signOut,
  );
});
