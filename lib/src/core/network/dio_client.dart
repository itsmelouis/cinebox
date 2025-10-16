import 'package:dio/dio.dart';
import '../config/env_config.dart';

/// Dio client for TMDB API
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.tmdbBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      _ApiKeyInterceptor(),
      _LoggingInterceptor(),
    ]);
  }

  Dio get dio => _dio;
}

/// Interceptor to add API key to all requests
class _ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add API key as query parameter
    options.queryParameters['api_key'] = EnvConfig.tmdbApiKey;
    super.onRequest(options, handler);
  }
}

/// Interceptor for logging requests and responses
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('   Message: ${err.message}');
    super.onError(err, handler);
  }
}
