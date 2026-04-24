# Android Networking Retrofit OkHttp Runnable Scenarios

## Happy path
- Goal: Model sync requests and network failures for task refresh.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest`

## Edge case
- Goal: Handle stale cache and retry behavior in the XML fixture.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest`

## Failure recovery
- Goal: Differentiate networking prompts from serialization, security, and offline-sync requests.
- Command: `python3 scripts/eval_triggers.py --skill android-networking-retrofit-okhttp`
