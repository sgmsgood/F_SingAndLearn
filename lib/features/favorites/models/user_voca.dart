class UserVoca {
  final String wordId;
  final String text;
  final String pinyin;
  final String meaning;
  final String status; // 'unknown' | 'known'
  final DateTime createdAt;

  UserVoca({
    required this.wordId,
    required this.text,
    required this.pinyin,
    required this.meaning,
    required this.status,
    required this.createdAt,
  });

  factory UserVoca.fromJson(Map<String, dynamic> json) {
    final word = (json['line_words'] as Map<String, dynamic>? ?? {});
    return UserVoca(
      wordId: json['word_id'] as String,
      status: (json['status'] as String?) ?? 'unknown',
      createdAt: DateTime.parse(json['created_at'] as String),
      text: (word['text'] as String?) ?? '',
      pinyin: (word['pinyin'] as String?) ?? '',
      meaning: (word['meaning'] as String?) ?? '',
    );
  }
}
