<!--
SYNC IMPACT REPORT
==================
Version change: 1.0.0 → 1.1.0
Modified principles:
  - II. "Responsive & Cross-Platform Design" → "Mobile-First Design" (removed desktop support, removed responsive requirements)
  - III. "Test-Driven Development" → "Flow-Based Testing" (emphasize integration tests over unit tests)
Added sections: None
Removed sections: None
Templates requiring updates: ✅ plan-template.md updated (constitution check section)
Follow-up TODOs: None
-->

# Guess Word Game Constitution

## Core Principles

### I. Flutter Architecture First
MUST follow Flutter's recommended patterns: clear separation between presentation, business logic, and data layers. MUST use StatefulWidget/StatelessWidget appropriately. MUST implement proper widget lifecycle management. MUST use Flutter's built-in state management before introducing external solutions. Every feature MUST be designed with widget composition and reusability in mind.

**Rationale**: Flutter's declarative UI paradigm requires specific architectural patterns for maintainability and performance. Proper separation prevents tight coupling and enables easier testing and debugging.

### II. Mobile-First Design (NON-NEGOTIABLE)
MUST implement mobile-first design with consistent mobile look and feel across all platforms. MUST support web and mobile platforms while maintaining mobile UI patterns even on web. MUST optimize for touch interactions and mobile viewport sizes. MUST ensure identical user experience regardless of platform.

**Rationale**: The game targets mobile users primarily. Maintaining mobile patterns across platforms ensures consistent user experience and simplified development workflow.

### III. Flow-Based Testing
MUST write integration tests that cover complete user flows from input to output. MUST write widget tests for all UI components. MUST write unit tests only for genuinely complex business logic that cannot be easily tested through flows. MUST achieve minimum 80% code coverage before merging features. Integration tests MUST cover external API dependencies and error scenarios.

**Rationale**: Flow-based testing provides better confidence in application behavior and catches integration issues that unit tests miss. Complex game interactions are better validated through complete user scenarios.

### IV. Performance & User Experience
MUST maintain 60 FPS during gameplay. MUST implement proper loading states for async operations (API calls, asset loading). MUST optimize widget rebuilds using const constructors and keys appropriately. MUST handle network failures gracefully with user-friendly error messages. MUST provide immediate visual feedback for user interactions.

**Rationale**: Games demand smooth performance and responsive UI. Poor performance or confusing interactions destroy user engagement and game enjoyment.

### V. Effective Dart Compliance
MUST follow all style guidelines from `.github/instructions/dart-n-flutter.instructions.md`. MUST use `dart format` for code formatting. MUST follow naming conventions: UpperCamelCase for types, lowerCamelCase for variables/functions. MUST write comprehensive doc comments (///) for public APIs. MUST organize imports correctly (dart:, package:, relative).

**Rationale**: Consistent code style and documentation standards are essential for maintainability, onboarding, and professional development practices.

## Flutter Development Standards

**Dependency Management**: Use semantic versioning for all dependencies. Pin major versions to prevent breaking changes. Regularly audit dependencies for security and maintenance status. Prefer official Flutter packages over third-party alternatives.

**Asset Organization**: Organize assets in logical directories under `/assets/`. Declare all assets in `pubspec.yaml`. Use appropriate asset loading patterns with error handling. Optimize image assets for multiple densities.

**Build Configuration**: Maintain consistent build configurations across platforms. Use environment-specific configurations for API endpoints and keys. Ensure web builds are optimized for production deployment.

**API Integration**: Implement proper error handling and retry logic for external API calls. Use typed models with `fromJson` factories for API responses. Handle network connectivity changes gracefully.

## Code Review & Quality Gates

**Review Requirements**: All code changes require peer review. Reviewer MUST verify constitution compliance, especially architecture and testing requirements. MUST validate mobile-first design consistency across platforms before approval.

**Quality Gates**: All tests MUST pass. Code coverage MUST meet 80% threshold. `flutter analyze` MUST show zero issues. Performance benchmarks MUST not regress. External API integration MUST handle failure scenarios.

**Documentation Updates**: Update README and inline documentation when adding features. Maintain ADRs for architectural decisions. Update API documentation when contracts change.

## Governance

This constitution supersedes all other development practices. All pull requests and code reviews MUST verify compliance with these principles. Any complexity or deviation MUST be explicitly justified and documented.

Use `.github/instructions/dart-n-flutter.instructions.md` for detailed runtime development guidance. Architecture decisions impacting these principles MUST be documented in `/docs/adrs/`.

Constitution amendments require approval from project maintainers, documentation of rationale, and migration plan for existing code. All amendments MUST maintain backward compatibility with existing development workflows.

**Version**: 1.1.0 | **Ratified**: 2025-10-11 | **Last Amended**: 2025-10-11
