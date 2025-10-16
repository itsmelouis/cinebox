import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<UserEntity?> authStateChanges() {
    return remoteDataSource.authStateChanges().map(
          (userModel) => userModel?.toEntity(),
        );
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel?.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGitHub() async {
    try {
      final userModel = await remoteDataSource.signInWithGitHub();
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return remoteDataSource.getAccessToken();
  }

  @override
  bool get isAuthenticated => remoteDataSource.isAuthenticated;
}
