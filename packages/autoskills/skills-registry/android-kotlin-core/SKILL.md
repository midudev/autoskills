---
name: "android-kotlin-core"
description: "Use Kotlin idioms safely in Android apps, including nullability, data classes, sealed types, extension functions, and collection pipelines."
metadata:
  version: "0.1.0"
  category: "foundations"
  tags: ["android", "kotlin", "foundation", "api-design"]
  triggers:
    include: ["kotlin cleanup in android app", "convert verbose android java-style kotlin", "sealed classes for ui state", "extension functions for android feature", "improve kotlin readability in android module"]
    exclude: ["full gradle upgrade", "compose navigation only", "release play console setup"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android Kotlin Core

## When To Use
- Use this skill when the request is about: kotlin cleanup in android app, convert verbose android java-style kotlin, sealed classes for ui state.
- Primary outcome: Use Kotlin idioms safely in Android apps, including nullability, data classes, sealed types, extension functions, and collection pipelines.
- Handoff skills when the scope expands:
- `android-state-management`
- `android-testing-unit`

## Workflow
1. Map the request to the current Android stack, module boundaries, and minimum supported API level.
2. Inspect the existing implementation for implicit assumptions, duplicate helpers, and outdated patterns.
3. Apply the smallest change that improves correctness, readability, and long-term maintainability.
4. Validate the result against the relevant showcase app path and repo benchmarks.
5. Hand off adjacent work to the next specialized skill only after the core foundation is stable.

## Guardrails
- Prefer official Android and Kotlin guidance over custom local conventions when they conflict.
- Keep public APIs boring and explicit; avoid clever abstractions that hide Android lifecycle costs.
- Do not mix architectural cleanup with product behavior changes unless the request explicitly needs both.
- Document any compatibility constraints that will affect old modules or generated code.

## Anti-Patterns
- Sprinkling helpers across modules without a clear ownership boundary.
- Introducing framework-specific code into pure domain or data layers.
- Refactoring every adjacent file when only one contract needed to change.
- Leaving migration notes implied instead of writing them down.

## Examples
### Happy path
- Scenario: Tighten domain and UI state models with sealed interfaces and immutable data.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

### Edge case
- Scenario: Guard nullable platform values crossing the XML activity boundary.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

### Failure recovery
- Scenario: Refactor broad helper objects into focused extensions without breaking call sites.
- Command: `python3 scripts/eval_triggers.py --skill android-kotlin-core`

## Done Checklist
- The implementation path is explicit, minimal, and tied to the right Android surface.
- Relevant example commands and benchmark prompts have been exercised or updated.
- Handoffs to adjacent skills are documented when the request crosses boundaries.
- Official references cover the chosen pattern and the main migration or troubleshooting path.

## Official References
- [https://developer.android.com/kotlin](https://developer.android.com/kotlin)
- [https://developer.android.com/build/kotlin-support](https://developer.android.com/build/kotlin-support)
- [https://kotlinlang.org/docs/coding-conventions.html](https://kotlinlang.org/docs/coding-conventions.html)
- [https://kotlinlang.org/docs/null-safety.html](https://kotlinlang.org/docs/null-safety.html)
