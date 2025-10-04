---
title: "0002: In-Device AI Models for Word Generation"
supersedes: "0001-ai-platform-selection.md"
superseded_by: ""
date: "2025-10-04"
status: "decided"
---

# 0002: In-Device AI Models for Word Generation

## Context

The guess word game currently relies on external cloud APIs for word definition generation, specifically the Merriam-Webster Dictionary API, with operational and architectural limitations that impact cost efficiency, user privacy, and offline capabilities. Analysis of the current implementation reveals several critical constraints:

**Cost Concerns**: The current cloud-based approach incurs approximately $0.45 per 1000 word generations through external API calls, creating unsustainable operational costs as user base scales. These costs compound with increased engagement and provide no cost predictability for budget planning.

**Network Dependencies**: The existing architecture requires persistent internet connectivity for core gameplay functionality, preventing offline usage and creating poor user experience during network interruptions. The static word list of 151 predefined words in `assets/words/nouns/words.txt` provides limited content variety as a fallback option.

**Privacy and Data Security**: External API calls transmit user interaction data to third-party services, raising privacy concerns and potential regulatory compliance issues. The hardcoded API keys in `WordService` represent security vulnerabilities that limit deployment flexibility.

**Performance Limitations**: Network latency of 500-2000ms for API responses creates noticeable delays in gameplay, particularly impacting the responsive user experience on mobile devices and slower network connections.

**Scalability Challenges**: Current architecture cannot efficiently handle traffic spikes or support features requiring real-time AI interaction without proportional increases in operational costs and infrastructure complexity.

The business requirements driving this architectural decision include:
- Dramatic reduction in operational AI generation costs (target: 60-90% savings)
- Enhanced user privacy through on-device processing where possible
- Offline gameplay capability for improved user experience
- Improved response times through local inference
- Scalable architecture supporting growth without linear cost increases

## Decision

We will implement a **multi-tier in-device AI strategy** that prioritizes device-native AI capabilities through progressive enhancement while maintaining universal compatibility via cloud fallbacks.

The selected approach establishes three tiers of AI implementation:

**Tier 1 - Built-in Device AI** (Zero Runtime Cost):
- Apple Intelligence integration for iPhone 15 Pro+, iPad M1+, Mac M1+ devices
- Android AICore for Pixel 8 Pro+ and Samsung Galaxy AI-enabled devices
- Chrome Built-in AI APIs (Prompt API, Writer API) for supported browsers

**Tier 2 - Downloadable Local Models** (Zero Runtime Cost After Download):
- WebLLM with WebGPU acceleration for Chrome/Edge browsers
- MediaPipe cross-platform LLM inference for Android and iOS
- ONNX Runtime Web for broader browser compatibility

**Tier 3 - Cloud API Fallback** (Existing Cost Structure):
- Integration with current Vercel AI SDK infrastructure
- Automatic fallback for unsupported devices or platforms
- Maintains existing functionality while new tiers provide cost optimization

This progressive enhancement strategy ensures:
- **Universal Compatibility**: Every device receives working functionality
- **Cost Optimization**: Maximum utilization of zero-cost local inference
- **Privacy Enhancement**: Data processing remains on-device where supported
- **Performance Improvement**: Reduced latency through local processing
- **Future-Proof Architecture**: Easy integration of new device AI capabilities

## Tier 1: Built-in Device AI Implementation

### Apple Intelligence Integration

**Device Compatibility**:
- iPhone 15 Pro, iPhone 15 Pro Max (A17 Pro chip)
- iPad Air M1, iPad Pro M1/M2/M4 (Apple Silicon)
- MacBook Air M1+, MacBook Pro M1+, iMac M1+, Mac Studio M1+, Mac Pro M2

**Technical Implementation**:
```dart
// Platform channel for Apple Intelligence integration
class AppleIntelligenceWordService implements WordService {
  static const platform = MethodChannel('ai.apple.intelligence');

  @override
  Future<Word> loadWordDefinition(String word) async {
    final result = await platform.invokeMethod('generateDefinition', {
      'word': word,
      'temperature': 0.7,
      'maxTokens': 200
    });
    return Word.fromAppleIntelligence(result);
  }
}
```

**Capabilities**:
- Native integration with system-level AI models
- Zero runtime costs and optimal battery efficiency
- Seamless privacy with no data leaving device
- 20-50 tokens/second inference speed

### Android Native AI Integration

**Device Compatibility**:
- Google Pixel 8 Pro, Pixel 9 series (Tensor G3/G4 chips)
- Samsung Galaxy S24 series with Galaxy AI
- OnePlus devices with AI-enabled chipsets

