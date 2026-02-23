import 'package:supabase/supabase.dart';

import '../models/user_voca.dart';

class UserVocaRepository {
  final SupabaseClient _supabase;
  UserVocaRepository(this._supabase);

  String? get _userId => _supabase.auth.currentUser?.id;

  Future<List<UserVoca>> fetchMyVoca() async {
    final userId = _userId;
    if (userId == null) return [];

    final res = await _supabase
        .from('user_voca')
        .select('word_id, status, created_at, line_words(text, pinyin, meaning)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (res as List)
        .map((e) => UserVoca.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Set<String>> fetchMyWordIds() async {
    final userId = _userId;
    if (userId == null) return {};

    final res = await _supabase
        .from('user_voca')
        .select('word_id')
        .eq('user_id', userId);

    return (res as List).map((e) => e['word_id'] as String).toSet();
  }

  Future<void> add({
    required String wordId,
    String? sourceSongId,
    String? sourceLineId,
  }) async {
    final userId = _userId;
    if (userId == null) return;

    await _supabase.from('user_voca').insert({
      'word_id': wordId,
      'user_id': userId,
      'status': 'unknown',
      if (sourceSongId != null) 'source_song_id': sourceSongId,
      if (sourceLineId != null) 'source_line_id': sourceLineId,
    });
  }

  Future<void> remove({required String wordId}) async {
    final userId = _userId;
    if (userId == null) return;

    await _supabase.from('user_voca').delete().match({
      'user_id': userId,
      'word_id': wordId,
    });
  }

  Future<void> updateStatus({
    required String wordId,
    required String status, // 'unknown'|'known'
  }) async {
    final userId = _userId;
    if (userId == null) return;

    await _supabase.from('user_voca').update({'status': status}).match({
      'user_id': userId,
      'word_id': wordId,
    });
  }
}