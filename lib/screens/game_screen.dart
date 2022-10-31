import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_word_game/utils/portrait_screen.dart';
import 'package:guess_word_game/widgets/default_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
            ConstrainedBox(
              constraints: const BoxConstraints.expand(
                width: 400,
                height: 100,
              ),
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverFixedExtentList(
                    itemExtent: 400,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          height: 20,
                          alignment: Alignment.center,
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: Text('list item ${index + 1}'),
                        );
                      },
                      // childCount: 3,
                    ),
                  ),
                ],
              ),
            ),
            Row(
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
