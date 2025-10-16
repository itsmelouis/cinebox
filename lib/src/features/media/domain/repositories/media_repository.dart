import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/media.dart';
import '../entities/user_media.dart';

/// Abstract repository for media operations
abstract class MediaRepository {
  // ============================================
  // Media Cache Operations (TMDB + Supabase)
  // ============================================

  /// Get media by ID from cache or fetch from TMDB
  Future<Either<Failure, Media>> getMediaById({
    required int id,
    required String mediaType,
    String language = 'fr-FR',
  });

  /// Search media from TMDB
  Future<Either<Failure, List<Media>>> searchMedia({
    required String query,
    String language = 'fr-FR',
  });

  /// Get trending media from TMDB
  Future<Either<Failure, List<Media>>> getTrendingMedia({
    String language = 'fr-FR',
  });

  /// Get popular movies from TMDB
  Future<Either<Failure, List<Media>>> getPopularMovies({
    String language = 'fr-FR',
  });

  /// Get popular TV shows from TMDB
  Future<Either<Failure, List<Media>>> getPopularTvShows({
    String language = 'fr-FR',
  });

  // ============================================
  // User Media CRUD Operations (Supabase)
  // ============================================

  /// Get all user's media with optional filters
  Future<Either<Failure, List<UserMedia>>> getUserMediaList({
    WatchStatus? status,
    String? mediaType,
    bool? isFavorite,
  });

  /// Get a specific user media entry
  Future<Either<Failure, UserMedia?>> getUserMedia({
    required int mediaId,
    required String mediaType,
  });

  /// Add or update user media
  Future<Either<Failure, UserMedia>> upsertUserMedia({
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  });

  /// Delete user media
  Future<Either<Failure, void>> deleteUserMedia({
    required int mediaId,
    required String mediaType,
  });

  /// Toggle favorite status
  Future<Either<Failure, void>> toggleFavorite({
    required int mediaId,
    required String mediaType,
  });

  /// Get user media statistics
  Future<Either<Failure, UserMediaStats>> getUserMediaStats();
}

/// User media statistics
class UserMediaStats {
  final int totalCount;
  final int toWatchCount;
  final int watchingCount;
  final int watchedCount;
  final int favoritesCount;
  final double? averageRating;

  UserMediaStats({
    required this.totalCount,
    required this.toWatchCount,
    required this.watchingCount,
    required this.watchedCount,
    required this.favoritesCount,
    this.averageRating,
  });
}
