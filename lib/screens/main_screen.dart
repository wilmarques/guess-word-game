import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScreen(
        squarishMainArea: Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Settings'),
            ),
            const Center(
              child: Text(
                'Guess the Word',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 55,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              child: const Text('Play'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Disable sound'),
            ),
          ],
        ),
      ),
    );
  }
}
