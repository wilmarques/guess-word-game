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

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const GuessWordApp(),
    ),
  );
}
