import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/word.dart';
import '../main.dart' show deviceCapabilityService, modelDownloadManager, analyticsService;
import '../services/on_device_word_service.dart';
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
  late final OnDeviceWordService _wordService;

  final List<String> _guessedLetters = [];

  late final Future<Word> _loadWordFuture;

  bool isAllLettersGuessedRight(Word currentWord) {
    final currentWordLetters = currentWord.letters;
    return currentWordLetters.every((letter) {
      return _guessedLetters.contains(letter);
    });
  }

  @override
  void initState() {
    super.initState();

    // Create word service factory
    final factory = WordServiceFactory(
      capabilityService: deviceCapabilityService,
      downloadManager: modelDownloadManager,
      analyticsService: analyticsService,
    );

    // Initialize word service and load first word
    _loadWordFuture = _initializeAndLoadWord(factory);
  }

  Future<Word> _initializeAndLoadWord(WordServiceFactory factory) async {
    try {
      // Create service (will throw if device unsupported)
      _wordService = await factory.createWordService();

      // Initialize MediaPipe service
      await _wordService.initialize();

      // Load first word with on-device definition
      return await _wordService.loadNextWord();
    } catch (e) {
      // This shouldn't happen as MainPage checks capability first,
      // but handle gracefully just in case
      rethrow;
    }
  }

  @override
  void dispose() {
    _wordService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadWordFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Loading word...',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Using on-device AI',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading word',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/'),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          );
        }

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
