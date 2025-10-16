import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/media.dart';
import '../../domain/entities/user_media.dart';
import '../../domain/repositories/media_repository.dart';
import '../datasources/media_supabase_datasource.dart';
import '../datasources/tmdb_remote_datasource.dart';
import '../models/media_model.dart';

/// Implementation of MediaRepository
class MediaRepositoryImpl implements MediaRepository {
  final TmdbRemoteDataSource tmdbDataSource;
  final MediaSupabaseDataSource supabaseDataSource;

  MediaRepositoryImpl({
    required this.tmdbDataSource,
    required this.supabaseDataSource,
  });

  // ============================================
  // Media Cache Operations (TMDB + Supabase)
  // ============================================

  @override
  Future<Either<Failure, Media>> getMediaById({
    required int id,
    required String mediaType,
    String language = 'fr-FR',
  }) async {
    try {
      // 1. Check cache first
      final cachedMedia = await supabaseDataSource.getMediaFromCache(id, mediaType);
      if (cachedMedia != null) {
        return Right(cachedMedia.toEntity());
      }

      // 2. Fetch from TMDB
      final MediaModel mediaModel;
      if (mediaType == 'movie') {
        mediaModel = await tmdbDataSource.getMovieDetails(
          id,
          language,
          'watch/providers',
        );
        
        // Get watch providers
        try {
          final providers = await tmdbDataSource.getMovieWatchProviders(id);
          final results = providers['results'] as Map<String, dynamic>?;
          if (results != null) {
            // Store providers in model
            final updatedModel = mediaModel.copyWith(
              streamingProviders: results,
            );
            // Cache in Supabase
            await supabaseDataSource.cacheMedia(updatedModel);
            return Right(updatedModel.toEntity());
          }
        } catch (_) {
          // Continue without providers if fetch fails
        }
      } else {
        mediaModel = await tmdbDataSource.getTvDetails(
          id,
          language,
          'watch/providers',
        );
        
        // Get watch providers
        try {
          final providers = await tmdbDataSource.getTvWatchProviders(id);
          final results = providers['results'] as Map<String, dynamic>?;
          if (results != null) {
            final updatedModel = mediaModel.copyWith(
              streamingProviders: results,
            );
            await supabaseDataSource.cacheMedia(updatedModel);
            return Right(updatedModel.toEntity());
          }
        } catch (_) {
          // Continue without providers
        }
      }

      // 3. Cache in Supabase
      await supabaseDataSource.cacheMedia(mediaModel);

      return Right(mediaModel.toEntity());
    } on NetworkException catch (e) {
      return Left(Failure.network(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } on CacheException catch (e) {
      return Left(Failure.cache(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> searchMedia({
    required String query,
    String language = 'fr-FR',
  }) async {
    try {
      final response = await tmdbDataSource.searchMulti(query, language);
      final results = response['results'] as List;

      final mediaList = results
          .where((json) {
            final mediaType = json['media_type'] as String?;
            return mediaType == 'movie' || mediaType == 'tv';
          })
          .map((json) => MediaModel.fromJson(json).toEntity())
          .toList();

      return Right(mediaList);
    } on NetworkException catch (e) {
      return Left(Failure.network(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getTrendingMedia({
    String language = 'fr-FR',
  }) async {
    try {
      final response = await tmdbDataSource.getTrending(language);
      final results = response['results'] as List;

      final mediaList = results
          .where((json) {
            final mediaType = json['media_type'] as String?;
            return mediaType == 'movie' || mediaType == 'tv';
          })
          .map((json) => MediaModel.fromJson(json).toEntity())
          .toList();

      return Right(mediaList);
    } on NetworkException catch (e) {
      return Left(Failure.network(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getPopularMovies({
    String language = 'fr-FR',
  }) async {
    try {
      final response = await tmdbDataSource.getPopularMovies(language);
      final results = response['results'] as List;

      final mediaList = results
          .map((json) {
            final model = MediaModel.fromJson(json);
            return model.copyWith(mediaType: 'movie').toEntity();
          })
          .toList();

      return Right(mediaList);
    } on NetworkException catch (e) {
      return Left(Failure.network(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getPopularTvShows({
    String language = 'fr-FR',
  }) async {
    try {
      final response = await tmdbDataSource.getPopularTvShows(language);
      final results = response['results'] as List;

      final mediaList = results
          .map((json) {
            final model = MediaModel.fromJson(json);
            return model.copyWith(mediaType: 'tv').toEntity();
          })
          .toList();

      return Right(mediaList);
    } on NetworkException catch (e) {
      return Left(Failure.network(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  // ============================================
  // User Media CRUD Operations (Supabase)
  // ============================================

  @override
  Future<Either<Failure, List<UserMedia>>> getUserMediaList({
    WatchStatus? status,
    String? mediaType,
    bool? isFavorite,
  }) async {
    try {
      final userMediaModels = await supabaseDataSource.getUserMediaList(
        status: status,
        mediaType: mediaType,
        isFavorite: isFavorite,
      );

      final userMediaList = userMediaModels.map((model) => model.toEntity()).toList();
      return Right(userMediaList);
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserMedia?>> getUserMedia({
    required int mediaId,
    required String mediaType,
  }) async {
    try {
      final userMediaModel = await supabaseDataSource.getUserMedia(
        mediaId,
        mediaType,
      );

      return Right(userMediaModel?.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserMedia>> upsertUserMedia({
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  }) async {
    try {
      // Ensure media exists in cache
      await getMediaById(
        id: mediaId,
        mediaType: mediaType,
      );

      // Continue even if media fetch fails (might already be cached)
      
      final userMediaModel = await supabaseDataSource.upsertUserMedia(
        mediaId: mediaId,
        mediaType: mediaType,
        watchStatus: watchStatus,
        myRating: myRating,
        myReview: myReview,
        isFavorite: isFavorite,
      );

      return Right(userMediaModel.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserMedia({
    required int mediaId,
    required String mediaType,
  }) async {
    try {
      await supabaseDataSource.deleteUserMedia(mediaId, mediaType);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite({
    required int mediaId,
    required String mediaType,
  }) async {
    try {
      final userMedia = await supabaseDataSource.getUserMedia(
        mediaId,
        mediaType,
      );

      if (userMedia == null) {
        return Left(Failure.validation('Media not in user list'));
      }

      await supabaseDataSource.upsertUserMedia(
        mediaId: mediaId,
        mediaType: mediaType,
        watchStatus: WatchStatus.fromString(userMedia.watchStatus),
        myRating: userMedia.myRating,
        myReview: userMedia.myReview,
        isFavorite: !userMedia.isFavorite,
      );

      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserMediaStats>> getUserMediaStats() async {
    try {
      final stats = await supabaseDataSource.getUserMediaStats();
      return Right(stats);
    } on AuthException catch (e) {
      return Left(Failure.auth(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.statusCode, e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }
}
