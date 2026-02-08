import 'package:mumu/features/songs/models/lyrics/lyric_word.dart';
import 'package:mumu/features/songs/models/lyrics/lyrics_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mumu/features/songs/models/song.dart';
import 'package:mumu/features/songs/providers/lyric_lines_provider.dart';
import 'package:mumu/features/songs/screens/widgets/favorite_button.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

class LyricsScreen extends ConsumerStatefulWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  ConsumerState<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends ConsumerState<LyricsScreen> with RouteAware {
  // 단어 상세 모달 (디자인 업그레이드)
  void _showWordDetail(BuildContext context, LyricsWord word) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // 배경 투명
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(28, 12, 28, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  word.text,
                  style: const TextStyle(
                    fontSize:24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "[ ${word.pinyin} ]",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0F5), // 연한 핑크톤 배경
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "뜻",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    word.meaning,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... 상단 import 및 _showWordDetail 함수는 동일하게 유지 ...

  @override
  Widget build(BuildContext context) {
    final lyricsAsync = ref.watch(lyricLinesProvider(widget.song.id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.song.title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FavoriteIconButton(
              isFavorite: widget.song.isFavorite,
              onChanged: (val) {},
            ),
          ),
        ],
      ),
      body: lyricsAsync.when(
        data: (lines) => ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: lines.length,
          itemBuilder: (context, index) {
            final line = lines[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // 카드 배경
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                // 문장 저장 버튼을 우측 상단에 올리기 위해 Stack 사용
                children: [
                  // 1. 카드 내용물
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 52, 24),
                    // 우측은 버튼 자리를 위해 패딩 더 줌
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 가사 (클릭 가능한 단어 포함)
                        _buildClickableLine(context, line),
                        const SizedBox(height: 12),
                        // 병음
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          child: Text(
                            line.pinyin,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 해석
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1D6E4).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            line.translation,
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xFF5E35B1).withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2. 문장 저장 버튼 (별 아이콘)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton(
                      icon: const Icon(Icons.star_border_rounded),
                      // 실제 상태에 따라 아이콘 변경 필요
                      color: const Color(0xFFD1C4E9),
                      onPressed: () {
                        // TODO: 문장 저장 로직 구현
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('문장이 저장되었습니다.'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('에러 발생: $err')),
      ),
    );
  }

  // 가사 렌더링 (좌측 정렬로 변경하여 카드 밸런스 유지)
  Widget _buildClickableLine(BuildContext context, LyricsLine line) {
    final String fullText = line.lineLyrics;
    final List<LyricsWord> words = line.words;
    final sortedWords = [...words]
      ..sort((a, b) => a.startSpan.compareTo(b.startSpan));

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (final word in sortedWords) {
      if (word.startSpan > lastIndex) {
        spans.add(
          TextSpan(text: fullText.substring(lastIndex, word.startSpan)),
        );
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () => _showWordDetail(context, word),
            child: Container(
              // 수평(4)뿐만 아니라 수직(4) 패딩도 주어 상자 자체의 높이를 확보
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              // 상자끼리 수직으로 붙지 않도록 마진 추가 (핵심!)
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
              decoration: BoxDecoration(
                color: word.isImportant
                    ? const Color(0xFFD1C4E9).withOpacity(0.5)
                    : const Color(0xFFF1D6E4).withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                fullText.substring(word.startSpan, word.endSpan),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // 글자 높이를 1.0으로 고정하여 상자 안에서 수직 중앙에 오도록 함
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

    if (lastIndex < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(lastIndex)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black87,
          // 전체 줄 간격을 1.8~2.0 정도로 넉넉히 주어 줄바꿈 시 상자 간 간격 확보
          height: 1.8,
        ),
        children: spans,
      ),
    );
  }
}
