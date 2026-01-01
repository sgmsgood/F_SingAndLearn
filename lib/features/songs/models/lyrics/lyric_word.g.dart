// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LyricsWord _$LyricsWordFromJson(Map<String, dynamic> json) => _LyricsWord(
  id: json['id'] as String? ?? '',
  text: json['text'] as String,
  pinyin: json['pinyin'] as String? ?? '',
  meaning: json['meaning'] as String? ?? '',
  span: Span.fromJson(json['span'] as Map<String, dynamic>),
  isImportant: json['isImportant'] as bool? ?? false,
  isSaved: json['isSaved'] as bool? ?? false,
);

Map<String, dynamic> _$LyricsWordToJson(_LyricsWord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'pinyin': instance.pinyin,
      'meaning': instance.meaning,
      'span': instance.span,
      'isImportant': instance.isImportant,
      'isSaved': instance.isSaved,
    };
