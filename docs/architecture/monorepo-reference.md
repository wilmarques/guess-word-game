# Monorepo Reference Guide: Flutter + Vercel Architecture

This document serves as a comprehensive reference for structuring a monorepo containing a Flutter application with Vercel Functions backend, based on the patterns established in the Guess Word Game repository.

## Table of Contents

- [Repository Overview](#repository-overview)
- [Architecture Pattern](#architecture-pattern)
- [Folder Structure](#folder-structure)
- [Configuration Files](#configuration-files)
- [Development Workflow](#development-workflow)
- [Deployment Strategy](#deployment-strategy)
- [CI/CD Pipeline](#cicd-pipeline)
- [Best Practices](#best-practices)

## Repository Overview

This monorepo architecture supports:

- **Frontend**: Flutter web application with responsive design
- **Backend**: Vercel Functions (TypeScript/Node.js) for AI integration
- **API Layer**: Optional Dart HTTP server for development/testing
- **Documentation**: ADRs, technical guides, and architectural decisions
- **Infrastructure**: DevContainer, CI/CD, and deployment configurations

### Key Benefits

1. **Unified Development**: Single repository for frontend and backend
2. **Shared Documentation**: Centralized ADRs and technical decisions
3. **Consistent CI/CD**: Unified deployment pipeline across services
4. **Efficient Development**: Shared configuration and tooling
5. **Version Alignment**: Coordinated releases across components

## Architecture Pattern

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Monorepo Root                            │
├─────────────────────┬───────────────────┬───────────────────┤
│   Flutter App       │  Vercel Functions │  Documentation    │
│   (Frontend)        │   (Backend)       │   & Config        │
│                     │                   │                   │
│  ┌─────────────┐    │  ┌─────────────┐  │  ┌─────────────┐  │
│  │    Web      │    │  │  AI API     │  │  │    ADRs     │  │
│  │   Mobile    │◄──►│  │ Generation  │  │  │   Guides    │  │
│  │  Desktop    │    │  │  Cache      │  │  │  Tracking   │  │
│  └─────────────┘    │  └─────────────┘  │  └─────────────┘  │
└─────────────────────┴───────────────────┴───────────────────┘
```

### Data Flow

```
┌──────────────┐    HTTP/REST    ┌─────────────────┐    AI SDK    ┌─────────────┐
│ Flutter App  │◄───────────────►│ Vercel Functions│◄────────────►│   AI APIs   │
│              │                 │                 │              │ (OpenAI,    │
│  - UI Layer  │                 │ - Route Handler │              │  Claude,    │
│  - HTTP      │                 │ - Auth          │              │  Gemini)    │
│  - State     │                 │ - Validation    │              │             │
└──────────────┘                 │ - AI Integration│              └─────────────┘
                                 └─────────────────┘
```

## Folder Structure

### Root Level Organization

```
monorepo/
├── .github/                    # GitHub-specific configurations
│   ├── workflows/             # CI/CD pipelines
│   ├── actions/              # Custom GitHub Actions
│   ├── instructions/         # Development guidelines
│   └── prompts/              # AI assistant prompts
├── .devcontainer/            # Development container setup
├── .vscode/                  # VS Code configurations
├── .copilot-tracking/        # AI development tracking
│   ├── plans/               # Implementation plans
│   ├── changes/             # Change logs
│   └── research/            # Technical research
├── docs/                     # Documentation
│   ├── adrs/                # Architectural Decision Records
│   ├── architecture/        # System architecture docs
│   └── guides/              # Development guides
├── packages/                 # Monorepo packages
│   ├── flutter-app/         # Flutter application
│   └── shared/              # Shared utilities
├── api/                      # Vercel Functions
│   ├── generate-word.ts     # AI word generation
│   ├── health.ts            # Health checks
│   └── types/               # Shared TypeScript types
├── functions/                # Additional serverless functions
├── public/                   # Static assets for Vercel
├── build/                    # Build outputs (gitignored)
├── scripts/                  # Build and deployment scripts
├── vercel.json              # Vercel deployment configuration
├── package.json             # Root package.json for functions
├── pubspec.yaml             # Flutter dependencies
└── README.md                # Project overview
```

### Flutter App Structure (`packages/flutter-app/` or root)

```
flutter-app/
├── lib/
│   ├── app.dart             # Main app configuration
│   ├── app_routes.dart      # Go router configuration
│   ├── main.dart            # Application entry point
│   ├── models/              # Data models
│   │   └── word.dart        # Word model with AI response parsing
│   ├── pages/               # Screen widgets
│   │   ├── main_page.dart   # Home screen
│   │   ├── game_page.dart   # Game interface
│   │   └── winning_page.dart # Victory screen
│   ├── services/            # Business logic
│   │   └── word_service.dart # API integration
│   ├── utils/               # Utilities
│   │   └── responsive_screen.dart # Responsive layout
│   └── widgets/             # Reusable UI components
│       ├── keyboard/        # Virtual keyboard
│       └── core/            # Shared widgets
├── assets/                  # Static assets
│   └── words/              # Word lists (fallback)
├── web/                     # Web-specific files
├── android/                 # Android configuration
├── ios/                     # iOS configuration
├── test/                    # Unit and widget tests
├── pubspec.yaml            # Flutter dependencies
└── analysis_options.yaml   # Dart analyzer configuration
```

### Vercel Functions Structure (`api/`)

```
api/
├── generate-word.ts         # Main AI generation endpoint
├── health.ts               # Health check endpoint
├── middleware/             # Shared middleware
│   ├── cors.ts             # CORS configuration
│   ├── auth.ts             # Authentication (if needed)
│   └── validation.ts       # Request validation
├── lib/                    # Shared utilities
│   ├── ai-client.ts        # AI SDK wrapper
│   ├── cache.ts            # Response caching
│   └── constants.ts        # Configuration constants
├── types/                  # TypeScript definitions
│   ├── word.ts             # Word type definitions
│   └── api.ts              # API response types
└── __tests__/              # Function tests
    ├── generate-word.test.ts
    └── health.test.ts
```

## Configuration Files

### Core Configuration Files

#### 1. `vercel.json` - Vercel Deployment Configuration

```json
{
  "buildCommand": "flutter build web --release --base-href=/",
  "outputDirectory": "build/web",
  "framework": null,
  "functions": {
    "api/**/*.ts": {
      "runtime": "nodejs18.x",
      "maxDuration": 30
    }
  },
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/$1"
    },
    {
      "src": "/(.*\\.(js|css|ico|png|jpg|jpeg|gif|svg|woff|woff2|ttf|eot))",
      "dest": "/$1",
      "headers": {
        "cache-control": "public, max-age=31536000, immutable"
      }
    },
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ],
  "headers": [
    {
      "source": "/api/(.*)",
      "headers": [
        {
          "key": "Access-Control-Allow-Origin",
          "value": "*"
        },
        {
          "key": "Access-Control-Allow-Methods",
          "value": "GET, POST, PUT, DELETE, OPTIONS"
        },
        {
          "key": "Access-Control-Allow-Headers",
          "value": "Content-Type, Authorization"
        }
      ]
    }
  ],
  "env": {
    "OPENAI_API_KEY": "@openai-api-key",
    "ANTHROPIC_API_KEY": "@anthropic-api-key"
  }
}
```

#### 2. `package.json` - Node.js Dependencies for Functions

```json
{
  "name": "guess-word-game-monorepo",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "vercel dev",
    "build": "flutter build web --release",
    "test": "jest",
    "lint": "eslint api/**/*.ts",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@ai-sdk/openai": "^0.0.66",
    "@ai-sdk/anthropic": "^0.0.50",
    "ai": "^3.4.32",
    "zod": "^3.22.4"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@vercel/node": "^3.0.0",
    "typescript": "^5.0.0",
    "eslint": "^8.0.0",
    "jest": "^29.0.0",
    "vercel": "^37.0.0"
  },
  "engines": {
    "node": ">=18"
  }
}
```

#### 3. `pubspec.yaml` - Flutter Dependencies

```yaml
name: guess_word_game
description: A Flutter word guessing game with AI-generated definitions
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^16.2.0
  device_preview: ^1.2.0
  http: ^1.5.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/words/nouns/words.txt
```

#### 4. `.devcontainer/devcontainer.json` - Development Environment

```json
{
  "image": "mcr.microsoft.com/devcontainers/universal:3",
  "features": {
    "ghcr.io/devcontainers/features/java:1": {
      "version": "17",
      "installGradle": true
    },
    "ghcr.io/devcontainers/features/docker-in-docker:2": {},
    "ghcr.io/devcontainers/features/node:1": {
      "version": "18"
    }
  },
  "forwardPorts": [8080, 3000],
  "portsAttributes": {
    "8080": {
      "label": "flutter-web",
      "onAutoForward": "openPreview"
    },
    "3000": {
      "label": "vercel-dev"
    }
  },
  "onCreateCommand": ".devcontainer/onCreate.sh",
  "postCreateCommand": "npm install && flutter pub get",
  "customizations": {
    "vscode": {
      "extensions": [
        "Dart-Code.dart-code",
        "Dart-Code.flutter",
        "EditorConfig.EditorConfig",
        "ms-vscode.vscode-typescript-next",
        "vercel.vercel-vscode"
      ],
      "settings": {
        "dart.flutterSdkPath": "/usr/local/flutter",
        "typescript.preferences.includePackageJsonAutoImports": "on"
      }
    }
  },
  "remoteUser": "root"
}
```

### Environment Configuration

#### 5. `.env.local` - Local Development Environment

```bash
# AI API Keys (local development only)
OPENAI_API_KEY=sk-your-openai-key-here
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key-here

# Development URLs
FLUTTER_WEB_URL=http://localhost:8080
VERCEL_FUNCTIONS_URL=http://localhost:3000

# Feature flags
ENABLE_AI_GENERATION=true
ENABLE_CACHING=false
DEBUG_MODE=true
```

## Development Workflow

### Local Development Setup

1. **Clone and Setup**
   ```bash
   git clone <monorepo-url>
   cd monorepo
   
   # Install Node.js dependencies for functions
   npm install
   
   # Install Flutter dependencies
   flutter pub get
   ```

2. **Development Servers**
   ```bash
   # Terminal 1: Start Vercel Functions
   vercel dev
   
   # Terminal 2: Start Flutter Web (in separate terminal)
   flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
   ```

3. **Testing**
   ```bash
   # Test Flutter app
   flutter test
   
   # Test Vercel Functions
   npm test
   
   # Integration tests
   npm run test:integration
   ```

### Code Organization Patterns

#### Service Layer Pattern

```dart
// lib/services/word_service.dart
class WordService {
  static const String _baseUrl = 'https://your-app.vercel.app/api';
  // or 'http://localhost:3000/api' for development
  
  Future<Word> generateWord() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/generate-word'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Word.fromJson(data['data']);
    }
    
    throw Exception('Failed to generate word');
  }
}
```

#### Function Handler Pattern

```typescript
// api/generate-word.ts
import { openai } from '@ai-sdk/openai';
import { generateObject } from 'ai';
import { z } from 'zod';

const WordSchema = z.object({
  word: z.string().min(4).max(8),
  definitions: z.array(z.string()).min(2).max(3)
});

export async function POST(req: Request) {
  try {
    const { object } = await generateObject({
      model: openai('gpt-4o-mini'),
      prompt: 'Generate a word guessing game entry: single noun (4-8 letters) with 2-3 clear definitions appropriate for family game',
      schema: WordSchema,
    });

    return Response.json({ 
      data: object,
      timestamp: new Date().toISOString(),
      version: '1.0'
    });
  } catch (error) {
    console.error('Generation failed:', error);
    return Response.json(
      { error: 'Generation failed', code: 'AI_ERROR' }, 
      { status: 500 }
    );
  }
}
```

## Deployment Strategy

### Vercel Deployment

1. **Automatic Deployments**
   - Main branch → Production deployment
   - Feature branches → Preview deployments
   - Pull requests → Preview deployments with comments

2. **Environment Variables**
   - Set in Vercel dashboard or CLI
   - Different values for development/preview/production
   - Secure API key management

3. **Build Configuration**
   ```bash
   # Build command in vercel.json
   flutter build web --release --base-href=/
   
   # Output directory
   build/web
   ```

### Multi-Environment Strategy

```yaml
# .github/workflows/deploy.yml
name: Deploy to Vercel

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.0'
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: |
          flutter pub get
          npm install
      
      - name: Run tests
        run: |
          flutter test
          npm test
      
      - name: Build Flutter web
        run: flutter build web --release
      
      - name: Deploy to Vercel
        uses: vercel/action@v1
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
          vercel-args: --prod
```

## CI/CD Pipeline

### GitHub Actions Workflow

#### Complete CI/CD Pipeline

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  lint-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.0'
          cache: true
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: |
          flutter pub get
          npm ci
      
      - name: Lint Flutter code
        run: flutter analyze
      
      - name: Lint TypeScript code
        run: npm run lint
      
      - name: Type check
        run: npm run type-check
      
      - name: Test Flutter
        run: flutter test --coverage
      
      - name: Test Functions
        run: npm test
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info

  build:
    needs: lint-and-test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.0'
          cache: true
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build web app
        run: flutter build web --release --base-href=/
      
      - name: Upload build artifacts
        uses: actions/upload-artifact@v3
        with:
          name: web-build
          path: build/web/

  deploy-preview:
    if: github.event_name == 'pull_request'
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Download build artifacts
        uses: actions/download-artifact@v3
        with:
          name: web-build
          path: build/web/
      
      - name: Deploy to Vercel (Preview)
        uses: vercel/action@v1
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}

  deploy-production:
    if: github.ref == 'refs/heads/main'
    needs: build
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      
      - name: Download build artifacts
        uses: actions/download-artifact@v3
        with:
          name: web-build
          path: build/web/
      
      - name: Deploy to Vercel (Production)
        uses: vercel/action@v1
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
          vercel-args: --prod
```

## Best Practices

### Code Organization

1. **Separation of Concerns**
   - Flutter handles UI and user interaction
   - Vercel Functions handle business logic and AI integration
   - Shared types between frontend and backend

2. **Error Handling**
   ```dart
   // Flutter: Graceful degradation
   try {
     final word = await wordService.generateWord();
     setState(() => _currentWord = word);
   } catch (e) {
     // Fallback to local word list
     final word = await wordService.loadRandomWord();
     setState(() => _currentWord = word);
   }
   ```

   ```typescript
   // Functions: Structured error responses
   export async function POST(req: Request) {
     try {
       // ... AI generation logic
     } catch (error) {
       console.error('Generation failed:', error);
       return Response.json({
         error: 'Generation failed',
         code: 'AI_ERROR',
         fallback: true
       }, { status: 500 });
     }
   }
   ```

3. **Configuration Management**
   - Environment-specific configurations
   - Feature flags for gradual rollouts
   - API versioning for backward compatibility

### Performance Optimization

1. **Caching Strategy**
   ```typescript
   // Simple in-memory cache for development
   const cache = new Map<string, any>();
   
   export async function POST(req: Request) {
     const cacheKey = `word-${req.body.difficulty}`;
     
     if (cache.has(cacheKey)) {
       return Response.json({ data: cache.get(cacheKey) });
     }
     
     const result = await generateWord();
     cache.set(cacheKey, result);
     
     return Response.json({ data: result });
   }
   ```

2. **Build Optimization**
   - Tree shaking for Flutter web
   - Function bundling optimization
   - Asset optimization and CDN usage

### Security Best Practices

1. **API Security**
   - CORS configuration
   - Rate limiting
   - Input validation with Zod schemas

2. **Secret Management**
   - Environment variables for API keys
   - Vercel secret management
   - No secrets in client-side code

### Monitoring and Observability

1. **Logging Strategy**
   ```typescript
   // Structured logging in functions
   console.log(JSON.stringify({
     timestamp: new Date().toISOString(),
     level: 'info',
     message: 'Word generated successfully',
     metadata: { wordLength: result.word.length }
   }));
   ```

2. **Error Tracking**
   - Vercel Analytics integration  
   - Custom error tracking
   - Performance monitoring

### Documentation Standards

1. **ADR Documentation**
   - Technical decision tracking
   - Architectural change history
   - Decision rationale and consequences

2. **API Documentation**
   - OpenAPI/Swagger specifications
   - Function endpoint documentation
   - Response schema definitions

3. **Development Guides**
   - Setup instructions
   - Deployment procedures
   - Troubleshooting guides

This monorepo structure provides a scalable, maintainable foundation for Flutter applications with AI-powered backends deployed on Vercel. The patterns established here can be adapted for various project requirements while maintaining consistency and best practices.