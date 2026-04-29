#!/usr/bin/env bash
    set -euo pipefail

    cat <<'EOF'
    Skill: Android Architecture Clean
    Canonical path: skills/android-architecture-clean
    Example commands:
    Happy path: cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest
Edge case: cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest
Failure recovery: python3 scripts/eval_triggers.py --skill android-architecture-clean
    EOF
