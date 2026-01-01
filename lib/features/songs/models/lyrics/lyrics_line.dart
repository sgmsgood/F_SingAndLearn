import 'package:freezed_annotation/freezed_annotation.dart';
import 'grammar_pattern.dart';
import 'lyric_word.dart';

part 'lyrics_line.freezed.dart';
part 'lyrics_line.g.dart';

@freezed
abstract class LyricsLine with _$LyricsLine {
  const factory LyricsLine({
    required String lineLyrics,
    required String translated,
    @Default(<LyricsWord>[]) List<LyricsWord> words,
    @Default(<GrammarPattern>[]) List<GrammarPattern> patterns,
  }) = _LyricsLine;

  factory LyricsLine.fromJson(Map<String, dynamic> json) => _$LyricsLineFromJson(json);
}