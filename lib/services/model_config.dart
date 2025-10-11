/// Configuration constants for on-device AI model management.
///
/// This file contains CDN URLs, checksums, and size information for the
/// MediaPipe Gemma model used for word definition generation.
class ModelConfig {
  ModelConfig._();

  /// CDN URL for downloading the Gemma 2B int4 quantized model.
  ///
  /// This model is optimized for on-device inference with GPU/NPU acceleration.
  static const String modelDownloadUrl =
      'https://storage.googleapis.com/mediapipe-models/llm_inference/gemma/gemma_2b_it_gpu_int4.bin';

  /// SHA-256 checksum for model integrity verification.
  ///
  /// Must match the downloaded file's checksum before installation.
  static const String modelChecksumSha256 =
      'placeholder-checksum-to-be-replaced-with-actual-model-checksum';

  /// Model file size in bytes (approximately 1.2 GB for Gemma 2B int4).
  static const int modelSizeBytes = 1200000000;

  /// Model name identifier.
  static const String modelName = 'gemma_2b_it_gpu_int4';

  /// Model version following semantic versioning.
  static const String modelVersion = '0.1.0';

  /// Maximum tokens for inference generation.
  static const int maxTokens = 128;

  /// Temperature for inference randomness (0.0 = deterministic, 1.0 = random).
  static const double temperature = 0.7;

  /// Model cache time-to-live in days.
  ///
  /// After this period, the model will be checked for updates.
  static const int modelCacheTtlDays = 30;
}
