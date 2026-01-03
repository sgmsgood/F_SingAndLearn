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
}
