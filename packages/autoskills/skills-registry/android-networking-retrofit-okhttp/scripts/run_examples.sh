#!/usr/bin/env bash
    set -euo pipefail

    cat <<'EOF'
    Skill: Android Networking Retrofit OkHttp
    Canonical path: skills/android-networking-retrofit-okhttp
    Example commands:
    Happy path: cd examples/orbittasks-compose && ./gradlew :app:testDebugUnitTest
Edge case: cd examples/orbittasks-xml && ./gradlew :app:testDebugUnitTest
Failure recovery: python3 scripts/eval_triggers.py --skill android-networking-retrofit-okhttp
    EOF
