import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_media.freezed.dart';

/// Watch status enum
enum WatchStatus {
  toWatch('to_watch', 'À voir'),
  watching('watching', 'En cours'),
  watched('watched', 'Vu');

  final String value;
  final String label;

  const WatchStatus(this.value, this.label);

  static WatchStatus fromString(String value) {
    return WatchStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => WatchStatus.toWatch,
    );
  }
}

/// User media entity representing a user's personal media entry
@freezed
class UserMedia with _$UserMedia {
  const factory UserMedia({
    required String id,
    required String userId,
    required int mediaId,
    required String mediaType,
    required WatchStatus watchStatus,
    double? myRating,
    String? myReview,
    @Default(false) bool isFavorite,
    required DateTime addedAt,
    required DateTime updatedAt,
    DateTime? watchedAt,
    // Media info (joined from media table)
    String? title,
    String? posterPath,
  }) = _UserMedia;

  const UserMedia._();

  /// Get formatted rating (e.g., "8.5/10")
  String get formattedRating =>
      myRating != null ? '${myRating!.toStringAsFixed(1)}/10' : 'Non noté';

  /// Check if media has been rated
  bool get hasRating => myRating != null;

  /// Check if media has a review
  bool get hasReview => myReview != null && myReview!.isNotEmpty;
}
