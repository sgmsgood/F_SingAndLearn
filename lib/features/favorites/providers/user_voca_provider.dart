import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../songs/providers/save_voca_providers.dart';
import '../data/user_voca_repository.dart';
import '../domain/voca_status.dart';
import '../models/user_voca.dart';

final userVocaRepositoryProvider = Provider<UserVocaRepository>((ref) {
  return UserVocaRepository(Supabase.instance.client);
});

/// 화면 표시용 모델 (domain 타입으로 변환)
class UserVocaItem {
  final String wordId;
  final String text;
  final String pinyin;
  final String meaning;
  final VocaStatus status;
  final DateTime createdAt;

  UserVocaItem({
    required this.wordId,
    required this.text,
    required this.pinyin,
    required this.meaning,
    required this.status,
    required this.createdAt,
  });

  factory UserVocaItem.fromRow(UserVoca row) {
    return UserVocaItem(
      wordId: row.wordId,
      text: row.text,
      pinyin: row.pinyin,
      meaning: row.meaning,
      status: VocaStatusX.fromDb(row.status),
      createdAt: row.createdAt,
    );
  }
}

final fetchUserVocaListProvider = FutureProvider.autoDispose<List<UserVocaItem>>((ref) async {
  final repo = ref.read(userVocaRepositoryProvider);
  final rows = await repo.fetchMyVoca();
  return rows.map(UserVocaItem.fromRow).toList();
});

/// 액션들: UI는 여기만 호출하면 됨
final userVocaActionsProvider = Provider<UserVocaActions>((ref) {
  return UserVocaActions(ref);
});

class UserVocaActions {
  final Ref _ref;
  UserVocaActions(this._ref);

  Future<void> remove(String wordId) async {
    final repo = _ref.read(userVocaRepositoryProvider);
    await repo.remove(wordId: wordId);
    
    // ✅ 1. 내 단어장 목록 새로고침
    _ref.invalidate(fetchUserVocaListProvider);
    
    // ✅ 2. 가사 화면의 책갈피 상태(Set<wordId>)도 함께 새로고침하여 아이콘 업데이트
    _ref.invalidate(savedVocaProvider);
  }

  Future<void> toggleStatus(UserVocaItem item) async {
    final repo = _ref.read(userVocaRepositoryProvider);
    final next = item.status.toggle();
    await repo.updateStatus(wordId: item.wordId, status: next.db);
    _ref.invalidate(fetchUserVocaListProvider);
  }
}
