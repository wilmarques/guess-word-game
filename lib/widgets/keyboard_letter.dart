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
      child: Text(letter),
    );
  }
}
