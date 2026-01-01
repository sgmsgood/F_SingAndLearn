import 'package:f_sing_and_learn/features/songs/models/lyrics/span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lyric_word.freezed.dart';
part 'lyric_word.g.dart';

@freezed
abstract class LyricsWord with _$LyricsWord {
  const factory LyricsWord({
    @Default('') String id,
    required String text,
    @Default('') String pinyin,
    @Default('') String meaning,
    required Span span,
    @Default(false) bool isImportant,
    @Default(false) bool isSaved,
  }) = _LyricsWord;

  factory LyricsWord.fromJson(Map<String, dynamic> json) => _$LyricsWordFromJson(json);
}