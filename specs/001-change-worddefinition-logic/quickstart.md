# Quickstart: In-Device AI Word Definitions

## Prerequisites
- Flutter SDK 3.x with Dart 3.x
- Access to Google MediaPipe Tasks for Text Flutter bindings (`mediapipe_text`)
- Gemma 2B int4 model package hosted on internal CDN (HTTPS)
- Device or emulator with at least 6 GB free storage for testing downloads

## Setup Steps
1. **Install dependencies**
   - Add `mediapipe_text`, `http`, `path_provider`, and `integration_test` to `pubspec.yaml`.
   - Run `flutter pub get`.
2. **Configure model source**
   - Add the CDN URL and checksum to app configuration (`lib/services/model_config.dart`).
   - Ensure HTTPS certificates are trusted in development.
3. **Implement capability provider**
   - Create `DeviceCapabilityService` that inspects GPU/NPU/WebAssembly support and storage/battery thresholds.
   - Provide a fake implementation under `test/` for automated verification.
4. **Set up automatic download**
   - Implement `ModelDownloadManager` using `http.Client.send` streamed responses and save files to `path_provider`'s application support directory.
   - Persist metadata (version, checksum, timestamp) via `shared_preferences` or lightweight JSON file.
5. **Wire MediaPipe inference**
   - Initialize `LlmInference` during app startup after confirming assets are installed.
   - Execute inference requests through the service wrapper defined by `contracts/local_inference.yaml`.
6. **Block unsupported devices**
   - On launch, check capability provider; show blocking dialog if unsupported and stop navigation to `GamePage`.
7. **Testing**
   - Run widget tests for download states and error messaging.
   - Execute integration tests toggling fake capability states to verify blocking and success flows.

## Verification Checklist
- [ ] Automatic download completes and persists model assets
- [ ] Unsupported device path blocks gameplay with alert
- [ ] Local inference returns definition with <1.5s latency on supported hardware
- [ ] Analytics event differentiates `local-success`, `local-blocked`, `download-failed`
- [ ] `flutter test`, integration tests, and `flutter analyze` succeed
