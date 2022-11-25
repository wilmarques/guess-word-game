import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/word.dart';

// TODO (next): Create integration to the Dictionary API
// https://www.dictionaryapi.com/account/example?key=5d0404b5-8fc4-4be1-9046-9c72304eb71e

// Example:

// import 'package:http/http.dart' as http;

// var url = Uri.https('example.com', 'whatsit/create');
// var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
// print('Response status: ${response.statusCode}');
// print('Response body: ${response.body}');

// print(await http.read(Uri.https('example.com', 'foobar.txt')));

class WordLoaderService extends InheritedWidget {
  WordLoaderService({super.key, required super.child});

  static WordLoaderService of(BuildContext context) {
    final WordLoaderService? result =
        context.dependOnInheritedWidgetOfExactType<WordLoaderService>();
    return result!;
  }

  @override
  bool updateShouldNotify(WordLoaderService oldWidget) {
    return oldWidget.currentWord().word != currentWord().word;
  }

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

  void loadNextWord() {
    // Request a word from the Dictionary API and include the word in the _loadedWords array
    if (_currentWordIndex >= (_loadedWords.length - 1)) {
      _currentWordIndex = 0;
    } else {
      _currentWordIndex++;
    }
  }

  void preloadNextWord() {
    // throw 'Not implemented yet';
  }
}
