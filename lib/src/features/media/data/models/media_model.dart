import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/media.dart';

part 'media_model.freezed.dart';
part 'media_model.g.dart';

/// Data model for Media
@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required int id,
    @JsonKey(name: 'media_type') String? mediaType,
    String? title,
    String? name, // TV shows use 'name' instead of 'title'
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
        Map<String, dynamic>? streamingProviders,
  }) = _MediaModel;

  const MediaModel._();

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  /// Convert to domain entity
  Media toEntity() {
    return Media(
      id: id,
      mediaType: mediaType ?? 'unknown',
      title: title ?? name ?? 'Unknown',
      originalTitle: originalTitle ?? originalName,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: _parseDate(releaseDate ?? firstAirDate),
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      originalLanguage: originalLanguage,
      genres: genres?.map((g) => g.toEntity()).toList(),
      runtime: runtime,
      status: status,
      tagline: tagline,
      homepage: homepage,
      streamingProviders: _parseStreamingProviders(streamingProviders),
    );
  }

  /// Convert from Supabase JSON
  factory MediaModel.fromSupabase(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] as int,
      mediaType: json['media_type'] as String,
      title: json['title'] as String?,
      name: null,
      originalTitle: json['original_title'] as String?,
      originalName: null,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      firstAirDate: null,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      originalLanguage: json['original_language'] as String?,
      genres: (json['genres'] as List?)
          ?.map((g) => GenreModel.fromJson(g as Map<String, dynamic>))
          .toList(),
      runtime: json['runtime'] as int?,
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      homepage: json['homepage'] as String?,
      streamingProviders: json['streaming_providers'] as Map<String, dynamic>?,
    );
  }

  /// Convert to Supabase JSON
  Map<String, dynamic> toSupabase() {
    // mediaType is required for Supabase
    if (mediaType == null) {
      throw Exception('mediaType cannot be null when saving to Supabase');
    }
    
    return {
      'id': id,
      'media_type': mediaType!,
      'title': title ?? name ?? 'Unknown',
      'original_title': originalTitle ?? originalName,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate ?? firstAirDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'original_language': originalLanguage,
      'genres': genres?.map((g) => g.toJson()).toList(),
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'homepage': homepage,
      'streaming_providers': streamingProviders,
    };
  }

  static DateTime? _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (_) {
      return null;
    }
  }

  static Map<String, List<StreamingProvider>>? _parseStreamingProviders(
      Map<String, dynamic>? data) {
    if (data == null) return null;

    final result = <String, List<StreamingProvider>>{};
    data.forEach((country, providers) {
      if (providers is List) {
        result[country] = providers
            .map((p) => StreamingProvider(
                  providerId: p['provider_id'] as int,
                  providerName: p['provider_name'] as String,
                  logoPath: p['logo_path'] as String?,
                ))
            .toList();
      }
    });
    return result;
  }
}

/// Genre model
@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    required int id,
    required String name,
  }) = _GenreModel;

  const GenreModel._();

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Genre toEntity() => Genre(id: id, name: name);
}