**Technical Implementation**:
```dart
// Platform channel for Android AICore integration
class AndroidAICoreWordService implements WordService {
  static const platform = MethodChannel('ai.android.aicore');

  @override
  Future<Word> loadWordDefinition(String word) async {
    final result = await platform.invokeMethod('inferenceRequest', {
      'prompt': 'Define the word: $word',
      'modelId': 'gemini-nano'
    });
    return Word.fromAndroidAI(result);
  }
}
```

**Capabilities**:
- Direct integration with Gemini Nano on-device model
- Hardware acceleration via NPU/GPU
- Privacy-preserving local inference
- 15-30 tokens/second on supported devices

### Chrome Built-in AI APIs

**Browser Compatibility**:
- Chrome 126+ with AI features enabled
- Chrome for Android with compatible hardware
- Future Edge browser integration

**Technical Implementation**:
```dart
// Web platform implementation for Chrome Built-in AI
class ChromeBuiltInAIWordService implements WordService {
  @override
  Future<Word> loadWordDefinition(String word) async {
    final aiSession = await html.window.ai.languageModel.create({
      'systemPrompt': 'You are a helpful dictionary assistant.',
      'temperature': 0.7,
      'topK': 3
    });

    final response = await aiSession.prompt('Define: $word');
    return Word.fromChromeAI(response);
  }
}
```

**Capabilities**:
- Browser-native AI with no downloads required
- Automatic model updates via browser
- Zero cost for supported users
- 10-25 tokens/second inference speed

## Tier 2: Downloadable Local Models Implementation

### WebLLM Browser Integration

**Platform Support**:
- Chrome/Edge with WebGPU support (Windows, macOS, Android)
- Safari 26+ with WebGPU (macOS, iOS 26.0+)
- Progressive enhancement for unsupported browsers

**Technical Implementation**:
```dart
// WebLLM service with OpenAI-compatible API
class WebLLMWordService implements WordService {
  late MLCEngine _engine;

  @override
  Future<void> initialize() async {
    _engine = await MLCEngine.create(
      model: "Llama-3-8B-Instruct-q4f16_1-1k",
      chatConfig: ChatConfig(temperature: 0.7)
    );
  }

  @override
  Future<Word> loadWordDefinition(String word) async {
    final response = await _engine.chat.completions.create(
      messages: [
        ChatMessage(role: "system", content: "You are a dictionary assistant."),
        ChatMessage(role: "user", content: "Define: $word")
      ]
    );
    return Word.fromOpenAIResponse(response);
  }
}
```

**Model Options and Performance**:
- Llama 3-8B: 3GB download, 10-20 tokens/second
- Phi-3-mini: 800MB download, 15-25 tokens/second
- Gemma-2B: 1.2GB download, 20-30 tokens/second

### MediaPipe Cross-Platform Integration

**Platform Support**:
- Android with GPU/NPU acceleration
- iOS with Neural Engine optimization
- Web with WebAssembly fallback

**Technical Implementation**:
```dart
// MediaPipe native integration
class MediaPipeWordService implements WordService {
  late LlmInference _inference;

  @override
  Future<void> initialize() async {
    final options = LlmInferenceOptions(
      modelAssetPath: 'assets/models/gemma_2b_it_gpu_int4.bin',
      maxTokens: 512,
      temperature: 0.7
    );
    _inference = LlmInference.createFromOptions(options);
  }

  @override
  Future<Word> loadWordDefinition(String word) async {
    final response = await _inference.generateResponse(
      'Define the word: $word'
    );
    return Word.fromMediaPipeResponse(response);
  }
}
```

**Performance Characteristics**:
- Model size: 500MB-2GB depending on quality requirements
- Inference speed: 25-50 tokens/second on modern mobile devices
- Hardware acceleration: GPU/NPU utilization for optimal performance

## Tier 3: Cloud API Fallback Strategy

**Fallback Triggers**:
- Unsupported device or browser platform
- Local AI model loading failures
- User preference for cloud processing
- Insufficient device resources for local inference

**Implementation Strategy**:
```dart
// Unified service with intelligent fallback
class HybridWordService implements WordService {
  late WordService _primaryService;
  late WordService _fallbackService;

  @override
  Future<void> initialize() async {
    // Platform detection and capability assessment
    if (await _hasBuiltInAI()) {
      _primaryService = await _createBuiltInAIService();
    } else if (await _supportsDownloadableModels()) {
      _primaryService = await _createDownloadableModelService();
    } else {
      _primaryService = null; // Direct to fallback
    }

    _fallbackService = VercelAIWordService(); // Existing implementation
  }

  @override
  Future<Word> loadWordDefinition(String word) async {
    if (_primaryService != null) {
      try {
        return await _primaryService.loadWordDefinition(word);
      } catch (e) {
        print('Local AI failed, using cloud fallback: $e');
      }
    }

    return await _fallbackService.loadWordDefinition(word);
  }
}
```

