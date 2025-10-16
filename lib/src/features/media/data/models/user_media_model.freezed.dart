// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_media_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserMediaModel _$UserMediaModelFromJson(Map<String, dynamic> json) {
  return _UserMediaModel.fromJson(json);
}

/// @nodoc
mixin _$UserMediaModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'media_id')
  int get mediaId => throw _privateConstructorUsedError;
  @JsonKey(name: 'media_type')
  String get mediaType => throw _privateConstructorUsedError;
  @JsonKey(name: 'watch_status')
  String get watchStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'my_rating')
  double? get myRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'my_review')
  String? get myReview => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_at')
  String get addedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'watched_at')
  String? get watchedAt =>
      throw _privateConstructorUsedError; // Joined fields from media table
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserMediaModelCopyWith<UserMediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMediaModelCopyWith<$Res> {
  factory $UserMediaModelCopyWith(
          UserMediaModel value, $Res Function(UserMediaModel) then) =
      _$UserMediaModelCopyWithImpl<$Res, UserMediaModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'media_id') int mediaId,
      @JsonKey(name: 'media_type') String mediaType,
      @JsonKey(name: 'watch_status') String watchStatus,
      @JsonKey(name: 'my_rating') double? myRating,
      @JsonKey(name: 'my_review') String? myReview,
      @JsonKey(name: 'is_favorite') bool isFavorite,
      @JsonKey(name: 'added_at') String addedAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'watched_at') String? watchedAt,
      String? title,
      @JsonKey(name: 'poster_path') String? posterPath});
}

/// @nodoc
class _$UserMediaModelCopyWithImpl<$Res, $Val extends UserMediaModel>
    implements $UserMediaModelCopyWith<$Res> {
  _$UserMediaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? mediaId = null,
    Object? mediaType = null,
    Object? watchStatus = null,
    Object? myRating = freezed,
    Object? myReview = freezed,
    Object? isFavorite = null,
    Object? addedAt = null,
    Object? updatedAt = null,
    Object? watchedAt = freezed,
    Object? title = freezed,
    Object? posterPath = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaId: null == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      watchStatus: null == watchStatus
          ? _value.watchStatus
          : watchStatus // ignore: cast_nullable_to_non_nullable
              as String,
      myRating: freezed == myRating
          ? _value.myRating
          : myRating // ignore: cast_nullable_to_non_nullable
              as double?,
      myReview: freezed == myReview
          ? _value.myReview
          : myReview // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      watchedAt: freezed == watchedAt
          ? _value.watchedAt
          : watchedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMediaModelImplCopyWith<$Res>
    implements $UserMediaModelCopyWith<$Res> {
  factory _$$UserMediaModelImplCopyWith(_$UserMediaModelImpl value,
          $Res Function(_$UserMediaModelImpl) then) =
      __$$UserMediaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'media_id') int mediaId,
      @JsonKey(name: 'media_type') String mediaType,
      @JsonKey(name: 'watch_status') String watchStatus,
      @JsonKey(name: 'my_rating') double? myRating,
      @JsonKey(name: 'my_review') String? myReview,
      @JsonKey(name: 'is_favorite') bool isFavorite,
      @JsonKey(name: 'added_at') String addedAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'watched_at') String? watchedAt,
      String? title,
      @JsonKey(name: 'poster_path') String? posterPath});
}

