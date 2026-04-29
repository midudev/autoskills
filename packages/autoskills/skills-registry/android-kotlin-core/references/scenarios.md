# Android Kotlin Core Runnable Scenarios

## Happy path
- Goal: Tighten domain and UI state models with sealed interfaces and immutable data.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

## Edge case
- Goal: Guard nullable platform values crossing the XML activity boundary.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

## Failure recovery
- Goal: Refactor broad helper objects into focused extensions without breaking call sites.
- Command: `python3 scripts/eval_triggers.py --skill android-kotlin-core`
