---
goal: Update Dev Container files to support Flutter 3.35 stable with modern Android SDK and tooling
version: 1.0
date_created: 2025-08-23
last_updated: 2025-08-23
owner: infrastructure
status: 'Planned'
tags: [upgrade, devcontainer, flutter, android, infrastructure]
---

# Introduction

![Status: Planned](https://img.shields.io/badge/status-Planned-blue)

This plan updates the Dev Container configuration files to support the updated Flutter 3.35 project, including upgrading Flutter SDK, Android SDK components, and modernizing the development environment setup to match the project's upgraded dependencies and requirements.

## 1. Requirements & Constraints

- **REQ-001**: Update Flutter SDK version from 3.10.3 to 3.35.0 in Dev Container installation scripts
- **REQ-002**: Upgrade Android SDK to support compileSdk=34 and targetSdk=34 requirements
- **REQ-003**: Update Android Build Tools version to support AGP 8.6.1 and Gradle 8.7
- **REQ-004**: Ensure Java 17 is available for Android builds (current: Java 11)
- **REQ-005**: Update base image to support modern Flutter development requirements
- **REQ-006**: Maintain compatibility with existing VS Code extensions and settings
- **REQ-007**: Preserve existing port forwarding and workspace configuration
- **SEC-001**: Maintain secure installation practices with verification steps
- **CON-001**: Keep installation scripts modular and maintainable
- **CON-002**: Ensure scripts work in non-interactive environments
- **GUD-001**: Follow Flutter official installation guidelines for Linux containers
- **PAT-001**: Use consistent environment variable naming and path management

## 2. Implementation Steps

### Implementation Phase 1: Update Flutter SDK Installation

- GOAL-001: Upgrade Flutter SDK installation to version 3.35.0

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-001 | Update FLUTTER_VERSION variable from "3.10.3" to "3.35.0" in installFlutterSdk.sh | | |
| TASK-002 | Update Flutter download URL to use 3.35.0 stable release | | |
| TASK-003 | Add verification step to ensure Flutter 3.35.0 is correctly installed | | |
| TASK-004 | Test Flutter SDK installation with new version | | |

### Implementation Phase 2: Update Android SDK Components

- GOAL-002: Upgrade Android SDK components to support modern Android development

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-005 | Update ANDROID_PLATFORM_VERSION from "30" to "34" in installAndroidSdk.sh | | |
| TASK-006 | Update ANDROID_BUILD_TOOLS_VERSION to "34.0.0" to match compileSdk requirements | | |
| TASK-007 | Update Android command line tools to latest version if needed | | |
| TASK-008 | Test Android SDK installation with updated versions | | |

### Implementation Phase 3: Update Java and Base Container Configuration

- GOAL-003: Ensure development environment supports Java 17 and modern tooling

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-009 | Update Java feature version from "11" to "17" in devcontainer.json | | |
| TASK-010 | Update base image to mcr.microsoft.com/devcontainers/universal:3 (latest) | | |
| TASK-011 | Add explicit Java 17 installation verification in onCreate.sh | | |
| TASK-012 | Test container build with updated configuration | | |

### Implementation Phase 4: Validation and Documentation

- GOAL-004: Validate updated Dev Container works with Flutter 3.35 project

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-013 | Test full container rebuild from scratch | | |
| TASK-014 | Verify flutter doctor shows no issues with new setup | | |
| TASK-015 | Test flutter pub get and flutter build web commands | | |
| TASK-016 | Test Android build capabilities (flutter build appbundle) | | |
| TASK-017 | Update documentation comments in installation scripts | | |

## 3. Alternatives

- **ALT-001**: Use Flutter Version Manager (fvm) for version management - rejected due to added complexity for container environment
- **ALT-002**: Use pre-built Flutter Docker image - rejected to maintain control over exact SDK and tool versions
- **ALT-003**: Keep Flutter 3.10.3 and upgrade later - rejected as it would prevent proper testing of Flutter 3.35 features

## 4. Dependencies

- **DEP-001**: Updated Flutter 3.35.0 stable release must be available from Google's storage
- **DEP-002**: Android SDK platform-34 and build-tools;34.0.0 must be available
- **DEP-003**: Java 17 support in the base container image
- **DEP-004**: Compatible VS Code extensions for Flutter development

## 5. Files

- **FILE-001**: `.devcontainer/devcontainer.json` - Update Java version and maintain VS Code settings
- **FILE-002**: `.devcontainer/installFlutterSdk.sh` - Update Flutter version and download URLs
- **FILE-003**: `.devcontainer/installAndroidSdk.sh` - Update Android SDK versions and build tools
- **FILE-004**: `.devcontainer/onCreate.sh` - Add any additional setup steps if needed

## 6. Testing

- **TEST-001**: Container builds successfully from clean state
- **TEST-002**: Flutter 3.35.0 is correctly installed and recognized
- **TEST-003**: Android SDK components are properly configured
- **TEST-004**: Java 17 is available and set as default
- **TEST-005**: VS Code extensions load correctly
- **TEST-006**: Flutter project builds successfully (web and Android)
- **TEST-007**: Port forwarding works for Flutter web development
- **TEST-008**: flutter doctor reports no critical issues

## 7. Risks & Assumptions

- **RISK-001**: Flutter 3.35.0 download URLs may change - mitigation: verify URLs before deployment
- **RISK-002**: New Android SDK versions may have compatibility issues - mitigation: test thoroughly
- **RISK-003**: Java 17 upgrade may break existing Android builds - mitigation: verify Gradle compatibility
- **RISK-004**: Container image size may increase significantly - mitigation: monitor and optimize if needed
- **ASSUMPTION-001**: Base universal image supports Java 17 installation
- **ASSUMPTION-002**: Current VS Code extensions are compatible with Flutter 3.35
- **ASSUMPTION-003**: Network access is available during container build for downloads

## 8. Related Specifications / Further Reading

- [Flutter 3.35 Release Notes](https://docs.flutter.dev/release/release-notes)
- [Android SDK Command Line Tools](https://developer.android.com/studio/command-line)
- [Dev Containers Specification](https://containers.dev/implementors/spec/)
- [upgrade-flutter-sdk-1.md](/workspaces/guess-word-game/plan/upgrade-flutter-sdk-1.md) - Main Flutter project upgrade plan
