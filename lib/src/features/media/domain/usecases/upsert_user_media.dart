import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_media.dart';
import '../repositories/media_repository.dart';

/// Use case for adding or updating user media
class UpsertUserMedia {
  final MediaRepository repository;

  UpsertUserMedia(this.repository);

  Future<Either<Failure, UserMedia>> call({
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  }) {
    return repository.upsertUserMedia(
      mediaId: mediaId,
      mediaType: mediaType,
      watchStatus: watchStatus,
      myRating: myRating,
      myReview: myReview,
      isFavorite: isFavorite,
    );
  }
}
