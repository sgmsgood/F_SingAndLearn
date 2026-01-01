import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LyricsSelectionNotifier extends StateNotifier<Set<String>> {
  LyricsSelectionNotifier() : super({});

  void toggle(String word) {
    if (state.contains(word)) {
      state = {...state}..remove(word);
    } else {
      state = {...state, word};
    }
  }

  bool isSelected(String word) => state.contains(word);

  void reset() => state = {};
}

final lyricsSelectionProvider =
StateNotifierProvider.autoDispose<LyricsSelectionNotifier, Set<String>>(
        (ref) => LyricsSelectionNotifier());

final selectedTokenProvider = StateProvider<String?>((ref) => null);
