import 'package:f_sing_and_learn/features/songs/models/lyrics/grammar_pattern.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/lyrics_line.dart';
import 'package:f_sing_and_learn/features/songs/screens/widgets/lyrics_rich_text.dart';
import 'package:f_sing_and_learn/shared/utils/fill_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_sing_and_learn/features/songs/models/song.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyrics_selection_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/lyrics/lyric_word.dart';

/// 이 routeObserver는 GoRouter 설정 시
/// MaterialApp.router(
///   routerConfig: goRouter,
///   navigatorObservers: () => [routeObserver],
/// )
/// 이런 식으로 등록해줘야 동작해.
final RouteObserver<PageRoute<dynamic>> routeObserver =
RouteObserver<PageRoute<dynamic>>();

class LyricsScreen extends ConsumerStatefulWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  ConsumerState<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends ConsumerState<LyricsScreen>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final selectedId = ref.watch(selectedTokenProvider);
    final lyrics = widget.song.lyrics;

    return Scaffold(
      appBar: AppBar(title: Text(widget.song.title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lyrics.lines.length,
        itemBuilder: (_, i) {
          final line = lyrics.lines[i];

          final wordClickable = makeClickableSpans(line: line.lineLyrics, words: line.words);

          final patternClickable = makePatternClickableSpans(patterns: line.patterns);

          patternClickable.forEach((e) => print("@!!--> ${e.id}"));

          final clickable = [
            ...wordClickable,
            ...patternClickable,
          ];

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              buildRichLine(
              text: line.lineLyrics,
              clickableSpans: clickable,
              selectedId: selectedId,
                  onTap: (id) {
                  print("@!!-->> id: $id");
                    ref.read(selectedTokenProvider.notifier).state = id;

                    if (id.startsWith('w_')) {
                      print("@!!--> word");
                      final w = line.words.firstWhere((e) => e.id == id);
                      showWordBottomSheet(context, word: w);
                      return;
                    }

                    if (id.startsWith('p_')) {
                      print("@!!--> pattern");
                      final p = line.patterns.firstWhere((e) => e.id == id);
                      showPatternBottomSheet(context, pattern: p);
                      return;
                    }
                  }
              ),
                // buildRichLine(
                //   text: line.lineLyrics,
                //   clickableSpans: clickable,
                //   selectedId: selectedId,
                //   onTap: (id) {
                //     ref.read(selectedTokenProvider.notifier).state =
                //     (selectedId == id) ? null : id;
                //
                //     // TODO: id로 word/pattern 찾아서 bottom sheet 띄우기
                //     // showWordBottomSheet(context, word: word).whenComplete(() {
                //     //   selectedTokenProvider.toggle(word.text);
                //     // });;
                //   },
                // ),
                const SizedBox(height: 6),
                Text(
                  line.translated,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> showTokenBottomSheet(
      BuildContext context, {
        required String id,
        required LyricsLine line,
        required WidgetRef ref,
      }) {
    // 1) word면 word 찾기
    final word = line.words.whereType<LyricsWord?>().firstWhere(
          (w) => w?.id == id,
      orElse: () => null,
    );

    print("@!!--> word: $word");

    if (word != null) {
      return showWordBottomSheet(
        context,
        word: word,
        // isSaved: ref.watch(savedWordIdsProvider).contains(word.id),
        onSavePressed: () {
          // ref.read(savedWordIdsProvider.notifier).toggle(word.id);
          Navigator.pop(context);
        },
      );
    }

    // 2) pattern이면 pattern 찾기
    final pattern = line.patterns.whereType<GrammarPattern?>().firstWhere(
          (p) => p?.id == id,
      orElse: () => null,
    );

    print("@!!--> pattern: $pattern");

    if (pattern != null) {
      return showPatternBottomSheet(context, pattern: pattern);
    }

    // 아무것도 못 찾으면 그냥 return
    return Future.value();
  }

  Future<void> showPatternBottomSheet(
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
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pattern.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(pattern.meaning, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(pattern.koreanTip, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              if (pattern.examples.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text('예문', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                ...pattern.examples.map((e) => Text('• $e')),
              ],
            ],
          ),
        );
      },
    );
  }




  Future<void> showWordBottomSheet(
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
                    word.text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      if (word.isImportant)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text('중요 단어'),
                            padding: EdgeInsets.symmetric(horizontal: 4),
                          ),
                        ),
                      // 내 단어 저장 상태가 있으면 조건부로 표시
                      if (word.isSaved)
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
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),

              Text(
                word.meaning,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              // 저장 버튼 (선택)
              if (onSavePressed != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onSavePressed,
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: Text(word.isSaved ? '저장됨' : '내 단어로 저장'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
