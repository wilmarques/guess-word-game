import 'package:flutter/material.dart';

import '../utils/portrait_screen.dart';

import '../services/word_loader_service.dart';

import '../widgets/game_screen_top_bar.dart';
import '../widgets/keyboard/keyboard.dart';
import '../widgets/keyboard/keyboard_letter_pressed_notification.dart';
import '../widgets/tip_viewer.dart';
import '../widgets/word_viewer.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _wordLoaderService = WordLoaderService();
  List<String> pressedLetters = [];

  @override
  void initState() {
    super.initState();
    _wordLoaderService.preloadNextWord();
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = _wordLoaderService.currentWord();

    return Scaffold(
      body: PortraitScreen(
        topMessageArea: const GameScreenTopBar(),
        squarishMainArea: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
              ),
              child: TipViewer(tips: currentWord.definitions),
            ),
            Expanded(
              child: WordViewer(word: currentWord.word),
            ),
          ],
        ),
        rectangularMenuArea:
            NotificationListener<KeyboardLetterPressedNotification>(
          onNotification: (pressedLetterNotification) {
            final pressedLetter = pressedLetterNotification.pressedLetter;
            if (!pressedLetters.contains(pressedLetter)) {
              setState(() {
                pressedLetters.add(pressedLetter);
              });
            }
            return true;
          },
          child: Keyboard(
            pressedLetters: pressedLetters,
          ),
        ),
      ),
    );
  }
}
