import 'package:flutter/material.dart';

import 'keyboard_letter_pressed_notification.dart';

class KeyboardLetter extends StatelessWidget {
  const KeyboardLetter({
    Key? key,
    required this.letter,
    required this.letterWasPressed,
  }) : super(key: key);

  final String letter;
  final bool letterWasPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!letterWasPressed) {
          KeyboardLetterPressedNotification(
            pressedLetter: letter,
          ).dispatch(context);
        }
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: letterWasPressed ? Colors.grey : Colors.black,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              letter,
              style: TextStyle(
                color: letterWasPressed ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
