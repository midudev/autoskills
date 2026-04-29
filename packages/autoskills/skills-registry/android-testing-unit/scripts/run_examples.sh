#!/usr/bin/env bash
    set -euo pipefail

    cat <<'EOF'
    Skill: Android Testing Unit
    Canonical path: skills/android-testing-unit
    Example commands:
    Happy path: cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest && cd ../orbittasks-xml && ./gradlew :app:testDebugUnitTest
Edge case: cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest
Failure recovery: python3 scripts/eval_triggers.py --skill android-testing-unit
    EOF
