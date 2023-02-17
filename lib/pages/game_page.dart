import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/word.dart';
import '../repositories/word_repository.dart';
import '../utils/responsive_screen.dart';

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
  final _wordRepository = const WordRepository();

  final List<String> _guessedLetters = [];

  late final Future<Word> _loadWordFuture;

  // TODO: Extract this logic to a new service
  bool isAllLettersGuessedRight(Word currentWord) {
    final currentWordLetters = currentWord.letters;
    return currentWordLetters.every((letter) {
      return _guessedLetters.contains(letter);
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // TODO(next): Consume API to get a random word dinamically
    // Loading the word from the file worked corectly
    // But an exception was thrown because `_loadWordFuture` was not initialized
    // Should find a way to "compose" futures

    final wordsTxt = await DefaultAssetBundle.of(context)
        .loadString('assets/words/nouns/words.txt');
    final allWords = wordsTxt.split('\n');
    final wordReference = allWords.first;

    _loadWordFuture = _wordRepository.loadWord(wordReference);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadWordFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Loading',
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        // TODO: Handle when API doesnt return any data or we get any error (like 404)

        final currentWord = snapshot.data!;

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
                    guessedLetters: _guessedLetters,
                  ),
                ),
              ],
            ),
            rectangularMenuArea:
                NotificationListener<KeyboardLetterPressedNotification>(
              onNotification: (pressedLetterNotification) {
                final pressedLetter = pressedLetterNotification.pressedLetter;
                if (!_guessedLetters.contains(pressedLetter)) {
                  setState(() {
                    _guessedLetters.add(pressedLetter);
                  });

                  if (isAllLettersGuessedRight(currentWord)) {
                    GoRouter.of(context).go('/winning');
                  }
                }
                return true;
              },
              child: Keyboard(
                pressedLetters: _guessedLetters,
              ),
            ),
          ),
        );
      },
    );
  }
}
