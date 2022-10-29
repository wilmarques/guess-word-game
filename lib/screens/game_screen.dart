import 'package:flutter/material.dart';
import 'package:guess_word_game/utils/portrait_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return PortraitScreen(
      topMessageArea: Column(
        children: const [
          Text('Score'),
        ],
      ),
      squarishMainArea: Column(
        children: const [
          Text('Deffinition and current word'),
        ],
      ),
      rectangularMenuArea: Column(
        children: const [
          Text('Keyboard and Show new tip button'),
        ],
      ),
    );
  }
}
