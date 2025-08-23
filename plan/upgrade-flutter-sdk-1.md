---
goal: Upgrade project to Flutter 3.35 stable (Dart 3.9) with modern Android/iOS templates
version: 1.0
date_created: 2025-08-23
last_updated: 2025-08-23
owner: mobile
status: 'Planned'
tags: [upgrade, flutter, dart, android, ios]
---

# Introduction

![Status: Planned](https://img.shields.io/badge/status-Planned-blue)

This plan upgrades the repository to Flutter 3.35 stable and Dart 3.9, updates platform tooling (Android Gradle, Kotlin, SDK levels; iOS minimums), migrates source to current APIs, and validates via build/test across platforms.

## 1. Requirements & Constraints

- **REQ-001**: Upgrade Flutter SDK to 3.35.0 (stable) and Dart SDK to 3.9.x (as bundled with Flutter 3.35).
- **REQ-002**: Update Android build to AGP 8.6.1 with Gradle 8.7, Kotlin 1.9.24, compileSdk=34, targetSdk=34.
- **REQ-003**: Migrate Android project to plugins DSL and new settings.gradle per Flutter templates.
- **REQ-004**: Update iOS minimum deployment target to iOS 13+, Xcode 15 compat; keep AppFrameworkInfo.plist MinimumOSVersion >= 13.0.
- **REQ-005**: Update Dart constraints in `pubspec.yaml` to `>=3.0.0 <4.0.0` and pin dependencies to explicit Flutter 3.35 compatible versions.
- **REQ-006**: Run `flutter fix --apply` and address breaking changes (3.19–3.35) where applicable.
- **REQ-007**: Ensure assets and `AssetManifest` changes are compatible with modern Flutter (no reliance on AssetManifest.json).
- **REQ-008**: Update CI/build docs and verify builds for Android, iOS, Web, and Desktop as configured.
- **SEC-001**: Do not commit signing keys; ensure `key.properties` is ignored.
- **CON-001**: Maintain package names, bundle identifiers, and app behavior.
- **GUD-001**: Follow official guides: Upgrade Flutter, Android/iOS release, breaking changes (3.19–3.35).
- **PAT-001**: Align platform files to current Flutter template where feasible without changing app identifiers.

## 2. Implementation Steps

### Implementation Phase 1

- GOAL-001: Bump SDK constraints, dependencies, and Flutter tooling files.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-001 | Update `/pubspec.yaml` `environment.sdk` to `>=3.0.0 <4.0.0`; set exact versions: `flutter_lints: ^4.0.0`, `cupertino_icons: ^1.0.8`, `http: ^1.2.2`, `go_router: ^14.2.7`, `device_preview: ^1.2.0`; run `flutter pub upgrade --major-versions`. |  |  |
| TASK-002 | Update `/api/pubspec.yaml` `environment.sdk` to `>=3.0.0 <4.0.0`; set exact versions: `shelf: ^1.4.1`, `shelf_router: ^1.1.4`, `shelf_static: ^1.1.2`, `lints: ^4.0.0`; run `flutter pub upgrade --major-versions` in `api/`. |  |  |
| TASK-003 | Update Gradle wrapper at `/android/gradle/wrapper/gradle-wrapper.properties` to `distributionUrl=https\://services.gradle.org/distributions/gradle-8.7-bin.zip`. |  |  |
| TASK-004 | Replace Android top-level Gradle `/android/build.gradle` with plugins DSL-free file per Flutter template for AGP 8+: move plugin management to settings and remove `buildscript` block. |  |  |
| TASK-005 | Migrate `/android/settings.gradle` to Flutter 3.35 template: configure `pluginManagement` to include Flutter tool, add `plugins { id "dev.flutter.flutter-plugin-loader" }`, and include `:app`. |  |  |
| TASK-006 | Update `/android/app/build.gradle` to use `plugins { id 'com.android.application'; id 'org.jetbrains.kotlin.android'; id 'dev.flutter.flutter-gradle-plugin' }`, set `android { namespace = "com.wilmarques.guess_word_game" compileSdk = 34 defaultConfig { minSdk = flutter.minSdkVersion targetSdk = 34 } compileOptions { sourceCompatibility = JavaVersion.VERSION_17 targetCompatibility = JavaVersion.VERSION_17 } kotlinOptions { jvmTarget = '17' } }` and remove legacy `apply from:` usage. |  |  |

### Implementation Phase 2

- GOAL-002: iOS minimums and Xcode settings alignment.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-007 | Update `ios/Flutter/AppFrameworkInfo.plist` `MinimumOSVersion` to `13.0`. |  |  |
| TASK-008 | Verify `ios/Runner/Info.plist` for UIScene support only if needed by templates; otherwise leave. Ensure `Runner.xcodeproj` LastUpgradeCheck aligns with Xcode 15 but do not require manual Xcode changes here. |  |  |

### Implementation Phase 3

- GOAL-003: Code migrations and fixes for breaking changes.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-009 | Run `dart fix --apply` and `flutter fix --apply` to auto-apply fixes. |  |  |
| TASK-010 | Sweep for deprecated API across 3.19–3.35: WidgetState rename, Material theme updates, Form sliver removal, Dialog background color rename; update code if any usages are found (search repo). |  |  |
| TASK-011 | Ensure no reliance on AssetManifest.json (Flutter now uses different manifest structure); verify asset loading via `AssetBundle` paths remains correct. |  |  |

### Implementation Phase 4

- GOAL-004: Build, test, and docs.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-012 | Clean and fetch: `flutter clean && flutter pub get`. |  |  |
| TASK-013 | Analyze and test: `flutter analyze`, `flutter test`. |  |  |
| TASK-014 | Build Android debug and release: `flutter run -d android`, `flutter build appbundle`. Ensure AGP downloads succeed with Gradle 8.7. |  |  |
| TASK-015 | Build iOS (macOS only): `flutter build ipa` (document-only here). |  |  |
| TASK-016 | Build Web: `flutter build web`. |  |  |

## 3. Alternatives

- **ALT-001**: Incremental upgrade across intermediate stable versions (3.19→3.22→…→3.35). Rejected for speed; project is small and migrations are minimal.
- **ALT-002**: Recreate Android/iOS folders from `flutter create .` and reapply identifiers. Rejected to minimize churn; prefer in-place template alignment.

## 4. Dependencies

- **DEP-001**: Flutter 3.35 SDK and Dart 3.9.
- **DEP-002**: Android Studio Giraffe+ or command-line Android SDK with API 34.
- **DEP-003**: Xcode 15+ (for iOS builds on macOS).

## 5. Files

- **FILE-001**: `/pubspec.yaml` main app constraints and deps.
- **FILE-002**: `/api/pubspec.yaml` server constraints and deps.
- **FILE-003**: `/android/build.gradle` → replace with plugins DSL.
- **FILE-004**: `/android/settings.gradle` → update to new loader.
- **FILE-005**: `/android/app/build.gradle` → modern DSL + namespace.
- **FILE-006**: `/ios/Flutter/AppFrameworkInfo.plist` → MinimumOSVersion.
- **FILE-007**: Project Dart sources for any API migrations.

## 6. Testing

- **TEST-001**: `flutter analyze` returns no errors.
- **TEST-002**: `flutter test` passes all tests.
- **TEST-003**: `flutter build appbundle` completes successfully.
- **TEST-004**: `flutter build web` completes successfully.

## 7. Risks & Assumptions

- **RISK-001**: AGP/Kotlin upgrades can break Gradle scripts; mitigated by following Flutter template.
- **RISK-002**: Dependency major bumps may introduce API changes; mitigated by app’s small surface.
- **ASSUMPTION-001**: No custom native plugins requiring manual migration.

## 8. Related Specifications / Further Reading

- Upgrade Flutter: https://docs.flutter.dev/install/upgrade
- Breaking changes: https://docs.flutter.dev/release/breaking-changes
- Android release: https://docs.flutter.dev/deployment/android
- iOS release: https://docs.flutter.dev/deployment/ios
