import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../user/auth/providers/auth_provider.dart';
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

@riverpod
class FavoriteToggler extends _$FavoriteToggler {
  @override
  Future<void> build() async {
    // 이 프로바이더는 상태를 갖지 않고, 오직 '행위'만 수행합니다.
  }

  Future<void> toggleFavoriteStatus(String songId, bool isCurrentlyFavorite) async {
    final auth = ref.read(authProvider.notifier);
    final user = auth.build(); // 현재 로그인된 사용자 정보 가져오기

    // 1. 로그인 상태 확인
    if (user == null) {
      throw Exception('로그인이 필요합니다.');
    }

    final repository = ref.read(songRepositoryProvider);
    state = const AsyncValue.loading(); // 로딩 상태 시작

    try {
      if (isCurrentlyFavorite) {
        // 즐겨찾기 상태이면 -> 삭제
        await repository.removeFavorite(songId, user.id);
      } else {
        // 즐겨찾기 상태가 아니면 -> 추가
        await repository.addFavorite(songId, user.id);
      }
      // 성공적으로 완료되면, 노래 목록을 다시 불러와 UI를 갱신합니다.
      ref.invalidate(fetchSongListProvider);
      state = const AsyncValue.data(null); // 로딩 상태 종료
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // 에러 상태
      rethrow;
    }
  }
}