/// Base exception class
class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => 'AppException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class NetworkException extends AppException {
  NetworkException([String message = 'Network error occurred']) : super(message);
}

class ServerException extends AppException {
  ServerException(String message, [int? statusCode]) : super(message, statusCode);
}

class CacheException extends AppException {
  CacheException([String message = 'Cache error occurred']) : super(message);
}

class AuthException extends AppException {
  AuthException([String message = 'Authentication error occurred']) : super(message);
}

class ValidationException extends AppException {
  ValidationException(String message) : super(message);
}
