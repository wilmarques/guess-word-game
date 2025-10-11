import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart' show deviceCapabilityService, analyticsService, modelDownloadManager;
import '../utils/responsive_screen.dart';
import '../widgets/default_button.dart';
import '../widgets/unsupported_device_dialog.dart';
import '../widgets/model_download_progress.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _checkingCapability = false;
  bool _downloading = false;
  double _downloadProgress = 0.0;
  String? _downloadError;

  @override
  void initState() {
    super.initState();
    _checkModelStatus();
  }

  /// Checks if model download is needed.
  Future<void> _checkModelStatus() async {
    final supported = await deviceCapabilityService.supportsLocalModels();
    if (!supported) return;

    final isInstalled = await modelDownloadManager.isModelInstalled();
    if (!isInstalled) {
      // Model not installed - prepare for download
      setState(() {
        _downloading = false; // Will start on play button
      });
    }
  }

  /// Initiates model download if needed.
  Future<void> _initiateDownload() async {
    setState(() {
      _downloading = true;
      _downloadProgress = 0.0;
      _downloadError = null;
    });

    try {
      // Set up progress callbacks
      modelDownloadManager.onProgressUpdate = (progress) {
        if (mounted) {
          setState(() {
            _downloadProgress = progress;
          });
        }
      };

      modelDownloadManager.onDownloadComplete = () {
        if (mounted) {
          setState(() {
            _downloading = false;
          });
          // Navigate to game after download completes
          GoRouter.of(context).go('/play');
        }
      };

      modelDownloadManager.onDownloadError = (error) {
        if (mounted) {
          setState(() {
            _downloadError = error;
          });
        }
      };

      // Start download
      await modelDownloadManager.downloadModel();
    } catch (e) {
      if (mounted) {
        setState(() {
          _downloadError = e.toString();
        });
      }
    }
  }

  /// Checks device capability before navigating to game.
  Future<void> _checkCapabilityAndNavigate() async {
    if (_checkingCapability || _downloading) return;

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
        // Check if model is installed
        final isInstalled = await modelDownloadManager.isModelInstalled();

        if (!isInstalled) {
          // Start automatic download
          await _initiateDownload();
        } else {
          // Model ready, navigate to game
          if (mounted) {
            GoRouter.of(context).go('/play');
          }
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
    final isBlocked = _checkingCapability || _downloading;

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
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Guess the Word',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 55,
                height: 1,
              ),
            ),
            if (_downloading) ...[
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ModelDownloadProgress(
                  progress: _downloadProgress,
                  error: _downloadError,
                  onRetry: _downloadError != null ? _initiateDownload : null,
                ),
              ),
            ],
          ],
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultButton(
              onPressed: isBlocked ? null : _checkCapabilityAndNavigate,
              text: _checkingCapability
                  ? 'Checking...'
                  : _downloading
                      ? 'Downloading...'
                      : 'Play',
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
