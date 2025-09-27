<!-- markdownlint-disable-file -->
# Task Research Notes: AI Generation for Word Game Definitions

## Research Executed

### File Analysis
- `/workspaces/guess-word-game/lib/services/word_service.dart`
  - Current implementation uses Merriam-Webster Dictionary API with hardcoded key
  - Loads random words from static assets (`assets/words/nouns/words.txt`)
  - Processes JSON responses through `Word.fromJson()` factory constructor
  - Limited to predefined word lists (151 words)

### Code Search Results
- Current architecture pattern
  - `WordService` handles external API integration
  - `Word` model with `definitions`, `word`, and `imageName` properties
  - Flutter HTTP client for API calls
  - Error handling currently minimal with TODO comments

### External Research
- #fetch:"https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html"
  - AWS Bedrock: Fully managed service for foundation models from leading AI companies
  - Unified API access to multiple models (Claude, Titan, etc.)
  - Built-in agents capability for task automation
  - Serverless experience with no infrastructure management

- #fetch:"https://docs.aws.amazon.com/bedrock/latest/userguide/bedrock-pricing.html"
  - Pay-per-use model based on input/output tokens
  - Pricing varies by model provider and region
  - Optional Provisioned Throughput for cost optimization
  - No upfront costs or minimum usage requirements

- #fetch:"https://azure.microsoft.com/en-us/products/ai-services/openai-service"
  - Azure OpenAI Service: Integrated with Azure infrastructure
  - Enterprise-grade security and compliance
  - Agents service for workflow automation
  - Multiple deployment types: Standard, Provisioned, Batch

- #fetch:"https://cloud.google.com/vertex-ai/generative-ai"
  - Google Vertex AI: Comprehensive ML platform with Gemini models
  - Built-in grounding and function calling capabilities
  - Multi-modal support (text, images, audio)
  - Custom model tuning and RAG integration

- #fetch:"https://cloud.google.com/vertex-ai/pricing"
  - Complex pricing structure with multiple components
  - Per-token pricing for Gemini models
  - Additional costs for training, deployment, and storage
  - Regional pricing variations

- #fetch:"https://www.anthropic.com/pricing"
  - Direct Claude API access
  - Tiered pricing: Free, Pro ($17-20/month), Max ($100+/month)
  - Consumer-focused with usage limits
  - Limited enterprise features

- #fetch:"https://openai.com/api/pricing/"
  - Latest GPT-5 series with reasoning capabilities
  - GPT-5: $1.25/1M input tokens, $10/1M output tokens
  - GPT-5 mini: $0.25/1M input tokens, $2/1M output tokens
  - Built-in tools: Code Interpreter, File Search, Web Search

### Project Conventions
- Standards referenced: Dart and Flutter effective guidelines from `.github/instructions/dart-n-flutter.instructions.md`
- Instructions followed: Clean architecture with service layer separation
- Existing HTTP service pattern using `http` package
- Model factory constructors for JSON parsing

## Key Discoveries

### Project Structure
Current architecture follows clean separation of concerns:
- Service layer (`WordService`) handles external API communication
- Model layer (`Word`) handles data transformation and validation
- UI layer consumes services through `FutureBuilder` patterns
- Asset-based word loading with text file parsing

### Implementation Patterns
Existing codebase demonstrates:
- Dependency injection through constructor parameters (`AssetBundle`)
- Future-based asynchronous operations
- JSON parsing with type-safe model factories
- Error handling placeholders for production readiness

### Complete AI Service Comparison

#### Cost Comparison (per 1000 word generations, ~200 tokens each)
- **OpenAI GPT-5 mini**: $0.05 input + $0.40 output = $0.45
- **AWS Bedrock (Claude Haiku)**: ~$0.25-$0.50 (varies by region)
- **Azure OpenAI (GPT-4)**: Similar to OpenAI direct pricing
- **Google Vertex AI (Gemini Flash)**: ~$0.075-$0.30 (complex pricing tiers)
- **Anthropic Direct**: Limited by usage tiers, not suitable for production

#### Agent Building Capabilities
1. **AWS Bedrock**: Native agents with action groups and knowledge bases
2. **Azure OpenAI**: Assistants API with function calling
3. **Google Vertex AI**: Agent Engine with built-in tools
4. **OpenAI Direct**: Assistants API with robust tool integration

