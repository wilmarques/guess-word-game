# Monorepo Configuration Examples

This directory contains example configuration files for structuring a Flutter + Vercel Functions monorepo based on the patterns established in the Guess Word Game repository.

## Files Overview

### Core Configuration
- [`vercel.json`](./vercel.json) - Vercel deployment configuration with Flutter web build and TypeScript functions
- [`package.json`](./package.json) - Node.js package configuration with scripts for development, testing, and deployment

### API Examples
- [`api/generate-word.ts`](./api/generate-word.ts) - Example Vercel Function for AI word generation using the Vercel AI SDK
- [`api/health.ts`](./api/health.ts) - Health check endpoint for monitoring

### CI/CD Pipeline
- [`.github/workflows/vercel-deployment.yml`](./.github/workflows/vercel-deployment.yml) - Complete GitHub Actions workflow for Flutter + Vercel deployment

## Architecture Summary

This monorepo structure supports:

```
┌─────────────────┐    HTTP/REST    ┌─────────────────┐    AI SDK    ┌─────────────┐
│ Flutter Web App │◄───────────────►│ Vercel Functions│◄────────────►│   AI APIs   │
│                 │                 │                 │              │ (OpenAI,    │
│ - Responsive UI │                 │ - Word Gen API  │              │  Claude,    │
│ - Game Logic    │                 │ - Health Check  │              │  Gemini)    │
│ - State Mgmt    │                 │ - CORS Handling │              │             │
└─────────────────┘                 └─────────────────┘              └─────────────┘
```

## Key Features

### 1. Unified Development Experience
- Single repository for frontend and backend
- Shared configuration and tooling
- Coordinated releases and deployments

### 2. Vercel-Optimized Deployment
- Automatic builds from Git pushes
- Preview deployments for pull requests
- Edge functions for global performance

### 3. AI Integration Ready
- Vercel AI SDK for multi-provider support
- Structured output with Zod schemas
- Error handling and fallback strategies

### 4. Production-Ready CI/CD
- Automated testing for both Flutter and Functions
- Code quality checks (linting, type checking)
- Health checks after deployment

## Quick Start

### 1. Repository Setup
```bash
# Copy configuration files to your monorepo root
cp examples/vercel.json ./
cp examples/package.json ./

# Copy API examples
cp -r examples/api ./

# Copy CI/CD workflow
cp examples/.github/workflows/vercel-deployment.yml ./.github/workflows/
```

### 2. Install Dependencies
```bash
# Install Node.js dependencies for functions
npm install

# Install Flutter dependencies
flutter pub get
```

### 3. Local Development
```bash
# Terminal 1: Start Vercel Functions
npm run dev

# Terminal 2: Start Flutter Web
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

### 4. Deployment Setup
1. Create a Vercel project: `vercel --prod`
2. Add environment variables in Vercel dashboard:
   - `OPENAI_API_KEY`
   - `ANTHROPIC_API_KEY`
3. Configure GitHub repository secrets:
   - `VERCEL_TOKEN`
   - `VERCEL_ORG_ID`
   - `VERCEL_PROJECT_ID`

## Environment Variables

### Required for AI Functions
```bash
OPENAI_API_KEY=sk-your-openai-key-here
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key-here
```

### Optional Configuration
```bash
ENABLE_AI_GENERATION=true
ENABLE_CACHING=false
DEBUG_MODE=true
```

## Scripts Reference

### Development
```bash
npm run dev          # Start Vercel dev server
npm run build        # Build Flutter web app
npm run test         # Run all tests
npm run lint         # Lint TypeScript code
```

### Flutter-specific
```bash
npm run build:flutter    # Build Flutter web with base-href
npm run test:flutter     # Run Flutter tests
npm run lint:flutter     # Analyze Dart code
```

### Functions-specific
```bash
npm run build:functions  # Type check TypeScript
npm run test:functions   # Test Vercel Functions only
npm run type-check       # TypeScript type checking
```

## Testing Strategy

### Flutter Tests
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for user flows

### Function Tests
- Unit tests for API endpoints
- Integration tests with AI providers
- Performance and load testing

### CI/CD Testing
- Automated test runs on PR
- Code coverage reporting
- Health checks after deployment

## Deployment Environments

### Development
- Local development with `vercel dev`
- Hot reload for both Flutter and Functions
- Mock AI responses for rapid iteration

### Preview (Pull Requests)
- Automatic preview deployments
- Full AI integration testing
- Staging environment validation

### Production
- Optimized Flutter web build
- Edge function deployment
- Performance monitoring

## Monitoring and Observability

### Built-in Monitoring
- Vercel Analytics for performance metrics
- Function execution logs
- Error tracking and alerting

### Custom Monitoring
- Health check endpoints
- Structured logging
- Custom metrics and dashboards

## Security Best Practices

### API Security
- CORS configuration for cross-origin requests
- Input validation with Zod schemas
- Rate limiting and abuse prevention

### Secret Management
- Environment variables for sensitive data
- Vercel secure secret storage
- No secrets in client-side code

### Access Control
- Function-level security
- Request validation and sanitization
- Audit logging for sensitive operations

## Performance Optimization

### Flutter Web
- Tree shaking for smaller bundles
- Asset optimization and CDN
- Progressive web app features

### Vercel Functions
- Edge function deployment
- Response caching strategies
- Cold start optimization

### Overall Architecture
- API response caching
- Image and asset optimization
- Global CDN distribution

## Troubleshooting

### Common Issues
1. **Build failures**: Check Flutter and Node.js versions
2. **Function errors**: Verify environment variables
3. **CORS issues**: Review vercel.json headers configuration
4. **Deployment failures**: Check Vercel project settings

### Debug Commands
```bash
# Check Vercel logs
vercel logs

# Analyze Flutter build
flutter analyze

# Type check functions
npm run type-check

# Test individual functions
vercel dev --debug
```

## Migration Guide

### From Existing Flutter App
1. Add `vercel.json` configuration
2. Create `package.json` for functions
3. Move API logic to `api/` directory
4. Update CI/CD pipeline

### From Existing Backend
1. Convert API endpoints to Vercel Functions
2. Update import statements and dependencies
3. Configure environment variables
4. Test function deployment

## Contributing

When adding new features or configurations:

1. Follow existing patterns and conventions
2. Update documentation and examples
3. Add appropriate tests
4. Ensure CI/CD pipeline passes

## Support

For questions or issues:
- Review the [main architecture documentation](../docs/architecture/monorepo-reference.md)
- Check existing [ADRs](../docs/adrs/) for architectural decisions
- Reference the [research files](../.copilot-tracking/research/) for implementation details