import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/media.dart';
import '../repositories/media_repository.dart';

/// Use case for getting trending media
class GetTrendingMedia {
  final MediaRepository repository;

  GetTrendingMedia(this.repository);

  Future<Either<Failure, List<Media>>> call({
    String language = 'fr-FR',
  }) {
    return repository.getTrendingMedia(language: language);
  }
}
