import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:supabase/supabase.dart';
import '../models/song.dart';
import '../models/song_bundle.dart';


class SongRepository {
  final SupabaseClient _supabase;

  SongRepository(this._supabase);

  Future<List<Song>> fetchSongs() async {
    final response = await _supabase.from('songs').select();
    print("@!!-->> response: ${response}");
    return response.map((e) => Song.fromJson(e)).toList();
  }

  // [추가] 즐겨찾기 추가
  Future<void> addFavorite(String songId, String userId) async {
    await _supabase.from('favorite_songs').insert({
      'song_id': songId,
      'user_id': userId,
    });
  }

  // [추가] 즐겨찾기 삭제
  Future<void> removeFavorite(String songId, String userId) async {
    await _supabase
        .from('favorite_songs')
        .delete()
        .match({'song_id': songId, 'user_id': userId});
  }
}
