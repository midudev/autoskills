#!/usr/bin/env bash
    set -euo pipefail

    cat <<'EOF'
    Skill: Android Gradle Build Logic
    Canonical path: skills/android-gradle-build-logic
    Example commands:
    Happy path: cd examples/orbittasks-compose && ./gradlew :app:assembleDebug
Edge case: cd examples/orbittasks-xml && ./gradlew :app:assembleDebug
Failure recovery: python3 scripts/eval_triggers.py --skill android-gradle-build-logic
    EOF
