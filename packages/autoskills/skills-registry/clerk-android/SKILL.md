---
name: clerk-android
description: Implement Clerk authentication for native Android apps using Kotlin and
  Jetpack Compose with clerk-android source-guided patterns. Use for prebuilt AuthView/UserButton
  or custom API-driven auth flows. Do not use for Expo or React Native projects.
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 1.2.0
compatibility: Requires Android Studio and clerk-android Gradle dependency
---

# Clerk Android (Native)

This skill implements Clerk in native Android projects by following current `clerk-android` SDK and docs patterns.

## Activation Rules

Activate this skill when either condition is true:
- The user explicitly asks for Android, Kotlin, Jetpack Compose, or native mobile Clerk implementation on Android.
- The project appears to be native Android (for example `build.gradle(.kts)` with Android plugins, `AndroidManifest.xml`, `app/src/main/java`, Compose UI files).

Do not activate this skill when either condition is true:
- The project is Expo.
- The project is React Native.

If Expo/React Native signals are present, route to the general setup skill instead.

## What Do You Need?

| Task | Reference |
|------|-----------|
| Prebuilt AuthView / UserButton (fastest) | references/prebuilt.md |
| Custom API-driven auth flows (full control) | references/custom.md |

## Quick Start

| Step | Action |
|------|--------|
| 1 | Confirm project type is native Android and not Expo/React Native |
| 2 | Determine flow type (`prebuilt` or `custom`) and load the matching reference file |
| 3 | Ensure a real Clerk publishable key exists (or ask developer) |
| 4 | Ensure correct Clerk artifacts are installed for the selected flow |
| 5 | Read official Android quickstart and verify required setup (Native API, min SDK/Java, manifest, initialization) |
| 6 | Inspect `clerk-android` source/sample patterns relevant to selected flow |
| 7 | Implement flow by following only the selected reference checklist |

## Decision Tree

```text
User asks for Clerk in Android/Kotlin
    |
    +-- Expo/React Native project detected?
    |     |
    |     +-- YES -> Do not use this skill
    |     |
    |     +-- NO -> Continue
    |
    +-- Existing auth UI detected?
    |     |
    |     +-- Prebuilt views detected -> Load references/prebuilt.md
    |     |
    |     +-- Custom flow detected -> Load references/custom.md
    |     |
    |     +-- New implementation -> Ask developer prebuilt/custom, then load matching reference
    |
    +-- Ensure publishable key and SDK initialization path
    |
    +-- Ensure correct Android artifacts are installed
    |
    +-- Verify quickstart prerequisites in project
    |
    +-- Implement using selected flow reference
```

## Flow References

After flow type is known, load exactly one:
- Prebuilt flow: [references/prebuilt.md](references/prebuilt.md)
- Custom flow: [references/custom.md](references/custom.md)

Do not blend the two references in a single implementation unless the developer explicitly asks for a hybrid approach.

## Interaction Contract

Before any implementation edits, the agent must have both:
- flow choice: `prebuilt` or `custom`
- a real Clerk publishable key

If either value is missing from the user request/context:
- ask the user for the missing value(s)
- pause and wait for the answer
- do not edit files or install dependencies yet

Only skip asking when the user has already explicitly provided the value in this conversation.

## Source-Driven Templates

Do not hardcode implementation examples in this skill. Inspect current `clerk-android` source/docs for the installed SDK version before implementing.

| Use Case | Source of Truth |
|----------|-----------------|
| SDK artifacts and dependency split (`clerk-android-api` vs `clerk-android-ui`) | `clerk-android` README and Android install docs |
| SDK initialization and publishable key wiring | Android quickstart and `source/api/.../Clerk.kt` |
| Prebuilt auth and profile behavior | `source/ui/.../AuthView.kt`, `source/ui/.../UserButton.kt`, and prebuilt sample |
| Custom auth sequencing and factor handling | `source/ui/auth/*`, `source/api/auth/*`, and custom-flows sample |
| Capability/feature gating from instance settings | `Clerk` public fields (for example `enabledFirstFactorAttributes`, `socialProviders`, `isGoogleOneTapEnabled`, `mfaIsEnabled`) and environment model source |
| Required Android setup checklist | Official Android quickstart (`/docs/android/getting-started/quickstart`) |

