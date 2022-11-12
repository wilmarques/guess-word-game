import 'package:flutter/material.dart';

class KeyboardLetter extends StatelessWidget {
  const KeyboardLetter({
    Key? key,
    required this.letter,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
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
