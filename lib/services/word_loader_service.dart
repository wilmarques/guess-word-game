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

// TODO: Extract InheritedWidget logic to another class
class WordLoaderService extends InheritedWidget {
  WordLoaderService({super.key, required super.child});

  final _wordRepository = const _WordRepository();

  final List<Word> _loadedWords = [];

  // TODO: Make this non-nullable
  Word? _currentWord;
  Word? get currentWord => _currentWord;

  bool get loading => _currentWord == null;

  static WordLoaderService of(BuildContext context) {
    final WordLoaderService? result =
        context.dependOnInheritedWidgetOfExactType<WordLoaderService>();
    return result!;
  }

  @override
  bool updateShouldNotify(WordLoaderService oldWidget) {
    if (oldWidget.currentWord == null) return false;
    if (currentWord == null) return true;
    return oldWidget.currentWord!.word != currentWord!.word;
  }

  void prepareNextWord() {
    final nextWord = _loadedWords.first;
    _loadedWords.removeAt(0);
    _currentWord = nextWord;
  }

  void loadNextWord() async {
    // TODO (next): Randomize next word based on some API
    final nextWord = await _wordRepository.loadWord('love');
    _loadedWords.add(nextWord);
    _currentWord = nextWord;
  }

  void preloadNextWord() async {
    // TODO (next): Randomize next word based on some API
    final word = await _wordRepository.loadWord('love');
    _loadedWords.add(word);
  }
}
