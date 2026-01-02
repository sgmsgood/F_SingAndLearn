// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lyrics_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LyricsLine {

 String get lineLyrics; String get linePinyin; String get translated; List<LyricsWord> get words; List<GrammarPattern> get patterns;
/// Create a copy of LyricsLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LyricsLineCopyWith<LyricsLine> get copyWith => _$LyricsLineCopyWithImpl<LyricsLine>(this as LyricsLine, _$identity);

  /// Serializes this LyricsLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LyricsLine&&(identical(other.lineLyrics, lineLyrics) || other.lineLyrics == lineLyrics)&&(identical(other.linePinyin, linePinyin) || other.linePinyin == linePinyin)&&(identical(other.translated, translated) || other.translated == translated)&&const DeepCollectionEquality().equals(other.words, words)&&const DeepCollectionEquality().equals(other.patterns, patterns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineLyrics,linePinyin,translated,const DeepCollectionEquality().hash(words),const DeepCollectionEquality().hash(patterns));

@override
String toString() {
  return 'LyricsLine(lineLyrics: $lineLyrics, linePinyin: $linePinyin, translated: $translated, words: $words, patterns: $patterns)';
}


}

/// @nodoc
abstract mixin class $LyricsLineCopyWith<$Res>  {
  factory $LyricsLineCopyWith(LyricsLine value, $Res Function(LyricsLine) _then) = _$LyricsLineCopyWithImpl;
@useResult
$Res call({
 String lineLyrics, String linePinyin, String translated, List<LyricsWord> words, List<GrammarPattern> patterns
});




}
/// @nodoc
class _$LyricsLineCopyWithImpl<$Res>
    implements $LyricsLineCopyWith<$Res> {
  _$LyricsLineCopyWithImpl(this._self, this._then);

  final LyricsLine _self;
  final $Res Function(LyricsLine) _then;

/// Create a copy of LyricsLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineLyrics = null,Object? linePinyin = null,Object? translated = null,Object? words = null,Object? patterns = null,}) {
  return _then(_self.copyWith(
lineLyrics: null == lineLyrics ? _self.lineLyrics : lineLyrics // ignore: cast_nullable_to_non_nullable
as String,linePinyin: null == linePinyin ? _self.linePinyin : linePinyin // ignore: cast_nullable_to_non_nullable
as String,translated: null == translated ? _self.translated : translated // ignore: cast_nullable_to_non_nullable
as String,words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<LyricsWord>,patterns: null == patterns ? _self.patterns : patterns // ignore: cast_nullable_to_non_nullable
as List<GrammarPattern>,
  ));
}

}


/// Adds pattern-matching-related methods to [LyricsLine].
extension LyricsLinePatterns on LyricsLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LyricsLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LyricsLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LyricsLine value)  $default,){
final _that = this;
switch (_that) {
case _LyricsLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LyricsLine value)?  $default,){
final _that = this;
switch (_that) {
case _LyricsLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lineLyrics,  String linePinyin,  String translated,  List<LyricsWord> words,  List<GrammarPattern> patterns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LyricsLine() when $default != null:
return $default(_that.lineLyrics,_that.linePinyin,_that.translated,_that.words,_that.patterns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lineLyrics,  String linePinyin,  String translated,  List<LyricsWord> words,  List<GrammarPattern> patterns)  $default,) {final _that = this;
switch (_that) {
case _LyricsLine():
return $default(_that.lineLyrics,_that.linePinyin,_that.translated,_that.words,_that.patterns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lineLyrics,  String linePinyin,  String translated,  List<LyricsWord> words,  List<GrammarPattern> patterns)?  $default,) {final _that = this;
switch (_that) {
case _LyricsLine() when $default != null:
return $default(_that.lineLyrics,_that.linePinyin,_that.translated,_that.words,_that.patterns);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LyricsLine implements LyricsLine {
  const _LyricsLine({required this.lineLyrics, this.linePinyin = "", required this.translated, final  List<LyricsWord> words = const <LyricsWord>[], final  List<GrammarPattern> patterns = const <GrammarPattern>[]}): _words = words,_patterns = patterns;
  factory _LyricsLine.fromJson(Map<String, dynamic> json) => _$LyricsLineFromJson(json);

@override final  String lineLyrics;
@override@JsonKey() final  String linePinyin;
@override final  String translated;
 final  List<LyricsWord> _words;
@override@JsonKey() List<LyricsWord> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

 final  List<GrammarPattern> _patterns;
@override@JsonKey() List<GrammarPattern> get patterns {
  if (_patterns is EqualUnmodifiableListView) return _patterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patterns);
}


/// Create a copy of LyricsLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LyricsLineCopyWith<_LyricsLine> get copyWith => __$LyricsLineCopyWithImpl<_LyricsLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LyricsLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LyricsLine&&(identical(other.lineLyrics, lineLyrics) || other.lineLyrics == lineLyrics)&&(identical(other.linePinyin, linePinyin) || other.linePinyin == linePinyin)&&(identical(other.translated, translated) || other.translated == translated)&&const DeepCollectionEquality().equals(other._words, _words)&&const DeepCollectionEquality().equals(other._patterns, _patterns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineLyrics,linePinyin,translated,const DeepCollectionEquality().hash(_words),const DeepCollectionEquality().hash(_patterns));

@override
String toString() {
  return 'LyricsLine(lineLyrics: $lineLyrics, linePinyin: $linePinyin, translated: $translated, words: $words, patterns: $patterns)';
}


}

/// @nodoc
abstract mixin class _$LyricsLineCopyWith<$Res> implements $LyricsLineCopyWith<$Res> {
  factory _$LyricsLineCopyWith(_LyricsLine value, $Res Function(_LyricsLine) _then) = __$LyricsLineCopyWithImpl;
@override @useResult
$Res call({
 String lineLyrics, String linePinyin, String translated, List<LyricsWord> words, List<GrammarPattern> patterns
});




}
/// @nodoc
class __$LyricsLineCopyWithImpl<$Res>
    implements _$LyricsLineCopyWith<$Res> {
  __$LyricsLineCopyWithImpl(this._self, this._then);

  final _LyricsLine _self;
  final $Res Function(_LyricsLine) _then;

/// Create a copy of LyricsLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineLyrics = null,Object? linePinyin = null,Object? translated = null,Object? words = null,Object? patterns = null,}) {
  return _then(_LyricsLine(
lineLyrics: null == lineLyrics ? _self.lineLyrics : lineLyrics // ignore: cast_nullable_to_non_nullable
as String,linePinyin: null == linePinyin ? _self.linePinyin : linePinyin // ignore: cast_nullable_to_non_nullable
as String,translated: null == translated ? _self.translated : translated // ignore: cast_nullable_to_non_nullable
as String,words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<LyricsWord>,patterns: null == patterns ? _self._patterns : patterns // ignore: cast_nullable_to_non_nullable
as List<GrammarPattern>,
  ));
}


}

// dart format on
