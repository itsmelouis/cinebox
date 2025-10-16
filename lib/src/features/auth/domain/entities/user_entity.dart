import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// User entity representing an authenticated user
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? displayName,
    String? avatarUrl,
    required DateTime createdAt,
    DateTime? lastSignInAt,
  }) = _UserEntity;

  const UserEntity._();

  /// Get display name or fallback to email
  String get name => displayName ?? email.split('@').first;
}
