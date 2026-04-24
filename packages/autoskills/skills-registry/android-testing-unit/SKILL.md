---
name: "android-testing-unit"
description: "Write fast, focused Android unit tests for reducers, use cases, repositories, and lifecycle-safe state holders."
metadata:
  version: "0.1.0"
  category: "quality-release"
  tags: ["android", "testing", "unit-tests", "verification"]
  triggers:
    include: ["android unit test strategy", "test viewmodel reducer android", "repository unit tests android", "mock coroutine dependency android", "fast test coverage android"]
    exclude: ["ui screenshot only", "play store listing", "apk alignment"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android Testing Unit

## When To Use
- Use this skill when the request is about: android unit test strategy, test viewmodel reducer android, repository unit tests android.
- Primary outcome: Write fast, focused Android unit tests for reducers, use cases, repositories, and lifecycle-safe state holders.
- Handoff skills when the scope expands:
- `android-testing-ui`
- `android-ui-states-validation`

## Workflow
1. Scope the risk surface: correctness, security, performance, test depth, or release automation.
2. Pick the narrowest verification strategy that still catches the likely regressions.
3. Instrument the workflow so failures are actionable rather than just red.
4. Run the relevant checks on the showcase apps and packaging outputs.
5. Capture any residual risk with explicit follow-up work and owner skills.

## Guardrails
- Prefer reproducible checks in CI over one-off local heroics.
- Fail with a precise remediation path instead of a vague quality gate.
- Keep secrets, signing material, and production credentials out of examples and fixtures.
- Treat performance and security work as engineering tasks with evidence, not folklore.

## Anti-Patterns
- Adding more tests without increasing signal.
- Shipping benchmarks or security scans that no one can reproduce.
- Hard-coding release credentials into build logic.
- Using synthetic metrics with no user-impact interpretation.

## Examples
### Happy path
- Scenario: Cover reducer and formatter logic in both fixture apps with focused local tests.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest && cd ../orbittasks-xml && ./gradlew :app:testDebugUnitTest`

### Edge case
- Scenario: Mock sync failures and permission-denied branches without instrumentation.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

### Failure recovery
- Scenario: Separate unit-testing requests from UI testing or general architecture cleanup.
- Command: `python3 scripts/eval_triggers.py --skill android-testing-unit`

## Done Checklist
- The implementation path is explicit, minimal, and tied to the right Android surface.
- Relevant example commands and benchmark prompts have been exercised or updated.
- Handoffs to adjacent skills are documented when the request crosses boundaries.
- Official references cover the chosen pattern and the main migration or troubleshooting path.

## Official References
- [https://developer.android.com/training/testing/local-tests](https://developer.android.com/training/testing/local-tests)
- [https://developer.android.com/training/testing/fundamentals](https://developer.android.com/training/testing/fundamentals)
- [https://developer.android.com/topic/libraries/architecture/viewmodel](https://developer.android.com/topic/libraries/architecture/viewmodel)
- [https://kotlinlang.org/docs/jvm-test-using-junit.html](https://kotlinlang.org/docs/jvm-test-using-junit.html)
