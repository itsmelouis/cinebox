import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data model for User
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? displayName,
    String? avatarUrl,
    required DateTime createdAt,
    DateTime? lastSignInAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert from Supabase User to UserModel
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: user.userMetadata?['full_name'] as String? ??
          user.userMetadata?['name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.parse(user.createdAt),
      lastSignInAt: user.lastSignInAt != null 
          ? DateTime.parse(user.lastSignInAt!)
          : null,
    );
  }

  /// Convert to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      lastSignInAt: lastSignInAt,
    );
  }
}
