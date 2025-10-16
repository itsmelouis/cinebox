// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) {
  return _MediaModel.fromJson(json);
}

/// @nodoc
mixin _$MediaModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'media_type')
  String? get mediaType => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get name =>
      throw _privateConstructorUsedError; // TV shows use 'name' instead of 'title'
  @JsonKey(name: 'original_title')
  String? get originalTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_name')
  String? get originalName => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'release_date')
  String? get releaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_air_date')
  String? get firstAirDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double? get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int? get voteCount => throw _privateConstructorUsedError;
  double? get popularity => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_language')
  String? get originalLanguage => throw _privateConstructorUsedError;
  List<GenreModel>? get genres => throw _privateConstructorUsedError;
  int? get runtime => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get tagline => throw _privateConstructorUsedError;
  String? get homepage => throw _privateConstructorUsedError;
  @JsonKey(name: 'streaming_providers')
  Map<String, dynamic>? get streamingProviders =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaModelCopyWith<MediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaModelCopyWith<$Res> {
  factory $MediaModelCopyWith(
          MediaModel value, $Res Function(MediaModel) then) =
      _$MediaModelCopyWithImpl<$Res, MediaModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'media_type') String? mediaType,
      String? title,
      String? name,
      @JsonKey(name: 'original_title') String? originalTitle,
      @JsonKey(name: 'original_name') String? originalName,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'release_date') String? releaseDate,
      @JsonKey(name: 'first_air_date') String? firstAirDate,
      @JsonKey(name: 'vote_average') double? voteAverage,
      @JsonKey(name: 'vote_count') int? voteCount,
      double? popularity,
      @JsonKey(name: 'original_language') String? originalLanguage,
      List<GenreModel>? genres,
      int? runtime,
      String? status,
      String? tagline,
      String? homepage,
      @JsonKey(name: 'streaming_providers')
      Map<String, dynamic>? streamingProviders});
}

/// @nodoc
class _$MediaModelCopyWithImpl<$Res, $Val extends MediaModel>
    implements $MediaModelCopyWith<$Res> {
  _$MediaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mediaType = freezed,
    Object? title = freezed,
    Object? name = freezed,
    Object? originalTitle = freezed,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
    Object? firstAirDate = freezed,
    Object? voteAverage = freezed,
    Object? voteCount = freezed,
    Object? popularity = freezed,
    Object? originalLanguage = freezed,
    Object? genres = freezed,
    Object? runtime = freezed,
    Object? status = freezed,
    Object? tagline = freezed,
    Object? homepage = freezed,
    Object? streamingProviders = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: freezed == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<GenreModel>?,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tagline: freezed == tagline
          ? _value.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      streamingProviders: freezed == streamingProviders
          ? _value.streamingProviders
          : streamingProviders // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaModelImplCopyWith<$Res>
    implements $MediaModelCopyWith<$Res> {
  factory _$$MediaModelImplCopyWith(
          _$MediaModelImpl value, $Res Function(_$MediaModelImpl) then) =
      __$$MediaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'media_type') String? mediaType,
      String? title,
      String? name,
      @JsonKey(name: 'original_title') String? originalTitle,
      @JsonKey(name: 'original_name') String? originalName,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'release_date') String? releaseDate,
      @JsonKey(name: 'first_air_date') String? firstAirDate,
      @JsonKey(name: 'vote_average') double? voteAverage,
      @JsonKey(name: 'vote_count') int? voteCount,
      double? popularity,
      @JsonKey(name: 'original_language') String? originalLanguage,
      List<GenreModel>? genres,
      int? runtime,
      String? status,
      String? tagline,
      String? homepage,
      @JsonKey(name: 'streaming_providers')
      Map<String, dynamic>? streamingProviders});
}

