// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_pattern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GrammarPattern _$GrammarPatternFromJson(Map<String, dynamic> json) =>
    _GrammarPattern(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      meaning: json['meaning'] as String? ?? '',
      koreanTip: json['koreanTip'] as String? ?? '',
      examples:
          (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[''],
      anchors:
          (json['anchors'] as List<dynamic>?)
              ?.map((e) => PatternAnchor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PatternAnchor>[],
      structureSpan: json['structureSpan'] == null
          ? const Span(start: 0, end: 1)
          : Span.fromJson(json['structureSpan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GrammarPatternToJson(_GrammarPattern instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'meaning': instance.meaning,
      'koreanTip': instance.koreanTip,
      'examples': instance.examples,
      'anchors': instance.anchors,
      'structureSpan': instance.structureSpan,
    };