### Technical Requirements
- **Security**: Frontend cannot expose API keys - requires backend proxy
- **Authentication**: Backend handles OAuth2/API keys for all services
- **Rate limiting**: Backend must implement request throttling and caching
- **Regional availability**: Varies significantly by provider
- **Compliance**: Enterprise features vary (Azure > AWS > Google > OpenAI Direct)
- **Integration complexity**: AWS/Azure require more setup, OpenAI Direct simplest
- **Backend hosting**: Additional infrastructure costs and complexity

## Alternative Analysis

### Option 1: OpenAI Direct API + Backend Proxy
**Strengths:**
- Simplest AI integration with robust documentation
- Latest GPT-5 models with superior reasoning
- Built-in function calling and agents support
- Predictable token-based pricing
- Excellent developer experience

**Weaknesses:**
- Requires custom backend development and hosting
- No enterprise SLAs without Scale Tier
- Limited compliance certifications
- Potential for service changes/restrictions
- Higher costs for large-scale usage

**Cost Analysis:**
- Development: Medium (3-4 days: 2 days backend + 2 days frontend)
- Usage: $0.45/1000 words + backend hosting ($5-20/month)
- Maintenance: Low-Medium (backend monitoring + API stability)

### Option 2: AWS Bedrock + Lambda/API Gateway
**Strengths:**
- Enterprise-grade infrastructure and compliance
- Multiple model options (Claude, Titan, etc.)
- Native agents capability
- Serverless backend with AWS Lambda
- Pay-per-use with no minimums
- Built-in security and API management

**Weaknesses:**
- Complex setup and IAM configuration
- Regional model availability varies
- Learning curve for AWS services
- Potential vendor lock-in
- AWS-specific deployment complexity

**Cost Analysis:**
- Development: Medium-High (4-6 days: AWS setup + Lambda + frontend)
- Usage: $0.25-$0.50/1000 words + Lambda costs (~$1-5/month)
- Maintenance: Medium (AWS service management + monitoring)

### Option 3: Azure OpenAI Service + Azure Functions
**Strengths:**
- Enterprise security and compliance built-in
- Microsoft ecosystem integration
- Azure Functions serverless backend
- Agents service for workflow automation
- Flexible deployment options
- Strong SLAs and support

**Weaknesses:**
- Most complex setup process
- Approval required for access
- Higher baseline costs
- Steeper learning curve
- Complex Azure infrastructure management

**Cost Analysis:**
- Development: High (6-8 days: approval + Azure setup + Functions + frontend)
- Usage: Similar to OpenAI Direct + Azure Functions costs (~$5-15/month)
- Maintenance: High (Azure infrastructure management + monitoring)

### Option 4: Google Vertex AI + Cloud Functions
**Strengths:**
- Comprehensive ML platform
- Multi-modal capabilities
- Good pricing for basic usage
- Built-in grounding and RAG
- Cloud Functions serverless backend
- Integrated with existing Google services

**Weaknesses:**
- Complex pricing structure
- Less mature agent capabilities
- Google Cloud learning curve
- Limited model options compared to competitors
- Additional GCP infrastructure complexity

**Cost Analysis:**
- Development: Medium-High (5-7 days: GCP setup + Cloud Functions + frontend)
- Usage: $0.075-$0.30/1000 words + Cloud Functions costs (~$2-8/month)
- Maintenance: Medium (GCP service management + function monitoring)

### Option 5: Existing Dart Backend + OpenAI API
**Strengths:**
- Leverage existing `api/server.dart` in project
- Familiar Dart ecosystem and tooling
- Simple HTTP server extension
- Complete control over backend logic
- Easy local development and testing
- Minimal additional dependencies

**Weaknesses:**
- Manual server hosting and deployment
- Need to implement rate limiting and caching
- Requires server infrastructure management
- Limited built-in enterprise features

**Cost Analysis:**
- Development: Low-Medium (2-3 days: extend existing server + frontend)
- Usage: $0.45/1000 words + hosting costs ($5-15/month)
- Maintenance: Low-Medium (server monitoring + updates)

