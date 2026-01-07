import 'package:f_sing_and_learn/features/songs/models/song.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyric_lines_provider.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyrics_selection_provider.dart';
import 'package:f_sing_and_learn/features/songs/screens/widgets/lyrics_rich_text.dart';
import 'package:f_sing_and_learn/shared/utils/fill_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/lyrics_controller.dart';

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

class _LyricsScreenState extends ConsumerState<LyricsScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    print("@!!-->> song: ${widget.song}");
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
    final lyricsAsync = ref.watch(lyricLinesProvider(widget.song.id));
    // final lyrics = widget.song.lyrics;

    return Scaffold(
      appBar: AppBar(title: Text(widget.song.title)),
      body: lyricsAsync.when(
        data: (lines) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lines.length,
            itemBuilder: (_, i) {
              final line = lines[i];

              final wordClickable = makeClickableSpans(
                line: line.lineLyrics,
                words: line.words,
              );

              print("@!!-->> wordClickable: $wordClickable");

              // final patternClickable = makePatternClickableSpans(
              //   patterns: line.patterns,
              // );

              final clickable = [...wordClickable];

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
                        print("@!!-->> id:: $id");
                        ref
                            .read(lyricsControllerProvider.notifier)
                            .onTokenTapped(context, id, line);
                      },
                    ),
                    const SizedBox(height: 6),
                    Text(
                      line.linePinyin,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      line.translated,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
