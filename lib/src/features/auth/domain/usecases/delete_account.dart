import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for deleting the current user's account
class DeleteAccount {
  final AuthRepository repository;

  DeleteAccount(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.deleteAccount();
  }
}
