
import 'package:mumu/features/songs/models/lyrics/lyrics_line.dart';
import 'package:supabase/supabase.dart';


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
        .order('play_timestamp', ascending: true);

    return (response as List).map((data) => LyricsLine.fromJson(data)).toList();
  }
}
