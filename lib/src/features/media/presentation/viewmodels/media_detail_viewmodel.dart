import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/media.dart';
import '../../domain/entities/user_media.dart';
import '../../domain/usecases/get_media_by_id.dart';
import '../../domain/usecases/get_user_media.dart';
import '../../domain/usecases/upsert_user_media.dart';

part 'media_detail_viewmodel.freezed.dart';

/// State for Media Detail page
@freezed
class MediaDetailState with _$MediaDetailState {
  const factory MediaDetailState({
    Media? media,
    UserMedia? userMedia,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _MediaDetailState;
}

/// ViewModel for Media Detail page
class MediaDetailViewModel extends StateNotifier<MediaDetailState> {
  final GetMediaById _getMediaById;
  final GetUserMedia _getUserMedia;
  final UpsertUserMedia _upsertUserMedia;

  MediaDetailViewModel({
    required GetMediaById getMediaById,
    required GetUserMedia getUserMedia,
    required UpsertUserMedia upsertUserMedia,
  })  : _getMediaById = getMediaById,
        _getUserMedia = getUserMedia,
        _upsertUserMedia = upsertUserMedia,
        super(const MediaDetailState());

  /// Load media details and check if already in user's list
  Future<void> loadMedia(int mediaId, String mediaType) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Load media details
    final mediaResult = await _getMediaById(
      id: mediaId,
      mediaType: mediaType,
    );

    // Load user media status
    final userMediaResult = await _getUserMedia(
      mediaId: mediaId,
      mediaType: mediaType,
    );

    mediaResult.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (media) {
        // Set both media and userMedia
        final userMedia = userMediaResult.fold(
          (_) => null,
          (um) => um,
        );
        
        state = state.copyWith(
          isLoading: false,
          media: media,
          userMedia: userMedia,
          errorMessage: null,
        );
      },
    );
  }

  /// Add to list or update status
  Future<void> updateUserMedia({
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  }) async {
    if (state.media == null) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'Media not loaded',
      );
      return;
    }

    state = state.copyWith(isSaving: true, errorMessage: null);

    final result = await _upsertUserMedia(
      mediaId: state.media!.id,
      mediaType: state.media!.mediaType,
      watchStatus: watchStatus,
      myRating: myRating,
      myReview: myReview,
      isFavorite: isFavorite,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isSaving: false,
          errorMessage: failure.message,
        );
      },
      (userMedia) {
        state = state.copyWith(
          isSaving: false,
          userMedia: userMedia,
          errorMessage: null,
        );
      },
    );
  }
}
