import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/media.dart';
import '../repositories/media_repository.dart';

/// Use case for searching media
class SearchMedia {
  final MediaRepository repository;

  SearchMedia(this.repository);

  Future<Either<Failure, List<Media>>> call({
    required String query,
    String language = 'fr-FR',
  }) {
    if (query.isEmpty) {
      return Future.value(const Right([]));
    }
    return repository.searchMedia(query: query, language: language);
  }
}
