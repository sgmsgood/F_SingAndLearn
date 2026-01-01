// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_lyrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SongLyrics _$SongLyricsFromJson(Map<String, dynamic> json) => _SongLyrics(
  chinese: json['chinese'] as String,
  lines: (json['lines'] as List<dynamic>)
      .map((e) => LyricsLine.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SongLyricsToJson(_SongLyrics instance) =>
    <String, dynamic>{'chinese': instance.chinese, 'lines': instance.lines};
