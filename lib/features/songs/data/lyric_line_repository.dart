import 'dart:convert';

import 'package:f_sing_and_learn/features/songs/models/lyrics/lyrics_line.dart';
import 'package:flutter/services.dart';
import 'package:supabase/supabase.dart';
import '../models/song.dart';
import '../models/song_bundle.dart';


class LyricLineRepository {
  final SupabaseClient _supabase;

  LyricLineRepository(this._supabase);

  Future<List<LyricsLine>> fetchLinesBySongId(String songId) async {
    print("@!!-->> songId:::: $songId");
    // final response = await _supabase
    //     .from('lyric_lines')
    //     .select()
    //     .eq('song_id', songId);

    final response = await _supabase
        .from('lyric_lines')
        .select('''
          *,
          line_word_occurrences (
            id,
            span_start,
            span_end,
            line_words (
              id,
              text,
              pinyin,
              meaning,
              level
            )
          )
        ''')
        .eq('song_id', songId);

    print("@!!-->>LyricsLine response: ${response}");
    return response.map((e) => LyricsLine.fromSupabase(e)).toList();
  }
}
