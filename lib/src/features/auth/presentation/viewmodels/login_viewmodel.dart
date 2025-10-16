import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/usecases/sign_in_with_github.dart';

part 'login_viewmodel.freezed.dart';

/// State for Login page
@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
  }) = _LoginState;
}

/// ViewModel for Login page
class LoginViewModel extends StateNotifier<LoginState> {
  final SignInWithGitHub _signInWithGitHub;

  LoginViewModel({
    required SignInWithGitHub signInWithGitHub,
  })  : _signInWithGitHub = signInWithGitHub,
        super(const LoginState());

  /// Sign in with GitHub OAuth
  Future<void> signInWithGitHub() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _signInWithGitHub();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          isSuccess: false,
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
          isSuccess: true,
        );
      },
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
