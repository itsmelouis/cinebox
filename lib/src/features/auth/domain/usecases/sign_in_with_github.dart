import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing in with GitHub OAuth
class SignInWithGitHub {
  final AuthRepository repository;

  SignInWithGitHub(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.signInWithGitHub();
  }
}
