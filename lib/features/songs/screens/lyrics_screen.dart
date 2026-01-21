import 'package:f_sing_and_learn/features/songs/models/lyrics/lyric_word.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/lyrics_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_sing_and_learn/features/songs/models/song.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyric_lines_provider.dart';
import 'package:f_sing_and_learn/features/songs/screens/widgets/favorite_button.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

class LyricsScreen extends ConsumerStatefulWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  ConsumerState<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends ConsumerState<LyricsScreen> with RouteAware {
  // 단어 클릭 시 하단 시트를 보여주는 함수
  void _showWordDetail(BuildContext context, LyricsWord word) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              word.text,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              word.pinyin,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const Divider(height: 32),
            const Text(
              "Meaning",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              word.meaning,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lyricsAsync = ref.watch(lyricLinesProvider(widget.song.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        actions: [
          FavoriteIconButton(
            isFavorite: widget.song.isFavorite,
            onChanged: (val) {},
          ),
        ],
      ),
      body: lyricsAsync.when(
        data: (lines) => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: lines.length,
          itemBuilder: (context, index) {
            final line = lines[index];
            print("@!!-->> line: $line");
            for (var e in line.words) {
              print('e: $e');
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. 클릭 가능한 가사 라인 빌드
                  _buildClickableLine(context, line),
                  const SizedBox(height: 8),
                  // 2. 병음 & 해석
                  Text(
                    line.pinyin,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    line.translation,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[400]),
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

  Widget _buildClickableLine(BuildContext context, LyricsLine line) {
    final String fullText = line.lineLyrics;
    final List<LyricsWord> words = line.words;

    // 시작 위치 순으로 단어 정렬
    final sortedWords = [...words]
      ..sort((a, b) => a.startSpan.compareTo(b.startSpan));

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (final word in sortedWords) {
      // 단어 이전의 일반 텍스트 추가
      print("@!!-->> word: $word");
      if (word.startSpan > lastIndex) {
        spans.add(
          TextSpan(text: fullText.substring(lastIndex, word.startSpan)),
        );
      }

      // 클릭 가능한 단어 영역 (WidgetSpan으로 감싸서 터치 영역 확보)
      spans.add(
        WidgetSpan(
          baseline: TextBaseline.alphabetic,
          alignment: PlaceholderAlignment.baseline,
          child: GestureDetector(
            onTap: () => _showWordDetail(context, word),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                color: word.isImportant
                    ? Colors.yellow.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: Text(
                fullText.substring(word.startSpan, word.endSpan),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
      lastIndex = word.endSpan;
    }

    // 남은 뒷부분 텍스트 추가
    if (lastIndex < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(lastIndex)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
          height: 1.5,
        ),
        children: spans,
      ),
    );
  }
}
