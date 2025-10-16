import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart' as core_exceptions;
import '../../domain/entities/user_media.dart';
import '../../domain/repositories/media_repository.dart';
import '../models/media_model.dart';
import '../models/user_media_model.dart';

/// Supabase data source for media operations
abstract class MediaSupabaseDataSource {
  // Media cache operations
  Future<MediaModel?> getMediaFromCache(int id, String mediaType);
  Future<void> cacheMedia(MediaModel media);

  // User media CRUD operations
  Future<List<UserMediaModel>> getUserMediaList({
    WatchStatus? status,
    String? mediaType,
    bool? isFavorite,
  });
  Future<UserMediaModel?> getUserMedia(int mediaId, String mediaType);
  Future<UserMediaModel> upsertUserMedia({
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  });
  Future<void> deleteUserMedia(int mediaId, String mediaType);
  Future<UserMediaStats> getUserMediaStats();
}

class MediaSupabaseDataSourceImpl implements MediaSupabaseDataSource {
  final SupabaseClient supabaseClient;

  MediaSupabaseDataSourceImpl(this.supabaseClient);

  String get _userId {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw core_exceptions.AuthException('User not authenticated');
    }
    return userId;
  }

  // ============================================
  // Media Cache Operations
  // ============================================

  @override
  Future<MediaModel?> getMediaFromCache(int id, String mediaType) async {
    try {
      final response = await supabaseClient
          .from('media')
          .select()
          .eq('id', id)
          .eq('media_type', mediaType)
          .maybeSingle();

      if (response == null) return null;

      return MediaModel.fromSupabase(response);
    } catch (e) {
      throw core_exceptions.CacheException('Failed to get media from cache: $e');
    }
  }

  @override
  Future<void> cacheMedia(MediaModel media) async {
    try {
      await supabaseClient.from('media').upsert(
            media.toSupabase(),
            onConflict: 'id,media_type',
          );
    } catch (e) {
      throw core_exceptions.CacheException('Failed to cache media: $e');
    }
  }

  // ============================================
  // User Media CRUD Operations
  // ============================================

  @override
  Future<List<UserMediaModel>> getUserMediaList({
    WatchStatus? status,
    String? mediaType,
    bool? isFavorite,
  }) async {
    try {
      var query = supabaseClient
          .from('user_media')
          .select('''
            *,
            media:media_id (
              title,
              poster_path
            )
          ''')
          .eq('user_id', _userId)
          .order('added_at', ascending: false);

      if (status != null) {
        query = query.eq('watch_status', status.value);
      }
      if (mediaType != null) {
        query = query.eq('media_type', mediaType);
      }
      if (isFavorite != null) {
        query = query.eq('is_favorite', isFavorite);
      }

      final response = await query;

      return (response as List).map((json) {
        // Flatten the joined media data
        final mediaData = json['media'] as Map<String, dynamic>?;
        final flattenedJson = Map<String, dynamic>.from(json);
        if (mediaData != null) {
          flattenedJson['title'] = mediaData['title'];
          flattenedJson['poster_path'] = mediaData['poster_path'];
        }
        flattenedJson.remove('media');
        return UserMediaModel.fromJson(flattenedJson);
      }).toList();
    } catch (e) {
      if (e is core_exceptions.AuthException) rethrow;
      throw core_exceptions.ServerException('Failed to get user media list: $e');
    }
  }

  @override
  Future<UserMediaModel?> getUserMedia(int mediaId, String mediaType) async {
    try {
      final response = await supabaseClient
          .from('user_media')
          .select('''
            *,
            media:media_id (
              title,
              poster_path
            )
          ''')
          .eq('user_id', _userId)
          .eq('media_id', mediaId)
          .eq('media_type', mediaType)
          .maybeSingle();

      if (response == null) return null;

      // Flatten the joined media data
      final mediaData = response['media'] as Map<String, dynamic>?;
      final flattenedJson = Map<String, dynamic>.from(response);
      if (mediaData != null) {
        flattenedJson['title'] = mediaData['title'];
        flattenedJson['poster_path'] = mediaData['poster_path'];
      }
      flattenedJson.remove('media');

      return UserMediaModel.fromJson(flattenedJson);
    } catch (e) {
      if (e is core_exceptions.AuthException) rethrow;
      throw core_exceptions.ServerException('Failed to get user media: $e');
    }
  }

  @override
  Future<UserMediaModel> upsertUserMedia({
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  }) async {
    try {
      final data = UserMediaModel.fromEntity(
        userId: _userId,
        mediaId: mediaId,
        mediaType: mediaType,
        watchStatus: watchStatus,
        myRating: myRating,
        myReview: myReview,
        isFavorite: isFavorite,
      );

      // Add watched_at if status is watched
      if (watchStatus == WatchStatus.watched) {
        data['watched_at'] = DateTime.now().toIso8601String();
      }

      final response = await supabaseClient
          .from('user_media')
          .upsert(
            data,
            onConflict: 'user_id,media_id,media_type',
          )
          .select('''
            *,
            media:media_id (
              title,
              poster_path
            )
          ''')
          .single();

      // Flatten the joined media data
      final mediaData = response['media'] as Map<String, dynamic>?;
      final flattenedJson = Map<String, dynamic>.from(response);
      if (mediaData != null) {
        flattenedJson['title'] = mediaData['title'];
        flattenedJson['poster_path'] = mediaData['poster_path'];
      }
      flattenedJson.remove('media');

      return UserMediaModel.fromJson(flattenedJson);
    } catch (e) {
      if (e is core_exceptions.AuthException) rethrow;
      throw core_exceptions.ServerException('Failed to upsert user media: $e');
    }
  }

  @override
  Future<void> deleteUserMedia(int mediaId, String mediaType) async {
    try {
      await supabaseClient
          .from('user_media')
          .delete()
          .eq('user_id', _userId)
          .eq('media_id', mediaId)
          .eq('media_type', mediaType);
    } catch (e) {
      if (e is core_exceptions.AuthException) rethrow;
      throw core_exceptions.ServerException('Failed to delete user media: $e');
    }
  }

  @override
  Future<UserMediaStats> getUserMediaStats() async {
    try {
      final response = await supabaseClient
          .rpc('get_user_media_stats', params: {'p_user_id': _userId})
          .single();

      return UserMediaStats(
        totalCount: response['total_count'] as int? ?? 0,
        toWatchCount: response['to_watch_count'] as int? ?? 0,
        watchingCount: response['watching_count'] as int? ?? 0,
        watchedCount: response['watched_count'] as int? ?? 0,
        favoritesCount: response['favorites_count'] as int? ?? 0,
        averageRating: (response['average_rating'] as num?)?.toDouble(),
      );
    } catch (e) {
      if (e is core_exceptions.AuthException) rethrow;
      throw core_exceptions.ServerException('Failed to get user media stats: $e');
    }
  }
}
