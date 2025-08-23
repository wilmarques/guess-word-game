<!-- markdownlint-disable-file -->
# Task Details: Flutter Web Initialization Upgrade

## Research Reference

**Source Research**: #file:../research/20250823-flutter-web-initialization-upgrade-research.md

## Phase 1: Remove Deprecated Patterns

### Task 1.1: Remove deprecated serviceWorkerVersion variable declaration

Remove the deprecated `var serviceWorkerVersion = null;` declaration that triggers warnings in Flutter 3.35+.

- **Files**:
  - web/index.html - Remove serviceWorkerVersion variable declaration from script block
- **Success**:
  - Variable declaration completely removed from index.html
  - No references to serviceWorkerVersion remain in manual initialization
- **Research References**:
  - #file:../research/20250823-flutter-web-initialization-upgrade-research.md (Lines 25-30) - Documentation confirms this variable is deprecated
  - #fetch:https://docs.flutter.dev/platform-integration/web/initialization#common-warning - Official warning about deprecated serviceWorkerVersion
- **Dependencies**:
  - None - standalone removal task

### Task 1.2: Remove deprecated flutter.js script tag

Remove the obsolete `<script src="flutter.js" defer></script>` tag as it's now included in bootstrap.

- **Files**:
  - web/index.html - Remove flutter.js script tag from head section
- **Success**:
  - flutter.js script tag completely removed
  - No manual flutter.js loading remains
- **Research References**:
  - #file:../research/20250823-flutter-web-initialization-upgrade-research.md (Lines 35-40) - Modern pattern eliminates need for separate flutter.js
  - #githubRepo:"flutter/flutter flutter_bootstrap.js template token" - Examples show no flutter.js script tag needed
- **Dependencies**:
  - Task 1.1 completion recommended for clean removal

### Task 1.3: Remove deprecated _flutter.loader.loadEntrypoint() initialization script

Remove the entire deprecated initialization script block containing `_flutter.loader.loadEntrypoint()` calls.

- **Files**:
  - web/index.html - Remove complete script block with loadEntrypoint initialization
- **Success**:
  - Complete removal of deprecated loadEntrypoint script block
  - No manual engine initialization or service worker setup remains
- **Research References**:
  - #file:../research/20250823-flutter-web-initialization-upgrade-research.md (Lines 42-47) - loadEntrypoint pattern is deprecated in Flutter 3.35+
  - #githubRepo:"flutter/flutter flutter_bootstrap.js template" - Modern examples use template token instead
- **Dependencies**:
  - Tasks 1.1 and 1.2 completion for consistent state

## Phase 2: Implement Modern Bootstrap Pattern

### Task 2.1: Add modern {{flutter_bootstrap_js}} template token

Replace deprecated initialization with modern `{{flutter_bootstrap_js}}` template token in script tag.

- **Files**:
  - web/index.html - Add script tag with {{flutter_bootstrap_js}} template token
- **Success**:
  - Template token properly placed in script tag within body
  - No syntax errors in resulting HTML
  - Template token correctly formatted for build-time replacement
- **Research References**:
  - #file:../research/20250823-flutter-web-initialization-upgrade-research.md (Lines 49-60) - Complete example of modern pattern implementation
  - #fetch:https://docs.flutter.dev/platform-integration/web/initialization#bootstrapping - Official template token documentation
- **Dependencies**:
  - Phase 1 completion ensures clean slate for modern implementation

## Dependencies

- Flutter SDK 3.35+ with template token support in build tools

## Success Criteria

- flutter build web completes without warnings about deprecated patterns
- Web app loads correctly in browser with all routes functioning
- Service worker registration works if enabled
- No browser console errors related to initialization
