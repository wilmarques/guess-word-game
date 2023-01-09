import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/word.dart';

class WordRepository {
  const WordRepository();

  Future<Word> loadWord(String wordReference) async {
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
