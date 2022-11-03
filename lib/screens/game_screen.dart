import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_word_game/utils/portrait_screen.dart';
import 'package:guess_word_game/widgets/default_button.dart';
import 'package:guess_word_game/widgets/tip_viewer.dart';

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
  var currentTipIndex = 0;

  bool hasNextTip() {
    final tipsListLength = tips.length - 1;
    if (currentTipIndex < tipsListLength) {
      return true;
    }
    return false;
  }

  bool hasPreviousTip() {
    if (currentTipIndex > 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PortraitScreen(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // TODO: move buttons and its state to TipViewer widget
              children: [
                DefaultButton(
                  text: 'Previous tip',
                  onPressed: hasPreviousTip()
                      ? () {
                          setState(() {
                            currentTipIndex--;
                          });
                        }
                      : null,
                ),
                TipViewer(
                  tips: tips,
                  currentTipIndex: currentTipIndex,
                ),
                DefaultButton(
                  text: 'Next tip',
                  onPressed: hasNextTip()
                      ? () {
                          setState(() {
                            currentTipIndex++;
                          });
                        }
                      : null,
                ),
              ],
            ),
            Row(
              // TODO: create a word viewer widget
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: const Text('L'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: const Text('O'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: const Text('V'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: const Text('E'),
                )
              ],
            ),
          ],
        ),
        rectangularMenuArea: Column(
          children: const [
            Text('Keyboard and Show new tip button'),
          ],
        ),
      ),
    );
  }
}
