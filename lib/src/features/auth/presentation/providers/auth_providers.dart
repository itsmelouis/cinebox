import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/observe_auth_state.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_github.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../viewmodels/login_viewmodel.dart';

// ============================================
// Data Source Providers
// ============================================

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthRemoteDataSourceImpl(supabaseClient);
});

// ============================================
// Repository Providers
// ============================================

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// ============================================
// Use Case Providers
// ============================================

final getCurrentUserProvider = Provider<GetCurrentUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUser(repository);
});

final observeAuthStateProvider = Provider<ObserveAuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return ObserveAuthState(repository);
});

final signInWithGitHubProvider = Provider<SignInWithGitHub>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithGitHub(repository);
});

final signInWithEmailProvider = Provider<SignInWithEmail>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithEmail(repository);
});

final signUpWithEmailProvider = Provider<SignUpWithEmail>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpWithEmail(repository);
});

final signOutProvider = Provider<SignOut>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignOut(repository);
});

final deleteAccountProvider = Provider<DeleteAccount>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return DeleteAccount(repository);
});

// ============================================
// Auth State Provider
// ============================================

/// Stream provider for authentication state
/// Returns UserEntity when authenticated, null when not
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final observeAuthState = ref.watch(observeAuthStateProvider);
  return observeAuthState();
});

/// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.asData?.value != null;
});

/// Provider to get current user (synchronous)
final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.asData?.value;
});

// ============================================
// ViewModel Providers
// ============================================

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final signInWithGitHub = ref.watch(signInWithGitHubProvider);

  return LoginViewModel(
    signInWithGitHub: signInWithGitHub,
  );
});
