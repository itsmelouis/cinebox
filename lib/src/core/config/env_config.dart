import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration class
class EnvConfig {
  // TMDB Configuration
  static String get tmdbApiKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static String get tmdbBaseUrl => dotenv.env['TMDB_BASE_URL'] ?? 'https://api.themoviedb.org/3';

  // GitHub OAuth Configuration
  static String get githubClientId => dotenv.env['GITHUB_CLIENT_ID'] ?? '';
  static String get githubClientSecret => dotenv.env['GITHUB_CLIENT_SECRET'] ?? '';

  // Supabase Configuration
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get supabaseServiceRoleKey => dotenv.env['SUPABASE_SERVICE_ROLE_KEY'] ?? '';

  /// Validate that all required environment variables are set
  static bool validate() {
    final required = [
      tmdbApiKey,
      supabaseUrl,
      supabaseAnonKey,
    ];

    return required.every((value) => value.isNotEmpty);
  }

  /// Get validation errors
  static List<String> getValidationErrors() {
    final errors = <String>[];

    if (tmdbApiKey.isEmpty) errors.add('TMDB_API_KEY is missing');
    if (supabaseUrl.isEmpty) errors.add('SUPABASE_URL is missing');
    if (supabaseAnonKey.isEmpty) errors.add('SUPABASE_ANON_KEY is missing');

    return errors;
  }
}
