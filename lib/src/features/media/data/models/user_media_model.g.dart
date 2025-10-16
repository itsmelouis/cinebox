// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMediaModelImpl _$$UserMediaModelImplFromJson(Map<String, dynamic> json) =>
    _$UserMediaModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      mediaId: (json['media_id'] as num).toInt(),
      mediaType: json['media_type'] as String,
      watchStatus: json['watch_status'] as String,
      myRating: (json['my_rating'] as num?)?.toDouble(),
      myReview: json['my_review'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      addedAt: json['added_at'] as String,
      updatedAt: json['updated_at'] as String,
      watchedAt: json['watched_at'] as String?,
      title: json['title'] as String?,
      posterPath: json['poster_path'] as String?,
    );

Map<String, dynamic> _$$UserMediaModelImplToJson(
        _$UserMediaModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'media_id': instance.mediaId,
      'media_type': instance.mediaType,
      'watch_status': instance.watchStatus,
      'my_rating': instance.myRating,
      'my_review': instance.myReview,
      'is_favorite': instance.isFavorite,
      'added_at': instance.addedAt,
      'updated_at': instance.updatedAt,
      'watched_at': instance.watchedAt,
      'title': instance.title,
      'poster_path': instance.posterPath,
    };
