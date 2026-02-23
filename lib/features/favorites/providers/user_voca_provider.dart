import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    _ref.invalidate(fetchUserVocaListProvider);
  }

  Future<void> toggleStatus(UserVocaItem item) async {
    final repo = _ref.read(userVocaRepositoryProvider);
    final next = item.status.toggle();
    await repo.updateStatus(wordId: item.wordId, status: next.db);
    _ref.invalidate(fetchUserVocaListProvider);
  }
}