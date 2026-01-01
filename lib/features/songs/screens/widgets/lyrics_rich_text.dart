import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SpanRange {
  final int start; // inclusive
  final int end;   // exclusive
  const SpanRange(this.start, this.end);
}

class ClickableSpan {
  final String id;      // word.id or pattern.id
  final SpanRange span;
  const ClickableSpan({required this.id, required this.span});
}

RichText buildRichLine({
  required String text,
  required List<ClickableSpan> clickableSpans,
  required String? selectedId,
  required void Function(String id) onTap,
}) {
  // 1) span 경계점 수집
  final boundaries = <int>{0, text.length};
  for (final s in clickableSpans) {
    boundaries.add(s.span.start);
    boundaries.add(s.span.end);
  }
  final points = boundaries.toList()..sort();

  // 2) 각 구간을 TextSpan으로 생성
  final spans = <TextSpan>[];
  for (var i = 0; i < points.length - 1; i++) {
    final a = points[i];
    final b = points[i + 1];
    if (a >= b) continue;

    final chunk = text.substring(a, b);

    // 이 chunk가 어떤 clickable span 안에 포함되는지 체크
    final owner = clickableSpans.firstWhere(
          (s) => a >= s.span.start && b <= s.span.end,
      orElse: () => const ClickableSpan(id: '__none__', span: SpanRange(-1, -1)),
    );

    final isClickable = owner.id != '__none__';
    final isSelected = isClickable && owner.id == selectedId;

    spans.add(
      TextSpan(
        text: chunk,
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
          backgroundColor: isSelected ? Colors.pinkAccent.withOpacity(0.25) : null,
          decoration: isClickable ? TextDecoration.underline : null,
        ),
        recognizer: isClickable
            ? (TapGestureRecognizer()..onTap = () => onTap(owner.id))
            : null,
      ),
    );
  }

  return RichText(text: TextSpan(style: const TextStyle(color: Colors.black), children: spans));
}
