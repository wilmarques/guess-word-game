import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/word.dart';
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
  List<String> guessedLetters = [];

  // TODO (live): Extract this logic to a new service
  bool isAllLettersGuessedRight(Word currentWord) {
    final currentWordLetters = currentWord.letters;
    return currentWordLetters.every((letter) {
      return guessedLetters.contains(letter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final currentWord = _wordLoaderService.currentWord();
    final wordLoaderService = WordLoaderService.of(context);
    final currentWord = wordLoaderService.currentWord();

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
              child: WordViewer(
                word: currentWord.word,
                guessedLetters: guessedLetters,
              ),
            ),
          ],
        ),
        rectangularMenuArea:
            NotificationListener<KeyboardLetterPressedNotification>(
          onNotification: (pressedLetterNotification) {
            final pressedLetter = pressedLetterNotification.pressedLetter;
            if (!guessedLetters.contains(pressedLetter)) {
              setState(() {
                guessedLetters.add(pressedLetter);
              });

              if (isAllLettersGuessedRight(currentWord)) {
                GoRouter.of(context).go('/winning');
              }
            }
            return true;
          },
          child: Keyboard(
            pressedLetters: guessedLetters,
          ),
        ),
      ),
    );
  }
}
