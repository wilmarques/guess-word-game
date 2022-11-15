import 'package:flutter/widgets.dart';

class KeyboardLetterPressedNotification extends Notification {
  const KeyboardLetterPressedNotification({
    required this.pressedLetter,
  });

  final String pressedLetter;
}
