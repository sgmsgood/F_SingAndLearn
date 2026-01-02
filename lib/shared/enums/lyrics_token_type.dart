enum LyricsTokenType {
  word('w_'),
  pattern('p_'),
  unknown(''); // 예외 처리를 위한 값

  final String prefix;
  const LyricsTokenType(this.prefix);

  static LyricsTokenType fromId(String id) {
    if (id.startsWith(word.prefix)) return word;
    if (id.startsWith(pattern.prefix)) return pattern;
    return unknown;
  }
}