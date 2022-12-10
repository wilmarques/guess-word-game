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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You win!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 55,
                  height: 1,
                ),
              ),
              const SizedBox(height: 50),
              DefaultButton(
                onPressed: () {
                  wordLoaderService.prepareNextWord();
                  GoRouter.of(context).go('/play');
                },
                text: 'Next word',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
