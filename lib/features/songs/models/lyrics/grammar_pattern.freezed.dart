// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grammar_pattern.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GrammarPattern {

 String get id; String get name; String get meaning; String get koreanTip; List<String> get examples;// anchors만 있어도 MVP 가능
 List<PatternAnchor> get anchors;// 선택: 전체 구조 구간
 Span? get structureSpan;
/// Create a copy of GrammarPattern
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GrammarPatternCopyWith<GrammarPattern> get copyWith => _$GrammarPatternCopyWithImpl<GrammarPattern>(this as GrammarPattern, _$identity);

  /// Serializes this GrammarPattern to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GrammarPattern&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.koreanTip, koreanTip) || other.koreanTip == koreanTip)&&const DeepCollectionEquality().equals(other.examples, examples)&&const DeepCollectionEquality().equals(other.anchors, anchors)&&(identical(other.structureSpan, structureSpan) || other.structureSpan == structureSpan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,meaning,koreanTip,const DeepCollectionEquality().hash(examples),const DeepCollectionEquality().hash(anchors),structureSpan);

@override
String toString() {
  return 'GrammarPattern(id: $id, name: $name, meaning: $meaning, koreanTip: $koreanTip, examples: $examples, anchors: $anchors, structureSpan: $structureSpan)';
}


}

/// @nodoc
abstract mixin class $GrammarPatternCopyWith<$Res>  {
  factory $GrammarPatternCopyWith(GrammarPattern value, $Res Function(GrammarPattern) _then) = _$GrammarPatternCopyWithImpl;
@useResult
$Res call({
 String id, String name, String meaning, String koreanTip, List<String> examples, List<PatternAnchor> anchors, Span? structureSpan
});


$SpanCopyWith<$Res>? get structureSpan;

}
/// @nodoc
class _$GrammarPatternCopyWithImpl<$Res>
    implements $GrammarPatternCopyWith<$Res> {
  _$GrammarPatternCopyWithImpl(this._self, this._then);

  final GrammarPattern _self;
  final $Res Function(GrammarPattern) _then;

/// Create a copy of GrammarPattern
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? meaning = null,Object? koreanTip = null,Object? examples = null,Object? anchors = null,Object? structureSpan = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,koreanTip: null == koreanTip ? _self.koreanTip : koreanTip // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<String>,anchors: null == anchors ? _self.anchors : anchors // ignore: cast_nullable_to_non_nullable
as List<PatternAnchor>,structureSpan: freezed == structureSpan ? _self.structureSpan : structureSpan // ignore: cast_nullable_to_non_nullable
as Span?,
  ));
}
/// Create a copy of GrammarPattern
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanCopyWith<$Res>? get structureSpan {
    if (_self.structureSpan == null) {
    return null;
  }

  return $SpanCopyWith<$Res>(_self.structureSpan!, (value) {
    return _then(_self.copyWith(structureSpan: value));
  });
}
}


