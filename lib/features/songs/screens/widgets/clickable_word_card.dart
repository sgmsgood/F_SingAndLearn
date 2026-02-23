import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../favorites/data/user_voca_repository.dart';
import '../../models/lyrics/lyric_word.dart';
import '../../models/lyrics/lyrics_line.dart';

class ClickableWordCard extends StatelessWidget {
  final LyricsLine line;

  const ClickableWordCard({required this.line, super.key});

  @override
  Widget build(BuildContext context) {
    final sortedWords = [...line.words]
      ..sort((a, b) => a.startSpan.compareTo(b.startSpan));

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (final word in sortedWords) {
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
                  color: word.isImportant
                      ? const Color(0xFF5E35B1)
                      : Colors.black87,
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
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser; // null 가능
    final repo = UserVocaRepository(supabase);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        // ✅ 로그인 안 되어 있으면 그냥 false
        final Future<bool> futureIsSaved = (user == null)
            ? Future.value(false)
            : repo
                  .fetchMyVoca()
                  .then((set) => set.contains(word.wordId));

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          padding: EdgeInsets.fromLTRB(28.w, 12.h, 28.w, 40.h),
          child: FutureBuilder<bool>(
            future: futureIsSaved,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
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
                    const Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30.h),
                  ],
                );
              }

              // ✅ Future 결과를 "초기값"으로만 쓰고, 이후는 local state로 관리
              bool isSaved = snap.data ?? false;
              bool isBusy = false;

              return StatefulBuilder(
                builder: (context, setModalState) {
                  Future<void> toggle() async {
                    // ✅ 비로그인은 "false 표시" + 누르면 로그인 안내만
                    if (user == null) {
                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                        const SnackBar(content: Text('즐겨찾기는 로그인 후 사용할 수 있어요.')),
                      );
                      return;
                    }
                    if (isBusy) return;

                    setModalState(() => isBusy = true);

                    try {
                      final userId = user.id;

                      if (isSaved) {
                        await repo.remove(wordId: word.wordId);
                        setModalState(() => isSaved = false);
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                          const SnackBar(content: Text('내 단어에서 제거했어요.')),
                        );
                      } else {
                        await repo.add(wordId: word.wordId);
                        setModalState(() => isSaved = true);
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                          const SnackBar(content: Text('내 단어에 추가했어요.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        sheetContext,
                      ).showSnackBar(SnackBar(content: Text('처리 실패: $e')));
                    } finally {
                      setModalState(() => isBusy = false);
                    }
                  }

                  return Column(
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
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    word.text,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -1,
                                      color: const Color(0xFF4A4A4A),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Flexible(
                                  child: Text(
                                    "[ ${word.pinyin} ]",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ✅ 즐겨찾기 버튼 (로그인 안돼도 보여주되, 누르면 안내만)
                          IconButton(
                            onPressed: isBusy ? null : toggle,
                            tooltip: isSaved ? '내 단어에서 제거' : '내 단어에 추가',
                            icon: isBusy
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    isSaved
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                  ),
                            color: isSaved
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black54,
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
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.7),
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              word.meaning,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
