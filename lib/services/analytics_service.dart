import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/definition_request_record.dart';
import '../utils/analytics_events.dart';

/// Service for capturing and managing analytics events.
///
/// Records events to a local queue and provides flush capability
/// for eventual backend synchronization.
class AnalyticsService {
  AnalyticsService();

  static const String _queueKey = 'analytics_queue';
  static const int _maxQueueSize = 1000;

  final Queue<Map<String, dynamic>> _eventQueue = Queue();

  /// Records an analytics event.
  Future<void> recordEvent(
    AnalyticsEvent event, {
    Map<String, dynamic>? properties,
  }) async {
    final eventData = {
      'event': event.name,
      'timestamp': DateTime.now().toIso8601String(),
      'description': event.description,
      if (properties != null) ...properties,
    };

    _eventQueue.add(eventData);

    // Trim queue if it exceeds max size
    while (_eventQueue.length > _maxQueueSize) {
      _eventQueue.removeFirst();
    }

    // Persist to local storage
    await _saveQueue();
  }

  /// Records a definition request event.
  Future<void> recordDefinitionRequest(DefinitionRequestRecord record) async {
    await recordEvent(
      AnalyticsEvent.definitionRequested,
      properties: record.toJson(),
    );
  }

  /// Records a local inference success event.
  Future<void> recordLocalSuccess({
    required String word,
    required int latencyMs,
  }) async {
    await recordEvent(
      AnalyticsEvent.localSuccess,
      properties: {
        'word': word,
        'latencyMs': latencyMs,
      },
    );
  }

  /// Records a local blocked event.
  Future<void> recordLocalBlocked({
    required String reason,
  }) async {
    await recordEvent(
      AnalyticsEvent.localBlocked,
      properties: {
        'reason': reason,
      },
    );
  }

  /// Records a download failed event.
  Future<void> recordDownloadFailed({
    required String error,
  }) async {
    await recordEvent(
      AnalyticsEvent.downloadFailed,
      properties: {
        'error': error,
      },
    );
  }

  /// Records a download started event.
  Future<void> recordDownloadStarted() async {
    await recordEvent(AnalyticsEvent.downloadStarted);
  }

  /// Records a download completed event.
  Future<void> recordDownloadCompleted({
    required int durationMs,
  }) async {
    await recordEvent(
      AnalyticsEvent.downloadCompleted,
      properties: {
        'durationMs': durationMs,
      },
    );
  }

  /// Saves event queue to local storage.
  Future<void> _saveQueue() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final queueJson = jsonEncode(_eventQueue.toList());
      await prefs.setString(_queueKey, queueJson);
    } catch (e) {
      // Silently fail - analytics should not break app functionality
    }
  }

  /// Loads event queue from local storage.
  Future<void> loadQueue() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final queueJson = prefs.getString(_queueKey);

      if (queueJson != null) {
        final List<dynamic> events = jsonDecode(queueJson);
        _eventQueue.clear();
        _eventQueue.addAll(events.cast<Map<String, dynamic>>());
      }
    } catch (e) {
      // Silently fail - analytics should not break app functionality
    }
  }

  /// Gets all pending events.
  List<Map<String, dynamic>> getPendingEvents() {
    return _eventQueue.toList();
  }

  /// Clears the event queue.
  Future<void> clearQueue() async {
    _eventQueue.clear();
    await _saveQueue();
  }

  /// Flushes events to backend (stub for future implementation).
  ///
  /// In production, this would send events to an analytics backend.
  Future<void> flush() async {
    // TODO: Implement backend synchronization
    // For now, this is a no-op stub
    // When online, send events to analytics backend
    // On success, clear the queue
  }
}
