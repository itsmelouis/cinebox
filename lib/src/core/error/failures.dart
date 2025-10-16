import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base class for all failures in the application
@freezed
class Failure with _$Failure {
  const factory Failure.network([String? message]) = NetworkFailure;
  const factory Failure.server(int? statusCode, [String? message]) = ServerFailure;
  const factory Failure.cache([String? message]) = CacheFailure;
  const factory Failure.auth([String? message]) = AuthFailure;
  const factory Failure.unexpected([String? message]) = UnexpectedFailure;
  const factory Failure.validation(String message) = ValidationFailure;
}
