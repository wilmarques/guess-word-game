import 'package:flutter/material.dart';

class KeyboardLetter extends StatelessWidget {
  const KeyboardLetter({
    Key? key,
    required this.letter,
    required this.letterWasUsed,
  }) : super(key: key);

  final String letter;
  final bool letterWasUsed;

  // TODO: change color to grey when letterWasUsed is true

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: letterWasUsed ? Colors.grey : Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(letter),
        ),
      ),
    );
  }
}
