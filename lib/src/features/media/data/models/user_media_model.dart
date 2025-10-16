import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_media.dart';

part 'user_media_model.freezed.dart';
part 'user_media_model.g.dart';

/// Data model for UserMedia
@freezed
class UserMediaModel with _$UserMediaModel {
  const factory UserMediaModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'media_id') required int mediaId,
    @JsonKey(name: 'media_type') required String mediaType,
    @JsonKey(name: 'watch_status') required String watchStatus,
    @JsonKey(name: 'my_rating') double? myRating,
    @JsonKey(name: 'my_review') String? myReview,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'added_at') required String addedAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'watched_at') String? watchedAt,
    // Joined fields from media table
    String? title,
    @JsonKey(name: 'poster_path') String? posterPath,
  }) = _UserMediaModel;

  const UserMediaModel._();

  factory UserMediaModel.fromJson(Map<String, dynamic> json) =>
      _$UserMediaModelFromJson(json);

  /// Convert to domain entity
  UserMedia toEntity() {
    return UserMedia(
      id: id,
      userId: userId,
      mediaId: mediaId,
      mediaType: mediaType,
      watchStatus: WatchStatus.fromString(watchStatus),
      myRating: myRating,
      myReview: myReview,
      isFavorite: isFavorite,
      addedAt: DateTime.parse(addedAt),
      updatedAt: DateTime.parse(updatedAt),
      watchedAt: watchedAt != null ? DateTime.parse(watchedAt!) : null,
      title: title,
      posterPath: posterPath,
    );
  }

  /// Create from entity for insert/update
  static Map<String, dynamic> fromEntity({
    required String userId,
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    bool? isFavorite,
  }) {
    return {
      'user_id': userId,
      'media_id': mediaId,
      'media_type': mediaType,
      'watch_status': watchStatus.value,
      'my_rating': myRating,
      'my_review': myReview,
      'is_favorite': isFavorite ?? false,
    };
  }
}
