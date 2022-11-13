import 'package:guess_word_game/models/word.dart';

class WordLoaderService {
  Word currentWord() => const Word(
        definitions: [
          'Is all we need',
          'A strong feeling of affection and concern toward another person, as that arising from kinship or close friendship.',
          'A strong feeling of affection and concern for another person accompanied by sexual attraction.',
          'A feeling of devotion or adoration toward God or a god.',
        ],
        word: 'love',
        imageName: 'none',
      );

  Word nextWord() => const Word(
        definitions: [
          'Opposite of love',
          'It is hate',
        ],
        word: 'hate',
        imageName: 'none',
      );

  void preloadWord() {
    throw 'Not implemented yet';
  }
}
