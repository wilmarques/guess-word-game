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

    // TODO (next) - Extract this logic to another method
    // Extract definitions from the result `json`
    Iterable<String> definitions = json.takeWhile((reference) {
      var referenceWord = _extractWordFromReference((reference));
      return referenceWord == word;
    }).map((reference) {
      final shortDefReference = reference['shortdef'] as Iterable<String>;
      final references = ...shortDefReference;
      return shortDefReference as String;
    }).toList();

    // final references = json[''];
    // [ { "meta": { "id": "love:1" } "shortdef": ["definitions"] }, {} ]
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
