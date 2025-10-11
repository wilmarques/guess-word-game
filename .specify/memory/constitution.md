<!--
SYNC IMPACT REPORT
==================
Version change: Initial → 1.0.0
Modified principles: All new (initial creation)
Added sections: All new (initial creation)
Removed sections: None
Templates requiring updates: ✅ Will validate after constitution creation
Follow-up TODOs: None
-->

# Guess Word Game Constitution

## Core Principles

### I. Flutter Architecture First
MUST follow Flutter's recommended patterns: clear separation between presentation, business logic, and data layers. MUST use StatefulWidget/StatelessWidget appropriately. MUST implement proper widget lifecycle management. MUST use Flutter's built-in state management before introducing external solutions. Every feature MUST be designed with widget composition and reusability in mind.

**Rationale**: Flutter's declarative UI paradigm requires specific architectural patterns for maintainability and performance. Proper separation prevents tight coupling and enables easier testing and debugging.

### II. Responsive & Cross-Platform Design (NON-NEGOTIABLE)
MUST implement responsive design using Flutter's layout widgets (Flex, Expanded, MediaQuery). MUST test on multiple screen sizes and orientations. MUST support web, mobile, and desktop platforms without platform-specific compromises to core gameplay. MUST use ResponsiveScreen pattern established in this codebase for consistent layout behavior.

**Rationale**: The game targets multiple platforms and devices. Responsive design is non-negotiable for user experience and market reach. Consistent patterns prevent layout fragmentation.

### III. Test-Driven Development
MUST write widget tests for all UI components. MUST write unit tests for business logic and models. MUST achieve minimum 80% code coverage before merging features. Test scenarios MUST include multiple screen sizes, orientations, and platform variations. Integration tests MUST cover external API dependencies.

**Rationale**: Game applications require high reliability. TDD ensures robust functionality and prevents regressions in game mechanics, especially for cross-platform compatibility.

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

**Review Requirements**: All code changes require peer review. Reviewer MUST verify constitution compliance, especially architecture and testing requirements. MUST validate responsive design on multiple screen sizes before approval.

**Quality Gates**: All tests MUST pass. Code coverage MUST meet 80% threshold. `flutter analyze` MUST show zero issues. Performance benchmarks MUST not regress. External API integration MUST handle failure scenarios.

**Documentation Updates**: Update README and inline documentation when adding features. Maintain ADRs for architectural decisions. Update API documentation when contracts change.

## Governance

This constitution supersedes all other development practices. All pull requests and code reviews MUST verify compliance with these principles. Any complexity or deviation MUST be explicitly justified and documented.

Use `.github/instructions/dart-n-flutter.instructions.md` for detailed runtime development guidance. Architecture decisions impacting these principles MUST be documented in `/docs/adrs/`.

Constitution amendments require approval from project maintainers, documentation of rationale, and migration plan for existing code. All amendments MUST maintain backward compatibility with existing development workflows.

**Version**: 1.0.0 | **Ratified**: 2025-10-11 | **Last Amended**: 2025-10-11
