import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/word.dart';

class _WordRepository {
  const _WordRepository();

  Future<Word> loadWord(String word) async {
    final url = Uri.https(
      'www.dictionaryapi.com',
      '/api/v3/references/sd2/json/love',
      {'key': '5d0404b5-8fc4-4be1-9046-9c72304eb71e'},
    );

    final response = await http.get(url);
    return parseResponseBody(response.body);
  }

  Word parseResponseBody(String responseBody) {
    final decodedJson = jsonDecode(responseBody);
    final parsedWord = Word.fromJson(decodedJson);
    return parsedWord;
  }
}

// TODO (next): Connect this Service to the repository above (_WordRepository)
class WordLoaderService extends InheritedWidget {
  WordLoaderService({super.key, required super.child});

  final _wordRepository = const _WordRepository();

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
    _wordRepository.loadWord('love');
    // throw 'Not implemented yet';
  }
}
