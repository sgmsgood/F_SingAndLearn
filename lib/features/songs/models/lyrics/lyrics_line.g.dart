// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LyricsLine _$LyricsLineFromJson(Map<String, dynamic> json) => _LyricsLine(
  lineLyrics: json['lineLyrics'] as String,
  translated: json['translated'] as String,
  words:
      (json['words'] as List<dynamic>?)
          ?.map((e) => LyricsWord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LyricsWord>[],
  patterns:
      (json['patterns'] as List<dynamic>?)
          ?.map((e) => GrammarPattern.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GrammarPattern>[],
);

Map<String, dynamic> _$LyricsLineToJson(_LyricsLine instance) =>
    <String, dynamic>{
      'lineLyrics': instance.lineLyrics,
      'translated': instance.translated,
      'words': instance.words,
      'patterns': instance.patterns,
    };
