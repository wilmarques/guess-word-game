import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_word_game/screens/game_screen.dart';

import 'screens/main_screen.dart';

class GuessWordApp extends StatelessWidget {
  GuessWordApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Guess the Word',
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/play',
        builder: (context, state) => const GameScreen(),
      ),
    ],
  );
}
