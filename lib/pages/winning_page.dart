import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/word_loader_service.dart';

import '../widgets/default_button.dart';

class WinningPage extends StatefulWidget {
  const WinningPage({super.key});

  @override
  State<WinningPage> createState() => _WinningPageState();
}

class _WinningPageState extends State<WinningPage> {
  @override
  Widget build(BuildContext context) {
    final wordLoaderService = WordLoaderService.of(context);

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
              wordLoaderService.loadNextWord();
              GoRouter.of(context).go('/play');
            },
            text: 'Next word',
          ),
        ],
      ),
    );
  }
}
