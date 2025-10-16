// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Media {
  int get id => throw _privateConstructorUsedError;
  String get mediaType => throw _privateConstructorUsedError; // 'movie' or 'tv'
  String get title => throw _privateConstructorUsedError;
  String? get originalTitle => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  String? get backdropPath => throw _privateConstructorUsedError;
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  double? get voteAverage => throw _privateConstructorUsedError;
  int? get voteCount => throw _privateConstructorUsedError;
  double? get popularity => throw _privateConstructorUsedError;
  String? get originalLanguage => throw _privateConstructorUsedError;
  List<Genre>? get genres => throw _privateConstructorUsedError;
  int? get runtime => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get tagline => throw _privateConstructorUsedError;
  String? get homepage => throw _privateConstructorUsedError;
  Map<String, List<StreamingProvider>>? get streamingProviders =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaCopyWith<Media> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaCopyWith<$Res> {
  factory $MediaCopyWith(Media value, $Res Function(Media) then) =
      _$MediaCopyWithImpl<$Res, Media>;
  @useResult
  $Res call(
      {int id,
      String mediaType,
      String title,
      String? originalTitle,
      String? overview,
      String? posterPath,
      String? backdropPath,
      DateTime? releaseDate,
      double? voteAverage,
      int? voteCount,
      double? popularity,
      String? originalLanguage,
      List<Genre>? genres,
      int? runtime,
      String? status,
      String? tagline,
      String? homepage,
      Map<String, List<StreamingProvider>>? streamingProviders});
}

/// @nodoc
class _$MediaCopyWithImpl<$Res, $Val extends Media>
    implements $MediaCopyWith<$Res> {
  _$MediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mediaType = null,
    Object? title = null,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
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
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
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
              as DateTime?,
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
              as List<Genre>?,
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
              as Map<String, List<StreamingProvider>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaImplCopyWith<$Res> implements $MediaCopyWith<$Res> {
  factory _$$MediaImplCopyWith(
          _$MediaImpl value, $Res Function(_$MediaImpl) then) =
      __$$MediaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String mediaType,
      String title,
      String? originalTitle,
      String? overview,
      String? posterPath,
      String? backdropPath,
      DateTime? releaseDate,
      double? voteAverage,
      int? voteCount,
      double? popularity,
      String? originalLanguage,
      List<Genre>? genres,
      int? runtime,
      String? status,
      String? tagline,
      String? homepage,
      Map<String, List<StreamingProvider>>? streamingProviders});
}

/// @nodoc
class __$$MediaImplCopyWithImpl<$Res>
    extends _$MediaCopyWithImpl<$Res, _$MediaImpl>
    implements _$$MediaImplCopyWith<$Res> {
  __$$MediaImplCopyWithImpl(
      _$MediaImpl _value, $Res Function(_$MediaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mediaType = null,
    Object? title = null,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
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
    return _then(_$MediaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
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
              as DateTime?,
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
              as List<Genre>?,
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
              as Map<String, List<StreamingProvider>>?,
    ));
  }
}

/// @nodoc

class _$MediaImpl extends _Media {
  const _$MediaImpl(
      {required this.id,
      required this.mediaType,
      required this.title,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.voteAverage,
      this.voteCount,
      this.popularity,
      this.originalLanguage,
      final List<Genre>? genres,
      this.runtime,
      this.status,
      this.tagline,
      this.homepage,
      final Map<String, List<StreamingProvider>>? streamingProviders})
      : _genres = genres,
        _streamingProviders = streamingProviders,
        super._();

