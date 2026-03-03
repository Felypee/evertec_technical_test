// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  username: json['username'] as String,
  lastLogin: json['lastLogin'] == null
      ? null
      : DateTime.parse(json['lastLogin'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'username': instance.username,
  'lastLogin': instance.lastLogin?.toIso8601String(),
};
