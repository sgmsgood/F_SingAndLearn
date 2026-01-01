// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'song_lyrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SongLyrics {

 String get chinese; List<LyricsLine> get lines;
/// Create a copy of SongLyrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SongLyricsCopyWith<SongLyrics> get copyWith => _$SongLyricsCopyWithImpl<SongLyrics>(this as SongLyrics, _$identity);

  /// Serializes this SongLyrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SongLyrics&&(identical(other.chinese, chinese) || other.chinese == chinese)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chinese,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'SongLyrics(chinese: $chinese, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $SongLyricsCopyWith<$Res>  {
  factory $SongLyricsCopyWith(SongLyrics value, $Res Function(SongLyrics) _then) = _$SongLyricsCopyWithImpl;
@useResult
$Res call({
 String chinese, List<LyricsLine> lines
});




}
/// @nodoc
class _$SongLyricsCopyWithImpl<$Res>
    implements $SongLyricsCopyWith<$Res> {
  _$SongLyricsCopyWithImpl(this._self, this._then);

  final SongLyrics _self;
  final $Res Function(SongLyrics) _then;

/// Create a copy of SongLyrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chinese = null,Object? lines = null,}) {
  return _then(_self.copyWith(
chinese: null == chinese ? _self.chinese : chinese // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<LyricsLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [SongLyrics].
extension SongLyricsPatterns on SongLyrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SongLyrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SongLyrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SongLyrics value)  $default,){
final _that = this;
switch (_that) {
case _SongLyrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SongLyrics value)?  $default,){
final _that = this;
switch (_that) {
case _SongLyrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chinese,  List<LyricsLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SongLyrics() when $default != null:
return $default(_that.chinese,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chinese,  List<LyricsLine> lines)  $default,) {final _that = this;
switch (_that) {
case _SongLyrics():
return $default(_that.chinese,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chinese,  List<LyricsLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _SongLyrics() when $default != null:
return $default(_that.chinese,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SongLyrics implements SongLyrics {
  const _SongLyrics({required this.chinese, required final  List<LyricsLine> lines}): _lines = lines;
  factory _SongLyrics.fromJson(Map<String, dynamic> json) => _$SongLyricsFromJson(json);

@override final  String chinese;
 final  List<LyricsLine> _lines;
@override List<LyricsLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of SongLyrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SongLyricsCopyWith<_SongLyrics> get copyWith => __$SongLyricsCopyWithImpl<_SongLyrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SongLyricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SongLyrics&&(identical(other.chinese, chinese) || other.chinese == chinese)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chinese,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'SongLyrics(chinese: $chinese, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$SongLyricsCopyWith<$Res> implements $SongLyricsCopyWith<$Res> {
  factory _$SongLyricsCopyWith(_SongLyrics value, $Res Function(_SongLyrics) _then) = __$SongLyricsCopyWithImpl;
@override @useResult
$Res call({
 String chinese, List<LyricsLine> lines
});




}
/// @nodoc
class __$SongLyricsCopyWithImpl<$Res>
    implements _$SongLyricsCopyWith<$Res> {
  __$SongLyricsCopyWithImpl(this._self, this._then);

  final _SongLyrics _self;
  final $Res Function(_SongLyrics) _then;

/// Create a copy of SongLyrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chinese = null,Object? lines = null,}) {
  return _then(_SongLyrics(
chinese: null == chinese ? _self.chinese : chinese // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<LyricsLine>,
  ));
}


}

// dart format on
