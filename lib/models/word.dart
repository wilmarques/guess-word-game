class Word {
  const Word({
    required this.definitions,
    required this.word,
    required this.imageName,
  });

  final List<String> definitions;
  final String word;
  final String imageName;

  Iterable<String> get letters {
    return word.split('').map((letter) => letter.toUpperCase());
  }
}
