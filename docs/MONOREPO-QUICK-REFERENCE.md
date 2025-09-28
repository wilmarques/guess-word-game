# Monorepo Quick Reference

> **TL;DR**: This repository demonstrates a production-ready Flutter + Vercel Functions monorepo architecture optimized for AI-powered applications.

## 🚀 What You'll Find Here

### Core Documentation
- **[Complete Architecture Guide](architecture/monorepo-reference.md)** - Comprehensive 20,000+ word reference
- **[Configuration Examples](../examples/)** - Copy-paste ready config files
- **[ADRs](adrs/)** - Architectural decision records with rationale

### Key Patterns Demonstrated

#### 1. Monorepo Structure
```
├── docs/                    # Architecture docs & ADRs
├── examples/               # Reference configurations
├── .github/workflows/      # CI/CD pipelines
├── .devcontainer/         # Development environment
├── api/                   # Vercel Functions (Future)
├── lib/                   # Flutter application
└── assets/                # Static resources
```

#### 2. Technology Stack
- **Frontend**: Flutter (Web/Mobile/Desktop)
- **Backend**: Vercel Functions + AI SDK
- **AI Providers**: OpenAI, Claude, Gemini (unified API)
- **Deployment**: Vercel with preview/production environments
- **CI/CD**: GitHub Actions with automated testing

#### 3. Development Workflow
```bash
# Local development
vercel dev              # Functions at localhost:3000
flutter run -d web      # Flutter at localhost:8080

# Testing
flutter test           # Dart/Flutter tests
npm test              # Function tests
npm run lint          # Code quality

# Deployment
git push              # Automatic via CI/CD
```

## 🎯 Use Cases

Perfect for projects requiring:
- **AI Integration**: Word generation, content creation, intelligent features
- **Cross-Platform**: Web, mobile, and desktop from single codebase
- **Scalable Backend**: Serverless functions with global edge deployment
- **Modern DevOps**: Automated testing, deployment, and monitoring

## 🏗️ Architecture Highlights

### Frontend (Flutter)
- Responsive design with `ResponsiveScreen` utility
- Go router for navigation
- HTTP service layer for API integration
- Device preview for development

### Backend (Vercel Functions)
- TypeScript with Vercel AI SDK
- Structured output with Zod validation
- Multi-provider AI support (OpenAI/Claude/Gemini)
- CORS handling and error responses

### Infrastructure
- DevContainer for consistent development
- GitHub Actions for CI/CD
- Vercel for hosting and functions
- Environment-based configuration

## 📋 Quick Start Checklist

### For New Projects
- [ ] Copy [`examples/vercel.json`](../examples/vercel.json) to root
- [ ] Copy [`examples/package.json`](../examples/package.json) to root  
- [ ] Create `api/` directory with function handlers
- [ ] Copy CI/CD workflow from [`examples/.github/workflows/`](../examples/.github/workflows/)
- [ ] Set up Vercel project and environment variables
- [ ] Configure GitHub repository secrets

### For Existing Flutter Apps
- [ ] Review current architecture against [reference guide](architecture/monorepo-reference.md)
- [ ] Migrate API calls to service layer pattern
- [ ] Add Vercel configuration files
- [ ] Set up backend functions in `api/` directory
- [ ] Update CI/CD pipeline for monorepo structure

### For Backend Migration
- [ ] Convert existing APIs to Vercel Functions format
- [ ] Update environment variable management
- [ ] Implement structured error handling
- [ ] Add health check endpoints
- [ ] Test function deployment and performance

## 🔧 Key Configuration Files

| File | Purpose | Status |
|------|---------|---------|
| [`vercel.json`](../examples/vercel.json) | Deployment config | ✅ Example ready |
| [`package.json`](../examples/package.json) | Node.js dependencies | ✅ Example ready |
| [`devcontainer.json`](../.devcontainer/devcontainer.json) | Dev environment | ✅ Production ready |
| [GitHub Actions](../examples/.github/workflows/) | CI/CD pipeline | ✅ Example ready |
| [`pubspec.yaml`](../pubspec.yaml) | Flutter dependencies | ✅ Production ready |

## 🎓 Learning Resources  

### Architecture Understanding
1. Read [ADR 0001](adrs/0001-ai-platform-selection.md) for AI platform decision rationale
2. Review [research files](../.copilot-tracking/research/) for implementation details
3. Study [change logs](../.copilot-tracking/changes/) for development progression

### Implementation Examples
1. Examine existing Flutter structure in [`lib/`](../lib/)
2. Review API server pattern in [`api/server.dart`](../api/server.dart)
3. Study responsive design in [`lib/utils/responsive_screen.dart`](../lib/utils/responsive_screen.dart)

### Best Practices
1. Follow [Dart/Flutter guidelines](../.github/instructions/dart-n-flutter.instructions.md)
2. Use [task implementation process](../.github/instructions/task-implementation.instructions.md)
3. Reference [copilot instructions](../.github/copilot-instructions.md) for AI assistance

## 📊 Success Metrics

### Development Efficiency
- **Setup Time**: < 10 minutes with DevContainer
- **Build Time**: < 2 minutes for Flutter web
- **Function Deploy**: < 30 seconds with hot reload

### Production Readiness
- **Uptime**: 99.9% with Vercel's global edge network
- **Performance**: < 100ms function response times
- **Scalability**: Auto-scaling serverless functions

### Developer Experience
- **Type Safety**: Full TypeScript + Dart type checking
- **Testing**: Automated unit/widget/integration tests
- **Documentation**: Comprehensive guides and examples

## 🎨 Customization Points

### Styling & Branding
- Update Flutter theme in [`lib/app.dart`](../lib/app.dart)
- Modify responsive breakpoints in [`lib/utils/responsive_screen.dart`](../lib/utils/responsive_screen.dart)
- Customize web assets in [`web/`](../web/) directory

### AI Integration
- Add new providers via Vercel AI SDK
- Customize prompts and schemas in function handlers
- Implement caching strategies for cost optimization

### Deployment Targets  
- Configure additional platforms (iOS, Android, Desktop)
- Set up multiple environments (dev, staging, prod)
- Add monitoring and analytics integrations

## 🤝 Contributing

When contributing to this reference:

1. **Document Decisions**: Add ADRs for architectural changes
2. **Update Examples**: Keep configuration files current
3. **Test Changes**: Verify all examples work end-to-end
4. **Maintain Quality**: Follow established patterns and guidelines

## 🔗 External References

- [Vercel AI SDK Documentation](https://sdk.vercel.ai/)
- [Flutter Architecture Recommendations](https://docs.flutter.dev/app-architecture)
- [Effective Dart Guidelines](https://dart.dev/effective-dart)
- [Vercel Deployment Documentation](https://vercel.com/docs)

---

> **Next Steps**: Start with the [Complete Architecture Guide](architecture/monorepo-reference.md) for detailed implementation guidance, or jump straight to the [examples directory](../examples/) if you're ready to start building.