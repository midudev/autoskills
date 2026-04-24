# Android Gradle Build Logic Runnable Scenarios

## Happy path
- Goal: Run the Compose showcase build from a clean checkout with version catalogs.
- Command: `cd examples/orbittasks-compose && ./gradlew :app:assembleDebug`

## Edge case
- Goal: Validate shared repositories and plugin management in the XML fixture.
- Command: `cd examples/orbittasks-xml && ./gradlew :app:assembleDebug`

## Failure recovery
- Goal: Benchmark build-logic trigger precision against modernization and CI skills.
- Command: `python3 scripts/eval_triggers.py --skill android-gradle-build-logic`
