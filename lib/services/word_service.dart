import 'dart:convert';
import 'dart:math';

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
    final random = Random();

    return assetBundle
        .loadString('assets/words/nouns/words.txt')
        .then((wordsTxt) => wordsTxt.split('\n'))
        .then((words) => words.elementAt(
              random.nextInt(words.length),
            ));
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
