import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../favorites/data/user_voca_repository.dart';
import '../../favorites/providers/user_voca_provider.dart';


final savedVocaProvider =
AsyncNotifierProvider<SavedVocaNotifier, Set<String>>(SavedVocaNotifier.new);

class SavedVocaNotifier extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    // 💡 내 단어장 리스트를 구독합니다. 
    // 리스트가 변경(invalidate)되면 이 Set 데이터도 자동으로 다시 계산됩니다.
    final vocaListAsync = ref.watch(fetchUserVocaListProvider);
    
    return vocaListAsync.when(
      data: (list) => list.map((e) => e.wordId).toSet(),
      error: (_, __) => <String>{},
      loading: () => state.value ?? <String>{}, 
    );
  }

  Future<void> toggle(String wordId) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final repo = UserVocaRepository(supabase);
    final isSaved = state.value?.contains(wordId) ?? false;

    try {
      if (isSaved) {
        await repo.remove(wordId: wordId);
      } else {
        await repo.add(wordId: wordId);
      }
      // ✅ 리스트 provider를 무효화하면 build()가 다시 실행되면서 
      // 가사 화면의 책갈피(Set)와 내 단어장 목록이 동시에 업데이트됩니다.
      ref.invalidate(fetchUserVocaListProvider);
    } catch (e) {
      rethrow;
    }
  }
}
