import 'package:f_sing_and_learn/features/songs/data/lyric_line_repository.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/lyrics_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/song_repository.dart';
import '../models/song.dart';

part 'lyric_lines_provider.g.dart';

@riverpod
class LyricLineRepositoryNotifier extends _$LyricLineRepositoryNotifier {
  @override
  LyricLineRepository build() {
    return LyricLineRepository(Supabase.instance.client);
  }
}

@riverpod
class LyricLines extends _$LyricLines {
  @override
  Future<List<LyricsLine>> build(String songId)  {
    // 위에서 이름을 바꿨으므로, 여기서도 바뀐 Provider를 불러와야 합니다.
    final repository = ref.watch(lyricLineRepositoryProvider);
print("@!!-->> lyrics Line Repository:: ${repository.toString()}");
    return repository.fetchLinesBySongId(songId);
  }
}