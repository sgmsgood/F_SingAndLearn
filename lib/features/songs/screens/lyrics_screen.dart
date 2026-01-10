import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:collection/collection.dart';
import 'package:f_sing_and_learn/features/songs/models/song.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/lyrics_line.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/lyric_word.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/grammar_pattern.dart';
import 'package:f_sing_and_learn/features/songs/providers/lyrics_controller.dart';

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
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) routeObserver.subscribe(this, route);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // song.lyrics가 null일 경우를 대비해 빈 리스트로 처리
    final lyrics = widget.song.lyrics ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
        itemCount: lyrics.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final line = lyrics[i];

          return _LyricCellInlineChips(
            line: line,
            onTapToken: (tokenId) {
              ref
                  .read(lyricsControllerProvider.notifier)
                  .onTokenTapped(context, tokenId, line);
            },
          );
        },
      ),
    );
  }
}

/// 가사 한 줄을 표시하는 위젯 (인라인 칩 포함)
class _LyricCellInlineChips extends StatelessWidget {
  final LyricsLine line;
  final void Function(String tokenId) onTapToken;

  const _LyricCellInlineChips({
    required this.line,
    required this.onTapToken,
  });

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    final border = Theme.of(context).dividerColor.withOpacity(0.08);
    final subColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border),
        ),
        padding: const EdgeInsets.fromLTRB(14, 14, 10, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 가사 + 인라인 칩
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _InlineChipRichText(
                    text: line.lineLyrics,
                    words: line.words,
                    patterns: line.patterns,
                    onTapToken: onTapToken,
                    textStyle:
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),

            // 번역
            if (line.translated.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                line.translated,
                style: TextStyle(fontSize: 15, color: subColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 텍스트 내부에 칩을 그려주는 RichText 위젯
class _InlineChipRichText extends StatelessWidget {
  final String text;
  final List<LyricsWord> words;
  final List<GrammarPattern>? patterns;
  final void Function(String tokenId) onTapToken;
  final TextStyle? textStyle;

  const _InlineChipRichText({
    required this.text,
    required this.words,
    this.patterns,
    required this.onTapToken,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final baseStyle = textStyle ?? DefaultTextStyle.of(context).style;

    // 1. words와 patterns를 하나의 리스트로 합칩니다.
    final allTokens = [
      ...words.map((w) => _TokenSpan(
        id: w.id,
        label: w.text,
        start: w.span?.start,
        end: w.span?.end,
      )),
      ...(patterns ?? []).mapIndexed((i, p) => _TokenSpan(
        id: p.id,
        label: p.name,
        start: p.anchors[i].span.start,
        end: p.anchors[i].span.end,
      )),
    ];

    // 2. 위치 정보가 있는 토큰만 필터링합니다.
    final spanTokens = allTokens.where((t) => t.start != null).toList();

    // [수정] 3. 정렬 로직 변경: 시작점이 같으면 긴 토큰이 먼저 오도록 정렬
    spanTokens.sort((a, b) {
      final startCompare = a.start!.compareTo(b.start!);
      if (startCompare != 0) {
        return startCompare;
      }
      // 시작점이 같으면, end가 더 큰 (더 긴) 토큰이 앞으로 오게 함 (내림차순)
      return b.end!.compareTo(a.end!);
    });

    final spans = <InlineSpan>[];
    int cursor = 0;

    // 4. 정렬된 토큰을 순회하며 RichText의 InlineSpan 리스트 생성
    for (final token in spanTokens) {
      // [수정] 현재 커서가 토큰의 시작점보다 뒤에 있다면,
      // 이 토큰은 이미 더 긴 토큰에 포함된 것이므로 건너뜁니다.
      if (cursor > token.start!) {
        continue;
      }

      // 현재 토큰 앞에 일반 텍스트가 있다면 추가
      if (cursor < token.start!) {
        spans.add(TextSpan(
          text: text.substring(cursor, token.start!),
          style: baseStyle,
        ));
      }

      // 현재 토큰 위치에 인라인 칩(WidgetSpan) 추가
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _InlineTokenChip(
              label: text.substring(token.start!, token.end!),
              color: primary,
              onTap: () => onTapToken(token.id),
            ),
          ),
        ),
      );
      cursor = token.end!;
    }

    // 5. 마지막 토큰 뒤에 남은 텍스트가 있다면 추가
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor), style: baseStyle));
    }

    // 6. 위치 정보가 없는 토큰들을 문장 끝에 칩으로 추가
    final tailTokens = allTokens.where((t) => t.start == null).toList();

    if (tailTokens.isNotEmpty) {
      spans.add(const TextSpan(text: '  '));
      for (final token in tailTokens) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _InlineTokenChip(
                label: token.label,
                color: primary,
                onTap: () => onTapToken(token.id),
              ),
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(children: spans),
      textScaler: MediaQuery.textScalerOf(context),
    );
  }
}

/// 인라인 칩 생성을 위한 중간 데이터 클래스
class _TokenSpan {
  final String id;
  final String label;
  final int? start;
  final int? end;

  _TokenSpan({
    required this.id,
    required this.label,
    this.start,
    this.end,
  });
}

/// 인라인으로 표시되는 작은 칩 위젯
class _InlineTokenChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _InlineTokenChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color.withOpacity(0.14);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 20,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}