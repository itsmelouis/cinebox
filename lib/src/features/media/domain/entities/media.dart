import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';

/// Media entity representing a movie or TV show
@freezed
class Media with _$Media {
  const factory Media({
    required int id,
    required String mediaType, // 'movie' or 'tv'
    required String title,
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
    Map<String, List<StreamingProvider>>? streamingProviders,
  }) = _Media;

  const Media._();

  /// Get full poster URL
  String get posterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : '';

  /// Get full backdrop URL
  String get backdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : '';

  /// Get formatted release year
  String? get releaseYear => releaseDate?.year.toString();

  /// Get formatted vote average (e.g., "8.4")
  String get formattedVoteAverage =>
      voteAverage != null ? voteAverage!.toStringAsFixed(1) : 'N/A';
}

/// Genre entity
@freezed
class Genre with _$Genre {
  const factory Genre({
    required int id,
    required String name,
  }) = _Genre;
}

/// Streaming provider entity
@freezed
class StreamingProvider with _$StreamingProvider {
  const factory StreamingProvider({
    required int providerId,
    required String providerName,
    String? logoPath,
  }) = _StreamingProvider;

  const StreamingProvider._();

  /// Get full logo URL
  String get logoUrl => logoPath != null
      ? 'https://image.tmdb.org/t/p/original$logoPath'
      : '';
}
