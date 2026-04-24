---
name: "android-di-hilt"
description: "Wire Android dependency injection with Hilt, scopes, testing overrides, and module ownership boundaries."
metadata:
  version: "0.1.0"
  category: "foundations"
  tags: ["android", "hilt", "dependency-injection", "testing"]
  triggers:
    include: ["android hilt setup", "inject viewmodel repository hilt", "scope dependency in android", "replace manual service locator", "hilt testing override", "android-di-hilt skill", "scope dependency in android hilt", "hilt component scope mismatch", "hilt entry point android"]
    exclude: ["retrofit serialization only", "compose typography only", "gradle wrapper upgrade", "collect flow in compose screen", "state matrix before release"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android DI Hilt

## When To Use
- Use this skill when the request is about: android hilt setup, inject viewmodel repository hilt, scope dependency in android.
- Primary outcome: Wire Android dependency injection with Hilt, scopes, testing overrides, and module ownership boundaries.
- Reach for this skill when the hard part is component ownership, bindings, scopes, entry points, or test replacement. If the request is only about networking APIs or reducer design, use the neighboring skill instead.
- Handoff skills when the scope expands:
- `android-testing-unit`
- `android-networking-retrofit-okhttp`

## Workflow
1. Identify the injection boundary first: app-wide singleton, activity-retained, ViewModel, worker, service, or entry point from unsupported framework code.
2. Decide what should be bound: constructor injection, `@Binds`, `@Provides`, qualifiers, multibindings, or assisted injection.
3. Match lifetime to scope explicitly so dependencies do not outlive their owner or rebuild too often.
4. Verify replacement strategy for tests with Hilt test modules, uninstall modules, or fakes at the right component boundary.
5. Hand off API-specific or architectural questions only after the DI graph ownership is correct.

## Guardrails
- Prefer constructor injection for app code you own.
- Use qualifiers and scope annotations deliberately; ambiguous bindings are a graph smell, not a convenience.
- Keep Hilt modules close to the ownership boundary they configure.
- Treat test replacement as part of the design, not an afterthought.

## Anti-Patterns
- Making everything `@Singleton` to silence scope questions.
- Hiding business construction logic inside giant `@Provides` methods when constructor injection would suffice.
- Using Hilt modules as a dumping ground for unrelated bindings across modules.
- Confusing DI graph ownership with app architecture ownership.

## Review Focus
- Component and scope alignment.
- Binding style and qualifier clarity.
- Unsupported-entry-point bridges and test replacement strategy.
- Module ownership boundaries across features and core code.

## Examples
### Happy path
- Scenario: Inject OrbitTasks repositories and dispatchers with clear Hilt scopes.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

### Edge case
- Scenario: Swap fake dependencies in the XML fixture for deterministic tests.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

### Failure recovery
- Scenario: Catch DI-specific prompts before they drift into architecture-clean or networking.
- Command: `python3 scripts/eval_triggers.py --skill android-di-hilt`

## Done Checklist
- Component lifetime matches dependency lifetime.
- Binding style is explicit and testable.
- Test overrides or fakes are planned at the right graph boundary.
- Non-DI work is handed off instead of buried in modules.

## Official References
- [https://developer.android.com/training/dependency-injection/hilt-android](https://developer.android.com/training/dependency-injection/hilt-android)
- [https://developer.android.com/training/dependency-injection/hilt-testing](https://developer.android.com/training/dependency-injection/hilt-testing)
- [https://developer.android.com/training/dependency-injection/hilt-multi-module](https://developer.android.com/training/dependency-injection/hilt-multi-module)
- [https://developer.android.com/topic/libraries/architecture/viewmodel](https://developer.android.com/topic/libraries/architecture/viewmodel)
- [https://developer.android.com/training/dependency-injection/manual](https://developer.android.com/training/dependency-injection/manual)
