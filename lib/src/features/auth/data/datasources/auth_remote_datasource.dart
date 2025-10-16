import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart' as core_exceptions;
import '../models/user_model.dart';

/// Remote data source for authentication using Supabase
abstract class AuthRemoteDataSource {
  Stream<UserModel?> authStateChanges();
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithGitHub();
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });
  Future<void> signOut();
  Future<String?> getAccessToken();
  bool get isAuthenticated;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Stream<UserModel?> authStateChanges() {
    return supabaseClient.auth.onAuthStateChange.map((state) {
      final user = state.session?.user;
      return user != null ? UserModel.fromSupabaseUser(user) : null;
    });
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = supabaseClient.auth.currentUser;
      return user != null ? UserModel.fromSupabaseUser(user) : null;
    } catch (e) {
      throw core_exceptions.AuthException('Failed to get current user: $e');
    }
  }

  @override
  Future<UserModel> signInWithGitHub() async {
    try {
      final response = await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.github,
        redirectTo: 'cinebox://login-callback',
      );

      if (!response) {
        throw core_exceptions.AuthException('GitHub sign in was cancelled or failed');
      }

      // Wait for auth state to update
      await Future.delayed(const Duration(seconds: 1));

      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw core_exceptions.AuthException('No user after GitHub sign in');
      }

      return UserModel.fromSupabaseUser(user);
    } on core_exceptions.AuthException {
      rethrow;
    } catch (e) {
      throw core_exceptions.AuthException('GitHub sign in failed: $e');
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw core_exceptions.AuthException('Sign in failed: No user returned');
      }

      return UserModel.fromSupabaseUser(user);
    } on AuthException catch (e) {
      throw core_exceptions.AuthException('Sign in failed: ${e.message}');
    } catch (e) {
      throw core_exceptions.AuthException('Sign in failed: $e');
    }
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'full_name': displayName} : null,
      );

      final user = response.user;
      if (user == null) {
        throw core_exceptions.AuthException('Sign up failed: No user returned');
      }

      return UserModel.fromSupabaseUser(user);
    } on AuthException catch (e) {
      throw core_exceptions.AuthException('Sign up failed: ${e.message}');
    } catch (e) {
      throw core_exceptions.AuthException('Sign up failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw core_exceptions.AuthException('Sign out failed: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      final session = supabaseClient.auth.currentSession;
      return session?.accessToken;
    } catch (e) {
      return null;
    }
  }

  @override
  bool get isAuthenticated => supabaseClient.auth.currentUser != null;
}