### Option 6: AWS Bedrock Agents (AgentCore)
**Strengths:**
- Native agent orchestration with multi-step reasoning
- Built-in action groups and knowledge base integration
- Automatic prompt engineering and memory management
- Enterprise-grade compliance and security
- No custom agent code required
- Integrated monitoring and tracing

**Weaknesses:**
- Most complex setup among all options
- AWS-specific vendor lock-in
- Higher learning curve for agent configuration
- Regional availability limitations
- Complex pricing with multiple components

**Cost Analysis:**
- Development: High (6-8 days: AWS setup + agent config + API integration)
- Usage: $0.25-$0.50/1000 words + agent invocation costs (~$2-8/month)
- Maintenance: High (AWS infrastructure + agent monitoring)

### Option 7: Google Firebase Genkit
**Strengths:**
- Open-source AI framework with unified APIs
- Multi-provider support (Google AI, OpenAI, Claude, Ollama)
- Built-in developer tools and debugging UI
- Firebase integration for easy deployment
- Composable workflows for agents and RAG
- TypeScript/JavaScript ecosystem

**Weaknesses:**
- Newer framework with limited production track record
- Requires Node.js runtime (not Dart native)
- Google Firebase deployment dependency
- Learning curve for new framework patterns

**Cost Analysis:**
- Development: Medium (4-5 days: Node.js setup + Genkit + Firebase deployment)
- Usage: $0.45/1000 words + Firebase hosting (~$0-10/month for low traffic)
- Maintenance: Low-Medium (Firebase managed infrastructure)

### Option 8: Vercel AI SDK + Vercel Functions
**Strengths:**
- Excellent developer experience and TypeScript support
- Multi-provider unified API (20+ providers including OpenAI, Claude, Gemini)
- Built-in UI hooks for React/Next.js integration
- Vercel Functions for serverless backend
- Agent workflows and tool calling built-in
- Generous free tier for prototyping

**Weaknesses:**
- Requires Node.js/TypeScript runtime
- Vercel-specific deployment (vendor lock-in)
- Limited to web-first frameworks
- Flutter would need separate HTTP client integration

**Cost Analysis:**
- Development: Medium (3-4 days: Node.js API + Vercel deployment + Flutter integration)
- Usage: $0.45/1000 words + Vercel Functions (1M invocations free/month)
- Maintenance: Low (Vercel managed infrastructure)

## Backend Architecture Options

### Serverless Functions (Recommended for MVP)
- **AWS Lambda**: Best integration with Bedrock, pay-per-request
- **Azure Functions**: Integrated with Azure OpenAI, automatic scaling
- **Google Cloud Functions**: Good for Vertex AI, simple deployment
- **Vercel Functions**: Excellent DX, 1M invocations free, perfect for OpenAI/Claude

### Agent Frameworks
- **AWS Bedrock Agents**: Native agent orchestration with enterprise features
- **Google Firebase Genkit**: Open-source unified AI framework with multi-provider support
- **Vercel AI SDK**: TypeScript-first with built-in agent patterns and UI hooks
- **LangChain/LangGraph**: Python/TypeScript agent frameworks (requires separate hosting)

### Traditional Backend
- **Extend existing Dart server**: Leverage current `api/server.dart`
- **Node.js/Express**: Rich AI library ecosystem, works with all agent frameworks
- **Python FastAPI**: Popular for AI/ML applications
- **Docker containerized**: Deploy anywhere (Railway, Render, etc.)

### Hybrid Approach
- **Backend-for-Frontend (BFF)**: Dedicated API for Flutter app
- **Edge functions**: Reduce latency with global deployment
- **Caching layer**: Redis/Memcached for frequently requested words
- **Multi-provider strategy**: Use agent frameworks for easy provider switching## Recommended Approach

**Primary Recommendation: Vercel AI SDK + Vercel Functions**

After considering all agent frameworks and platforms, the optimal approach has changed:

