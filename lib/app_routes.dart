import 'package:go_router/go_router.dart';

import 'pages/game_page.dart';
import 'pages/main_page.dart';
import 'pages/winning_page.dart';

final GoRouter routes = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/play',
      builder: (context, state) => const GamePage(),
    ),
    GoRoute(
      path: '/winning',
      builder: (context, state) => const WinningPage(),
    ),
  ],
);
