import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/media.dart';
import '../repositories/media_repository.dart';

/// Use case for getting popular TV shows
class GetPopularTvShows {
  final MediaRepository repository;

  GetPopularTvShows(this.repository);

  Future<Either<Failure, List<Media>>> call({
    String language = 'fr-FR',
  }) {
    return repository.getPopularTvShows(language: language);
  }
}
