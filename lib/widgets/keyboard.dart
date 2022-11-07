import 'package:flutter/material.dart';

import '../utils/letters.dart';

import 'keyboard_letter.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imaginarypadding = 8;
    const double runSpacing = 2;
    const double spacing = 2;
    const columns = 6;

    // TODO: understand why items placing 5 items in the row, instead of 6

    final itemWidth =
        (MediaQuery.of(context).size.width - (spacing) * (columns + 1)) /
            columns;

    return Center(
      child: Wrap(
        runSpacing: runSpacing,
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: letters
            .map(
              // TODO: Remove this Container after understanding the layout issue
              (letter) => Container(
                decoration: BoxDecoration(border: Border.all()),
                child: SizedBox(
                  width: itemWidth,
                  height: itemWidth,
                  child: KeyboardLetter(letter: letter),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
