import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/media.dart';
import '../../domain/usecases/get_trending_media.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_popular_tv_shows.dart';
import '../../domain/usecases/search_media.dart';

part 'discovery_viewmodel.freezed.dart';

/// State for Discovery page
@freezed
class DiscoveryState with _$DiscoveryState {
  const factory DiscoveryState({
    @Default([]) List<Media> trendingMedia,
    @Default([]) List<Media> popularMovies,
    @Default([]) List<Media> popularTvShows,
    @Default([]) List<Media> searchResults,
    @Default(false) bool isLoading,
    @Default(false) bool isSearching,
    @Default(false) bool isSearchLoading,
    String? errorMessage,
    @Default('Tous') String selectedType,
    @Default(0.0) double minRating,
  }) = _DiscoveryState;
}

/// ViewModel for Discovery page
class DiscoveryViewModel extends StateNotifier<DiscoveryState> {
  final GetTrendingMedia _getTrendingMedia;
  final GetPopularMovies _getPopularMovies;
  final GetPopularTvShows _getPopularTvShows;
  final SearchMedia _searchMedia;

  DiscoveryViewModel({
    required GetTrendingMedia getTrendingMedia,
    required GetPopularMovies getPopularMovies,
    required GetPopularTvShows getPopularTvShows,
    required SearchMedia searchMedia,
  })  : _getTrendingMedia = getTrendingMedia,
        _getPopularMovies = getPopularMovies,
        _getPopularTvShows = getPopularTvShows,
        _searchMedia = searchMedia,
        super(const DiscoveryState());

  /// Load all media (trending, popular movies, popular TV shows)
  Future<void> loadAllMedia() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Load all in parallel
    final results = await Future.wait([
      _getTrendingMedia(),
      _getPopularMovies(),
      _getPopularTvShows(),
    ]);

    final trendingResult = results[0];
    final moviesResult = results[1];
    final tvShowsResult = results[2];

    // Check if any failed
    String? error;
    if (trendingResult.isLeft()) {
      trendingResult.fold((failure) => error = failure.message, (_) {});
    }

    final trendingList = trendingResult.fold((_) => <Media>[], (media) => media);
    final moviesList = moviesResult.fold((_) => <Media>[], (media) => media);
    final tvShowsList = tvShowsResult.fold((_) => <Media>[], (media) => media);

    // Update state with all data
    state = state.copyWith(
      isLoading: false,
      trendingMedia: trendingList,
      popularMovies: moviesList,
      popularTvShows: tvShowsList,
      errorMessage: error,
    );
  }

  /// Load trending media (legacy method for compatibility)
  Future<void> loadTrendingMedia() async {
    await loadAllMedia();
  }

  /// Search media
  Future<void> searchMedia(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(
        isSearching: false,
        searchResults: [],
        isSearchLoading: false,
      );
      return;
    }

    state = state.copyWith(
      isSearching: true,
      isSearchLoading: true,
      errorMessage: null,
    );

    final result = await _searchMedia(query: query);

    result.fold(
      (failure) {
        state = state.copyWith(
          isSearchLoading: false,
          errorMessage: failure.message,
        );
      },
      (mediaList) {
        state = state.copyWith(
          isSearchLoading: false,
          searchResults: mediaList,
          errorMessage: null,
        );
      },
    );
  }

  /// Clear search
  void clearSearch() {
    state = state.copyWith(
      isSearching: false,
      searchResults: [],
      isSearchLoading: false,
    );
  }

  /// Update filter: type
  void updateTypeFilter(String type) {
    state = state.copyWith(selectedType: type);
  }

  /// Update filter: min rating
  void updateMinRating(double rating) {
    state = state.copyWith(minRating: rating);
  }

  /// Reset filters
  void resetFilters() {
    state = state.copyWith(
      selectedType: 'Tous',
      minRating: 0.0,
    );
  }

  /// Get filtered trending media
  List<Media> getFilteredTrendingMedia() {
    return state.trendingMedia.where((media) {
      final matchesType = state.selectedType == 'Tous' ||
          (state.selectedType == 'Films' && media.mediaType == 'movie') ||
          (state.selectedType == 'Séries' && media.mediaType == 'tv');
      final matchesRating =
          media.voteAverage == null || media.voteAverage! >= state.minRating;
      return matchesType && matchesRating;
    }).toList();
  }
}
