import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/game_page.dart';
import 'pages/main_page.dart';
import 'pages/winning_page.dart';

import 'services_initializer.dart';

class GuessWordApp extends StatelessWidget {
  GuessWordApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ServicesInitializer(
      child: MaterialApp.router(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        routerConfig: _router,
        title: 'Guess the Word',
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  // TODO (live): Extract the routes to another file
  final GoRouter _router = GoRouter(
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
}
