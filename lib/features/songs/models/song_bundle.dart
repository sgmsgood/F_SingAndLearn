import 'package:freezed_annotation/freezed_annotation.dart';
import 'song.dart';

part 'song_bundle.freezed.dart';
part 'song_bundle.g.dart';

@freezed
abstract class SongBundle with _$SongBundle {
  const factory SongBundle({
    required String country,
    @JsonKey(name: 'list') required List<Song> list,
  }) = _SongBundle;

  factory SongBundle.fromJson(Map<String, dynamic> json) =>
      _$SongBundleFromJson(json);
}
