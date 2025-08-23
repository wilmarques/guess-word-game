# Flutter 3.35 Upgrade - Post-Configuration Steps

This document outlines the steps that need to be executed after the configuration files have been updated to complete the Flutter 3.35 upgrade.

## Completed Configuration Updates

✅ **Phase 1 - Dependencies Updated**
- ✅ TASK-001: Updated `/pubspec.yaml` environment.sdk to `>=3.0.0 <4.0.0`
- ✅ Updated dependencies: flutter_lints ^4.0.0, cupertino_icons ^1.0.8, http ^1.2.2, go_router ^14.2.7, device_preview ^1.2.0
- ✅ TASK-002: Updated `/api/pubspec.yaml` environment.sdk to `>=3.0.0 <4.0.0`
- ✅ Updated API dependencies: shelf ^1.4.1, shelf_router ^1.1.4, shelf_static ^1.1.2, lints ^4.0.0

✅ **Phase 2 - Android Configuration Updated**
- ✅ TASK-003: Updated gradle-wrapper.properties to Gradle 8.7-bin
- ✅ TASK-004: Removed buildscript block from /android/build.gradle for AGP 8+ compatibility
- ✅ TASK-005: Updated /android/settings.gradle with new pluginManagement and Flutter 3.35 template
- ✅ TASK-006: Updated /android/app/build.gradle with new plugin syntax, namespace, compileSdk=34, targetSdk=34, Java/Kotlin 17

✅ **Phase 3 - iOS Configuration Updated**
- ✅ TASK-007: Set ios/Flutter/AppFrameworkInfo.plist MinimumOSVersion to 13.0

✅ **Phase 4 - Code Review Completed**
- ✅ TASK-010: Reviewed codebase for deprecated APIs - no obvious issues found
- ✅ TASK-011: Verified asset bundle paths - current path 'assets/words/nouns/words.txt' is correct
- ✅ Analysis_options.yaml already configured for flutter_lints package upgrades

## Files Updated

The following files have been modified to support Flutter 3.35 (Dart 3.9):

### Dependency Configuration
- `/pubspec.yaml` - Updated Dart SDK constraint and all dependencies to target versions
- `/api/pubspec.yaml` - Updated Dart SDK constraint and shelf dependencies 

### Android Configuration  
- `/android/gradle/wrapper/gradle-wrapper.properties` - Updated to Gradle 8.7-bin
- `/android/build.gradle` - Removed buildscript block for AGP 8.6.1 compatibility
- `/android/settings.gradle` - Added pluginManagement and Flutter 3.35 plugin loader
- `/android/app/build.gradle` - New plugin syntax, namespace, compileSdk=34, targetSdk=34, Java 17

### iOS Configuration
- `/ios/Flutter/AppFrameworkInfo.plist` - Updated MinimumOSVersion to 13.0

### Documentation
- `/FLUTTER_UPGRADE_STEPS.md` - Complete upgrade execution guide

## Required Command Execution Steps

### Step 1: Install Flutter 3.35
```bash
# Ensure Flutter 3.35 is installed and active
flutter upgrade
flutter --version  # Should show Flutter 3.35.x
```

### Step 2: Clean and Update Dependencies
```bash
# Main project
flutter clean
flutter pub get
flutter pub upgrade --major-versions

# API project  
cd api
dart pub get
dart pub upgrade --major-versions
cd ..
```

### Step 3: Apply Automated Fixes
```bash
# Apply Dart language fixes
dart fix --apply

# Apply Flutter-specific fixes
flutter fix --apply
```

### Step 4: Code Review and Manual Fixes
- Review any deprecation warnings in IDE
- Check for breaking changes in dependencies (especially go_router ^14.2.7)
- Verify asset bundle paths are correct
- Test API endpoints if any breaking changes in shelf packages

### Step 5: Build and Test
```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Test Android build
flutter run -d android
flutter build appbundle

# Test web build
flutter build web

# Test iOS build (macOS only)
flutter build ipa
```

## Potential Issues to Watch For

### go_router Migration (6.2.0 → 14.2.7)
- Major version jump may require API changes
- Check for route configuration breaking changes
- Verify navigation patterns still work

### device_preview Migration (1.1.0 → 1.2.0)
- Check if initialization patterns have changed
- Verify compatibility with Flutter 3.35

### Shelf Dependencies Migration
- shelf: 1.2.0 → 1.4.1
- shelf_router: 1.0.0 → 1.1.4
- shelf_static: 1.0.0 → 1.1.2
- May require API updates in server.dart

### Android Build Issues
- AGP 8.6.1 with new plugin syntax may require Gradle daemon restart
- Java 17 requirement may need local environment updates
- Namespace declaration in build.gradle replaces applicationId in some contexts

## Testing Checklist

- [ ] Project builds without errors (`flutter build appbundle`)
- [ ] Web build succeeds (`flutter build web`)
- [ ] All existing functionality works (game play, navigation, API calls)
- [ ] No runtime deprecation warnings
- [ ] All automated tests pass (`flutter test`)
- [ ] Static analysis passes (`flutter analyze`)

## Rollback Plan

If issues arise, use git to rollback individual files:
```bash
# Rollback specific files if needed
git checkout HEAD~1 -- pubspec.yaml
git checkout HEAD~1 -- android/build.gradle
# etc.
```

Or rollback the entire branch:
```bash
git reset --hard <previous_commit_hash>
```