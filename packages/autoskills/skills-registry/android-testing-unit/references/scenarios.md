# Android Testing Unit Runnable Scenarios

## Happy path
- Goal: Cover reducer and formatter logic in both fixture apps with focused local tests.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest && cd ../orbittasks-xml && ./gradlew :app:testDebugUnitTest`

## Edge case
- Goal: Mock sync failures and permission-denied branches without instrumentation.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

## Failure recovery
- Goal: Separate unit-testing requests from UI testing or general architecture cleanup.
- Command: `python3 scripts/eval_triggers.py --skill android-testing-unit`
