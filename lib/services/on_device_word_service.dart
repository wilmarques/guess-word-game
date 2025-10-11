import 'package:flutter/services.dart';
import '../models/word.dart';
import 'device_capability_service.dart';
import 'model_download_manager.dart';
import 'mediapipe_word_service.dart';
import 'analytics_service.dart';

/// Factory service that creates the appropriate word service based on
/// device capabilities.
///
/// CRITICAL: This implementation enforces the NO CLOUD POLICY.
/// Unsupported devices will be blocked from gameplay.
class WordServiceFactory {
  WordServiceFactory({
    required this.capabilityService,
    required this.downloadManager,
    required this.analyticsService,
  });

  final DeviceCapabilityService capabilityService;
  final ModelDownloadManager downloadManager;
  final AnalyticsService analyticsService;

  /// Creates the word service for the current device.
  ///
  /// Throws [UnsupportedDeviceException] if device cannot run on-device AI.
  /// This enforces the no-cloud policy by blocking unsupported devices.
  Future<OnDeviceWordService> createWordService() async {
    // Check if device supports local models
    final supported = await capabilityService.supportsLocalModels();

    if (!supported) {
      final reason = await capabilityService.getUnsupportedReason();
      throw UnsupportedDeviceException(
        reason ?? 'Device does not support on-device AI capabilities.',
      );
    }

    // Create MediaPipe-based service for supported devices
    return OnDeviceWordService(
      mediaPipeService: MediaPipeWordService(
        analyticsService: analyticsService,
        downloadManager: downloadManager,
        capabilityService: capabilityService,
      ),
    );
  }
}

/// Exception thrown when device doesn't support on-device AI.
class UnsupportedDeviceException implements Exception {
  UnsupportedDeviceException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Word service that exclusively uses on-device AI for definitions.
///
/// NO CLOUD FALLBACK. This service will fail if on-device inference is unavailable.
class OnDeviceWordService {
  OnDeviceWordService({
    required this.mediaPipeService,
    AssetBundle? assetBundle,
  }) : _assetBundle = assetBundle ?? rootBundle;

  final MediaPipeWordService mediaPipeService;
  final AssetBundle _assetBundle;

  bool _initialized = false;

  /// Initializes the on-device word service.
  ///
  /// Must be called before loadNextWord().
  Future<void> initialize() async {
    await mediaPipeService.initialize();
    _initialized = true;
  }

  /// Loads next word with on-device generated definition.
  ///
  /// 1. Loads random word from assets
  /// 2. Generates definition using MediaPipe LLM (NO CLOUD)
  /// 3. Returns Word with local definition
  Future<Word> loadNextWord() async {
    if (!_initialized) {
      throw StateError('OnDeviceWordService not initialized. Call initialize() first.');
    }

    // Load random word from assets
    final word = await _loadRandomWord();

    // Generate definition using on-device AI
    // NO CLOUD FALLBACK - will throw if inference fails
    final wordWithDefinition = await mediaPipeService.generateDefinition(word);

    return wordWithDefinition;
  }

  /// Loads a random word from local assets.
  Future<String> _loadRandomWord() async {
    final wordsTxt = await _assetBundle.loadString('assets/words/nouns/words.txt');
    final words = wordsTxt.split('\n');
    words.removeWhere((word) => word.trim().isEmpty);

    // Use current time as seed for randomness
    final index = DateTime.now().millisecondsSinceEpoch % words.length;
    return words[index].trim();
  }

  /// Disposes resources.
  void dispose() {
    mediaPipeService.dispose();
  }
}
