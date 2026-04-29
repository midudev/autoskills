#!/usr/bin/env bash
    set -euo pipefail

    cat <<'EOF'
    Skill: Android Compose Foundations
    Canonical path: skills/android-compose-foundations
    Example commands:
    Happy path: cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest
Edge case: cd examples/orbittasks-compose && ./gradlew :app:assembleDebug
Failure recovery: python3 scripts/eval_triggers.py --skill android-compose-foundations
    EOF
