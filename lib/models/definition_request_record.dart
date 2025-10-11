/// Inference tiers for analytics tracking.
enum InferenceTier {
  /// Local inference completed successfully.
  localSuccess,

  /// Device blocked due to unsupported hardware.
  localBlocked,

  /// Model download failed.
  downloadFailed,
}

/// Captures each player definition request with inference tier,
/// latency, and success state for analytics and support.
///
/// Logged in analytics pipeline (local queue flushed when online).
class DefinitionRequestRecord {
  DefinitionRequestRecord({
    required this.requestId,
    required this.word,
    required this.timestamp,
    required this.inferenceTier,
    required this.latencyMs,
    this.errorCode,
    this.errorDescription,
  });

  /// Unique request identifier (UUID).
  final String requestId;

  /// Word being defined.
  final String word;

  /// Timestamp when request was initiated.
  final DateTime timestamp;

  /// Inference tier used for this request.
  ///
  /// MUST never reference cloud tiers (enforces no-cloud policy).
  final InferenceTier inferenceTier;

  /// Time taken to generate definition in milliseconds.
  final int latencyMs;

  /// Error code if request failed.
  ///
  /// Populated when inferenceTier is localBlocked or downloadFailed.
  final String? errorCode;

  /// Human-readable error description.
  ///
  /// Used to drive UI messaging (e.g., show retry prompts).
  final String? errorDescription;

  /// Converts to JSON for analytics logging.
  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'word': word,
      'timestamp': timestamp.toIso8601String(),
      'inferenceTier': inferenceTier.name,
      'latencyMs': latencyMs,
      if (errorCode != null) 'errorCode': errorCode,
      if (errorDescription != null) 'errorDescription': errorDescription,
    };
  }

  /// Creates instance from JSON.
  factory DefinitionRequestRecord.fromJson(Map<String, dynamic> json) {
    return DefinitionRequestRecord(
      requestId: json['requestId'] as String,
      word: json['word'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      inferenceTier: InferenceTier.values.firstWhere(
        (e) => e.name == json['inferenceTier'],
      ),
      latencyMs: json['latencyMs'] as int,
      errorCode: json['errorCode'] as String?,
      errorDescription: json['errorDescription'] as String?,
    );
  }
}
