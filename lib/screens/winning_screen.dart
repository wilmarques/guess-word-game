import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/default_button.dart';

class WinningScreen extends StatelessWidget {
  const WinningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'You win!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 55,
              height: 1,
            ),
          ),
          DefaultButton(
            onPressed: () {
              // TODO: load next word, before going to play screen
              GoRouter.of(context).go('/play');
            },
            text: 'Next word',
          ),
        ],
      ),
    );
  }
}
