import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/word_loader_service.dart';
import '../widgets/default_button.dart';

class WinningScreen extends StatefulWidget {
  const WinningScreen({super.key});

  @override
  State<WinningScreen> createState() => _WinningScreenState();
}

class _WinningScreenState extends State<WinningScreen> {
  final _wordLoaderService = WordLoaderService();

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
              _wordLoaderService.loadNextWord();
              GoRouter.of(context).go('/play');
            },
            text: 'Next word',
          ),
        ],
      ),
    );
  }
}