/// @nodoc
class __$$MediaModelImplCopyWithImpl<$Res>
    extends _$MediaModelCopyWithImpl<$Res, _$MediaModelImpl>
    implements _$$MediaModelImplCopyWith<$Res> {
  __$$MediaModelImplCopyWithImpl(
      _$MediaModelImpl _value, $Res Function(_$MediaModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mediaType = freezed,
    Object? title = freezed,
    Object? name = freezed,
    Object? originalTitle = freezed,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
    Object? firstAirDate = freezed,
    Object? voteAverage = freezed,
    Object? voteCount = freezed,
    Object? popularity = freezed,
    Object? originalLanguage = freezed,
    Object? genres = freezed,
    Object? runtime = freezed,
    Object? status = freezed,
    Object? tagline = freezed,
    Object? homepage = freezed,
    Object? streamingProviders = freezed,
  }) {
    return _then(_$MediaModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: freezed == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<GenreModel>?,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tagline: freezed == tagline
          ? _value.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      streamingProviders: freezed == streamingProviders
          ? _value._streamingProviders
          : streamingProviders // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaModelImpl extends _MediaModel {
  const _$MediaModelImpl(
      {required this.id,
      @JsonKey(name: 'media_type') this.mediaType,
      this.title,
      this.name,
      @JsonKey(name: 'original_title') this.originalTitle,
      @JsonKey(name: 'original_name') this.originalName,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'release_date') this.releaseDate,
      @JsonKey(name: 'first_air_date') this.firstAirDate,
      @JsonKey(name: 'vote_average') this.voteAverage,
      @JsonKey(name: 'vote_count') this.voteCount,
      this.popularity,
      @JsonKey(name: 'original_language') this.originalLanguage,
      final List<GenreModel>? genres,
      this.runtime,
      this.status,
      this.tagline,
      this.homepage,
      @JsonKey(name: 'streaming_providers')
      final Map<String, dynamic>? streamingProviders})
      : _genres = genres,
        _streamingProviders = streamingProviders,
        super._();

  factory _$MediaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'media_type')
  final String? mediaType;
  @override
  final String? title;
  @override
  final String? name;
// TV shows use 'name' instead of 'title'
  @override
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @override
  @JsonKey(name: 'original_name')
  final String? originalName;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @override
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @override
  final double? popularity;
  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  final List<GenreModel>? _genres;
  @override
  List<GenreModel>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? runtime;
  @override
  final String? status;
  @override
  final String? tagline;
  @override
  final String? homepage;
  final Map<String, dynamic>? _streamingProviders;
  @override
  @JsonKey(name: 'streaming_providers')
  Map<String, dynamic>? get streamingProviders {
    final value = _streamingProviders;
    if (value == null) return null;
    if (_streamingProviders is EqualUnmodifiableMapView)
      return _streamingProviders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MediaModel(id: $id, mediaType: $mediaType, title: $title, name: $name, originalTitle: $originalTitle, originalName: $originalName, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, firstAirDate: $firstAirDate, voteAverage: $voteAverage, voteCount: $voteCount, popularity: $popularity, originalLanguage: $originalLanguage, genres: $genres, runtime: $runtime, status: $status, tagline: $tagline, homepage: $homepage, streamingProviders: $streamingProviders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.firstAirDate, firstAirDate) ||
                other.firstAirDate == firstAirDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.originalLanguage, originalLanguage) ||
                other.originalLanguage == originalLanguage) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.homepage, homepage) ||
                other.homepage == homepage) &&
            const DeepCollectionEquality()
                .equals(other._streamingProviders, _streamingProviders));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        mediaType,
        title,
        name,
        originalTitle,
        originalName,
        overview,
        posterPath,
        backdropPath,
        releaseDate,
        firstAirDate,
        voteAverage,
        voteCount,
        popularity,
        originalLanguage,
        const DeepCollectionEquality().hash(_genres),
        runtime,
        status,
        tagline,
        homepage,
        const DeepCollectionEquality().hash(_streamingProviders)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaModelImplCopyWith<_$MediaModelImpl> get copyWith =>
      __$$MediaModelImplCopyWithImpl<_$MediaModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaModelImplToJson(
      this,
    );
  }
}