/// @nodoc
class __$$UserMediaModelImplCopyWithImpl<$Res>
    extends _$UserMediaModelCopyWithImpl<$Res, _$UserMediaModelImpl>
    implements _$$UserMediaModelImplCopyWith<$Res> {
  __$$UserMediaModelImplCopyWithImpl(
      _$UserMediaModelImpl _value, $Res Function(_$UserMediaModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? mediaId = null,
    Object? mediaType = null,
    Object? watchStatus = null,
    Object? myRating = freezed,
    Object? myReview = freezed,
    Object? isFavorite = null,
    Object? addedAt = null,
    Object? updatedAt = null,
    Object? watchedAt = freezed,
    Object? title = freezed,
    Object? posterPath = freezed,
  }) {
    return _then(_$UserMediaModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaId: null == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      watchStatus: null == watchStatus
          ? _value.watchStatus
          : watchStatus // ignore: cast_nullable_to_non_nullable
              as String,
      myRating: freezed == myRating
          ? _value.myRating
          : myRating // ignore: cast_nullable_to_non_nullable
              as double?,
      myReview: freezed == myReview
          ? _value.myReview
          : myReview // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      watchedAt: freezed == watchedAt
          ? _value.watchedAt
          : watchedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserMediaModelImpl extends _UserMediaModel {
  const _$UserMediaModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'media_id') required this.mediaId,
      @JsonKey(name: 'media_type') required this.mediaType,
      @JsonKey(name: 'watch_status') required this.watchStatus,
      @JsonKey(name: 'my_rating') this.myRating,
      @JsonKey(name: 'my_review') this.myReview,
      @JsonKey(name: 'is_favorite') this.isFavorite = false,
      @JsonKey(name: 'added_at') required this.addedAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'watched_at') this.watchedAt,
      this.title,
      @JsonKey(name: 'poster_path') this.posterPath})
      : super._();

  factory _$UserMediaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMediaModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'media_id')
  final int mediaId;
  @override
  @JsonKey(name: 'media_type')
  final String mediaType;
  @override
  @JsonKey(name: 'watch_status')
  final String watchStatus;
  @override
  @JsonKey(name: 'my_rating')
  final double? myRating;
  @override
  @JsonKey(name: 'my_review')
  final String? myReview;
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @override
  @JsonKey(name: 'added_at')
  final String addedAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @override
  @JsonKey(name: 'watched_at')
  final String? watchedAt;
// Joined fields from media table
  @override
  final String? title;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  String toString() {
    return 'UserMediaModel(id: $id, userId: $userId, mediaId: $mediaId, mediaType: $mediaType, watchStatus: $watchStatus, myRating: $myRating, myReview: $myReview, isFavorite: $isFavorite, addedAt: $addedAt, updatedAt: $updatedAt, watchedAt: $watchedAt, title: $title, posterPath: $posterPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMediaModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.watchStatus, watchStatus) ||
                other.watchStatus == watchStatus) &&
            (identical(other.myRating, myRating) ||
                other.myRating == myRating) &&
            (identical(other.myReview, myReview) ||
                other.myReview == myReview) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.watchedAt, watchedAt) ||
                other.watchedAt == watchedAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      mediaId,
      mediaType,
      watchStatus,
      myRating,
      myReview,
      isFavorite,
      addedAt,
      updatedAt,
      watchedAt,
      title,
      posterPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMediaModelImplCopyWith<_$UserMediaModelImpl> get copyWith =>
      __$$UserMediaModelImplCopyWithImpl<_$UserMediaModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMediaModelImplToJson(
      this,
    );
  }
}

abstract class _UserMediaModel extends UserMediaModel {
  const factory _UserMediaModel(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'media_id') required final int mediaId,
          @JsonKey(name: 'media_type') required final String mediaType,
          @JsonKey(name: 'watch_status') required final String watchStatus,
          @JsonKey(name: 'my_rating') final double? myRating,
          @JsonKey(name: 'my_review') final String? myReview,
          @JsonKey(name: 'is_favorite') final bool isFavorite,
          @JsonKey(name: 'added_at') required final String addedAt,
          @JsonKey(name: 'updated_at') required final String updatedAt,
          @JsonKey(name: 'watched_at') final String? watchedAt,
          final String? title,
          @JsonKey(name: 'poster_path') final String? posterPath}) =
      _$UserMediaModelImpl;
  const _UserMediaModel._() : super._();

  factory _UserMediaModel.fromJson(Map<String, dynamic> json) =
      _$UserMediaModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'media_id')
  int get mediaId;
  @override
  @JsonKey(name: 'media_type')
  String get mediaType;
  @override
  @JsonKey(name: 'watch_status')
  String get watchStatus;
  @override
  @JsonKey(name: 'my_rating')
  double? get myRating;
  @override
  @JsonKey(name: 'my_review')
  String? get myReview;
  @override
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;
  @override
  @JsonKey(name: 'added_at')
  String get addedAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override
  @JsonKey(name: 'watched_at')
  String? get watchedAt;
  @override // Joined fields from media table
  String? get title;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(ignore: true)
  _$$UserMediaModelImplCopyWith<_$UserMediaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
