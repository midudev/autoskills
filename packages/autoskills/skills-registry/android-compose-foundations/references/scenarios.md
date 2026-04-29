# Android Compose Foundations Runnable Scenarios

## Happy path
- Goal: Refine the Compose OrbitTasks board with stable slots and theme tokens.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

## Edge case
- Goal: Keep previews and layout behavior stable under narrow widths and long text.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:assembleDebug`

## Failure recovery
- Goal: Keep general Compose requests from drifting into state/effects or performance work.
- Command: `python3 scripts/eval_triggers.py --skill android-compose-foundations`
