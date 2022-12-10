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

  factory Word.fromJson(Iterable<dynamic> json) {
    var wordReference = json
        .first; // The first element contains the word "meta" (https://www.dictionaryapi.com/products/json#sec-2.meta)
    var word = _extractWordFromReference(wordReference);

    Iterable<String> definitions = json
        .takeWhile((reference) {
          var referenceWord = _extractWordFromReference((reference));
          return referenceWord == word;
        })
        .expand((reference) => reference['shortdef'])
        .map((definition) => definition as String)
        .map((definition) => _capitalizeFirstLetter(definition));

    return Word(
      definitions: definitions,
      word: word,
      imageName: word,
    );
  }
}

String _extractWordFromReference(Map<String, dynamic> reference) {
  final referenceMeta = reference['meta'];
  final referenceId = referenceMeta['id'];
  final word = referenceId.split(':').first;
  return word;
}

String _capitalizeFirstLetter(String sentence) =>
    sentence.replaceRange(0, 1, sentence[0].toUpperCase());