  @override
  final int id;
  @override
  final String mediaType;
// 'movie' or 'tv'
  @override
  final String title;
  @override
  final String? originalTitle;
  @override
  final String? overview;
  @override
  final String? posterPath;
  @override
  final String? backdropPath;
  @override
  final DateTime? releaseDate;
  @override
  final double? voteAverage;
  @override
  final int? voteCount;
  @override
  final double? popularity;
  @override
  final String? originalLanguage;
  final List<Genre>? _genres;
  @override
  List<Genre>? get genres {
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
  final Map<String, List<StreamingProvider>>? _streamingProviders;
  @override
  Map<String, List<StreamingProvider>>? get streamingProviders {
    final value = _streamingProviders;
    if (value == null) return null;
    if (_streamingProviders is EqualUnmodifiableMapView)
      return _streamingProviders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Media(id: $id, mediaType: $mediaType, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, voteAverage: $voteAverage, voteCount: $voteCount, popularity: $popularity, originalLanguage: $originalLanguage, genres: $genres, runtime: $runtime, status: $status, tagline: $tagline, homepage: $homepage, streamingProviders: $streamingProviders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      mediaType,
      title,
      originalTitle,
      overview,
      posterPath,
      backdropPath,
      releaseDate,
      voteAverage,
      voteCount,
      popularity,
      originalLanguage,
      const DeepCollectionEquality().hash(_genres),
      runtime,
      status,
      tagline,
      homepage,
      const DeepCollectionEquality().hash(_streamingProviders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaImplCopyWith<_$MediaImpl> get copyWith =>
      __$$MediaImplCopyWithImpl<_$MediaImpl>(this, _$identity);
}

abstract class _Media extends Media {
  const factory _Media(
          {required final int id,
          required final String mediaType,
          required final String title,
          final String? originalTitle,
          final String? overview,
          final String? posterPath,
          final String? backdropPath,
          final DateTime? releaseDate,
          final double? voteAverage,
          final int? voteCount,
          final double? popularity,
          final String? originalLanguage,
          final List<Genre>? genres,
          final int? runtime,
          final String? status,
          final String? tagline,
          final String? homepage,
          final Map<String, List<StreamingProvider>>? streamingProviders}) =
      _$MediaImpl;
  const _Media._() : super._();

  @override
  int get id;
  @override
  String get mediaType;
  @override // 'movie' or 'tv'
  String get title;
  @override
  String? get originalTitle;
  @override
  String? get overview;
  @override
  String? get posterPath;
  @override
  String? get backdropPath;
  @override
  DateTime? get releaseDate;
  @override
  double? get voteAverage;
  @override
  int? get voteCount;
  @override
  double? get popularity;
  @override
  String? get originalLanguage;
  @override
  List<Genre>? get genres;
  @override
  int? get runtime;
  @override
  String? get status;
  @override
  String? get tagline;
  @override
  String? get homepage;
  @override
  Map<String, List<StreamingProvider>>? get streamingProviders;
  @override
  @JsonKey(ignore: true)
  _$$MediaImplCopyWith<_$MediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Genre {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenreCopyWith<Genre> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreCopyWith<$Res> {
  factory $GenreCopyWith(Genre value, $Res Function(Genre) then) =
      _$GenreCopyWithImpl<$Res, Genre>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$GenreCopyWithImpl<$Res, $Val extends Genre>
    implements $GenreCopyWith<$Res> {
  _$GenreCopyWithImpl(this._value, this._then);

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
abstract class _$$GenreImplCopyWith<$Res> implements $GenreCopyWith<$Res> {
  factory _$$GenreImplCopyWith(
          _$GenreImpl value, $Res Function(_$GenreImpl) then) =
      __$$GenreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$GenreImplCopyWithImpl<$Res>
    extends _$GenreCopyWithImpl<$Res, _$GenreImpl>
    implements _$$GenreImplCopyWith<$Res> {
  __$$GenreImplCopyWithImpl(
      _$GenreImpl _value, $Res Function(_$GenreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$GenreImpl(
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

class _$GenreImpl implements _Genre {
  const _$GenreImpl({required this.id, required this.name});

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'Genre(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreImplCopyWith<_$GenreImpl> get copyWith =>
      __$$GenreImplCopyWithImpl<_$GenreImpl>(this, _$identity);
}

abstract class _Genre implements Genre {
  const factory _Genre({required final int id, required final String name}) =
      _$GenreImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$GenreImplCopyWith<_$GenreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StreamingProvider {
  int get providerId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  String? get logoPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StreamingProviderCopyWith<StreamingProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingProviderCopyWith<$Res> {
  factory $StreamingProviderCopyWith(
          StreamingProvider value, $Res Function(StreamingProvider) then) =
      _$StreamingProviderCopyWithImpl<$Res, StreamingProvider>;
  @useResult
  $Res call({int providerId, String providerName, String? logoPath});
}

/// @nodoc
class _$StreamingProviderCopyWithImpl<$Res, $Val extends StreamingProvider>
    implements $StreamingProviderCopyWith<$Res> {
  _$StreamingProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? providerName = null,
    Object? logoPath = freezed,
  }) {
    return _then(_value.copyWith(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as int,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      logoPath: freezed == logoPath
          ? _value.logoPath
          : logoPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamingProviderImplCopyWith<$Res>
    implements $StreamingProviderCopyWith<$Res> {
  factory _$$StreamingProviderImplCopyWith(_$StreamingProviderImpl value,
          $Res Function(_$StreamingProviderImpl) then) =
      __$$StreamingProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int providerId, String providerName, String? logoPath});
}

/// @nodoc
class __$$StreamingProviderImplCopyWithImpl<$Res>
    extends _$StreamingProviderCopyWithImpl<$Res, _$StreamingProviderImpl>
    implements _$$StreamingProviderImplCopyWith<$Res> {
  __$$StreamingProviderImplCopyWithImpl(_$StreamingProviderImpl _value,
      $Res Function(_$StreamingProviderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? providerName = null,
    Object? logoPath = freezed,
  }) {
    return _then(_$StreamingProviderImpl(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as int,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      logoPath: freezed == logoPath
          ? _value.logoPath
          : logoPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StreamingProviderImpl extends _StreamingProvider {
  const _$StreamingProviderImpl(
      {required this.providerId, required this.providerName, this.logoPath})
      : super._();

  @override
  final int providerId;
  @override
  final String providerName;
  @override
  final String? logoPath;

  @override
  String toString() {
    return 'StreamingProvider(providerId: $providerId, providerName: $providerName, logoPath: $logoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingProviderImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.logoPath, logoPath) ||
                other.logoPath == logoPath));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, providerId, providerName, logoPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingProviderImplCopyWith<_$StreamingProviderImpl> get copyWith =>
      __$$StreamingProviderImplCopyWithImpl<_$StreamingProviderImpl>(
          this, _$identity);
}

abstract class _StreamingProvider extends StreamingProvider {
  const factory _StreamingProvider(
      {required final int providerId,
      required final String providerName,
      final String? logoPath}) = _$StreamingProviderImpl;
  const _StreamingProvider._() : super._();

  @override
  int get providerId;
  @override
  String get providerName;
  @override
  String? get logoPath;
  @override
  @JsonKey(ignore: true)
  _$$StreamingProviderImplCopyWith<_$StreamingProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
