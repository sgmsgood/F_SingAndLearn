import 'package:f_sing_and_learn/features/songs/models/lyrics/pattern_anchor.dart';
import 'package:f_sing_and_learn/features/songs/models/lyrics/span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'grammar_pattern.freezed.dart';
part 'grammar_pattern.g.dart';


@freezed
abstract class GrammarPattern with _$GrammarPattern {
  const factory GrammarPattern({
    @Default('') String id,
    required String name,
    @Default('') String meaning,
    @Default('') String koreanTip,
    @Default(<String>['']) List<String> examples,

    // anchors만 있어도 MVP 가능
    @Default(<PatternAnchor>[]) List<PatternAnchor> anchors,

    // 선택: 전체 구조 구간
    @Default(Span(start: 0, end: 1)) Span? structureSpan,
  }) = _GrammarPattern;

  factory GrammarPattern.fromJson(Map<String, dynamic> json) => _$GrammarPatternFromJson(json);
}