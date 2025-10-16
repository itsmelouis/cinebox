import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing in with email and password
class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.signInWithEmail(email: email, password: password);
  }
}
