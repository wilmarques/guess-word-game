import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_word_game/widgets/default_button.dart';

import '../utils/portrait_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PortraitScreen(
        topMessageArea: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: DefaultButton(
                text: 'Settings',
                onPressed: () {},
              ),
            ),
          ],
        ),
        squarishMainArea: const Center(
          child: Text(
            'Guess the Word',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 55,
              height: 1,
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              text: 'Play',
            ),
            const SizedBox(height: 10),
            DefaultButton(
              onPressed: () {},
              text: 'Disable sound',
            ),
          ],
        ),
      ),
    );
  }
}
