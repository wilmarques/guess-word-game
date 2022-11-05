import 'package:flutter/material.dart';

class LetterViewer extends StatelessWidget {
  const LetterViewer({super.key, required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(letter),
      ),
    );
  }
}
