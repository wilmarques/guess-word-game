# Guess Word Game

A Flutter built game where you have to guess the word when given its definition.

## ✨ New: On-Device AI Word Definitions

This game now uses **on-device AI models** for word definitions, providing:
- **Zero cloud dependencies** - All word definitions generated locally
- **Offline gameplay** - No internet connection required
- **Privacy-first** - Your data never leaves your device
- **Fast responses** - Sub-1.5s definition generation on supported devices

### Requirements

The game requires devices with:
- GPU/NPU acceleration (Android, iOS) OR WebGPU support (modern browsers)
- At least 2 GB free storage for AI model
- 20%+ battery level for model downloads

Unsupported devices will receive a clear message at startup and cannot play until requirements are met.

### How It Works

1. **First Launch**: The game automatically downloads a 1.2 GB MediaPipe Gemma model
2. **Capability Check**: Device hardware is verified before gameplay
3. **Local Inference**: Word definitions are generated entirely on your device
4. **No Cloud Fallback**: If your device doesn't meet requirements, cloud services are **never** used

For technical details, see [ADR 0002: In-Device AI Models](docs/adrs/0002-in-device-ai-models.md).

## Run in GitHub Codespaces

This repo includes a dev container that sets up Flutter (web-first) for Codespaces.

- Dev container uses the Desktop Lite feature and auto-forwards:
  - 8080: Flutter web server (label: flutter-web)

- VS Code launch configs are prepared for web; if debugging fails to detect Dart, ensure the Dart and Flutter extensions are enabled.

Steps (per GitHub Codespaces docs):

1. Open this repo in a Codespace.
2. Wait for the dev container to build and post-create steps to finish.
3. Launch the App using Launch on VSCode (press F5)

## Architecture

The game follows a clean architecture with strict separation of concerns:

### Services
- **DeviceCapabilityService**: Detects GPU/NPU/WebGPU support and device capabilities
- **ModelDownloadManager**: Handles automatic model downloads with progress tracking
- **MediaPipeWordService**: Wraps MediaPipe LLM inference for word definitions
- **AnalyticsService**: Tracks usage events locally with privacy-first approach

### Data Flow
```
User → MainPage (capability check) → GamePage → OnDeviceWordService → MediaPipe AI → Definition
```

### Key Design Decisions
1. **No Cloud Policy**: Unsupported devices are blocked completely - no fallback to cloud services
2. **Automatic Downloads**: Models download automatically without user prompts on capable devices
3. **Stub Implementation**: MediaPipe integration uses stubs until actual SDK is available
4. **Privacy First**: All inference happens on-device; analytics stored locally

## Development

### Dependencies
- `mediapipe_text`: MediaPipe Tasks for Text (LLM inference) - *pending SDK release*
- `path_provider`: Local file storage paths
- `shared_preferences`: Persistent storage for model metadata
- `crypto`: SHA-256 checksum verification

### Testing
- Widget tests verify UI behavior with fake capability services
- Integration tests validate end-to-end flows with injectable dependencies
- All tests use fake implementations to avoid hardware dependencies

See [Implementation Plan](specs/001-change-worddefinition-logic/plan.md) for full technical details.
