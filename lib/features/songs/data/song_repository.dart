import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/song_bundle.dart';


class SongRepository {
  const SongRepository(this.assetBundle);
  final AssetBundle assetBundle;

  Future<SongBundle> fetchSongs() async {
    final jsonStr = await assetBundle.loadString('assets/song/china/china_song_list.json');
    final jsonMap = jsonDecode(jsonStr);

    return SongBundle.fromJson(jsonMap);
  }
}
