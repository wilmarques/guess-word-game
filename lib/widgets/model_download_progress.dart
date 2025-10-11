import 'package:flutter/material.dart';

/// Widget displaying model download progress.
///
/// Shows download percentage and provides visual feedback during
/// automatic model downloads.
class ModelDownloadProgress extends StatelessWidget {
  const ModelDownloadProgress({
    super.key,
    required this.progress,
    this.error,
    this.onRetry,
  });

  /// Download progress (0.0 to 1.0).
  final double progress;

  /// Error message if download failed.
  final String? error;

  /// Callback for retry action.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;
    final progressPercent = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasError ? Colors.red.shade50 : Colors.blue.shade50,
        border: Border.all(
          color: hasError ? Colors.red.shade200 : Colors.blue.shade200,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                hasError ? Icons.error_outline : Icons.download,
                color: hasError ? Colors.red : Colors.blue,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasError ? 'Download Failed' : 'Downloading AI Model...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: hasError ? Colors.red.shade900 : Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!hasError) ...[
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.blue.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              '$progressPercent% complete',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait while the AI model downloads.\nGameplay will begin automatically when ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ] else ...[
            Text(
              error!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.red.shade900,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Download'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
