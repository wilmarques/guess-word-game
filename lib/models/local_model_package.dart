/// Represents downloadable AI model assets required for on-device inference.
///
/// Exactly one active package per device; stored in persistent storage.
class LocalModelPackage {
  LocalModelPackage({
    required this.modelName,
    required this.version,
    required this.downloadUrl,
    required this.checksumSha256,
    required this.sizeBytes,
    required this.installPath,
    this.downloadProgress = 0.0,
    DateTime? lastUpdatedAt,
  }) : lastUpdatedAt = lastUpdatedAt ?? DateTime.now();

  /// Model name identifier (e.g., 'gemma_2b_it_gpu_int4').
  final String modelName;

  /// Semantic version string.
  final String version;

  /// Secure HTTPS endpoint for model download.
  final String downloadUrl;

  /// SHA-256 checksum for integrity verification.
  ///
  /// Checksum verification MUST pass before switching PlayerDeviceProfile.modelInstallState to installed.
  final String checksumSha256;

  /// Model file size in bytes.
  final int sizeBytes;

  /// Absolute path in application sandbox where model is installed.
  final String installPath;

  /// Download progress (0.0 to 1.0).
  final double downloadProgress;

  /// Timestamp of last model update.
  ///
  /// Automatic re-download triggered when older than configured TTL or checksum mismatch occurs.
  final DateTime lastUpdatedAt;

  /// Checks if model needs update based on TTL.
  bool needsUpdate({int ttlDays = 30}) {
    final now = DateTime.now();
    final difference = now.difference(lastUpdatedAt);
    return difference.inDays > ttlDays;
  }

  /// Creates a copy with updated fields.
  LocalModelPackage copyWith({
    String? modelName,
    String? version,
    String? downloadUrl,
    String? checksumSha256,
    int? sizeBytes,
    String? installPath,
    double? downloadProgress,
    DateTime? lastUpdatedAt,
  }) {
    return LocalModelPackage(
      modelName: modelName ?? this.modelName,
      version: version ?? this.version,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      checksumSha256: checksumSha256 ?? this.checksumSha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      installPath: installPath ?? this.installPath,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  /// Converts to JSON for persistence.
  Map<String, dynamic> toJson() {
    return {
      'modelName': modelName,
      'version': version,
      'downloadUrl': downloadUrl,
      'checksumSha256': checksumSha256,
      'sizeBytes': sizeBytes,
      'installPath': installPath,
      'downloadProgress': downloadProgress,
      'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
    };
  }

  /// Creates instance from JSON.
  factory LocalModelPackage.fromJson(Map<String, dynamic> json) {
    return LocalModelPackage(
      modelName: json['modelName'] as String,
      version: json['version'] as String,
      downloadUrl: json['downloadUrl'] as String,
      checksumSha256: json['checksumSha256'] as String,
      sizeBytes: json['sizeBytes'] as int,
      installPath: json['installPath'] as String,
      downloadProgress: (json['downloadProgress'] as num?)?.toDouble() ?? 0.0,
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
    );
  }
}
