import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/word.dart';
import '../utils/responsive_screen.dart';

import '../services/word_loader_service.dart';

import '../widgets/game_screen_top_bar.dart';
import '../widgets/keyboard/keyboard.dart';
import '../widgets/keyboard/keyboard_letter_pressed_notification.dart';
import '../widgets/tip_viewer.dart';
import '../widgets/word_viewer.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> guessedLetters = [];

  // TODO (live - next): Extract this logic to a new service
  bool isAllLettersGuessedRight(Word currentWord) {
    final currentWordLetters = currentWord.letters;
    return currentWordLetters.every((letter) {
      return guessedLetters.contains(letter);
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   wordd
  // }

  @override
  Widget build(BuildContext context) {
    final wordLoaderService = WordLoaderService.of(context);
    final currentWord = wordLoaderService.currentWord();
    wordLoaderService.preloadNextWord();

    return Scaffold(
      body: ResponsiveScreen(
        topMessageArea: const GameScreenTopBar(),
        squarishMainArea: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: TipViewer(
                tips: currentWord.definitions.toList(),
              ),
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
