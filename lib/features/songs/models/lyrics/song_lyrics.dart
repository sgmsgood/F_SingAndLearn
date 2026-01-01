import 'package:freezed_annotation/freezed_annotation.dart';

import 'lyrics_line.dart';

part 'song_lyrics.freezed.dart';
part 'song_lyrics.g.dart';


@freezed
abstract class SongLyrics with _$SongLyrics {
  const factory SongLyrics({
    required String chinese,
    required List<LyricsLine> lines,
  }) = _SongLyrics;

  factory SongLyrics.fromJson(Map<String, dynamic> json) =>
      _$SongLyricsFromJson(json);
}