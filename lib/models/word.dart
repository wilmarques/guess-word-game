class Word {
  const Word({
    required this.definitions,
    // required this.shortDefinitions,
    required this.word,
    required this.imageName,
  });

  final Iterable<String> definitions;
  // final Iterable<String> shortDefinitions;
  final String word;
  final String imageName;

  Iterable<String> get letters {
    return word.split('').map((letter) => letter.toUpperCase());
  }

  factory Word.fromJson(Iterable<Map<String, dynamic>> json) {
    // final references = json[''];
    // [ { "meta": { "id": "love:1" } "shortdef": ["definitions"] }, {} ]
    return const Word(
      definitions: ['def'],
      word: 'love',
      imageName: 'love',
    );
  }
}
