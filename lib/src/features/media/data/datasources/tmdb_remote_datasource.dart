import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/media_model.dart';

part 'tmdb_remote_datasource.g.dart';

/// Remote data source for TMDB API
@RestApi()
abstract class TmdbRemoteDataSource {
  factory TmdbRemoteDataSource(Dio dio, {String baseUrl}) =
      _TmdbRemoteDataSource;

  /// Get movie details
  @GET('/movie/{id}')
  Future<MediaModel> getMovieDetails(
    @Path('id') int id,
    @Query('language') String language,
    @Query('append_to_response') String appendToResponse,
  );

  /// Get TV show details
  @GET('/tv/{id}')
  Future<MediaModel> getTvDetails(
    @Path('id') int id,
    @Query('language') String language,
    @Query('append_to_response') String appendToResponse,
  );

  /// Get movie watch providers
  @GET('/movie/{id}/watch/providers')
  Future<Map<String, dynamic>> getMovieWatchProviders(
    @Path('id') int id,
  );

  /// Get TV watch providers
  @GET('/tv/{id}/watch/providers')
  Future<Map<String, dynamic>> getTvWatchProviders(
    @Path('id') int id,
  );

  /// Search multi (movies and TV shows)
  @GET('/search/multi')
  Future<Map<String, dynamic>> searchMulti(
    @Query('query') String query,
    @Query('language') String language,
  );

  /// Get trending (all media types)
  @GET('/trending/all/week')
  Future<Map<String, dynamic>> getTrending(
    @Query('language') String language,
  );

  /// Get popular movies
  @GET('/movie/popular')
  Future<Map<String, dynamic>> getPopularMovies(
    @Query('language') String language,
  );

  /// Get popular TV shows
  @GET('/tv/popular')
  Future<Map<String, dynamic>> getPopularTvShows(
    @Query('language') String language,
  );
}
