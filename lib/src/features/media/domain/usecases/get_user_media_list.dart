import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_media.dart';
import '../repositories/media_repository.dart';

/// Use case for getting user's media list
class GetUserMediaList {
  final MediaRepository repository;

  GetUserMediaList(this.repository);

  Future<Either<Failure, List<UserMedia>>> call({
    WatchStatus? status,
    String? mediaType,
    bool? isFavorite,
  }) {
    return repository.getUserMediaList(
      status: status,
      mediaType: mediaType,
      isFavorite: isFavorite,
    );
  }
}
