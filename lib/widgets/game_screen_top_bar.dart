import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'default_button.dart';

class GameScreenTopBar extends StatelessWidget {
  const GameScreenTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('456'),
        Center(
          child: DefaultButton(
            text: 'Stop',
            onPressed: () {
              GoRouter.of(context).go('/');
            },
          ),
        ),
        const Text('123'),
      ],
    );
  }
}
