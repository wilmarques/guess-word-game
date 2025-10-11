/// Analytics event types for tracking on-device AI usage.
///
/// These events differentiate successful local inference, blocked unsupported
/// devices, and download failures for observability and rollout decisions.
enum AnalyticsEvent {
  /// Local inference completed successfully.
  localSuccess,

  /// Device blocked due to unsupported hardware.
  localBlocked,

  /// Model download failed.
  downloadFailed,

  /// Model download started.
  downloadStarted,

  /// Model download completed.
  downloadCompleted,

  /// Definition request initiated.
  definitionRequested,

  /// Inference timeout occurred.
  inferenceTimeout,

  /// Model corruption detected.
  modelCorrupted,
}

/// Extension to provide human-readable names for analytics events.
extension AnalyticsEventExtension on AnalyticsEvent {
  /// Returns the event name as a string.
  String get name {
    switch (this) {
      case AnalyticsEvent.localSuccess:
        return 'local-success';
      case AnalyticsEvent.localBlocked:
        return 'local-blocked';
      case AnalyticsEvent.downloadFailed:
        return 'download-failed';
      case AnalyticsEvent.downloadStarted:
        return 'download-started';
      case AnalyticsEvent.downloadCompleted:
        return 'download-completed';
      case AnalyticsEvent.definitionRequested:
        return 'definition-requested';
      case AnalyticsEvent.inferenceTimeout:
        return 'inference-timeout';
      case AnalyticsEvent.modelCorrupted:
        return 'model-corrupted';
    }
  }

  /// Returns a description of the event.
  String get description {
    switch (this) {
      case AnalyticsEvent.localSuccess:
        return 'Definition generated successfully using on-device AI';
      case AnalyticsEvent.localBlocked:
        return 'Device blocked due to unsupported hardware capabilities';
      case AnalyticsEvent.downloadFailed:
        return 'AI model download failed';
      case AnalyticsEvent.downloadStarted:
        return 'AI model download initiated';
      case AnalyticsEvent.downloadCompleted:
        return 'AI model download completed successfully';
      case AnalyticsEvent.definitionRequested:
        return 'Word definition requested by player';
      case AnalyticsEvent.inferenceTimeout:
        return 'Local inference exceeded timeout threshold';
      case AnalyticsEvent.modelCorrupted:
        return 'Installed model file is corrupted';
    }
  }
}
