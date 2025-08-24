# GitHub Copilot Instructions for Guess Word Game

This Flutter app is a word guessing game where players guess words based on definitions from an external dictionary API. The architecture emphasizes responsive design, clean separation of concerns, and external service integration.

## Architecture Overview

### Core Application Structure
- **Entry Point**: `main.dart` uses `DevicePreview` for responsive testing and initializes `GuessWordApp`
- **Routing**: `go_router` package with 3 main routes (`/`, `/play`, `/winning`) defined in `app_routes.dart`
- **State Management**: Stateful widgets with local state, no global state management
- **Responsive Design**: Custom `ResponsiveScreen` utility handles portrait/landscape layouts

### Key Data Flow
```
User → MainPage → GamePage → WordService → Dictionary API → Word Model → UI Components
```

The `WordService` loads random words from `assets/words/nouns/words.txt` and fetches definitions from Merriam-Webster Dictionary API. The `Word` model processes JSON responses and extracts definitions using the `fromJson` factory constructor.

## Critical Development Patterns

### Responsive Layout System
The app uses a custom responsive pattern via `ResponsiveScreen` widget:
- **Portrait**: Vertical stack with top message, square main area, rectangular menu
- **Landscape**: Horizontal layout with adapted proportions
- **Usage**: Wrap page content in `ResponsiveScreen` with required areas
```dart
ResponsiveScreen(
  topMessageArea: // Navigation/status
  squarishMainArea: // Main game content
  rectangularMenuArea: // Controls/keyboard
)
```

### Word Service Integration
External API calls follow this pattern in `WordService`:
```dart
// 1. Load random word from assets
Future<String> loadRandomWord() // reads from assets/words/nouns/words.txt
// 2. Fetch definition from API
Future<Word> loadWordDefinition(String word) // calls dictionary API
// 3. Parse JSON to Word model
Word parseResponseBody(String responseBody) // transforms API response
```

### Widget Composition Strategy
UI follows a component-based approach:
- Reusable widgets in `/widgets/` (e.g., `DefaultButton`, `WordViewer`)
- Game-specific widgets in `/widgets/keyboard/` for letter input
- Notification pattern using `KeyboardLetterPressedNotification` for events

## Development Workflow

### Running the Application
- **Debug**: Use VS Code's "Flutter Debug" launch config (F5) - serves on `0.0.0.0:8080`
- **Web-first development**: Configured for Codespaces with auto-opening dev tools
- **Device Preview**: Automatically enabled in debug mode for responsive testing

### Key Development Commands
```bash
flutter pub get                    # Install dependencies
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080  # Manual web run
flutter build web                  # Production build
dart run api/server.dart          # Run optional local API server
```

### Asset Management
Words are stored in `assets/words/nouns/words.txt` (151 words) and must be declared in `pubspec.yaml` assets section. Add new word lists by:
1. Creating files in `assets/words/` structure
2. Updating `pubspec.yaml` assets
3. Modifying `WordService.loadRandomWord()` to reference new files

## Project-Specific Conventions

### Error Handling Strategy
- External API calls in `WordService` currently lack comprehensive error handling
- TODO comments indicate areas needing error handling (API failures, empty responses)
- Use `FutureBuilder` pattern for async UI updates with loading states

### Model Design Pattern
Models use factory constructors for JSON parsing:
```dart
factory Word.fromJson(Iterable<dynamic> json) {
  // Extract word from first reference's meta.id
  // Collect all definitions for the same word
  // Return Word with definitions, word, and imageName
}
```

### Game Logic Organization
Core game state lives in `GamePage._gamePageState`:
- `_guessedLetters` tracks player input
- `isAllLettersGuessedRight()` determines win condition
- Word loading handled via `FutureBuilder` with `_loadWordFuture`

## Integration Points

### External Dependencies
- **Dictionary API**: Merriam-Webster Student Dictionary API (hardcoded key in `WordService`)
- **Device Preview**: `device_preview` package for responsive testing
- **HTTP Client**: `http` package for API calls
- **Navigation**: `go_router` for declarative routing

### Development Environment
- **Codespaces Ready**: Pre-configured with dev container and VS Code settings
- **Web-first**: Optimized for web development with port forwarding on 8080
- **Extension Requirements**: Dart and Flutter extensions must be enabled

### Build Targets
Supports all Flutter platforms (web, Android, iOS, macOS, Linux, Windows) with platform-specific configurations in respective directories. Primary development target is web.

## Code Quality Standards

### Code Review Validation
**Critical**: All Dart and Flutter code changes must be validated against `.github/instructions/dart-n-flutter.instructions.md` during code reviews. This file contains:
- **Effective Dart** guidelines covering style, documentation, usage, and design patterns
- **Flutter Architecture** recommendations including MVVM, repository pattern, and separation of concerns
- **Testing standards** for unit tests, widget tests, and fake implementations

When reviewing code or implementing new features:
1. **Always reference** the Dart and Flutter instructions for style compliance
2. **Validate naming conventions**: `UpperCamelCase` for types, `lowerCamelCase` for variables
3. **Check architecture patterns**: Ensure proper separation between UI and data layers
4. **Verify documentation**: Use `///` for doc comments, follow sentence formatting
5. **Confirm state management**: Follow unidirectional data flow principles

## Common Gotchas

- Word definitions come from external API; offline mode not implemented
- `DevicePreview` only enabled in debug mode (`!kReleaseMode`)
- Responsive layout breaks if `ResponsiveScreen` areas aren't properly defined
- Asset paths in `pubspec.yaml` must match actual file structure exactly
- API key is hardcoded in `WordService` (consider environment variables for production)
