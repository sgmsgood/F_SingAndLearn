// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Song _$SongFromJson(Map<String, dynamic> json) => _Song(
  id: json['id'] as String,
  title: json['title'] as String,
  pinyinTitle: json['pinyinTitle'] as String? ?? '',
  name: json['name'] as String,
  nickname: json['nickname'] as String? ?? '',
  youtubeLink: json['youtubeLink'] as String? ?? '',
  isFavorite: json['isFavorite'] as bool? ?? false,
  lyrics:
      (json['lyrics'] as List<dynamic>?)
          ?.map((e) => LyricsLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SongToJson(_Song instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'pinyinTitle': instance.pinyinTitle,
  'name': instance.name,
  'nickname': instance.nickname,
  'youtubeLink': instance.youtubeLink,
  'isFavorite': instance.isFavorite,
  'lyrics': instance.lyrics,
};
