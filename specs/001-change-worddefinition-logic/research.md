# Research Findings: In-Device AI Word Definitions

## MediaPipe LLM integration for Flutter

- **Decision**: Adopt the Google MediaPipe Tasks for Text library via the `mediapipe_text` Flutter bindings (alpha channel) and wrap it behind a dedicated `MediaPipeWordService` abstraction.
- **Rationale**: MediaPipe Tasks provides a cross-platform LLM inference API (`LlmInference`) matching the ADR prototype, supports Gemma int4 quantization, and offers GPU/NPU acceleration with CPU/WebAssembly fallbacks. The alpha Flutter bindings expose asynchronous APIs suitable for background downloads and inference, keeping the UI thread responsive.
- **Alternatives considered**:
  - **WebLLM (MLC)**: Focused on WebGPU; fails mobile-first requirement and contradicts the no-cloud mandate.
  - **Custom native plugins**: Higher engineering cost to maintain platform-specific wrappers around the C++ Tasks SDK; Flutter bindings already maintained by Google reduce risk.
  - **TFLite text models**: Limited support for instruction-tuned LLM behavior and lacks built-in tokenizer parity with Gemma models.

## Capability simulation for automated tests

- **Decision**: Implement a capability provider interface that can be overridden in tests, combined with integration tests using Flutter's `integration_test` harness on emulators/simulators configured with and without GPU acceleration.
- **Rationale**: Dependency injection allows deterministic unit/widget tests that toggle "supported" vs. "unsupported" states. Integration tests on CI can stub the provider to avoid hardware-specific requirements while still validating alert flows and blocking behavior.
- **Alternatives considered**:
  - **Relying on real hardware in CI**: Impractical and brittle for automated pipelines.
  - **Compilation flags per platform**: Too coarse; doesn't cover runtime checks or edge conditions like low storage.
  - **Mocking MediaPipe APIs directly**: More brittle and tied to plugin internals compared to abstract capability checks.

## Automatic model download management

- **Decision**: Use Flutter's `path_provider` for storing model assets, coupled with the `http` package's streamed requests (`Client.send`) for resumable downloads, and exponential backoff retry logic with battery/storage guards.
- **Rationale**: `path_provider` is standard for cross-platform persistent storage. Streaming downloads via `http` enable progress reporting and pause/resume when connectivity changes without adding an extra dependency. Backoff reduces battery drain and handles flaky connections while respecting the no-cloud inference rule.
- **Alternatives considered**:
  - **Platform-specific download managers**: Adds channel complexity and inconsistent UX across platforms.
  - **Naïve single-shot download**: Fails gracefully on interruptions and large file sizes, risking corrupted models.
  - **Bundling models in app package**: Bloats install size and prevents future updates or hotfixes.
