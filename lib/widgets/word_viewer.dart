import 'package:flutter/material.dart';

import '../widgets/letter_viewer.dart';

class WordViewer extends StatelessWidget {
  const WordViewer({super.key, required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    final letters =
        word.split('').map((letter) => letter.toUpperCase()).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: letters.map((letter) => LetterViewer(letter: letter)).toList(),
    );
  }
}