**Cost Optimization Strategy**:
- Intelligent routing prioritizes zero-cost local inference
- Cloud fallback maintains existing cost structure ($0.45/1000 words)
- User analytics track local vs cloud usage ratios
- Progressive migration as device support expands

## Cost Analysis and ROI Projection

### Current Cost Baseline
- **Cloud API Cost**: $0.45 per 1000 word generations
- **Monthly Volume Estimate**: 10,000-50,000 word generations
- **Current Monthly Cost**: $4.50-$22.50

### Multi-Tier Cost Structure

**Tier 1 (Built-in AI) - 30-40% device coverage**:
- **Runtime Cost**: $0.00 per word generation
- **Development Cost**: One-time platform channel implementation

**Tier 2 (Downloadable Models) - 40-50% device coverage**:
- **Runtime Cost**: $0.00 per word generation after model download
- **Bandwidth Cost**: $0.01-0.05 per user for initial model download

**Tier 3 (Cloud Fallback) - 10-30% device coverage**:
- **Runtime Cost**: $0.45 per 1000 word generations (existing rate)
- **Infrastructure Cost**: No change from current implementation

### Projected Cost Reduction
- **Conservative Estimate**: 60% cost reduction (70% local, 30% cloud)
- **Optimistic Estimate**: 90% cost reduction (90% local, 10% cloud)
- **Monthly Savings**: $2.70-$20.25 per month at current volume
- **Annual Savings**: $32.40-$243.00 with potential for significantly higher savings at scale

### Device Compatibility Matrix

| Platform | Tier 1 Support | Tier 2 Support | Coverage Estimate |
|----------|---------------|----------------|-------------------|
| iPhone 15 Pro+ | ✅ Apple Intelligence | ✅ MediaPipe | 15% iOS users |
| iPhone 14/older | ❌ | ✅ MediaPipe | 25% iOS users |
| Android Pixel 8+ | ✅ Android AICore | ✅ MediaPipe | 10% Android users |
| Android Other | ❌ | ✅ MediaPipe | 35% Android users |
| Chrome Desktop | ✅ Built-in AI | ✅ WebLLM | 40% web users |
| Safari Desktop | ❌ | ⚠️ WebLLM (macOS 26+) | 15% web users |
| Firefox/Other | ❌ | ❌ | 20% web users |

**Total Coverage Estimates**:
- **Tier 1 Coverage**: 30-40% of users with zero-cost inference
- **Tier 2 Coverage**: 40-50% of users with downloadable models
- **Tier 3 Fallback**: 10-30% requiring cloud API calls

## Implementation Phases and Migration Strategy

### Phase 1: Foundation and Built-in AI (Months 1-2)
- Implement device detection and capability assessment
- Chrome Built-in AI integration for immediate cost savings
- Apple Intelligence integration for premium iOS devices
- Maintain cloud fallback for comprehensive coverage

### Phase 2: Browser Optimization (Months 2-3)
- WebLLM integration for Chrome/Edge with WebGPU support
- ONNX Runtime Web for broader browser compatibility
- Performance optimization and caching strategies

### Phase 3: Mobile Native Integration (Months 3-4)
- Android AICore integration for Pixel and Galaxy devices
- MediaPipe cross-platform implementation for iOS/Android
- Native platform channel development and testing

### Phase 4: Optimization and Analytics (Months 4-5)
- User preference settings for local vs cloud processing
- Performance analytics and cost tracking implementation
- Model compression and optimization for faster loading

### Testing and Validation Strategy
- **Unit Testing**: Individual service implementations with mock models
- **Integration Testing**: End-to-end fallback behavior validation
- **Performance Testing**: Inference speed and memory usage benchmarks
- **Cost Validation**: Real-world usage tracking and cost measurement

## Consequences

### Positive Consequences

**COST-001**: **Dramatic Cost Reduction**: 60-90% reduction in operational AI costs through prioritized local inference, eliminating cloud API costs for majority of users while maintaining service quality.

**PRIV-001**: **Enhanced Privacy Protection**: On-device processing ensures user data never leaves the device for 70-90% of interactions, addressing privacy concerns and potential regulatory compliance requirements.

**PERF-001**: **Improved Response Times**: Local inference reduces latency from 500-2000ms to 50-200ms, significantly improving user experience and gameplay responsiveness.

**OFFL-001**: **Offline Capability**: Users can continue playing without internet connectivity once models are downloaded, expanding accessibility and use cases.

