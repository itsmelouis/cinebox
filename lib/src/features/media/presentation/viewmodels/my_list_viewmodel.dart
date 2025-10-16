import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_media.dart';
import '../../domain/usecases/get_user_media_list.dart';
import '../../domain/usecases/delete_user_media.dart';

part 'my_list_viewmodel.freezed.dart';

/// State for My List page
@freezed
class MyListState with _$MyListState {
  const factory MyListState({
    @Default([]) List<UserMedia> mediaList,
    @Default(false) bool isLoading,
    @Default(false) bool isDeleting,
    String? errorMessage,
    WatchStatus? selectedFilter,
  }) = _MyListState;
}

/// ViewModel for My List page
class MyListViewModel extends StateNotifier<MyListState> {
  final GetUserMediaList _getUserMediaList;
  final DeleteUserMedia _deleteUserMedia;

  MyListViewModel({
    required GetUserMediaList getUserMediaList,
    required DeleteUserMedia deleteUserMedia,
  })  : _getUserMediaList = getUserMediaList,
        _deleteUserMedia = deleteUserMedia,
        super(const MyListState());

  /// Load user's media list
  Future<void> loadMediaList({WatchStatus? status}) async {
    state = state.copyWith(isLoading: true, errorMessage: null, selectedFilter: status);

    final result = await _getUserMediaList(status: status);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (mediaList) {
        state = state.copyWith(
          isLoading: false,
          mediaList: mediaList,
          errorMessage: null,
        );
      },
    );
  }

  /// Delete media from list
  Future<bool> deleteMedia(int mediaId, String mediaType) async {
    state = state.copyWith(isDeleting: true, errorMessage: null);

    final result = await _deleteUserMedia(
      mediaId: mediaId,
      mediaType: mediaType,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isDeleting: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        // Remove from local list
        final updatedList = state.mediaList
            .where((media) => !(media.mediaId == mediaId && media.mediaType == mediaType))
            .toList();
        
        state = state.copyWith(
          isDeleting: false,
          mediaList: updatedList,
          errorMessage: null,
        );
        return true;
      },
    );
  }

  /// Filter by status
  void filterByStatus(WatchStatus? status) {
    loadMediaList(status: status);
  }
}
