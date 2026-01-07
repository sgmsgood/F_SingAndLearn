import 'package:f_sing_and_learn/features/songs/models/lyrics/span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'grammar_pattern.dart';
import 'lyric_word.dart'; // 이 파일 안에 클래스명이 LyricsWord 인지 확인 필요

part 'lyrics_line.freezed.dart';
// part 'lyrics_line.g.dart';

@freezed
abstract class LyricsLine with _$LyricsLine {
  const factory LyricsLine({
    required String id,
    @JsonKey(name: 'song_id') required String songId,
    @JsonKey(name: 'line_lyrics') required String lineLyrics,
    @JsonKey(name: 'line_pinyin') @Default("") String linePinyin,
    required String translated,
    @Default(<LyricsWord>[]) List<LyricsWord> words,
    @Default(<GrammarPattern>[]) List<GrammarPattern> patterns,
  }) = _LyricsLine;

  factory LyricsLine.fromSupabase(Map<String, dynamic> json) {
    final occurrences = json['line_word_occurrences'] as List<dynamic>? ?? [];

    final List<LyricsWord> parsedWords = [];
    final List<GrammarPattern> parsedPatterns = [];

    for (var occ in occurrences) {
      // line_words 테이블의 정보를 가져옵니다.
      final wordInfo = occ['line_words'] as Map<String, dynamic>;
      final type = wordInfo['type'] as String? ?? 'word'; // type 확인 (word / pattern)

      // 공통적으로 사용하는 Span 정보
      final span = Span(
        start: occ['span_start'] as int,
        end: occ['span_end'] as int,
      );

      if (type == 'word') {
        parsedWords.add(LyricsWord(
          id: wordInfo['id'].toString(), // UUID 그대로 사용
          text: wordInfo['text'] ?? '',
          pinyin: wordInfo['pinyin'] ?? '',
          meaning: wordInfo['meaning'] ?? '',
          span: span, type: '',
        ));
      } else if (type == 'pattern') {
        // GrammarPattern 클래스 구조에 맞춰서 데이터 매핑
        // parsedPatterns.add(GrammarPattern(
        //   id: wordInfo['id'].toString(), // UUID 그대로 사용
        //   pattern: wordInfo['text'] ?? '', // 패턴 텍스트
        //   explanation: wordInfo['meaning'] ?? '', // 설명
        //   span: span, name: '',
        // ));
      }
    }

    return LyricsLine(
      id: json['id'].toString(),
      songId: json['song_id']?.toString() ?? '',
      lineLyrics: json['line_lyrics'] ?? json['text_chinese'] ?? '',
      linePinyin: json['line_pinyin'] ?? json['text_pinyin'] ?? '',
      translated: json['translated'] ?? json['translation'] ?? '',
      words: parsedWords,
      patterns: parsedPatterns,
    );
  }
}