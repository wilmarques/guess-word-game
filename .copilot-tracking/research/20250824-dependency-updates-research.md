<!-- markdownlint-disable-file -->
# Task Research Notes: Dependency Updates

## Research Executed

### File Analysis
- `/workspaces/guess-word-game/pubspec.yaml`
  - Flutter app dependencies: cupertino_icons (^1.0.8), go_router (^14.2.7), device_preview (^1.2.0), http (^1.2.2)
  - Dev dependencies: flutter_lints (^4.0.0)
  - SDK constraint: >=3.0.0 <4.0.0
- `/workspaces/guess-word-game/api/pubspec.yaml`
  - API dependencies: shelf (^1.4.1), shelf_router (^1.1.4), shelf_static (^1.1.2)
  - Dev dependencies: http (^0.13.0), lints (^4.0.0)
  - SDK constraint: >=3.0.0 <4.0.0

### Code Search Results
- `flutter pub outdated`
  - go_router: Current 14.8.1 → Latest 16.2.0 (major version change)
  - flutter_lints: Current 4.0.0 → Latest 6.0.0 (major version change)
- `dart pub outdated` (API)
  - http: Current 0.13.6 → Latest 1.5.0 (major version change)
  - lints: Current 4.0.0 → Latest 6.0.0 (major version change)

### External Research
- #fetch:"https://pub.dev/packages/go_router/changelog"
  - go_router 16.0.0 introduces breaking changes to GoRouteData with new method signatures
  - go_router 15.0.0 made URLs case sensitive by default (caseSensitive parameter added)
  - Minimum Flutter SDK updated to 3.29/Dart 3.7 in 16.2.0
  - Migration guides available for major versions
- #fetch:"https://pub.dev/packages/flutter_lints/changelog"
  - flutter_lints 6.0.0 adds strict_top_level_inference and unnecessary_underscores lints
  - flutter_lints 5.0.0 removed prefer_const_* lints, adds new validation rules
  - Minimum Flutter SDK updated to 3.32/Dart 3.8 in 6.0.0

### Project Conventions
- Standards referenced: Analysis options configured in analysis_options.yaml
- Instructions followed: Standard Flutter project structure

## Key Discoveries

### Project Structure
- Flutter app with separate API module structure
- Simple routing configuration using go_router with basic paths
- Clean separation between main app and API dependencies

### Implementation Patterns
- Standard go_router configuration with route definitions
- Basic route structure: /, /play, /winning
- No complex routing features like named routes or nested routing used

### Complete Examples
```dart
// Current routing configuration (simple)
final GoRouter routes = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/play',
      builder: (context, state) => const GamePage(),
    ),
    GoRoute(
      path: '/winning',
      builder: (context, state) => const WinningPage(),
    ),
  ],
);
```

### API and Schema Documentation
- go_router breaking changes in version 16.0.0 mainly affect GoRouteData (not used in this project)
- Case sensitivity changes in 15.0.0 shouldn't affect this project (simple paths)
- flutter_lints 6.0.0 adds new lint rules but removes some const-related rules

### Configuration Examples
```yaml
# Main app dependencies to update
dependencies:
  go_router: ^16.2.0  # from ^14.2.7

dev_dependencies:
  flutter_lints: ^6.0.0  # from ^4.0.0

# API dependencies to update
dependencies:
  http: ^1.5.0  # from ^0.13.0 (API dev deps)

dev_dependencies:
  lints: ^6.0.0  # from ^4.0.0
```

### Technical Requirements
- Flutter SDK constraint may need updating for newer dependencies
- go_router 16.2.0 requires Flutter 3.29/Dart 3.7 minimum
- flutter_lints 6.0.0 requires Flutter 3.32/Dart 3.8 minimum

## Recommended Approach

**Safe Major Version Updates Strategy**: Update dependencies systematically with Flutter SDK constraint adjustments, since this project uses basic features that are stable across major versions.

## Implementation Guidance

- **Objectives**: Update all dependencies to latest versions including major version changes
- **Key Tasks**:
  1. Update Flutter SDK constraint to support latest dependency requirements
  2. Update all package versions to latest in both pubspec.yaml files
  3. Run dependency resolution and test for any breaking changes
  4. Address any new lint warnings from updated linting rules
- **Dependencies**: No external dependencies - all packages are standard Flutter/Dart packages
- **Success Criteria**:
  - All dependencies updated to latest versions
  - Project builds successfully
  - All existing functionality preserved
  - No breaking changes affecting current code
