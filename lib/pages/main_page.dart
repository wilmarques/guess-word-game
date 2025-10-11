import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart' show deviceCapabilityService, analyticsService;
import '../utils/responsive_screen.dart';
import '../widgets/default_button.dart';
import '../widgets/unsupported_device_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _checkingCapability = false;

  /// Checks device capability before navigating to game.
  Future<void> _checkCapabilityAndNavigate() async {
    if (_checkingCapability) return;

    setState(() {
      _checkingCapability = true;
    });

    try {
      // Check if device supports on-device models
      final supported = await deviceCapabilityService.supportsLocalModels();

      if (!mounted) return;

      if (!supported) {
        // Get reason and show blocking dialog
        final reason = await deviceCapabilityService.getUnsupportedReason();

        // Log analytics event
        await analyticsService.recordLocalBlocked(
          reason: reason ?? 'Unknown reason',
        );

        // Show blocking dialog
        await UnsupportedDeviceDialog.show(
          context,
          reason ?? 'Your device does not support on-device AI capabilities.',
        );
      } else {
        // Device is supported, navigate to game
        if (mounted) {
          GoRouter.of(context).go('/play');
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _checkingCapability = false;
        });
      }
    }
  }

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
              onPressed: _checkingCapability ? null : _checkCapabilityAndNavigate,
              text: _checkingCapability ? 'Checking...' : 'Play',
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