abstract class _MediaModel extends MediaModel {
  const factory _MediaModel(
      {required final int id,
      @JsonKey(name: 'media_type') final String? mediaType,
      final String? title,
      final String? name,
      @JsonKey(name: 'original_title') final String? originalTitle,
      @JsonKey(name: 'original_name') final String? originalName,
      final String? overview,
      @JsonKey(name: 'poster_path') final String? posterPath,
      @JsonKey(name: 'backdrop_path') final String? backdropPath,
      @JsonKey(name: 'release_date') final String? releaseDate,
      @JsonKey(name: 'first_air_date') final String? firstAirDate,
      @JsonKey(name: 'vote_average') final double? voteAverage,
      @JsonKey(name: 'vote_count') final int? voteCount,
      final double? popularity,
      @JsonKey(name: 'original_language') final String? originalLanguage,
      final List<GenreModel>? genres,
      final int? runtime,
      final String? status,
      final String? tagline,
      final String? homepage,
      @JsonKey(name: 'streaming_providers')
      final Map<String, dynamic>? streamingProviders}) = _$MediaModelImpl;
  const _MediaModel._() : super._();

  factory _MediaModel.fromJson(Map<String, dynamic> json) =
      _$MediaModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'media_type')
  String? get mediaType;
  @override
  String? get title;
  @override
  String? get name;
  @override // TV shows use 'name' instead of 'title'
  @JsonKey(name: 'original_title')
  String? get originalTitle;
  @override
  @JsonKey(name: 'original_name')
  String? get originalName;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @override
  @JsonKey(name: 'release_date')
  String? get releaseDate;
  @override
  @JsonKey(name: 'first_air_date')
  String? get firstAirDate;
  @override
  @JsonKey(name: 'vote_average')
  double? get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  int? get voteCount;
  @override
  double? get popularity;
  @override
  @JsonKey(name: 'original_language')
  String? get originalLanguage;
  @override
  List<GenreModel>? get genres;
  @override
  int? get runtime;
  @override
  String? get status;
  @override
  String? get tagline;
  @override
  String? get homepage;
  @override
  @JsonKey(name: 'streaming_providers')
  Map<String, dynamic>? get streamingProviders;
  @override
  @JsonKey(ignore: true)
  _$$MediaModelImplCopyWith<_$MediaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) {
  return _GenreModel.fromJson(json);
}

/// @nodoc
mixin _$GenreModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenreModelCopyWith<GenreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreModelCopyWith<$Res> {
  factory $GenreModelCopyWith(
          GenreModel value, $Res Function(GenreModel) then) =
      _$GenreModelCopyWithImpl<$Res, GenreModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$GenreModelCopyWithImpl<$Res, $Val extends GenreModel>
    implements $GenreModelCopyWith<$Res> {
  _$GenreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenreModelImplCopyWith<$Res>
    implements $GenreModelCopyWith<$Res> {
  factory _$$GenreModelImplCopyWith(
          _$GenreModelImpl value, $Res Function(_$GenreModelImpl) then) =
      __$$GenreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$GenreModelImplCopyWithImpl<$Res>
    extends _$GenreModelCopyWithImpl<$Res, _$GenreModelImpl>
    implements _$$GenreModelImplCopyWith<$Res> {
  __$$GenreModelImplCopyWithImpl(
      _$GenreModelImpl _value, $Res Function(_$GenreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$GenreModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenreModelImpl extends _GenreModel {
  const _$GenreModelImpl({required this.id, required this.name}) : super._();

  factory _$GenreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenreModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'GenreModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreModelImplCopyWith<_$GenreModelImpl> get copyWith =>
      __$$GenreModelImplCopyWithImpl<_$GenreModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenreModelImplToJson(
      this,
    );
  }
}

abstract class _GenreModel extends GenreModel {
  const factory _GenreModel(
      {required final int id, required final String name}) = _$GenreModelImpl;
  const _GenreModel._() : super._();

  factory _GenreModel.fromJson(Map<String, dynamic> json) =
      _$GenreModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$GenreModelImplCopyWith<_$GenreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
