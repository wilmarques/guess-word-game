---
title: "0001: AI Platform Selection for Word Generation"
supersedes: ""
superseded_by: ""
---

# 0001: AI Platform Selection for Word Generation

## Context

The guess word game currently relies on the Merriam-Webster Dictionary API for word definitions and operates with a static word list containing only 151 predefined words loaded from `assets/words/nouns/words.txt`. This approach presents several limitations:

- **Content Limitations**: Static word lists severely constrain the game's vocabulary, reducing replay value and educational potential
- **API Dependencies**: External dictionary APIs may have rate limits, availability issues, or cost structures that don't align with game requirements
- **Security Constraints**: Frontend applications cannot safely store API keys for direct service calls, requiring backend proxy architecture
- **Scalability Concerns**: Current architecture cannot easily support dynamic content generation or personalized difficulty levels

The business requirements include:
- Unlimited vocabulary generation with contextual definitions
- Cost-effective scaling for potential user growth
- Secure architecture preventing API key exposure
- Maintainable codebase with clear separation of concerns
- Future extensibility for features like difficulty adaptation and multi-language support

Technical constraints include:
- Flutter web frontend cannot store secrets securely
- Need for responsive design across devices
- Integration with existing `WordService` and `Word` model architecture
- Compliance with Dart and Flutter development best practices

## Decision

We will implement **Vercel AI SDK with Vercel Functions** as our AI generation platform for word definitions, replacing the current Merriam-Webster Dictionary API integration.

The selected solution provides:
- **Secure Backend Proxy**: Vercel Functions handle API keys server-side, eliminating frontend security risks
- **Multi-Provider Flexibility**: Vercel AI SDK supports OpenAI, Anthropic, Google, and other providers through unified interface
- **Cost-Effective Scaling**: Pay-per-execution model aligns with usage patterns, estimated $0.45 per 1000 word generations
- **Developer Experience**: TypeScript/JavaScript functions integrate naturally with existing web deployment workflow
- **Agent Capabilities**: Built-in support for structured output, function calling, and multi-step reasoning workflows

## Consequences

### Positive

- **POS-001**: **Security**: API keys remain server-side, eliminating frontend exposure risks and meeting enterprise security requirements
- **POS-002**: **Flexibility**: Multi-provider SDK allows easy switching between AI models (GPT, Claude, Gemini) without architectural changes
- **POS-003**: **Cost Efficiency**: Pay-per-use model with competitive pricing ($0.45/1K generations) and no minimum commitments
- **POS-004**: **Developer Productivity**: Familiar web technologies (TypeScript) and excellent documentation reduce development time
- **POS-005**: **Scalability**: Serverless functions auto-scale with demand and handle traffic spikes automatically
- **POS-006**: **Agent Evolution**: Built-in support for advanced AI patterns like function calling and structured output enables future features

### Negative

- **NEG-001**: **Vendor Lock-in**: Vercel-specific deployment and function architecture creates platform dependency
- **NEG-002**: **Cold Start Latency**: Serverless functions may experience initialization delays during low-traffic periods
- **NEG-003**: **Debugging Complexity**: Distributed architecture with frontend/backend separation complicates local development and debugging
- **NEG-004**: **Cost Unpredictability**: Usage-based pricing can become expensive with unexpected traffic or inefficient prompt engineering
- **NEG-005**: **Limited Offline Support**: Cloud-dependent architecture prevents offline gameplay functionality

## Alternatives Considered

### AWS Bedrock + Lambda Functions

- **ALT-001**: **Description**: AWS-native solution with Bedrock for AI models and Lambda for serverless execution, providing enterprise-grade security and multi-model access
- **ALT-002**: **Rejection Reason**: Higher complexity requiring AWS infrastructure knowledge, more expensive Lambda cold starts, and steeper learning curve for web developers

### Azure OpenAI + Azure Functions

- **ALT-003**: **Description**: Microsoft's enterprise AI service with Functions for serverless backend, offering enterprise security and compliance features
- **ALT-004**: **Rejection Reason**: Complex pricing structure, requires Azure ecosystem familiarity, and less developer-friendly tooling compared to web-native solutions

### Google Vertex AI + Cloud Functions

- **ALT-005**: **Description**: Google's comprehensive AI platform with Cloud Functions for backend processing, featuring advanced Gemini models and built-in grounding
- **ALT-006**: **Rejection Reason**: Complex multi-tiered pricing, steep learning curve for Google Cloud Platform, and less straightforward integration patterns

### OpenAI Direct API Integration

- **ALT-007**: **Description**: Direct frontend integration with OpenAI API using stored API keys for immediate implementation
- **ALT-008**: **Rejection Reason**: Critical security vulnerability exposing API keys to client-side code, unacceptable for production deployment

### Existing Dart Backend Extension

- **ALT-009**: **Description**: Extend current Flutter app with Dart server backend for AI integration, maintaining single-language consistency
- **ALT-010**: **Rejection Reason**: Requires server infrastructure management, lacks serverless scaling benefits, and adds deployment complexity for web-focused workflow

### AWS Bedrock Agents (AgentCore)

- **ALT-011**: **Description**: AWS's native agent framework with built-in knowledge bases and action groups for complex AI workflows
- **ALT-012**: **Rejection Reason**: Over-engineered for current requirements, requires AWS infrastructure expertise, and higher operational overhead for simple word generation

### Google Firebase Genkit

- **ALT-013**: **Description**: Google's AI agent framework with Firebase integration, designed for rapid prototyping and deployment
- **ALT-014**: **Rejection Reason**: Limited production track record, requires Firebase ecosystem adoption, and less comprehensive documentation than established alternatives

## Implementation Notes

- **IMP-001**: **Architecture Pattern**: Implement backend proxy with Vercel Functions handling AI API calls, Flutter frontend consuming REST endpoints with existing HTTP client patterns
- **IMP-002**: **Migration Strategy**: Phased rollout starting with single-provider implementation (OpenAI GPT-4o mini), followed by multi-provider support and advanced agent features
- **IMP-003**: **Performance Monitoring**: Track function execution time, AI response quality, cost per generation, and user satisfaction metrics through Vercel Analytics
- **IMP-004**: **Fallback Strategy**: Maintain existing Merriam-Webster integration as backup for service availability and cost control during high-usage periods
- **IMP-005**: **Development Workflow**: Local development using Vercel CLI, CI/CD integration with GitHub Actions, and preview deployments for testing AI model changes

## References

- **REF-001**: [Comprehensive AI Platform Research](/.copilot-tracking/research/20250927-ai-generation-word-definitions-research.md)
- **REF-002**: [Current WordService Implementation](/lib/services/word_service.dart)
- **REF-003**: [Vercel AI SDK Documentation](https://sdk.vercel.ai/docs)
- **REF-004**: [OpenAI API Pricing](https://openai.com/api/pricing/)
- **REF-005**: [Dart and Flutter Development Guidelines](/.github/instructions/dart-n-flutter.instructions.md)
