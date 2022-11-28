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
}
