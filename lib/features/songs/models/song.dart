import 'package:freezed_annotation/freezed_annotation.dart';

import 'lyrics/lyrics_line.dart';
import 'lyrics/song_lyrics.dart';

part 'song.freezed.dart';
part 'song.g.dart';

@freezed
abstract class Song with _$Song {
  const factory Song({
    required String id,
    required String title,
    @Default('') String pinyinTitle,
    required String name,

    // JSON 키가 nickname 이니까 name 지정
    @JsonKey(name: 'nickname') @Default('') String nickname,

    @Default('') String youtubeLink,
    @Default(false) bool isFavorite,
    @Default([]) List<LyricsLine> lyrics,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}