/// Adds pattern-matching-related methods to [GrammarPattern].
extension GrammarPatternPatterns on GrammarPattern {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GrammarPattern value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GrammarPattern() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GrammarPattern value)  $default,){
final _that = this;
switch (_that) {
case _GrammarPattern():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GrammarPattern value)?  $default,){
final _that = this;
switch (_that) {
case _GrammarPattern() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String meaning,  String koreanTip,  List<String> examples,  List<PatternAnchor> anchors,  Span? structureSpan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GrammarPattern() when $default != null:
return $default(_that.id,_that.name,_that.meaning,_that.koreanTip,_that.examples,_that.anchors,_that.structureSpan);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String meaning,  String koreanTip,  List<String> examples,  List<PatternAnchor> anchors,  Span? structureSpan)  $default,) {final _that = this;
switch (_that) {
case _GrammarPattern():
return $default(_that.id,_that.name,_that.meaning,_that.koreanTip,_that.examples,_that.anchors,_that.structureSpan);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String meaning,  String koreanTip,  List<String> examples,  List<PatternAnchor> anchors,  Span? structureSpan)?  $default,) {final _that = this;
switch (_that) {
case _GrammarPattern() when $default != null:
return $default(_that.id,_that.name,_that.meaning,_that.koreanTip,_that.examples,_that.anchors,_that.structureSpan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GrammarPattern implements GrammarPattern {
  const _GrammarPattern({this.id = '', required this.name, this.meaning = '', this.koreanTip = '', final  List<String> examples = const <String>[''], final  List<PatternAnchor> anchors = const <PatternAnchor>[], this.structureSpan = const Span(start: 0, end: 1)}): _examples = examples,_anchors = anchors;
  factory _GrammarPattern.fromJson(Map<String, dynamic> json) => _$GrammarPatternFromJson(json);

@override@JsonKey() final  String id;
@override final  String name;
@override@JsonKey() final  String meaning;
@override@JsonKey() final  String koreanTip;
 final  List<String> _examples;
@override@JsonKey() List<String> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}

// anchors만 있어도 MVP 가능
 final  List<PatternAnchor> _anchors;
// anchors만 있어도 MVP 가능
@override@JsonKey() List<PatternAnchor> get anchors {
  if (_anchors is EqualUnmodifiableListView) return _anchors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_anchors);
}

// 선택: 전체 구조 구간
@override@JsonKey() final  Span? structureSpan;

/// Create a copy of GrammarPattern
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GrammarPatternCopyWith<_GrammarPattern> get copyWith => __$GrammarPatternCopyWithImpl<_GrammarPattern>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GrammarPatternToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GrammarPattern&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.koreanTip, koreanTip) || other.koreanTip == koreanTip)&&const DeepCollectionEquality().equals(other._examples, _examples)&&const DeepCollectionEquality().equals(other._anchors, _anchors)&&(identical(other.structureSpan, structureSpan) || other.structureSpan == structureSpan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,meaning,koreanTip,const DeepCollectionEquality().hash(_examples),const DeepCollectionEquality().hash(_anchors),structureSpan);

@override
String toString() {
  return 'GrammarPattern(id: $id, name: $name, meaning: $meaning, koreanTip: $koreanTip, examples: $examples, anchors: $anchors, structureSpan: $structureSpan)';
}


}

/// @nodoc
abstract mixin class _$GrammarPatternCopyWith<$Res> implements $GrammarPatternCopyWith<$Res> {
  factory _$GrammarPatternCopyWith(_GrammarPattern value, $Res Function(_GrammarPattern) _then) = __$GrammarPatternCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String meaning, String koreanTip, List<String> examples, List<PatternAnchor> anchors, Span? structureSpan
});


@override $SpanCopyWith<$Res>? get structureSpan;

}
/// @nodoc
class __$GrammarPatternCopyWithImpl<$Res>
    implements _$GrammarPatternCopyWith<$Res> {
  __$GrammarPatternCopyWithImpl(this._self, this._then);

  final _GrammarPattern _self;
  final $Res Function(_GrammarPattern) _then;

/// Create a copy of GrammarPattern
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? meaning = null,Object? koreanTip = null,Object? examples = null,Object? anchors = null,Object? structureSpan = freezed,}) {
  return _then(_GrammarPattern(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,koreanTip: null == koreanTip ? _self.koreanTip : koreanTip // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<String>,anchors: null == anchors ? _self._anchors : anchors // ignore: cast_nullable_to_non_nullable
as List<PatternAnchor>,structureSpan: freezed == structureSpan ? _self.structureSpan : structureSpan // ignore: cast_nullable_to_non_nullable
as Span?,
  ));
}

/// Create a copy of GrammarPattern
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanCopyWith<$Res>? get structureSpan {
    if (_self.structureSpan == null) {
    return null;
  }

  return $SpanCopyWith<$Res>(_self.structureSpan!, (value) {
    return _then(_self.copyWith(structureSpan: value));
  });
}
}

// dart format on
