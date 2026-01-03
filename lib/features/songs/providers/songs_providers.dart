import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/song_repository.dart';
import '../models/song.dart';

part 'songs_providers.g.dart';

@riverpod
class SongRepositoryNotifier extends _$SongRepositoryNotifier {
  @override
  SongRepository build() {
    return SongRepository(Supabase.instance.client);
  }
}

@riverpod
class FetchSongList extends _$FetchSongList {
  @override
  Future<List<Song>> build() async {
    // 클래스형에서는 ref.watch 대신 그냥 ref.watch를 씁니다 (this.ref)
    final repository = ref.watch(songRepositoryProvider);
    return repository.fetchSongs();
  }
}