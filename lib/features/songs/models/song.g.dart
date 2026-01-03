// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Song _$SongFromJson(Map<String, dynamic> json) => _Song(
  id: json['id'] as String,
  title: json['title'] as String,
  pinyinTitle: json['pinyin_title'] as String? ?? '',
  singer: json['singer'] as String,
  nickname: json['nickname'] as String? ?? '',
  youtubeLink: json['youtubeLink'] as String? ?? '',
  isFavorite: json['isFavorite'] as bool? ?? false,
  lyrics: json['lyrics'] == null
      ? const SongLyrics(chinese: '', lines: [])
      : SongLyrics.fromJson(json['lyrics'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SongToJson(_Song instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'pinyin_title': instance.pinyinTitle,
  'singer': instance.singer,
  'nickname': instance.nickname,
  'youtubeLink': instance.youtubeLink,
  'isFavorite': instance.isFavorite,
  'lyrics': instance.lyrics,
};
