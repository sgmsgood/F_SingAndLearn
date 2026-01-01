// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  nickname: json['nickname'] as String,
  birthYear: json['birthYear'] as String,
  gender: (json['gender'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  locale: json['locale'] as String? ?? 'ko-KR',
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'nickname': instance.nickname,
  'birthYear': instance.birthYear,
  'gender': instance.gender,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'locale': instance.locale,
};
