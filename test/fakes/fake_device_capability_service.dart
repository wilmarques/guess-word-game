import '../../lib/services/device_capability_service.dart';

/// Fake implementation of DeviceCapabilityService for testing.
///
/// Allows tests to override hardware capability flags to simulate
/// different device configurations.
class FakeDeviceCapabilityService implements DeviceCapabilityService {
  FakeDeviceCapabilityService({
    this.gpuOrNpuAcceleration = true,
    this.webAssemblySupport = false,
    this.availableStorageBytes = 6000000000, // 6 GB default
    this.batteryPercentage = 100,
  });

  /// Whether the device has GPU/NPU acceleration.
  bool gpuOrNpuAcceleration;

  /// Whether the device supports WebAssembly.
  bool webAssemblySupport;

  /// Available storage in bytes.
  int availableStorageBytes;

  /// Battery percentage (0-100).
  int batteryPercentage;

  @override
  Future<bool> hasGpuOrNpuAcceleration() async => gpuOrNpuAcceleration;

  @override
  Future<bool> hasWebAssemblySupport() async => webAssemblySupport;

  @override
  Future<int> getAvailableStorageBytes() async => availableStorageBytes;

  @override
  Future<int> getBatteryPercentage() async => batteryPercentage;

  @override
  Future<bool> supportsLocalModels() async {
    final hasAcceleration = gpuOrNpuAcceleration || webAssemblySupport;
    return hasAcceleration &&
        availableStorageBytes >= 2000000000 &&
        batteryPercentage > 20;
  }

  @override
  Future<String?> getUnsupportedReason() async {
    final hasAcceleration = gpuOrNpuAcceleration || webAssemblySupport;

    if (!hasAcceleration) {
      return 'Your device does not support GPU/NPU acceleration required for on-device AI.';
    }

    if (availableStorageBytes < 2000000000) {
      return 'Insufficient storage space. At least 2 GB is required for the AI model.';
    }

    if (batteryPercentage <= 20) {
      return 'Battery level too low. Please charge your device to at least 20% before downloading the AI model.';
    }

    return null;
  }
}
