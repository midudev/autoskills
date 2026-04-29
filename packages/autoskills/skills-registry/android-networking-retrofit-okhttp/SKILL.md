---
name: "android-networking-retrofit-okhttp"
description: "Build Android networking stacks with Retrofit, OkHttp, interceptors, API contracts, and resilient error handling."
metadata:
  version: "0.1.0"
  category: "data-platform"
  tags: ["android", "networking", "retrofit", "okhttp"]
  triggers:
    include: ["retrofit android setup", "okhttp interceptor android", "api error mapping android", "network client cleanup android", "retry timeout android api"]
    exclude: ["fragment back stack", "compose semantics", "play store notes"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android Networking Retrofit OkHttp

## When To Use
- Use this skill when the request is about: retrofit android setup, okhttp interceptor android, api error mapping android.
- Primary outcome: Build Android networking stacks with Retrofit, OkHttp, interceptors, API contracts, and resilient error handling.
- Handoff skills when the scope expands:
- `android-serialization-offline-sync`
- `android-security-best-practices`

## Workflow
1. Confirm the data source, persistence boundary, sync model, and device capability involved.
2. Model contracts explicitly before wiring network, storage, media, or background APIs.
3. Apply the recommended AndroidX or platform pattern with migration-safe defaults.
4. Validate offline, retry, and process death behavior against the sample apps and scenarios.
5. Escalate security, performance, or release risk to the linked supporting skills when needed.

## Guardrails
- Prefer typed models and explicit serializers over ad-hoc maps or bundles.
- Keep background work idempotent and cancellation-aware.
- Do not leak storage, media, or networking details into presentation code.
- Treat user data durability, privacy, and migration paths as part of the implementation.

## Anti-Patterns
- Blocking the main thread with disk or network calls.
- Treating retryable sync failures as terminal user-facing errors.
- Mixing cache models and wire models without a mapping layer.
- Requesting broad storage or notification capabilities when a narrower API exists.

## Examples
### Happy path
- Scenario: Model sync requests and network failures for task refresh.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

### Edge case
- Scenario: Handle stale cache and retry behavior in the XML fixture.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

### Failure recovery
- Scenario: Differentiate networking prompts from serialization, security, and offline-sync requests.
- Command: `python3 scripts/eval_triggers.py --skill android-networking-retrofit-okhttp`

## Done Checklist
- The implementation path is explicit, minimal, and tied to the right Android surface.
- Relevant example commands and benchmark prompts have been exercised or updated.
- Handoffs to adjacent skills are documented when the request crosses boundaries.
- Official references cover the chosen pattern and the main migration or troubleshooting path.

## Official References
- [https://developer.android.com/develop/connectivity/network-ops/connecting](https://developer.android.com/develop/connectivity/network-ops/connecting)
- [https://developer.android.com/topic/architecture/data-layer/offline-first](https://developer.android.com/topic/architecture/data-layer/offline-first)
- [https://developer.android.com/training/volley](https://developer.android.com/training/volley)
- [https://developer.android.com/training/articles/perf-anr](https://developer.android.com/training/articles/perf-anr)
