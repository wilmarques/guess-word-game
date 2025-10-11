<!-- markdownlint-disable-file -->
# Release Changes: In-Device AI Word Definitions

**Related Plan**: specs/001-change-worddefinition-logic/tasks.md
**Implementation Date**: 2025-10-11

## Summary

Implementing on-device MediaPipe-based AI inference for word definitions to eliminate cloud dependencies, reduce costs, and enable offline gameplay. The system will automatically download required model assets on capable devices, block unsupported devices with clear messaging, and ensure 100% local processing with zero cloud fallback.

## Changes

### Added

- lib/services/model_config.dart - Configuration constants for MediaPipe Gemma model CDN URL, checksum, and size
- lib/services/device_capability_service.dart - Interface and default implementation for detecting GPU/NPU acceleration and device capabilities
- test/fakes/fake_device_capability_service.dart - Fake capability service implementation for testing with overridable hardware flags
- lib/services/model_download_manager.dart - Download manager skeleton with http.Client dependency injection for streaming model downloads
- lib/utils/analytics_events.dart - Analytics event enums covering local-success, local-blocked, download-failed, and related events

### Modified

- pubspec.yaml - Added dependencies: mediapipe_text, path_provider, shared_preferences, and integration_test

### Removed

