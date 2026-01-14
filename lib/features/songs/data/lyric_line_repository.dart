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

    final response = await _supabase
        .from('lyric_lines')
        .select('''
        id, 
        line_lyrics, 
        translation, 
        line_pinyin,
        line_word_occurrences (
          id, 
          line_id, 
          word_id, 
          is_important, 
          start_span, 
          end_span,
          line_words (
            text, 
            pinyin, 
            meaning
          )
        )
      ''')
        .eq('song_id', songId)
        .order('line_index', ascending: true);

    return (response as List).map((data) => LyricsLine.fromJson(data)).toList();
  }
}
