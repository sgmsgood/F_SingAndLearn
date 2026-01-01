// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lyric_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LyricsWord {

 String get id; String get text; String get pinyin; String get meaning; Span get span; bool get isImportant; bool get isSaved;
/// Create a copy of LyricsWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LyricsWordCopyWith<LyricsWord> get copyWith => _$LyricsWordCopyWithImpl<LyricsWord>(this as LyricsWord, _$identity);

  /// Serializes this LyricsWord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LyricsWord&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.span, span) || other.span == span)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,pinyin,meaning,span,isImportant,isSaved);

@override
String toString() {
  return 'LyricsWord(id: $id, text: $text, pinyin: $pinyin, meaning: $meaning, span: $span, isImportant: $isImportant, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class $LyricsWordCopyWith<$Res>  {
  factory $LyricsWordCopyWith(LyricsWord value, $Res Function(LyricsWord) _then) = _$LyricsWordCopyWithImpl;
@useResult
$Res call({
 String id, String text, String pinyin, String meaning, Span span, bool isImportant, bool isSaved
});


$SpanCopyWith<$Res> get span;

}
/// @nodoc
class _$LyricsWordCopyWithImpl<$Res>
    implements $LyricsWordCopyWith<$Res> {
  _$LyricsWordCopyWithImpl(this._self, this._then);

  final LyricsWord _self;
  final $Res Function(LyricsWord) _then;

/// Create a copy of LyricsWord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? pinyin = null,Object? meaning = null,Object? span = null,Object? isImportant = null,Object? isSaved = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as Span,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LyricsWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanCopyWith<$Res> get span {
  
  return $SpanCopyWith<$Res>(_self.span, (value) {
    return _then(_self.copyWith(span: value));
  });
}
}


/// Adds pattern-matching-related methods to [LyricsWord].
extension LyricsWordPatterns on LyricsWord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LyricsWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LyricsWord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LyricsWord value)  $default,){
final _that = this;
switch (_that) {
case _LyricsWord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LyricsWord value)?  $default,){
final _that = this;
switch (_that) {
case _LyricsWord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String pinyin,  String meaning,  Span span,  bool isImportant,  bool isSaved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LyricsWord() when $default != null:
return $default(_that.id,_that.text,_that.pinyin,_that.meaning,_that.span,_that.isImportant,_that.isSaved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String pinyin,  String meaning,  Span span,  bool isImportant,  bool isSaved)  $default,) {final _that = this;
switch (_that) {
case _LyricsWord():
return $default(_that.id,_that.text,_that.pinyin,_that.meaning,_that.span,_that.isImportant,_that.isSaved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String pinyin,  String meaning,  Span span,  bool isImportant,  bool isSaved)?  $default,) {final _that = this;
switch (_that) {
case _LyricsWord() when $default != null:
return $default(_that.id,_that.text,_that.pinyin,_that.meaning,_that.span,_that.isImportant,_that.isSaved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LyricsWord implements LyricsWord {
  const _LyricsWord({this.id = '', required this.text, this.pinyin = '', this.meaning = '', required this.span, this.isImportant = false, this.isSaved = false});
  factory _LyricsWord.fromJson(Map<String, dynamic> json) => _$LyricsWordFromJson(json);

@override@JsonKey() final  String id;
@override final  String text;
@override@JsonKey() final  String pinyin;
@override@JsonKey() final  String meaning;
@override final  Span span;
@override@JsonKey() final  bool isImportant;
@override@JsonKey() final  bool isSaved;

/// Create a copy of LyricsWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LyricsWordCopyWith<_LyricsWord> get copyWith => __$LyricsWordCopyWithImpl<_LyricsWord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LyricsWordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LyricsWord&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.span, span) || other.span == span)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,pinyin,meaning,span,isImportant,isSaved);

@override
String toString() {
  return 'LyricsWord(id: $id, text: $text, pinyin: $pinyin, meaning: $meaning, span: $span, isImportant: $isImportant, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class _$LyricsWordCopyWith<$Res> implements $LyricsWordCopyWith<$Res> {
  factory _$LyricsWordCopyWith(_LyricsWord value, $Res Function(_LyricsWord) _then) = __$LyricsWordCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String pinyin, String meaning, Span span, bool isImportant, bool isSaved
});


@override $SpanCopyWith<$Res> get span;

}
/// @nodoc
class __$LyricsWordCopyWithImpl<$Res>
    implements _$LyricsWordCopyWith<$Res> {
  __$LyricsWordCopyWithImpl(this._self, this._then);

  final _LyricsWord _self;
  final $Res Function(_LyricsWord) _then;

/// Create a copy of LyricsWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? pinyin = null,Object? meaning = null,Object? span = null,Object? isImportant = null,Object? isSaved = null,}) {
  return _then(_LyricsWord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as Span,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LyricsWord
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
