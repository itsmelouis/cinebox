// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastSignInAt: json['lastSignInAt'] == null
          ? null
          : DateTime.parse(json['lastSignInAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
    };
