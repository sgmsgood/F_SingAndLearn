import 'package:f_sing_and_learn/features/songs/models/lyrics/span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lyric_word.freezed.dart';
// part 'lyric_word.g.dart';

@freezed
abstract class LyricsWord with _$LyricsWord {
  const factory LyricsWord({
    // @Default('') String id,
    // required String text,
    // required String type,
    // @Default('') String pinyin,
    // @Default('') String meaning,
    required String id,             // line_word_occurrences.id
    required String lineId,         // line_id
    required String wordId,         // word_id
    required String text,           // line_words.text (조인 데이터)
    @Default('') String pinyin,     // line_words.pinyin
    @Default('') String meaning,    // line_words.meaning
    @Default(false) bool isImportant, // is_important
    required int startSpan,         // start_span
    required int endSpan,           // end_span
  }) = _LyricsWord;

  factory LyricsWord.fromJson(Map<String, dynamic> json) {
    // 1. 조인되어 넘어온 line_words 테이블 데이터 추출
    final wordTable = json['line_words'] as Map<String, dynamic>? ?? {};

    return LyricsWord(
      id: json['id']?.toString() ?? '',
      lineId: json['line_id']?.toString() ?? '',
      wordId: json['word_id']?.toString() ?? '',
      // 조인된 테이블에서 값 추출
      text: wordTable['text'] ?? '',
      pinyin: wordTable['pinyin'] ?? '',
      meaning: wordTable['meaning'] ?? '',
      // 테이블 필드명 그대로 매핑
      isImportant: json['is_important'] ?? false,
      startSpan: json['start_span'] as int? ?? 0,
      endSpan: json['end_span'] as int? ?? 0,
    );
  }
}