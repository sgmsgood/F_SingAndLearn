import 'dart:convert';

import 'package:f_sing_and_learn/features/songs/models/song_bundle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/song_repository.dart';
import '../models/song.dart';

final songRepositoryProvider = Provider(
      (ref) => SongRepository(rootBundle),
);

final songBundleProvider = FutureProvider<SongBundle>((ref) async {
  return ref.watch(songRepositoryProvider).fetchSongs();
});

final songListProvider = FutureProvider((ref) async {
  final repo = ref.watch(songRepositoryProvider);
  final response = await repo.fetchSongs();
  return response.list; // List<Song>
});
