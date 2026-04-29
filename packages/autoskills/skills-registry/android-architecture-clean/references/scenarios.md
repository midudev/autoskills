# Android Architecture Clean Runnable Scenarios

## Happy path
- Goal: Separate OrbitTasks feature state, use case, and repository contracts.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

## Edge case
- Goal: Keep XML activity actions thin while preserving saved-state behavior.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

## Failure recovery
- Goal: Catch trigger confusion against modularization and state-management requests.
- Command: `python3 scripts/eval_triggers.py --skill android-architecture-clean`
