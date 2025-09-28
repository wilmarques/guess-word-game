# Guess Word Game

A Flutter built game where you have to guess the word when given its definition.

## Architecture & Monorepo Reference

This repository serves as a **reference implementation** for structuring Flutter applications with Vercel Functions in a monorepo architecture. The established patterns can be used for similar projects requiring:

- Flutter web/mobile frontend
- AI-powered backend services
- Vercel deployment pipeline
- Comprehensive CI/CD workflows

📚 **[View Complete Monorepo Reference Guide](docs/architecture/monorepo-reference.md)**

🔧 **[Browse Configuration Examples](examples/)**

### Key Architecture Highlights

- **Frontend**: Flutter app with responsive design and device preview
- **Backend**: Vercel Functions with AI SDK integration (OpenAI, Claude, Gemini)
- **Infrastructure**: DevContainer, GitHub Actions, and automated deployments
- **Documentation**: ADRs, technical guides, and implementation tracking

## Run in GitHub Codespaces

This repo includes a dev container that sets up Flutter (web-first) for Codespaces.

- Dev container uses the Desktop Lite feature and auto-forwards:
  - 8080: Flutter web server (label: flutter-web)

- VS Code launch configs are prepared for web; if debugging fails to detect Dart, ensure the Dart and Flutter extensions are enabled.

Steps (per GitHub Codespaces docs):

1. Open this repo in a Codespace.
2. Wait for the dev container to build and post-create steps to finish.
3. Launch the App using Launch on VSCode (press F5)

## Using This Repository as a Template

This repository demonstrates best practices for:

1. **Monorepo Structure**: Organized folder hierarchy with clear separation of concerns
2. **AI Integration**: Vercel AI SDK patterns for multi-provider support
3. **Development Workflow**: Local development with hot reload and testing
4. **Deployment Pipeline**: Automated CI/CD with preview and production environments
5. **Documentation Standards**: ADRs, guides, and architectural decision tracking

See the [examples directory](examples/) for configuration files you can copy to your own projects.
