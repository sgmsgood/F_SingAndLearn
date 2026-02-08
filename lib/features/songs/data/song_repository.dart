
import 'package:supabase/supabase.dart';
import '../models/song.dart';


class SongRepository {
  final SupabaseClient _supabase;

  SongRepository(this._supabase);

  Future<List<Song>> fetchSongs() async {
    final response = await _supabase.from('songs').select();
    return response.map((e) => Song.fromJson(e)).toList();
  }

  Future<Set<String>> fetchFavoriteSongIds(String userId) async {
    final response = await _supabase
        .from('favorites')
        .select('song_id')
        .eq('user_id', userId);

    // Set으로 반환하면 나중에 contains() 검색 속도가 매우 빠릅니다.
    return (response as List).map((f) => f['song_id'] as String).toSet();
  }

  // [추가] 즐겨찾기 추가
  Future<void> addFavorite(String songId, String userId) async {
    await _supabase.from('favorites').insert({
      'song_id': songId,
      'user_id': userId,
    });
  }

  // [추가] 즐겨찾기 삭제
  Future<void> removeFavorite(String songId, String userId) async {
    await _supabase
        .from('favorites')
        .delete()
        .match({'song_id': songId, 'user_id': userId});
  }
}
