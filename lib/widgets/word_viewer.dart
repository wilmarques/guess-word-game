import 'package:flutter/material.dart';

import '../widgets/letter_viewer.dart';

class WordViewer extends StatelessWidget {
  const WordViewer({
    super.key,
    required this.word,
    required this.guessedLetters,
  });

  final String word;

  /// Which letters were already tried
  final Iterable<String> guessedLetters;

  @override
  Widget build(BuildContext context) {
    final letters =
        word.split('').map((letter) => letter.toUpperCase());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: letters
          .map((letter) => LetterViewer(
                letter: letter,
                show: guessedLetters.contains(letter),
              ))
          .toList(),
    );
  }
}
