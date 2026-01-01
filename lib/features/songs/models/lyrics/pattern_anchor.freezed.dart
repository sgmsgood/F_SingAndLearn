// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_anchor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatternAnchor {

 String get label; Span get span;
/// Create a copy of PatternAnchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternAnchorCopyWith<PatternAnchor> get copyWith => _$PatternAnchorCopyWithImpl<PatternAnchor>(this as PatternAnchor, _$identity);

  /// Serializes this PatternAnchor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternAnchor&&(identical(other.label, label) || other.label == label)&&(identical(other.span, span) || other.span == span));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,span);

@override
String toString() {
  return 'PatternAnchor(label: $label, span: $span)';
}


}

/// @nodoc
abstract mixin class $PatternAnchorCopyWith<$Res>  {
  factory $PatternAnchorCopyWith(PatternAnchor value, $Res Function(PatternAnchor) _then) = _$PatternAnchorCopyWithImpl;
@useResult
$Res call({
 String label, Span span
});


$SpanCopyWith<$Res> get span;

}
/// @nodoc
class _$PatternAnchorCopyWithImpl<$Res>
    implements $PatternAnchorCopyWith<$Res> {
  _$PatternAnchorCopyWithImpl(this._self, this._then);

  final PatternAnchor _self;
  final $Res Function(PatternAnchor) _then;

/// Create a copy of PatternAnchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? span = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as Span,
  ));
}
/// Create a copy of PatternAnchor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanCopyWith<$Res> get span {
  
  return $SpanCopyWith<$Res>(_self.span, (value) {
    return _then(_self.copyWith(span: value));
  });
}
}


/// Adds pattern-matching-related methods to [PatternAnchor].
extension PatternAnchorPatterns on PatternAnchor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternAnchor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternAnchor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternAnchor value)  $default,){
final _that = this;
switch (_that) {
case _PatternAnchor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternAnchor value)?  $default,){
final _that = this;
switch (_that) {
case _PatternAnchor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  Span span)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternAnchor() when $default != null:
return $default(_that.label,_that.span);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  Span span)  $default,) {final _that = this;
switch (_that) {
case _PatternAnchor():
return $default(_that.label,_that.span);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  Span span)?  $default,) {final _that = this;
switch (_that) {
case _PatternAnchor() when $default != null:
return $default(_that.label,_that.span);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatternAnchor implements PatternAnchor {
  const _PatternAnchor({required this.label, this.span = const Span(start: 0, end: 0)});
  factory _PatternAnchor.fromJson(Map<String, dynamic> json) => _$PatternAnchorFromJson(json);

@override final  String label;
@override@JsonKey() final  Span span;

/// Create a copy of PatternAnchor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternAnchorCopyWith<_PatternAnchor> get copyWith => __$PatternAnchorCopyWithImpl<_PatternAnchor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatternAnchorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternAnchor&&(identical(other.label, label) || other.label == label)&&(identical(other.span, span) || other.span == span));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,span);

@override
String toString() {
  return 'PatternAnchor(label: $label, span: $span)';
}


}

/// @nodoc
abstract mixin class _$PatternAnchorCopyWith<$Res> implements $PatternAnchorCopyWith<$Res> {
  factory _$PatternAnchorCopyWith(_PatternAnchor value, $Res Function(_PatternAnchor) _then) = __$PatternAnchorCopyWithImpl;
@override @useResult
$Res call({
 String label, Span span
});


@override $SpanCopyWith<$Res> get span;

}
/// @nodoc
class __$PatternAnchorCopyWithImpl<$Res>
    implements _$PatternAnchorCopyWith<$Res> {
  __$PatternAnchorCopyWithImpl(this._self, this._then);

  final _PatternAnchor _self;
  final $Res Function(_PatternAnchor) _then;

/// Create a copy of PatternAnchor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? span = null,}) {
  return _then(_PatternAnchor(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as Span,
  ));
}

/// Create a copy of PatternAnchor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanCopyWith<$Res> get span {
  
  return $SpanCopyWith<$Res>(_self.span, (value) {
    return _then(_self.copyWith(span: value));
  });
}
}

// dart format on
