import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/media.dart';
import '../repositories/media_repository.dart';

/// Use case for getting media by ID
class GetMediaById {
  final MediaRepository repository;

  GetMediaById(this.repository);

  Future<Either<Failure, Media>> call({
    required int id,
    required String mediaType,
    String language = 'fr-FR',
  }) {
    return repository.getMediaById(
      id: id,
      mediaType: mediaType,
      language: language,
    );
  }
}
