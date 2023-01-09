import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/default_button.dart';

class WinningPage extends StatefulWidget {
  const WinningPage({super.key});

  @override
  State<WinningPage> createState() => _WinningPageState();
}

class _WinningPageState extends State<WinningPage> {
  @override
  Widget build(BuildContext context) {
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
