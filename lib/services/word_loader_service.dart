import 'package:guess_word_game/models/word.dart';

// TODO: Remove all stale data and consume some API service

class WordLoaderService {
  final List<Word> _loadedWords = [
    const Word(
      definitions: [
        'Is all we need',
        'A strong feeling of affection and concern toward another person, as that arising from kinship or close friendship.',
        'A strong feeling of affection and concern for another person accompanied by sexual attraction.',
        'A feeling of devotion or adoration toward God or a god.',
      ],
      word: 'love',
      imageName: 'love',
    ),
    const Word(
      definitions: [
        'Opposite of love',
        'It is hate',
      ],
      word: 'hate',
      imageName: 'hate',
    ),
  ];
  var _currentWordIndex = 0;

  Word currentWord() => _loadedWords.elementAt(_currentWordIndex);

  void loadNextWord() => _currentWordIndex++;

  void preloadNextWord() {
    // throw 'Not implemented yet';
  }
}
