---
applyTo: '.copilot-tracking/changes/20250823-flutter-web-initialization-upgrade-changes.md'
---
<!-- markdownlint-disable-file -->
# Task Checklist: Flutter Web Initialization Upgrade

## Overview

Upgrade Flutter web app initialization from deprecated `_flutter.loader.loadEntrypoint()` pattern to modern `{{flutter_bootstrap_js}}` template token approach for Flutter 3.35+ compatibility.

## Objectives

- Replace deprecated web initialization patterns with modern Flutter 3.35+ approach
- Eliminate deprecation warnings for `serviceWorkerVersion` and `_flutter.loader.loadEntrypoint()`
- Maintain existing app functionality and loading behavior
- Follow Flutter web initialization best practices

## Research Summary

### Project Files
- web/index.html - Contains deprecated initialization patterns requiring modernization

### External References
- #file:../research/20250823-flutter-web-initialization-upgrade-research.md - Comprehensive analysis of modern Flutter web initialization patterns
- #githubRepo:"flutter/flutter flutter_bootstrap.js template token index.html modern" - Official Flutter repository examples of modern initialization
- #fetch:https://docs.flutter.dev/platform-integration/web/initialization - Official Flutter web initialization documentation

### Standards References
- #file:../../plan/upgrade-web-initialization-1.md - Original implementation plan with requirements and constraints

## Implementation Checklist

### [x] Phase 1: Remove Deprecated Patterns

- [x] Task 1.1: Remove deprecated serviceWorkerVersion variable declaration
  - Details: .copilot-tracking/details/20250823-flutter-web-initialization-upgrade-details.md (Lines 15-25)

- [x] Task 1.2: Remove deprecated flutter.js script tag
  - Details: .copilot-tracking/details/20250823-flutter-web-initialization-upgrade-details.md (Lines 27-37)

- [x] Task 1.3: Remove deprecated _flutter.loader.loadEntrypoint() initialization script
  - Details: .copilot-tracking/details/20250823-flutter-web-initialization-upgrade-details.md (Lines 39-49)

### [x] Phase 2: Implement Modern Bootstrap Pattern

- [x] Task 2.1: Add modern {{flutter_bootstrap_js}} template token
  - Details: .copilot-tracking/details/20250823-flutter-web-initialization-upgrade-details.md (Lines 51-61)

## Dependencies

- Flutter SDK 3.35+ with updated web build tools
- Modern web browsers supporting async/await and Promises
- Build pipeline supporting template token replacement

## Success Criteria

- flutter build web completes without deprecation warnings about legacy initialization
- Web app loads correctly in development and production modes
- All application routes and functionality preserved
- Service worker functionality maintained if enabled