**SCAL-001**: **Scalable Architecture**: Cost structure becomes largely independent of user volume growth, enabling sustainable scaling without proportional infrastructure cost increases.

**FUTU-001**: **Future-Proof Design**: Architecture easily accommodates new device AI capabilities as they become available across platforms.

### Negative Consequences

**COMP-001**: **Increased Development Complexity**: Multi-platform implementation requires specialized knowledge of device AI frameworks and increases codebase complexity for testing and maintenance.

**FRAG-001**: **Device Fragmentation**: Different capabilities across devices create inconsistent user experiences and complicate feature parity testing across platform matrix.

**SIZE-001**: **Application Size Increase**: Downloaded models add 500MB-3GB storage requirements, potentially impacting app adoption on storage-constrained devices.

**BATT-001**: **Battery Impact**: Local AI inference increases device energy consumption, particularly on mobile devices during extended gameplay sessions.

**MAINT-001**: **Maintenance Overhead**: Multiple AI service implementations require ongoing updates, model versioning, and platform-specific optimization efforts.

### Risk Mitigation Strategies

**Model Loading Failures**: Automatic graceful degradation to cloud API with user notification and retry mechanisms.

**Performance Variability**: Device capability detection with intelligent model selection based on hardware specifications and user preferences.

**Storage Limitations**: Optional model downloads with user consent, efficient compression, and model sharing across applications where possible.

**Platform Support**: Progressive enhancement ensures functional experience on all devices while optimizing for capable hardware.

## Alternatives Considered

### Cloud-Only Approach (Rejected)
**Rationale**: Continuing with pure cloud-based AI generation would maintain existing cost structure ($0.45/1000 words) without addressing privacy, offline capability, or scalability concerns. This approach lacks strategic positioning for cost optimization and user experience enhancement.

### Single-Platform Native AI (Rejected)
**Rationale**: Implementing AI for only one platform (e.g., iOS-only Core ML) would create platform inequality and reduce overall cost savings potential. Cross-platform consistency is essential for Flutter application architecture.

### Pure Downloadable Models Approach (Rejected)
**Rationale**: Requiring model downloads for all users would create poor initial experience due to large file sizes (1-3GB) and would miss opportunities for zero-cost built-in AI on supported devices.

### Hybrid Cloud-Edge Split Processing (Rejected)
**Rationale**: Splitting individual requests between local and cloud processing would increase complexity without proportional benefits compared to the selected device-first approach with cloud fallback strategy.

## Implementation Notes

### Flutter Platform Channel Architecture
```dart
// Service factory for platform-specific implementations
abstract class WordServiceFactory {
  static Future<WordService> create() async {
    if (await DeviceCapabilities.hasBuiltInAI()) {
      return BuiltInAIWordService();
    } else if (await DeviceCapabilities.supportsLocalModels()) {
      return DownloadableModelWordService();
    } else {
      return CloudFallbackWordService();
    }
  }
}
```

### Device Capability Detection
```dart
class DeviceCapabilities {
  static Future<bool> hasBuiltInAI() async {
    if (Platform.isIOS) {
      return await _checkAppleIntelligence();
    } else if (Platform.isAndroid) {
      return await _checkAndroidAICore();
    } else if (kIsWeb) {
      return await _checkChromeBuiltInAI();
    }
    return false;
  }

  static Future<bool> supportsLocalModels() async {
    return await _checkWebGPUSupport() ||
           await _checkMobileAIFramework();
  }
}
```

### Model Management and Caching
```dart
class ModelManager {
  static Future<void> downloadModel(String modelId) async {
    final cacheDir = await getApplicationCacheDirectory();
    final modelPath = '${cacheDir.path}/models/$modelId.bin';

    if (!await File(modelPath).exists()) {
      await _downloadAndCache(modelId, modelPath);
    }
  }

  static Future<void> clearModels() async {
    // User-initiated model cleanup for storage management
  }
}
```

## References

- **Research Documentation**: [In-Device AI Models Research](.copilot-tracking/research/20251004-in-device-ai-models-research.md)
- **WebLLM Documentation**: https://webllm.mlc.ai/
- **MediaPipe LLM Inference**: https://ai.google.dev/edge/mediapipe/solutions/genai/llm_inference
- **Chrome Built-in AI**: https://developer.chrome.com/docs/ai/built-in
- **Apple Intelligence Documentation**: https://developer.apple.com/machine-learning/
- **Android AICore Guide**: https://developer.android.com/guide/topics/connectivity/ai
- **ONNX Runtime Web**: https://onnxruntime.ai/docs/get-started/with-javascript/web.html
- **Flutter Platform Channels**: https://docs.flutter.dev/platform-integration/platform-channels
