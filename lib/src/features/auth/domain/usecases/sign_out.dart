import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing out
class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
