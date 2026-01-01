// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SongBundle _$SongBundleFromJson(Map<String, dynamic> json) => _SongBundle(
  country: json['country'] as String,
  list: (json['list'] as List<dynamic>)
      .map((e) => Song.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SongBundleToJson(_SongBundle instance) =>
    <String, dynamic>{'country': instance.country, 'list': instance.list};