### Rationale
1. **Security**: API keys safely stored in Vercel Functions, no frontend exposure
2. **Developer Experience**: Best-in-class TypeScript SDK with unified multi-provider API
3. **Cost Effectiveness**: $0.45/1000 words + free Vercel Functions tier (1M calls/month)
4. **Development Speed**: 3-4 days (faster than AWS/Azure, similar to Dart extension)
5. **Future-Proof**: Easy provider switching (OpenAI, Claude, Gemini) through unified API
6. **Agent Ready**: Built-in agent patterns and tool calling capabilities
7. **Maintenance**: Zero infrastructure management with Vercel's managed platform

### Architecture Overview
```
Flutter App ↔ HTTP → Vercel Functions ↔ [OpenAI|Claude|Gemini] API
                          ↓           ↔ Vercel AI SDK
                    [Caching/Analytics]
```

### Implementation Strategy
1. **Phase 1 (MVP)**: Vercel Functions + AI SDK + OpenAI integration
2. **Phase 2 (Enhancement)**: Add Claude/Gemini as fallback providers
3. **Phase 3 (Agents)**: Implement multi-step word generation with context
4. **Future**: Agent-driven difficulty scaling and theme-based generation

### Alternative Recommendation 1: Existing Dart Backend + OpenAI API
**If staying in Dart ecosystem is critical:**
- Leverage existing team expertise
- Full control over backend logic
- Manual hosting and infrastructure management required
- $5-15/month additional hosting costs

### Alternative Recommendation 2: AWS Bedrock Agents
**If enterprise agent capabilities are required:**
- Native multi-step reasoning and orchestration
- Enterprise compliance and security
- Highest setup complexity and costs
- Best for complex agent workflows beyond simple word generation

### Risk Mitigation
- Implement service interface for easy provider switching
- Add local fallback with curated word lists
- Monitor usage and costs with alerting
- Plan for rate limiting and error handling

## Implementation Guidance
- **Objectives**: Replace static dictionary API with secure AI-generated words and definitions
- **Key Tasks**:
  1. **Backend**: Extend `api/server.dart` with OpenAI integration endpoint
  2. **Backend**: Implement prompt engineering for consistent word generation
  3. **Backend**: Add rate limiting, caching, and error handling
  4. **Frontend**: Update `WordService` to call backend instead of direct API
  5. **Security**: Implement API key management and request validation
  6. **Monitoring**: Add usage tracking and cost monitoring
- **Dependencies**:
  - Backend: OpenAI SDK for Dart (`openai_dart` package)
  - Frontend: `http` package (already present)
  - Hosting: Platform for Dart server (Railway, Render, or VPS)
  - Secrets: Environment variable management for API keys
- **Success Criteria**:
  - Secure backend proxy protecting API keys
  - Generate unlimited unique words with definitions
  - Maintain existing game functionality
  - Keep total cost under $20/month (AI + hosting)
  - Implement graceful fallbacks for API failures
  - Backend response time under 2 seconds

### Sample Implementation Comparisons

#### Recommended: Vercel AI SDK + Functions
```typescript
// api/generate-word.ts (Vercel Function)
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

    return Response.json({ data: object });
  } catch (error) {
    return Response.json({ error: 'Generation failed' }, { status: 500 });
  }
}
```

#### Alternative: Dart Backend Extension
```dart
// api/server.dart extension
import 'package:openai_dart/openai_dart.dart';

class AIWordController {
  final OpenAI _openai;

  AIWordController(String apiKey) : _openai = OpenAI(apiKey: apiKey);

  Future<Response> generateWord(Request request) async {
    try {
      final prompt = '''Generate a word guessing game entry:
      - Single noun (4-8 letters)
      - 2-3 clear definitions
      - Appropriate for family game

      Format: {"word": "example", "definitions": ["def1", "def2"]}''';

      final response = await _openai.chat.completions.create(
        model: ChatCompletionModel.gpt4oMini,
        messages: [ChatCompletionMessage.user(content: prompt)],
        maxTokens: 150,
      );

      return Response.json({'data': response.choices.first.message.content});
    } catch (e) {
      return Response.json({'error': 'Generation failed'}, 500);
    }
  }
}
```

#### Flutter Client (Same for Both)
```dart
class AIWordService extends WordService {
  final String _baseUrl;

  AIWordService(this._baseUrl);

  @override
  Future<Word> loadNextWord() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/generate-word'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Word.fromAIResponse(data);
    }

    throw Exception('Failed to generate word');
  }
}
```
