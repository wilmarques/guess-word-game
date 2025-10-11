import 'package:flutter/material.dart';

/// Dialog shown when device doesn't support on-device AI models.
///
/// Blocks gameplay and provides clear explanation to the user.
class UnsupportedDeviceDialog extends StatelessWidget {
  const UnsupportedDeviceDialog({
    super.key,
    required this.reason,
    this.onClose,
  });

  /// Human-readable explanation for why device is unsupported.
  final String reason;

  /// Callback when user closes the dialog.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.orange,
            size: 32,
          ),
          SizedBox(width: 12),
          Flexible(
            child: Text(
              'Device Not Supported',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reason,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'This game requires on-device AI capabilities that are not available on your current device.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onClose?.call();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  /// Shows the dialog and prevents dismissal by tapping outside.
  static Future<void> show(
    BuildContext context,
    String reason, {
    VoidCallback? onClose,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => UnsupportedDeviceDialog(
        reason: reason,
        onClose: onClose,
      ),
    );
  }
}
