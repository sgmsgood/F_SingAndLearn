import 'package:freezed_annotation/freezed_annotation.dart';
import 'lyric_word.dart'; // 이 파일 안에 클래스명이 LyricsWord 인지 확인 필요

part 'lyrics_line.freezed.dart';
// part 'lyrics_line.g.dart';

@freezed
abstract class LyricsLine with _$LyricsLine {
  const factory LyricsLine({
    required String id,
    @JsonKey(name: 'line_lyrics') required String lineLyrics,
    @Default('') String translation,
    @JsonKey(name: 'line_pinyin') @Default('') String pinyin,
    @Default([]) List<LyricsWord> words,
  }) = _LyricsLine;

  factory LyricsLine.fromJson(Map<String, dynamic> json) {
    // 2. 조인된 occurrences 리스트 추출
    final List occurrencesList = json['line_word_occurrences'] ?? [];

    return LyricsLine(
      id: json['id'].toString(),
      lineLyrics: json['line_lyrics'] ?? '',
      translation: json['translation'] ?? '',
      pinyin: json['line_pinyin'] ?? '',
      words: occurrencesList.map((occ) => LyricsWord.fromJson(occ)).toList(),
    );
  }
}