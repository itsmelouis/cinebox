// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaModelImpl _$$MediaModelImplFromJson(Map<String, dynamic> json) =>
    _$MediaModelImpl(
      id: (json['id'] as num).toInt(),
      mediaType: json['media_type'] as String,
      title: json['title'] as String?,
      name: json['name'] as String?,
      originalTitle: json['original_title'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      originalLanguage: json['original_language'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      runtime: (json['runtime'] as num?)?.toInt(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      homepage: json['homepage'] as String?,
      streamingProviders: json['streaming_providers'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MediaModelImplToJson(_$MediaModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': instance.mediaType,
      'title': instance.title,
      'name': instance.name,
      'original_title': instance.originalTitle,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'first_air_date': instance.firstAirDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'original_language': instance.originalLanguage,
      'genres': instance.genres,
      'runtime': instance.runtime,
      'status': instance.status,
      'tagline': instance.tagline,
      'homepage': instance.homepage,
      'streaming_providers': instance.streamingProviders,
    };

_$GenreModelImpl _$$GenreModelImplFromJson(Map<String, dynamic> json) =>
    _$GenreModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$GenreModelImplToJson(_$GenreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
