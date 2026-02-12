import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/lyrics/lyric_word.dart';
import '../../models/lyrics/lyrics_line.dart';

class ClickableWordCard extends StatelessWidget {
  final LyricsLine line;
  const ClickableWordCard({required this.line});

  @override
  Widget build(BuildContext context) {
    final sortedWords = [...line.words]..sort((a, b) => a.startSpan.compareTo(b.startSpan));

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (final word in sortedWords) {
      if (word.startSpan > lastIndex) {
        spans.add(TextSpan(text: line.lineLyrics.substring(lastIndex, word.startSpan)));
      }
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () => _showWordDetail(context, word),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: word.isImportant
                    ? const Color(0xFFD1C4E9).withOpacity(0.5)
                    : const Color(0xFFF1D6E4).withOpacity(0.4),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                line.lineLyrics.substring(word.startSpan, word.endSpan),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  color: word.isImportant ? const Color(0xFF5E35B1) : Colors.black87,
                ),
              ),
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
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        padding: EdgeInsets.fromLTRB(28.w, 12.h, 28.w, 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 45.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  word.text,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  "[ ${word.pinyin} ]",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0F5),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "뜻",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    word.meaning,
                    style: TextStyle(fontSize: 20.sp, color: Colors.black87, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
