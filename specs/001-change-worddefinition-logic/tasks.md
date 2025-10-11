# Task Plan: In-Device AI Word Definitions

**Branch**: `001-change-worddefinition-logic`
**Spec**: [/specs/001-change-worddefinition-logic/spec.md](/specs/001-change-worddefinition-logic/spec.md)
**Plan**: [/specs/001-change-worddefinition-logic/plan.md](/specs/001-change-worddefinition-logic/plan.md)

## Phase 0 – Setup & Infrastructure

| ID   | Task | Notes |
|------|------|-------|
| T001 | Create `lib/services/model_config.dart` with CDN URL, checksum, model size constants | Shared configuration for downloads |
| T002 | Add dependencies (`mediapipe_text`, `http`, `path_provider`, `integration_test`, `shared_preferences`) to `pubspec.yaml` and run pub get | Required for all stories |
| T003 | Scaffold `DeviceCapabilityService` interface and default implementation stub in `lib/services/device_capability_service.dart` | Provides capability checks for all flows |
| T004 | Set up `test/fakes/fake_device_capability_service.dart` with overridable hardware flags | Enables automated tests |
| T005 | Create `lib/services/model_download_manager.dart` skeleton with dependency injection for `http.Client` | Shared automatic download pipeline |
| T006 | Add analytics event enums to `lib/utils/analytics_events.dart` covering `local-success`, `local-blocked`, `download-failed` | Used across stories |

## Phase 1 – Foundational Enablement

| ID   | Task | Notes |
|------|------|-------|
| T007 | Implement `PlayerDeviceProfile`, `LocalModelPackage`, `DefinitionRequestRecord` data classes in `lib/models/` per data-model.md | Base entities |
| T008 | Extend capability service to evaluate GPU/NPU/WebAssembly, storage, and battery thresholds | Must precede story execution |
| T009 | Implement `ModelDownloadManager` logic for `http.Client.send` streaming, checksum validation, persistence via `shared_preferences` | Enables automatic downloads |
| T010 | Add blocking dialog widget `lib/widgets/unsupported_device_dialog.dart` with responsive layout | Reused in US2 |
| T011 | Wire analytics helper `lib/services/analytics_service.dart` capturing DefinitionRequestRecord events (local queue + flush stub) | Required for instrumentation |
| T012 | Update app initialization in `lib/main.dart` to initialize capability service, download manager, and analytics | Establish boot sequence |

## Phase 2 – User Story 1 (P1) – Player receives instant offline definition

**Goal**: Deliver local MediaPipe inference when assets available, ensuring zero network calls.
**Independent Test**: With a supported device profile and pre-installed model assets, request a definition offline and verify response time <1.5s with no HTTP traffic.

| ID   | Task | Notes |
|------|------|-------|
| T013 | [US1] Implement `MediaPipeWordService` in `lib/services/mediapipe_word_service.dart` wrapping `LlmInference` and endpoints from `contracts/local_inference.yaml` | Core inference layer |
| T014 | [US1] Update `GamePage` to request definitions via new service and ensure asynchronous loading indicators | UI integration |
| T015 | [US1] Add offline mode guard ensuring no network calls (disable existing HTTP lookups) | Replace previous WordService logic |
| T016 | [US1] Record analytics event `local-success` with latency measurement | Instrumentation |
| T017 | [US1][P] Write widget test verifying offline definition path renders definition and does not trigger HTTP | Parallel with implementation review |
| T018 | [US1][P] Add integration test using fake capability + pre-installed model to assert <1.5s response and no network logs | Requires test harness |

**Checkpoint**: US1 tasks complete → offline inference flow demo-ready.

## Phase 3 – User Story 2 (P2) – Player is informed of unsupported device

**Goal**: Block unsupported hardware from starting the game and display clear alert.
**Independent Test**: Using fake capability returning unsupported, launch app and verify blocking dialog appears before entering `GamePage`, with analytics `local-blocked` logged.

