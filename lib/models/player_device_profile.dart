/// Device platforms supported for on-device AI inference.
enum DevicePlatform {
  /// Android platform.
  android,

  /// iOS platform.
  ios,

  /// Web platform.
  web,

  /// Desktop platforms (Windows, macOS, Linux).
  desktop,
}

/// Architecture types for device processors.
enum DeviceArchitecture {
  /// ARM 64-bit architecture.
  arm64,

  /// x86 64-bit architecture.
  x86_64,

  /// ARM 32-bit architecture.
  arm32,

  /// Unknown architecture.
  unknown,
}

/// Network connectivity types.
enum NetworkType {
  /// Wi-Fi connection.
  wifi,

  /// Cellular data connection.
  cellular,

  /// Offline (no connection).
  offline,
}

/// Model installation states.
enum ModelInstallState {
  /// Model is not installed.
  missing,

  /// Model is currently being downloaded/installed.
  installing,

  /// Model is installed and ready.
  installed,

  /// Model file is corrupted and needs re-download.
  corrupted,
}

/// Describes hardware capabilities, storage, and connectivity state
/// used to choose the inference path.
///
/// Computed at runtime and not persisted; cached for session scope.
class PlayerDeviceProfile {
  PlayerDeviceProfile({
    required this.deviceId,
    required this.platform,
    required this.architecture,
    required this.gpuAcceleration,
    required this.npuAcceleration,
    required this.webAssemblySupport,
    required this.storageAvailableBytes,
    required this.batteryPercent,
    required this.networkType,
    required this.modelInstallState,
  });

  /// Hashed identifier stored in memory only.
  final String deviceId;

  /// Device platform.
  final DevicePlatform platform;

  /// Device architecture.
  final DeviceArchitecture architecture;

  /// Whether GPU acceleration is available.
  final bool gpuAcceleration;

  /// Whether NPU (Neural Processing Unit) acceleration is available.
  final bool npuAcceleration;

  /// Whether WebAssembly support is available (web platform).
  final bool webAssemblySupport;

  /// Available storage in bytes.
  ///
  /// Must be greater than model package size prior to automatic download.
  final int storageAvailableBytes;

  /// Battery percentage (0-100).
  final int batteryPercent;

  /// Current network connectivity type.
  final NetworkType networkType;

  /// Current model installation state.
  final ModelInstallState modelInstallState;

  /// Checks if device supports on-device models.
  bool get supportsLocalModels {
    final hasAcceleration = gpuAcceleration || npuAcceleration || webAssemblySupport;
    return hasAcceleration &&
        storageAvailableBytes >= 2000000000 && // At least 2 GB
        batteryPercent > 20;
  }

  /// Creates a copy with updated fields.
  PlayerDeviceProfile copyWith({
    String? deviceId,
    DevicePlatform? platform,
    DeviceArchitecture? architecture,
    bool? gpuAcceleration,
    bool? npuAcceleration,
    bool? webAssemblySupport,
    int? storageAvailableBytes,
    int? batteryPercent,
    NetworkType? networkType,
    ModelInstallState? modelInstallState,
  }) {
    return PlayerDeviceProfile(
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
      architecture: architecture ?? this.architecture,
      gpuAcceleration: gpuAcceleration ?? this.gpuAcceleration,
      npuAcceleration: npuAcceleration ?? this.npuAcceleration,
      webAssemblySupport: webAssemblySupport ?? this.webAssemblySupport,
      storageAvailableBytes: storageAvailableBytes ?? this.storageAvailableBytes,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      networkType: networkType ?? this.networkType,
      modelInstallState: modelInstallState ?? this.modelInstallState,
    );
  }
}
