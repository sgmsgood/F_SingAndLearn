// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_anchor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatternAnchor _$PatternAnchorFromJson(Map<String, dynamic> json) =>
    _PatternAnchor(
      label: json['label'] as String,
      span: json['span'] == null
          ? const Span(start: 0, end: 0)
          : Span.fromJson(json['span'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatternAnchorToJson(_PatternAnchor instance) =>
    <String, dynamic>{'label': instance.label, 'span': instance.span};
