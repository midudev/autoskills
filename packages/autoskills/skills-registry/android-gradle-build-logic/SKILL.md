---
name: "android-gradle-build-logic"
description: "Shape Android build logic with Gradle, version catalogs, plugins, convention patterns, and toolchain compatibility."
metadata:
  version: "0.1.0"
  category: "foundations"
  tags: ["android", "gradle", "build", "toolchain"]
  triggers:
    include: ["android gradle plugin setup", "fix build logic for android modules", "version catalog for android repo", "gradle convention cleanup for android", "agp build logic change"]
    exclude: ["room schema migration only", "compose layout only", "notification permission flow"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android Gradle Build Logic

## When To Use
- Use this skill when the request is about: android gradle plugin setup, fix build logic for android modules, version catalog for android repo.
- Primary outcome: Shape Android build logic with Gradle, version catalogs, plugins, convention patterns, and toolchain compatibility.
- Handoff skills when the scope expands:
- `android-modernization-upgrade`
- `android-ci-cd-release-playstore`

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
- Scenario: Run the Compose showcase build from a clean checkout with version catalogs.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:assembleDebug`

### Edge case
- Scenario: Validate shared repositories and plugin management in the XML fixture.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:assembleDebug`

### Failure recovery
- Scenario: Benchmark build-logic trigger precision against modernization and CI skills.
- Command: `python3 scripts/eval_triggers.py --skill android-gradle-build-logic`

## Done Checklist
- The implementation path is explicit, minimal, and tied to the right Android surface.
- Relevant example commands and benchmark prompts have been exercised or updated.
- Handoffs to adjacent skills are documented when the request crosses boundaries.
- Official references cover the chosen pattern and the main migration or troubleshooting path.

## Official References
- [https://developer.android.com/build](https://developer.android.com/build)
- [https://developer.android.com/build/releases/gradle-plugin](https://developer.android.com/build/releases/gradle-plugin)
- [https://developer.android.com/build/migrate-to-built-in-kotlin](https://developer.android.com/build/migrate-to-built-in-kotlin)
- [https://docs.gradle.org/current/userguide/userguide.html](https://docs.gradle.org/current/userguide/userguide.html)
