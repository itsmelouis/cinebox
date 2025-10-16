import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Stream of authentication state changes
  /// Emits UserEntity when authenticated, null when not authenticated
  Stream<UserEntity?> authStateChanges();

  /// Get current authenticated user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Sign in with GitHub OAuth
  Future<Either<Failure, UserEntity>> signInWithGitHub();

  /// Sign in with email and password (JWT)
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Get current access token (JWT)
  Future<String?> getAccessToken();

  /// Check if user is authenticated
  bool get isAuthenticated;
}
