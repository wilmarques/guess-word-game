import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive_screen.dart';
import '../widgets/default_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () => GoRouter.of(context).go('/play'),
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
