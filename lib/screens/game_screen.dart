import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_word_game/services/word_loader_service.dart';

import '../utils/portrait_screen.dart';

import '../widgets/default_button.dart';
import '../widgets/keyboard.dart';
import '../widgets/tip_viewer.dart';
import '../widgets/word_viewer.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final wordLoaderService = WordLoaderService();

  @override
  Widget build(BuildContext context) {
    final currentWord = wordLoaderService.currentWord();

    return Scaffold(
      body: PortraitScreen(
        // TODO: Extract this to another widget
        topMessageArea: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('456'),
            Center(
              child: DefaultButton(
                text: 'Stop',
                onPressed: () {
                  GoRouter.of(context).go('/');
                },
              ),
            ),
            const Text('123'),
          ],
        ),
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
        rectangularMenuArea: const Keyboard(),
      ),
    );
  }
}
