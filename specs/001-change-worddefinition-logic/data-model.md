# Data Model: In-Device AI Word Definitions

## PlayerDeviceProfile
- **deviceId**: String (hashed identifier stored in memory only)
- **platform**: Enum (`android`, `ios`, `web`)
- **architecture**: String (e.g., `arm64`, `x86_64`)
- **gpuAcceleration**: Boolean
- **npuAcceleration**: Boolean
- **webAssemblySupport**: Boolean
- **storageAvailableBytes**: Integer
- **batteryPercent**: Integer
- **networkType**: Enum (`wifi`, `cellular`, `offline`)
- **modelInstallState**: Enum (`missing`, `installing`, `installed`, `corrupted`)

### Relationships & Rules
- Computed at runtime and not persisted; cached for session scope.
- `storageAvailableBytes` MUST be greater than model package size prior to automatic download.
- `modelInstallState` transitions: `missing → installing → installed`; corruption resets to `corrupted` and triggers re-download.

## LocalModelPackage
- **modelName**: String (e.g., `gemma_2b_it_gpu_int4`)
- **version**: String (semantic version)
- **downloadUrl**: String (secure HTTPS endpoint)
- **checksumSha256**: String
- **sizeBytes**: Integer
- **installPath**: String (absolute path in application sandbox)
- **downloadProgress**: Double (0.0 – 1.0)
- **lastUpdatedAt**: DateTime

### Relationships & Rules
- Exactly one active package per device; stored in persistent storage (app sandbox).
- Checksum verification MUST pass before switching `PlayerDeviceProfile.modelInstallState` to `installed`.
- Automatic re-download triggered when `lastUpdatedAt` older than configured TTL or checksum mismatch occurs.

## DefinitionRequestRecord
- **requestId**: String (UUID)
- **word**: String
- **timestamp**: DateTime
- **inferenceTier**: Enum (`local-success`, `local-blocked`, `download-failed`)
- **latencyMs**: Integer
- **errorCode**: String (nullable)
- **errorDescription**: String (nullable)

### Relationships & Rules
- Logged in analytics pipeline (local queue flushed when online).
- `inferenceTier` MUST never reference cloud tiers.
- `errorCode` populated when `inferenceTier` is `local-blocked` or `download-failed`.
- Used to drive UI messaging (e.g., show retry prompts) and business metrics.
