---
goal: Upgrade Flutter web app initialization to use modern flutter_bootstrap.js pattern
version: 1.0
date_created: 2025-08-23
last_updated: 2025-08-23
owner: Development Team
status: 'Planned'
tags: ['upgrade', 'web', 'initialization', 'flutter']
---

# Upgrade Flutter Web App Initialization

![Status: Planned](https://img.shields.io/badge/status-Planned-blue)

This implementation plan upgrades the Flutter web app initialization from the deprecated `_flutter.loader.loadEntrypoint()` pattern to the modern `flutter_bootstrap.js` pattern recommended for Flutter 3.35+. This addresses deprecation warnings and follows current Flutter web best practices.

## 1. Requirements & Constraints

- **REQ-001**: Replace deprecated `_flutter.loader.loadEntrypoint()` with modern `flutter_bootstrap.js` pattern
- **REQ-002**: Remove deprecated `serviceWorkerVersion` local variable that triggers warning
- **REQ-003**: Maintain existing app functionality and loading behavior
- **REQ-004**: Use template token approach for inline bootstrap script
- **REQ-005**: Ensure compatibility with Flutter 3.35+ web initialization
- **SEC-001**: Maintain secure initialization without exposing sensitive configuration
- **CON-001**: Must not break existing web deployment pipeline
- **CON-002**: Changes must be compatible with `flutter build web` command
- **GUD-001**: Follow Flutter web initialization documentation patterns
- **GUD-002**: Use modern JavaScript async/await patterns where appropriate
- **PAT-001**: Use {{flutter_bootstrap_js}} template token for clean inline approach

## 2. Implementation Steps

### Implementation Phase 1: Update web/index.html initialization

- GOAL-001: Replace legacy initialization with modern flutter_bootstrap.js pattern

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-001 | Remove deprecated `serviceWorkerVersion` variable declaration from web/index.html | |  |
| TASK-002 | Remove deprecated `_flutter.loader.loadEntrypoint()` initialization script block | |  |
| TASK-003 | Replace with `{{flutter_bootstrap_js}}` template token in script tag | |  |
| TASK-004 | Remove obsolete `flutter.js` script tag as it's now included in bootstrap | |  |

### Implementation Phase 2: Validate and test

- GOAL-002: Ensure proper functionality and verify no regressions

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-005 | Test `flutter build web` command to verify bootstrap script generation | |  |
| TASK-006 | Verify web app loads correctly in development mode | |  |
| TASK-007 | Verify web app loads correctly in production build | |  |
| TASK-008 | Test service worker functionality is preserved | |  |

## 3. Alternatives

- **ALT-001**: Use external `flutter_bootstrap.js` file instead of template token - rejected for simplicity and to avoid additional file management
- **ALT-002**: Create custom bootstrap script with loading indicators - deferred to future enhancement as current functionality should be preserved
- **ALT-003**: Use `onEntrypointLoaded` callback for custom loading - deferred as no custom loading logic currently exists

## 4. Dependencies

- **DEP-001**: Flutter SDK 3.35+ with updated web build tools
- **DEP-002**: Modern web browsers that support async/await and Promises
- **DEP-003**: Build pipeline must support template token replacement

## 5. Files

- **FILE-001**: `/web/index.html` - Primary file requiring initialization pattern update
- **FILE-002**: Generated `build/web/index.html` - Output file to be validated after build
- **FILE-003**: Generated `build/web/flutter_bootstrap.js` - Auto-generated bootstrap script to verify

## 6. Testing

- **TEST-001**: Unit test: Verify `flutter build web` completes without warnings about deprecated patterns
- **TEST-002**: Integration test: Load web app in browser and verify all routes function correctly
- **TEST-003**: Integration test: Verify service worker registration works if enabled
- **TEST-004**: Manual test: Check browser developer console for deprecation warnings
- **TEST-005**: Manual test: Verify app loads on various browsers (Chrome, Firefox, Safari, Edge)

## 7. Risks & Assumptions

- **RISK-001**: Build pipeline might fail if Flutter SDK doesn't support template tokens - mitigation: verify Flutter version supports modern initialization
- **RISK-002**: Service worker configuration might break - mitigation: test thoroughly and compare with working builds
- **ASSUMPTION-001**: Current Flutter SDK version (3.35+) supports {{flutter_bootstrap_js}} template token
- **ASSUMPTION-002**: No custom initialization logic exists that depends on direct _flutter.loader access
- **ASSUMPTION-003**: Build process will correctly replace template tokens during `flutter build web`

## 8. Related Specifications / Further Reading

- [Flutter Web App Initialization Documentation](https://docs.flutter.dev/platform-integration/web/initialization)
- [Flutter Web Bootstrapping Guide](https://docs.flutter.dev/platform-integration/web/initialization#bootstrapping)
- [Flutter 3.35 Release Notes](https://medium.com/flutter/whats-new-in-flutter-3-35-c58ef72e3766)
- Related plan: `/plan/upgrade-flutter-sdk-1.md` - Ensures proper Flutter SDK version is installed