## Execution Gates (Do Not Skip)

1. No implementation edits before prerequisites
- Do not edit project files until flow type is confirmed and a valid publishable key is available.

2. Missing flow or key must trigger a question
- If flow choice is missing, explicitly ask: prebuilt views or custom flow.
- If publishable key is missing/placeholder/invalid, explicitly ask for a real key.
- Do not continue until both answers are provided.

3. Publishable key wiring mode is mandatory
- By default, wire the developer-provided key directly in `Clerk.initialize(...)`.
- Do not introduce secret-management indirection unless explicitly requested.

4. Artifact install policy is mandatory
- Prebuilt flow: use `clerk-android-ui` (includes API).
- Custom flow: use `clerk-android-api` unless prebuilt components are explicitly requested.
- If Clerk artifacts are missing, add the latest stable release available.

5. Android quickstart compliance is mandatory
- Verify Native API is enabled for the Clerk app.
- Verify Android requirements from quickstart are implemented in project (minimum SDK and Java target, manifest internet permission, app-level Clerk initialization).
- Verify app waits for SDK initialization (`Clerk.isInitialized`) before assuming auth-ready state.

6. Capability-driven behavior is mandatory
- Use Clerk runtime capability/settings state (for example enabled factors/social providers/MFA flags) to gate flow behavior.
- Do not hardcode factor assumptions that may conflict with dashboard configuration.

7. Reference-file discipline is mandatory
- Once flow is selected, follow only that flow reference file for implementation and verification.

8. Custom-flow structure parity is mandatory
- For `custom` flow, preserve multi-step auth progression and factor-specific handling (no single all-fields form by default).
- Keep UI, state orchestration, and Clerk API integration in separate modules.

9. Prebuilt preference is mandatory when selected
- For `prebuilt` flow, do not rebuild auth forms with custom API calls unless explicitly requested.
- Use `AuthView`/`UserButton` as default building blocks.

## Workflow

1. Detect native Android vs Expo/React Native.
2. If flow type is not explicitly provided, ask user for `prebuilt` or `custom`.
3. If publishable key is not explicitly provided, ask user for it.
4. Wait for both answers before changing files.
5. Load matching flow reference file.
6. Ensure `Clerk.initialize(...)` path and publishable key wiring are valid.
7. Ensure dependencies/artifacts match selected flow.
8. Review Android quickstart requirements and apply missing setup in project.
9. Implement using selected reference checklist.
10. Verify using selected reference checklist plus shared gates.

## Common Pitfalls

| Level | Issue | Prevention |
|-------|-------|------------|
| CRITICAL | Not asking for missing flow choice before implementation | Ask for `prebuilt` vs `custom` and wait before edits |
| CRITICAL | Not asking for missing publishable key before implementation | Ask for key and wait before edits |
| CRITICAL | Starting implementation before flow type is confirmed | Confirm flow first and load matching reference |
| CRITICAL | Skipping Android quickstart prerequisites | Verify and apply required setup from official Android quickstart |
| CRITICAL | Missing app-level `Clerk.initialize(...)` call | Initialize Clerk from `Application` startup path |
| HIGH | Wrong artifact for chosen flow | Prebuilt: `clerk-android-ui`; custom: `clerk-android-api` |
| HIGH | Rendering auth UI before SDK initialization completes | Gate UI with `Clerk.isInitialized` state |
| HIGH | Hardcoding auth factors/social providers | Drive behavior from Clerk runtime capability fields |
| HIGH | Using this skill for Expo/React Native | Detect and route away before implementation |

## See Also

- `clerk` skill for top-level Clerk routing
- `clerk-setup` skill for cross-framework quickstart setup
- `https://github.com/clerk/clerk-android`
- `https://clerk.com/docs/android/getting-started/quickstart`
