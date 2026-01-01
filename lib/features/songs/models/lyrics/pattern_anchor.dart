import 'package:f_sing_and_learn/features/songs/models/lyrics/span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pattern_anchor.freezed.dart';
part 'pattern_anchor.g.dart';


@freezed
abstract class PatternAnchor with _$PatternAnchor {
  const factory PatternAnchor({
    required String label,
    @Default(Span(start: 0, end: 0)) Span span,
  }) = _PatternAnchor;

  factory PatternAnchor.fromJson(Map<String, dynamic> json) => _$PatternAnchorFromJson(json);
}