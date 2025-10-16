import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/media_supabase_datasource.dart';
import '../../data/datasources/tmdb_remote_datasource.dart';
import '../../data/repositories/media_repository_impl.dart';
import '../../domain/repositories/media_repository.dart';
import '../../domain/usecases/delete_user_media.dart';
import '../../domain/usecases/get_media_by_id.dart';
import '../../domain/usecases/get_trending_media.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_popular_tv_shows.dart';
import '../../domain/usecases/get_user_media.dart';
import '../../domain/usecases/get_user_media_list.dart';
import '../../domain/usecases/search_media.dart';
import '../../domain/usecases/upsert_user_media.dart';
import '../viewmodels/discovery_viewmodel.dart';
import '../viewmodels/media_detail_viewmodel.dart';
import '../viewmodels/my_list_viewmodel.dart';

// ============================================
// Network Providers
// ============================================

final dioClientProvider = Provider<Dio>((ref) {
  return DioClient().dio;
});

// ============================================
// Data Source Providers
// ============================================

final tmdbRemoteDataSourceProvider = Provider<TmdbRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return TmdbRemoteDataSource(dio);
});

final mediaSupabaseDataSourceProvider = Provider<MediaSupabaseDataSource>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return MediaSupabaseDataSourceImpl(supabaseClient);
});

// ============================================
// Repository Providers
// ============================================

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  final tmdbDataSource = ref.watch(tmdbRemoteDataSourceProvider);
  final supabaseDataSource = ref.watch(mediaSupabaseDataSourceProvider);
  
  return MediaRepositoryImpl(
    tmdbDataSource: tmdbDataSource,
    supabaseDataSource: supabaseDataSource,
  );
});

// ============================================
// Use Case Providers
// ============================================

final getMediaByIdProvider = Provider<GetMediaById>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return GetMediaById(repository);
});

final getTrendingMediaProvider = Provider<GetTrendingMedia>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return GetTrendingMedia(repository);
});

final getPopularMoviesProvider = Provider<GetPopularMovies>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return GetPopularMovies(repository);
});

final getPopularTvShowsProvider = Provider<GetPopularTvShows>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return GetPopularTvShows(repository);
});

final searchMediaProvider = Provider<SearchMedia>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return SearchMedia(repository);
});

final getUserMediaListProvider = Provider<GetUserMediaList>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return GetUserMediaList(repository);
});

final getUserMediaProvider = Provider<GetUserMedia>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return GetUserMedia(repository);
});

final upsertUserMediaProvider = Provider<UpsertUserMedia>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return UpsertUserMedia(repository);
});

final deleteUserMediaProvider = Provider<DeleteUserMedia>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return DeleteUserMedia(repository);
});

// ============================================
// ViewModel Providers
// ============================================

final discoveryViewModelProvider =
    StateNotifierProvider<DiscoveryViewModel, DiscoveryState>((ref) {
  final getTrendingMedia = ref.watch(getTrendingMediaProvider);
  final getPopularMovies = ref.watch(getPopularMoviesProvider);
  final getPopularTvShows = ref.watch(getPopularTvShowsProvider);
  final searchMedia = ref.watch(searchMediaProvider);

  return DiscoveryViewModel(
    getTrendingMedia: getTrendingMedia,
    getPopularMovies: getPopularMovies,
    getPopularTvShows: getPopularTvShows,
    searchMedia: searchMedia,
  );
});

final mediaDetailViewModelProvider =
    StateNotifierProvider.family<MediaDetailViewModel, MediaDetailState, String>(
  (ref, mediaKey) {
    final getMediaById = ref.watch(getMediaByIdProvider);
    final getUserMedia = ref.watch(getUserMediaProvider);
    final upsertUserMedia = ref.watch(upsertUserMediaProvider);

    return MediaDetailViewModel(
      getMediaById: getMediaById,
      getUserMedia: getUserMedia,
      upsertUserMedia: upsertUserMedia,
    );
  },
);

final myListViewModelProvider =
    StateNotifierProvider<MyListViewModel, MyListState>((ref) {
  final getUserMediaList = ref.watch(getUserMediaListProvider);
  final deleteUserMedia = ref.watch(deleteUserMediaProvider);

  return MyListViewModel(
    getUserMediaList: getUserMediaList,
    deleteUserMedia: deleteUserMedia,
  );
});
