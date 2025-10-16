import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing up with email and password
class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    String? displayName,
  }) {
    return repository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
