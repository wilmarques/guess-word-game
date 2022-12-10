import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/word_loader_service.dart';
import '../utils/responsive_screen.dart';
import '../widgets/default_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wordLoaderService = WordLoaderService.of(context);
    final loading = wordLoaderService.loading;
    // TODO (next): First word must be loaded before the game initialization
    // The 'Play' must show 'Loading' while the first word is being loaded
    // Once loaded, the 'Play' button must navigate to 'Game Page'
    wordLoaderService.loadNextWord();

    return Scaffold(
      body: ResponsiveScreen(
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
              onPressed: loading ? null : () {
                GoRouter.of(context).go('/play');
              },
              text: loading ? 'Loading' : 'Play',
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
