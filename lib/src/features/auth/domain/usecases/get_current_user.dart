import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for getting current authenticated user
class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, UserEntity?>> call() {
    return repository.getCurrentUser();
  }
}
