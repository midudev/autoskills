---
name: "android-coroutines-flow"
description: "Use coroutines, Flow, structured concurrency, dispatchers, and cancellation-safe Android async pipelines."
metadata:
  version: "0.1.0"
  category: "foundations"
  tags: ["android", "coroutines", "flow", "async"]
  triggers:
    include: ["android flow collection", "fix coroutine scope in android", "structured concurrency in viewmodel", "flow retry caching android", "dispatcher cleanup in android"]
    exclude: ["play release notes", "xml layout spacing", "hilt module graph only"]
  owners: ["@android-agent-skills/maintainers"]
  test_targets: ["examples/orbittasks-compose", "examples/orbittasks-xml", "benchmarks/triggers.jsonl"]
---
# Android Coroutines Flow

## When To Use
- Use this skill when the request is about: android flow collection, fix coroutine scope in android, structured concurrency in viewmodel.
- Primary outcome: Use coroutines, Flow, structured concurrency, dispatchers, and cancellation-safe Android async pipelines.
- Handoff skills when the scope expands:
- `android-state-management`
- `android-workmanager-notifications`

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

## Remediation Examples
### Inject dispatchers instead of hard-coding them
```kotlin
class TaskRepository(
    private val ioDispatcher: CoroutineDispatcher = Dispatchers.IO,
) {
    suspend fun refresh(): List<TaskUiModel> = withContext(ioDispatcher) { loadTasks() }
}
```

### Collect flows with lifecycle awareness
```kotlin
viewLifecycleOwner.lifecycleScope.launch {
    viewLifecycleOwner.repeatOnLifecycle(Lifecycle.State.STARTED) {
        viewModel.uiState.collect { render(it) }
    }
}
```

### Preserve cancellation in generic error handling
```kotlin
try {
    repository.refresh()
} catch (error: CancellationException) {
    throw error
} catch (error: Exception) {
    emit(UiState.Error(error))
}
```

## Examples
### Happy path
- Scenario: Model task updates as StateFlow and shared event channels in the Compose fixture.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

### Edge case
- Scenario: Recover from cancellation and configuration changes in the XML activity flow.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

### Failure recovery
- Scenario: Disambiguate coroutine requests from state-management and WorkManager prompts.
- Command: `python3 scripts/eval_triggers.py --skill android-coroutines-flow`

## Done Checklist
- The implementation path is explicit, minimal, and tied to the right Android surface.
- Relevant example commands and benchmark prompts have been exercised or updated.
- Handoffs to adjacent skills are documented when the request crosses boundaries.
- Official references cover the chosen pattern and the main migration or troubleshooting path.

## Official References
- [https://developer.android.com/kotlin/coroutines](https://developer.android.com/kotlin/coroutines)
- [https://developer.android.com/topic/libraries/architecture/coroutines](https://developer.android.com/topic/libraries/architecture/coroutines)
- [https://kotlinlang.org/docs/coroutines-overview.html](https://kotlinlang.org/docs/coroutines-overview.html)
- [https://kotlinlang.org/docs/flow.html](https://kotlinlang.org/docs/flow.html)
