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
class AllSongs extends _$AllSongs {
  @override
  Future<List<Song>> build() async {
    final repository = ref.watch(songRepositoryProvider);
    return await repository.fetchSongs();
  }
}

@riverpod
class FavoriteIdsStream extends _$FavoriteIdsStream {
  @override
  Stream<Set<String>> build() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return Stream.value({});

    // favorites 테이블의 실시간 변화를 구독
    return Supabase.instance.client
        .from('favorites')
        .stream(primaryKey: ['id'])
        .eq('user_id', user.id)
        .map((data) {
      final ids = data.map((row) => row['song_id'] as String).toSet();
      print("실시간 즐겨찾기 ID 목록 업데이트: $ids"); // <-- 로그 확인
      return ids;
    });
  }
}

@riverpod
class FetchSongList extends _$FetchSongList {
  @override
  Future<List<Song>> build() async {
    final allSongsAsync = ref.watch(allSongsProvider);
    final favoriteIdsAsync = ref.watch(favoriteIdsStreamProvider);

    // 둘 다 데이터가 왔을 때 합칩니다.
    final songs = allSongsAsync.value ?? [];
    final favIds = favoriteIdsAsync.value ?? {};

    return songs.map((song) {
      return song.copyWith(isFavorite: favIds.contains(song.id));
    }).toList();
  }



  // UI에서 즉시 상태를 변경하기 위한 메서드 추가
  void toggleLocalFavorite(String songId, bool isFavorite) {
    final currentSongs = state.asData?.value;
    if (currentSongs == null) return;

    // 리스트 내에서 해당 곡만 찾아서 isFavorite 값만 반전시킴
    state = AsyncValue.data(
      currentSongs.map((song) {
        if (song.id == songId) {
          return song.copyWith(isFavorite: isFavorite);
        }
        return song;
      }).toList(),
    );
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

// 이 프로바이더는 상태를 갖지 않고, 오직 '행위'만 수행합니다.
@riverpod
class FavoriteToggler extends _$FavoriteToggler {
  @override
  Future<void> build() async {}

  Future<void> toggleFavoriteStatus(
    String songId,
    bool isCurrentlyFavorite,
  ) async {
    final auth = ref.read(authProvider.notifier);
    final user = auth.build(); // 현재 로그인된 사용자 정보 가져오기

    if (user == null) {
      throw Exception('로그인이 필요합니다.');
    }

    final repository = ref.read(songRepositoryProvider);
    // state = const AsyncValue.loading(); // 로딩 상태 시작

    try {
      if (isCurrentlyFavorite) {
        await repository.removeFavorite(songId, user.id);
      } else {
        await repository.addFavorite(songId, user.id);
      }
      // 성공적으로 완료되면, 노래 목록을 다시 불러와 UI를 갱신합니다.
      // ref
      //     .read(fetchSongListProvider.notifier)
      //     .toggleLocalFavorite(songId, !isCurrentlyFavorite);
    } catch (e) {
      rethrow;
    }
  }
}