| ID   | Task | Notes |
|------|------|-------|
| T019 | [US2] Implement capability check hook at navigation entry (e.g., `MainPage` init) to evaluate device eligibility | Blocks flow early |
| T020 | [US2] Trigger `UnsupportedDeviceDialog` and prevent routing to `GamePage` | Uses widget from T010 |
| T021 | [US2] Log analytics event `local-blocked` with reason from capability service | Observability |
| T022 | [US2][P] Add widget test toggling fake capability to confirm dialog display and navigation halt | Parallel |
| T023 | [US2][P] Add integration test verifying no inference attempts occur when blocked | Parallel |

**Checkpoint**: US2 tasks complete → unsupported devices halted with messaging.

## Phase 4 – User Story 3 (P3) – Automatic model download on capable devices

**Goal**: Automatically download model assets on capable devices lacking installations, show progress, and defer gameplay until ready.
**Independent Test**: Start with capable device & missing assets, verify download auto-starts, progress displayed, gameplay resumes only after installation, analytics events emitted (`download-failed` on error, success triggers definition usage).

| ID   | Task | Notes |
|------|------|-------|
| T024 | [US3] Integrate download manager into app init to trigger when `modelInstallState == missing` | Automatic start |
| T025 | [US3] Add progress UI to `MainPage`/`GamePage` (e.g., overlay or status banner) showing percentage | Player feedback |
| T026 | [US3] Block gameplay interactions until download completes or errors, with retry messaging | Ensures definitions local |
| T027 | [US3] Emit analytics `download-failed` with reason and expose retry action | Observability |
| T028 | [US3][P] Write widget test simulating download progress & completion using fake download manager | Parallel |
| T029 | [US3][P] Add integration test covering automatic download, pause/resume, and gameplay unblock on completion | Parallel |

**Checkpoint**: US3 tasks complete → automatic download flow operational.

## Phase 5 – Polish & Cross-Cutting

| ID   | Task | Notes |
|------|------|-------|
| T030 | Conduct performance profiling to confirm sub-1.5s inference and 60 FPS during downloads | Validate SC-001 |
| T031 | Update documentation (README + ADR 0002 references) with new on-device workflow and setup | Knowledge sharing |
| T032 | Run full test suite (`flutter analyze`, `flutter test`, integration tests) and prepare release notes | Final quality gate |

## Dependencies & Flow

1. Phase 0 → Phase 1 → Phase 2 → Phase 3 → Phase 4 → Phase 5
2. User stories prioritized US1 > US2 > US3; each independent once foundational tasks complete.

## Parallel Execution Opportunities

- **US1**: T017 and T018 can proceed in parallel after T015 is stable.
- **US2**: T022 and T023 parallel once T020 is implemented.
- **US3**: T028 and T029 parallel after T026.

## Task Counts

- Total tasks: 32
- Setup/Foundation (Phases 0-1): 12
- US1 tasks: 6
- US2 tasks: 5
- US3 tasks: 6
- Polish: 3

## Independent Test Criteria Summary

- **US1**: Offline supported device returns definition <1.5s with no network traffic.
- **US2**: Unsupported device shows blocking dialog, prevents gameplay, logs `local-blocked`.
- **US3**: Capable device auto-downloads model, shows progress, blocks gameplay until installed.

## Suggested MVP Scope

Deliver Phases 0-2 (Setup, Foundational) and Phase 2 (US1). This provides offline inference for supported devices, satisfying core product goal while deferring unsupported-device messaging and automatic download enhancements.

## Implementation Strategy

1. Complete Phase 0 & 1 to establish shared infrastructure.
2. Ship US1 as MVP; ensure analytics, offline inference, and tests are stable.
3. Layer on US2 to handle unsupported hardware gracefully.
4. Finish with US3 automatic downloads to broaden supported device coverage.
5. Execute polish phase for performance validation and documentation updates.
