import 'package:flutter/material.dart';

import '../../utils/letters.dart';

import 'keyboard_letter.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.pressedLetters,
  });

  final double rowSpacing = 0;
  final double columnSpacing = 0;
  final columns = 6;
  final gaps = 5; // Number of gaps between the columns
  final errorMargin = 0.01;

  final List<String> pressedLetters;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalAvailableWidth = constraints.biggest.width;
        final itemWidth =
            ((totalAvailableWidth - (columnSpacing * gaps)) / columns) -
                errorMargin;

        return Wrap(
          runSpacing: rowSpacing,
          spacing: columnSpacing,
          alignment: WrapAlignment.center,
          children: letters
              .map(
                (letter) => SizedBox(
                  width: itemWidth,
                  height: itemWidth,
                  child: KeyboardLetter(
                    letter: letter,
                    letterWasPressed: pressedLetters.contains(letter),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
