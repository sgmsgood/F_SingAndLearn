import 'package:f_sing_and_learn/features/songs/models/lyrics/grammar_pattern.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/lyric_word.dart';

import '../../features/songs/screens/widgets/lyrics_rich_text.dart';

List<ClickableSpan> makeClickableSpans({
  required String line,
  required List<LyricsWord> words,
}) {
  var cursor = 0;
  final res = <ClickableSpan>[];

  for (final w in words) {
    final idx = line.indexOf(w.text, cursor);
    if (idx == -1) continue;

    final start = idx;
    final end = idx + w.text.length;
    cursor = end;

    res.add(ClickableSpan(
      id: w.id, // 없으면 text로 임시 id 써도 됨
      span: SpanRange(start, end),
    ));
  }

  return res;
}

List<ClickableSpan> makePatternClickableSpans({
  required List<GrammarPattern> patterns,
}) {
  final res = <ClickableSpan>[];

  for (final p in patterns) {
    // anchors span들 중 유효한 것만 수집
    final spans = p.anchors
        .map((a) => a.span)
        .where((s) => s.start >= 0 && s.end > s.start)
        .toList();

    if (spans.isEmpty) continue;

    // 패턴 전체 범위를 anchors span의 min/max로 확장
    final start = spans.map((s) => s.start).reduce((a, b) => a < b ? a : b);
    final end = spans.map((s) => s.end).reduce((a, b) => a > b ? a : b);

    res.add(ClickableSpan(id: p.id, span: SpanRange(start, end)));
  }

  return res;
}



