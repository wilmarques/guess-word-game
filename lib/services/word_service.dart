import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/word.dart';

class WordService {
  const WordService({required this.assetBundle});

  final AssetBundle assetBundle;

  Future<Word> loadNextWord() async {
    return loadRandomWord().then((value) => loadWordDefinition(value));
  }

  Future<String> loadRandomWord() async {
    // TODO(next): This methods is always returning the same word
    // We should count how many words are loaded and get a random from 0 to the last index
    // And use this index to get a random word
    return assetBundle.loadString('assets/words/nouns/words.txt').then(
        (wordsTxt) =>
            wordsTxt.split('\n').first); // Returning always the firt word
  }

  Future<Word> loadWordDefinition(String wordReference) async {
    final url = Uri.https(
      'www.dictionaryapi.com',
      '/api/v3/references/sd2/json/$wordReference',
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
