// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_detail_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MediaDetailState {
  Media? get media => throw _privateConstructorUsedError;
  UserMedia? get userMedia => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaDetailStateCopyWith<MediaDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaDetailStateCopyWith<$Res> {
  factory $MediaDetailStateCopyWith(
          MediaDetailState value, $Res Function(MediaDetailState) then) =
      _$MediaDetailStateCopyWithImpl<$Res, MediaDetailState>;
  @useResult
  $Res call(
      {Media? media,
      UserMedia? userMedia,
      bool isLoading,
      bool isSaving,
      String? errorMessage});

  $MediaCopyWith<$Res>? get media;
  $UserMediaCopyWith<$Res>? get userMedia;
}

/// @nodoc
class _$MediaDetailStateCopyWithImpl<$Res, $Val extends MediaDetailState>
    implements $MediaDetailStateCopyWith<$Res> {
  _$MediaDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? media = freezed,
    Object? userMedia = freezed,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as Media?,
      userMedia: freezed == userMedia
          ? _value.userMedia
          : userMedia // ignore: cast_nullable_to_non_nullable
              as UserMedia?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MediaCopyWith<$Res>? get media {
    if (_value.media == null) {
      return null;
    }

    return $MediaCopyWith<$Res>(_value.media!, (value) {
      return _then(_value.copyWith(media: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserMediaCopyWith<$Res>? get userMedia {
    if (_value.userMedia == null) {
      return null;
    }

    return $UserMediaCopyWith<$Res>(_value.userMedia!, (value) {
      return _then(_value.copyWith(userMedia: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MediaDetailStateImplCopyWith<$Res>
    implements $MediaDetailStateCopyWith<$Res> {
  factory _$$MediaDetailStateImplCopyWith(_$MediaDetailStateImpl value,
          $Res Function(_$MediaDetailStateImpl) then) =
      __$$MediaDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Media? media,
      UserMedia? userMedia,
      bool isLoading,
      bool isSaving,
      String? errorMessage});

  @override
  $MediaCopyWith<$Res>? get media;
  @override
  $UserMediaCopyWith<$Res>? get userMedia;
}

/// @nodoc
class __$$MediaDetailStateImplCopyWithImpl<$Res>
    extends _$MediaDetailStateCopyWithImpl<$Res, _$MediaDetailStateImpl>
    implements _$$MediaDetailStateImplCopyWith<$Res> {
  __$$MediaDetailStateImplCopyWithImpl(_$MediaDetailStateImpl _value,
      $Res Function(_$MediaDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? media = freezed,
    Object? userMedia = freezed,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$MediaDetailStateImpl(
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as Media?,
      userMedia: freezed == userMedia
          ? _value.userMedia
          : userMedia // ignore: cast_nullable_to_non_nullable
              as UserMedia?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MediaDetailStateImpl implements _MediaDetailState {
  const _$MediaDetailStateImpl(
      {this.media,
      this.userMedia,
      this.isLoading = false,
      this.isSaving = false,
      this.errorMessage});

  @override
  final Media? media;
  @override
  final UserMedia? userMedia;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'MediaDetailState(media: $media, userMedia: $userMedia, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaDetailStateImpl &&
            (identical(other.media, media) || other.media == media) &&
            (identical(other.userMedia, userMedia) ||
                other.userMedia == userMedia) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, media, userMedia, isLoading, isSaving, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaDetailStateImplCopyWith<_$MediaDetailStateImpl> get copyWith =>
      __$$MediaDetailStateImplCopyWithImpl<_$MediaDetailStateImpl>(
          this, _$identity);
}

abstract class _MediaDetailState implements MediaDetailState {
  const factory _MediaDetailState(
      {final Media? media,
      final UserMedia? userMedia,
      final bool isLoading,
      final bool isSaving,
      final String? errorMessage}) = _$MediaDetailStateImpl;

  @override
  Media? get media;
  @override
  UserMedia? get userMedia;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$MediaDetailStateImplCopyWith<_$MediaDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
