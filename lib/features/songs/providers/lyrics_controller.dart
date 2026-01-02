import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/enums/lyrics_token_type.dart';
import '../models/lyrics/grammar_pattern.dart';
import '../models/lyrics/lyric_word.dart';
import '../models/lyrics/lyrics_line.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyrics_selection_provider.dart';

part 'lyrics_controller.g.dart';

@riverpod
class LyricsController extends _$LyricsController {
  @override
  void build() {
    return;
  }

  void onTokenTapped(BuildContext context, String id, LyricsLine line) {
    ref.read(selectedTokenProvider.notifier).set(id);

    final type = LyricsTokenType.fromId(id);

    switch (type) {
      case LyricsTokenType.word:
        final word = line.words.firstWhere((e) => e.id == id);
        _showWordSheet(context, word: word);
        break;

      case LyricsTokenType.pattern:
        final pattern = line.patterns.firstWhere((e) => e.id == id);
        _showPatternSheet(context, pattern: pattern);
        break;

      case LyricsTokenType.unknown:
        debugPrint('Unknown token id: $id');
        break;
    }
  }

  Future<void> _showPatternSheet(
    BuildContext context, {
    required GrammarPattern pattern,
  }) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pattern.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(pattern.meaning, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                pattern.koreanTip,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              if (pattern.examples.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  '예문',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                ...pattern.examples.map((e) => Text('• $e')),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _showWordSheet(
    BuildContext context, {
    required LyricsWord word,
    VoidCallback? onSavePressed,
  }) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    word?.text ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      if (word?.isImportant ?? false)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text('중요 단어'),
                            padding: EdgeInsets.symmetric(horizontal: 4),
                          ),
                        ),
                      // 내 단어 저장 상태가 있으면 조건부로 표시
                      if (word?.isSaved ?? false)
                        const Chip(
                          label: Text('내 단어'),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text(
                word.pinyin,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),

              Text(word.meaning, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 16),

              // 저장 버튼 (선택)
              if (onSavePressed != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onSavePressed,
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: Text((word?.isSaved ?? false) ? '저장됨' : '내 단어로 저장'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
