import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/media_repository.dart';

/// Use case for deleting user media
class DeleteUserMedia {
  final MediaRepository repository;

  DeleteUserMedia(this.repository);

  Future<Either<Failure, void>> call({
    required int mediaId,
    required String mediaType,
  }) {
    return repository.deleteUserMedia(
      mediaId: mediaId,
      mediaType: mediaType,
    );
  }
}
