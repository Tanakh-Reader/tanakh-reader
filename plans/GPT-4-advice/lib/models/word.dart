class Word {
  final String id;
  final String text;
  final String translation;
  final int book;
  final int chapter;
  final int verse;

  Word({
    required this.id,
    required this.text,
    required this.translation,
    required this.book,
    required this.chapter,
    required this.verse,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      text: json['text'],
      translation: json['translation'],
      book: json['book'],
      chapter: json['chapter'],
      verse: json['verse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'book': book,
      'chapter': chapter,
      'verse': verse,
    };
  }
}
