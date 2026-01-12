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
    final repository = ref.watch(songRepositoryProvider);
    return repository.fetchSongs();
  }
}

@riverpod
class FetchFavoriteSongList extends _$FetchFavoriteSongList {
  @override
  Future<List<Song>> build() async {
    final songsAsyncValue = ref.watch(fetchSongListProvider);

    return songsAsyncValue.when(
      data: (songs) => songs.where((song) => song.isFavorite).toList(),
      loading: () => [],
      error: (e, st) => [],
    );
  }
}