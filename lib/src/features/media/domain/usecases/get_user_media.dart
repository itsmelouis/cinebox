import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_media.dart';
import '../repositories/media_repository.dart';

/// Use case to get a specific user media entry
class GetUserMedia {
  final MediaRepository repository;

  GetUserMedia(this.repository);

  Future<Either<Failure, UserMedia?>> call({
    required int mediaId,
    required String mediaType,
  }) async {
    return await repository.getUserMedia(
      mediaId: mediaId,
      mediaType: mediaType,
    );
  }
}
