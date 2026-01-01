import 'package:freezed_annotation/freezed_annotation.dart';
part 'span.freezed.dart';
part 'span.g.dart';

@freezed
abstract class Span with _$Span {
  const factory Span({
    required int start, // inclusive
    required int end,   // exclusive
  }) = _Span;

  factory Span.fromJson(Map<String, dynamic> json) => _$SpanFromJson(json);
}
