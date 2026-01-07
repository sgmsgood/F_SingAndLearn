import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/lyrics/grammar_pattern.dart';
import '../models/lyrics/lyric_word.dart'; // 파일명/클래스명 확인 (LyricsWord vs LyricWord)
import '../models/lyrics/lyrics_line.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyrics_selection_provider.dart';

part 'lyrics_controller.g.dart';

@riverpod
class LyricsController extends _$LyricsController {
  @override
  void build() {
    return;
  }

  /// [수정된 로직]
  /// ID에 접두사가 없으므로, 리스트를 검색해서 타입을 찾습니다.
  void onTokenTapped(BuildContext context, String id, LyricsLine line) {
    print("@!!-->> id: $id / line: $line");
    // 1. 선택된 ID 상태 업데이트 (하이라이팅용)
    ref.read(selectedTokenProvider.notifier).set(id);

    // 2. 먼저 '단어(words)' 리스트에서 해당 ID를 찾아봅니다.
    try {
      // firstWhere는 요소를 찾으면 반환하고, 없으면 에러를 던지거나 orElse를 실행합니다.
      final word = line.words.firstWhere((element) => element.id == id);

      print("@!!-->> word:: $word");
      _showWordSheet(context, word: word);
      return;
    } catch (_) {
      // 단어 리스트에 없으면 무시하고 다음 단계로 진행
    }

    // 3. '패턴(patterns)' 리스트에서 해당 ID를 찾아봅니다.
    try {
      final pattern = line.patterns.firstWhere((element) => element.id == id);

      // 찾았다면 패턴 바텀시트를 띄우고 종료
      _showPatternSheet(context, pattern: pattern);
      return;
    } catch (_) {
      // 패턴 리스트에도 없으면 무시
    }

    // 4. 둘 다 없으면 디버그 로그 출력 (데이터 정합성 문제)
    debugPrint('Tapped ID $id not found in words or patterns of line ${line.id}');
  }

  // --- 아래는 바텀시트 UI 코드 (기존 유지 또는 필드명 수정) ---

  Future<void> _showWordSheet(
      BuildContext context, {
        required LyricsWord word,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: 30 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.text,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                word.pinyin,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Text(
                word.meaning,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPatternSheet(
      BuildContext context, {
        required GrammarPattern pattern,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: 30 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // GrammarPattern 모델 필드명에 맞춰 수정하세요 (예: pattern vs name)
              // Text(
              //   pattern.pattern, // 혹은 pattern.name
              //   style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 12),
              // Text(
              //   pattern.explanation, // 혹은 pattern.meaning
              //   style: const TextStyle(fontSize: 16),
              // ),
            ],
          ),
        );
      },
    );
  }
}