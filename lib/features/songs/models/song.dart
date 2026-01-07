import 'package:freezed_annotation/freezed_annotation.dart';
// import 'lyrics/song_lyrics.dart';

part 'song.freezed.dart';
part 'song.g.dart';

@freezed
abstract class Song with _$Song {
  const factory Song({
    required String id,
    required String title,
    required String singer,
    @JsonKey(name: 'pinyin_title') @Default('') String pinyinTitle,
    @JsonKey(name: 'nickname') @Default('') String nickname,
    @Default('') String youtubeLink,
    @Default(false) bool isFavorite,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}