# Guess Word Game

A Flutter built game where you have to guess the word when given its definition.

## Run in GitHub Codespaces

This repo includes a dev container that sets up Flutter (web-first) for Codespaces.

- Dev container uses the Desktop Lite feature and auto-forwards:
  - 6080: web VNC desktop (label: desktop)
  - 8080: Flutter web server (label: flutter-web)

- VS Code tasks:
  - "Flutter: pub get" – install dependencies
  - "Flutter: run (web)" – start the app on <http://localhost:8080>
- VS Code launch configs are prepared for web; if debugging fails to detect Dart, ensure the Dart and Flutter extensions are enabled.

Steps (per GitHub Codespaces docs):

1. Open this repo in a Codespace.
2. Wait for the dev container to build and post-create steps to finish.
3. Run the task "Flutter: pub get" then "Flutter: run (web)". The port 8080 is automatically forwarded. See: <https://docs.github.com/codespaces/developing-in-codespaces/forwarding-ports-in-your-codespace>

Notes:

- The container installs Google Chrome for convenience, but the recommended device in Codespaces is the Flutter "web-server" to avoid sandbox issues.
- The Desktop Lite feature provides a basic GUI via noVNC on port 6080 if you need a browser in-container. See: <https://github.com/devcontainers/features/tree/main/src/desktop-lite>
