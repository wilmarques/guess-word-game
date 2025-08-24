<!-- markdownlint-disable-file -->
# Task Research Notes: Flutter Web Initialization Upgrade

## Research Executed

### File Analysis
- `/web/index.html`
  - Current implementation uses deprecated `_flutter.loader.loadEntrypoint()` pattern
  - Contains deprecated `var serviceWorkerVersion = null;` declaration
  - Uses legacy `flutter.js` script tag with manual initialization
  - Implements manual service worker configuration and engine initialization

### Code Search Results
- Flutter documentation patterns
  - Modern `{{flutter_bootstrap_js}}` template token approach
  - Replacement for `flutter.js` + manual initialization
- GitHub Flutter repository examples
  - Multiple examples of `flutter_bootstrap.js` custom and template approaches
  - Template tokens: `{{flutter_js}}`, `{{flutter_build_config}}`, `{{flutter_bootstrap_js}}`

### External Research
- #fetch:"https://docs.flutter.dev/platform-integration/web/initialization"
  - Official documentation confirms `{{flutter_bootstrap_js}}` template token is recommended approach
  - Template token is replaced during `flutter build web` with complete bootstrap script
  - Eliminates need for separate `flutter.js` script tag and manual initialization
  - Addresses deprecation warnings for `serviceWorkerVersion` local variable

- #githubRepo:"flutter/flutter flutter_bootstrap.js template token index.html modern"
  - Examples show `{{flutter_bootstrap_js}}` pattern in script tag
  - Template generates complete initialization script including service worker settings
  - Eliminates deprecated `_flutter.loader.loadEntrypoint()` calls
  - Multiple Flutter repo examples use inline template token approach

### Project Conventions
- Standards referenced: Flutter 3.35+ web initialization best practices
- Instructions followed: `/plan/upgrade-web-initialization-1.md` requirements

## Key Discoveries

### Project Structure
- Web directory `/web/` contains `index.html` requiring modernization
- Current implementation uses deprecated initialization patterns
- Build process generates `build/web/` output directory with processed files

### Implementation Patterns
- Modern pattern: `{{flutter_bootstrap_js}}` template token in script tag
- Template replacement occurs during `flutter build web` process
- Eliminates need for separate `flutter.js` script loading
- Automatically handles service worker configuration and engine initialization

### Complete Examples
```html
<!-- Modern Flutter web initialization pattern -->
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="A new Flutter project.">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="guess_word_game">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>

  <title>guess_word_game</title>
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <script>
    {{flutter_bootstrap_js}}
  </script>
</body>
</html>
```

### API and Schema Documentation
- Template token `{{flutter_bootstrap_js}}` replaces entire initialization script
- Build process substitutes token with complete bootstrap script including:
  - Flutter engine loading
  - Service worker configuration
  - Application startup logic
  - Error handling and fallbacks

### Configuration Examples
```javascript
// Generated bootstrap script includes service worker settings
_flutter.loader.load({
  serviceWorker: {
    serviceWorkerVersion: "generated_hash"
  }
});
```

### Technical Requirements
- Flutter SDK 3.35+ with updated web build tools
- Modern browsers supporting async/await and Promises
- Build pipeline that supports template token replacement during `flutter build web`

## Recommended Approach
Replace current deprecated initialization with modern `{{flutter_bootstrap_js}}` template token approach. This eliminates deprecated patterns, removes manual service worker management, and follows Flutter 3.35+ best practices for web initialization.

## Implementation Guidance
- **Objectives**: Modernize web initialization to eliminate deprecation warnings and follow current Flutter best practices
- **Key Tasks**:
  1. Remove deprecated `serviceWorkerVersion` variable declaration
  2. Remove deprecated `_flutter.loader.loadEntrypoint()` script block
  3. Remove obsolete `flutter.js` script tag
  4. Replace with `{{flutter_bootstrap_js}}` template token in script tag
- **Dependencies**: Flutter SDK 3.35+ with template token support in build tools
- **Success Criteria**:
  - `flutter build web` completes without deprecation warnings
  - Web app loads correctly with modern initialization
  - All routes and functionality preserved
  - Service worker functionality maintained if enabled
