import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  final tips = const [
    'Is all we need',
    'A strong feeling of affection and concern toward another person, as that arising from kinship or close friendship.',
    'A strong feeling of affection and concern for another person accompanied by sexual attraction.',
    'A feeling of devotion or adoration toward God or a god.',
  ];
  final word = 'love';

  @override
  Widget build(BuildContext context) {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: TipViewer(tips: tips),
            ),
            // TODO: Centralize the word viewer
            Expanded(
              child: WordViewer(word: word),
            ),
            const SizedBox(
              height: 400,
              child: Keyboard(),
            ),
          ],
        ),
        rectangularMenuArea: const Text('Menu area'),
      ),
    );
  }
}
