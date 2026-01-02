import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lyrics_selection_provider.g.dart';

@riverpod
class LyricsSelection extends _$LyricsSelection {
  @override
  Set<String> build() {
    return {};
  }

  void toggle(String word) {
    if (state.contains(word)) {
      state = {...state}..remove(word);
    } else {
      state = {...state, word};
    }
  }

  void reset() {
    state = {};
  }
}

@riverpod
class SelectedToken extends _$SelectedToken {
  @override
  String? build() {
    return null;
  }

  void set(String? id) {
    state = id;
  }
}