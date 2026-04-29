# Android Coroutines Flow Runnable Scenarios

## Happy path
- Goal: Model task updates as StateFlow and shared event channels in the Compose fixture.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

## Edge case
- Goal: Recover from cancellation and configuration changes in the XML activity flow.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

## Failure recovery
- Goal: Disambiguate coroutine requests from state-management and WorkManager prompts.
- Command: `python3 scripts/eval_triggers.py --skill android-coroutines-flow`
