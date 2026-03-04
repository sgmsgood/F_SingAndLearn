import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/lyrics/lyric_word.dart';
import '../../models/lyrics/lyrics_line.dart';
import '../../providers/save_voca_providers.dart';
import 'word_detail_sheet.dart';

class ClickableWordCard extends ConsumerWidget {
  final LyricsLine line;

  const ClickableWordCard({required this.line, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedAsync = ref.watch(savedVocaProvider);
    final savedSet = savedAsync.value ?? <String>{};

    final sortedWords = [...line.words]
      ..sort((a, b) => a.startSpan.compareTo(b.startSpan));

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (final word in sortedWords) {
      final isSaved = savedSet.contains(word.wordId);

      if (word.startSpan > lastIndex) {
        spans.add(
          TextSpan(text: line.lineLyrics.substring(lastIndex, word.startSpan)),
        );
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () => _showWordDetail(context, word),
            child: _WordChip(
              text: line.lineLyrics.substring(word.startSpan, word.endSpan),
              isImportant: word.isImportant,
              isSaved: isSaved,
            ),
          ),
        ),
      );

      lastIndex = word.endSpan;
    }

    if (lastIndex < line.lineLyrics.length) {
      spans.add(TextSpan(text: line.lineLyrics.substring(lastIndex)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18.sp, color: Colors.black87, height: 1.8),
        children: spans,
      ),
    );
  }

  void _showWordDetail(BuildContext context, LyricsWord word) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => WordDetailSheet(word: word),
    );
  }
}

class _WordChip extends StatelessWidget {
  final String text;
  final bool isImportant;
  final bool isSaved;

  const _WordChip({
    required this.text,
    required this.isImportant,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isImportant
            ? const Color(0xFFD1C4E9).withOpacity(0.5)
            : const Color(0xFFF1D6E4).withOpacity(0.4),
        borderRadius: BorderRadius.circular(8.r),
        border: isSaved 
            ? Border.all(color: const Color(0xFF5E35B1).withOpacity(0.3), width: 1)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          height: 1.0,
          color: isImportant ? const Color(0xFF5E35B1) : Colors.black87,
        ),
      ),
    );
  }
}
