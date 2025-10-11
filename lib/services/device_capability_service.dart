import 'dart:io';
import 'package:flutter/foundation.dart';

/// Service for detecting device capabilities related to on-device AI inference.
///
/// This service determines whether the device meets the requirements for
/// running MediaPipe LLM inference locally.
abstract class DeviceCapabilityService {
  /// Checks if the device has GPU or NPU acceleration.
  Future<bool> hasGpuOrNpuAcceleration();

  /// Checks if the device supports WebAssembly (for web platform).
  Future<bool> hasWebAssemblySupport();

  /// Gets available storage in bytes.
  Future<int> getAvailableStorageBytes();

  /// Gets current battery percentage (0-100).
  ///
  /// Returns 100 for devices on AC power or without battery.
  Future<int> getBatteryPercentage();

  /// Checks if the device supports on-device AI models.
  ///
  /// Combines multiple capability checks to determine overall support.
  Future<bool> supportsLocalModels();

  /// Gets a human-readable reason if device is unsupported.
  Future<String?> getUnsupportedReason();
}

/// Default implementation of DeviceCapabilityService.
///
/// This implementation provides basic capability detection across platforms.
class DefaultDeviceCapabilityService implements DeviceCapabilityService {
  DefaultDeviceCapabilityService();

  @override
  Future<bool> hasGpuOrNpuAcceleration() async {
    // Platform-specific GPU/NPU detection
    if (kIsWeb) {
      // Check for WebGPU support via browser APIs
      return hasWebAssemblySupport();
    } else if (Platform.isAndroid) {
      // Android devices with API level 27+ generally have GPU support
      return true; // Simplified - would need platform channel for actual check
    } else if (Platform.isIOS) {
      // iOS devices with Neural Engine (A12+)
      return true; // Simplified - would need platform channel for actual check
    }
    return false;
  }

  @override
  Future<bool> hasWebAssemblySupport() async {
    if (kIsWeb) {
      // In a real implementation, this would check WebGPU/WebAssembly availability
      return true; // Simplified assumption for web builds
    }
    return false;
  }

  @override
  Future<int> getAvailableStorageBytes() async {
    // This is a placeholder - actual implementation would use platform channels
    // to query available storage from the OS.
    // For now, we assume sufficient storage (6 GB).
    return 6000000000; // 6 GB
  }

  @override
  Future<int> getBatteryPercentage() async {
    // This is a placeholder - actual implementation would use platform channels
    // or battery_plus package to query battery status.
    // For now, we assume device is charged.
    return 100;
  }

  @override
  Future<bool> supportsLocalModels() async {
    // Check if device has acceleration and sufficient storage
    final hasAcceleration = await hasGpuOrNpuAcceleration() ||
        await hasWebAssemblySupport();
    final storageBytes = await getAvailableStorageBytes();
    final batteryPercent = await getBatteryPercentage();

    // Require acceleration, at least 2 GB storage, and >20% battery
    return hasAcceleration &&
        storageBytes >= 2000000000 &&
        batteryPercent > 20;
  }

  @override
  Future<String?> getUnsupportedReason() async {
    final hasAcceleration = await hasGpuOrNpuAcceleration() ||
        await hasWebAssemblySupport();
    final storageBytes = await getAvailableStorageBytes();
    final batteryPercent = await getBatteryPercentage();

    if (!hasAcceleration) {
      return 'Your device does not support GPU/NPU acceleration required for on-device AI.';
    }

    if (storageBytes < 2000000000) {
      return 'Insufficient storage space. At least 2 GB is required for the AI model.';
    }

    if (batteryPercent <= 20) {
      return 'Battery level too low. Please charge your device to at least 20% before downloading the AI model.';
    }

    return null; // Device is supported
  }
}
