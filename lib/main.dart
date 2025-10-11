import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'services/device_capability_service.dart';
import 'services/model_download_manager.dart';
import 'services/analytics_service.dart';

/// Global instances for dependency injection.
late final DeviceCapabilityService deviceCapabilityService;
late final ModelDownloadManager modelDownloadManager;
late final AnalyticsService analyticsService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  deviceCapabilityService = DefaultDeviceCapabilityService();
  modelDownloadManager = ModelDownloadManager();
  analyticsService = AnalyticsService();

  // Load analytics queue from storage
  await analyticsService.loadQueue();

  // Check if device supports local models and model needs download
  await _checkAndInitiateDownload();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const GuessWordApp(),
    ),
  );
}

/// Checks device capabilities and initiates model download if needed.
Future<void> _checkAndInitiateDownload() async {
  try {
    final supported = await deviceCapabilityService.supportsLocalModels();

    if (!supported) {
      // Device not supported - no download needed
      return;
    }

    // Check if model is already installed
    final isInstalled = await modelDownloadManager.isModelInstalled();

    if (!isInstalled) {
      // Record download start
      await analyticsService.recordDownloadStarted();

      // Set up progress callbacks
      final downloadStartTime = DateTime.now();

      modelDownloadManager.onProgressUpdate = (progress) {
        // Progress updates handled by UI widgets
      };

      modelDownloadManager.onDownloadComplete = () async {
        final durationMs = DateTime.now().difference(downloadStartTime).inMilliseconds;
        await analyticsService.recordDownloadCompleted(durationMs: durationMs);
      };

      modelDownloadManager.onDownloadError = (error) async {
        await analyticsService.recordDownloadFailed(error: error);
      };

      // Note: Actual download is deferred until first gameplay attempt
      // to avoid blocking app startup. Download will be triggered when
      // user navigates to game page.
    }
  } catch (e) {
    // Silently log error - don't block app startup
    await analyticsService.recordEvent(
      AnalyticsEvent.downloadFailed,
      properties: {'error': e.toString(), 'phase': 'initialization'},
    );
  }
}
