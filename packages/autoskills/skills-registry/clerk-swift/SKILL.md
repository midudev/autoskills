---
name: clerk-swift
description: Implement Clerk authentication for native Swift and iOS apps using ClerkKit
  and ClerkKitUI source-guided patterns. Use for prebuilt AuthView or custom native
  flows. Do not use for Expo or React Native projects.
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 1.2.0
compatibility: Requires Xcode and ClerkKit Swift package
---

# Clerk Swift (Native iOS)

This skill implements Clerk in native Swift/iOS projects by reading installed package source and mirroring current ClerkKit/ClerkKitUI behavior.

## Activation Rules

Activate this skill when either condition is true:
- The user explicitly asks for Swift, SwiftUI, UIKit, or native iOS Clerk implementation.
- The project appears to be native iOS/Swift (for example `.xcodeproj`, `.xcworkspace`, `Package.swift`, Swift targets).

Do not activate this skill when either condition is true:
- The project is Expo.
- The project is React Native.

If Expo/React Native signals are present, route to the general setup skill instead of this one.

## What Do You Need?

| Task | Reference |
|------|-----------|
| Prebuilt AuthView / UserButton (fastest) | references/prebuilt.md |
| Custom API-driven auth flows (full control) | references/custom.md |

## Quick Start

| Step | Action |
|------|--------|
| 1 | Confirm project type is native Swift/iOS and not Expo/React Native |
| 2 | Determine flow type (`prebuilt` or `custom`) and load the matching reference file |
| 3 | Ensure a valid publishable key exists (or ask developer) and wire it directly in configuration |
| 4 | Ensure `clerk-ios` package is installed with correct products for selected flow; if missing, install latest available release using an up-to-next-major version requirement |
| 5 | Inspect installed `ClerkKitUI` source to identify which `Environment` fields drive feature/step gating |
| 6 | Call `/v1/environment` after step 5 and evaluate only against the `ClerkKitUI`-aligned field map |
| 7 | Find the iOS quickstart URL in the installed `clerk-ios` package README, append `.md`, then visit and read the markdown URL to compile a required-step checklist |
| 8 | Verify and complete all quickstart prerequisites for this project (for example associated domains and required capabilities) |
| 9 | Implement flow by following only the selected reference checklist |

## Decision Tree

```text
User asks for Clerk in Swift/iOS
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
    +-- Ensure publishable key and direct wiring
    |
    +-- Ensure clerk-ios is installed
    |
    +-- Inspect ClerkKitUI Environment field usage
    |
    +-- Call /v1/environment using that field map
    |
    +-- Visit/read quickstart URL from installed clerk-ios package README
    |
    +-- Verify all quickstart prerequisites are completed
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

Do not hardcode implementation examples in this skill. Inspect current installed package source before implementing.

| Use Case | Source of Truth in Installed Package |
|----------|--------------------------------------|
| SDK package products, platform support, and dependency constraints | Package manifest and target product definitions for `ClerkKit` and `ClerkKitUI`, plus package requirement style (up-to-next-major) |
| Publishable key validation and frontend API derivation | Clerk configuration logic (search symbols: `configure(publishableKey`, `frontendApiUrl`, `invalidPublishableKeyFormat`) |
| Environment endpoint contract and field semantics | Environment request path and request construction plus `ClerkKitUI` `Environment` field usage for gating (search symbols: `/v1/environment`, `Request<Clerk.Environment>`, `Environment` usage in `ClerkKitUI`) |
| iOS quickstart requirements | Installed `clerk-ios` package README quickstart link plus the visited/read quickstart page checklist steps (including project setup prerequisites) |
| Native Sign in with Apple implementation | Apple capability and native sign-in behavior in selected flow reference |

## Execution Gates (Do Not Skip)

1. No implementation edits before prerequisites
- Do not edit project files until flow type is confirmed and a valid publishable key is available.

2. Missing flow or key must trigger a question
- If flow choice is missing, explicitly ask: prebuilt views or custom flow.
- If publishable key is missing/placeholder/invalid, explicitly ask for a real key.
- Do not continue until both answers are provided.

3. Publishable key wiring mode is mandatory
- Use the developer-provided publishable key plainly in app configuration passed to `Clerk.configure`.
- Do not introduce plist/local-secrets/env-file/build-setting indirection unless explicitly requested.

4. Package install/version policy is mandatory
- If `clerk-ios` is not installed, add it using the latest available release with an up-to-next-major requirement.
- Do not pin an exact package version unless the developer explicitly asks for exact pinning.

5. ClerkKitUI Environment field inspection is mandatory
- After package install, inspect installed `ClerkKitUI` source and identify which `Environment` fields gate auth behavior for the selected flow.
- Build an agent-internal field map before any `/v1/environment` call.

6. Environment call is mandatory (both flows)
- Make a direct HTTP call to `/v1/environment` only after package install and step 5 field-map inspection.
- Pass the response into the selected reference workflow using the `ClerkKitUI`-aligned field map:
  - prebuilt: use it to determine whether Apple is enabled and capability changes are needed
  - custom: perform full normalization/matrix handling as agent-internal analysis only (never persist matrix artifacts in project code)

7. Reference-file discipline is mandatory
- Once flow is selected, follow only that flow reference file for implementation and verification.

8. Quickstart compliance is mandatory
- Find the iOS quickstart URL in the installed `clerk-ios` package README, append `.md`, then visit and read that markdown URL.
- Audit the project against all quickstart setup steps before finishing.
- If required quickstart setup is missing, implement it before completing the task.
- This includes adding any missing Associated Domains entries and any other required app capabilities from the quickstart.
- Explicitly execute the quickstart step `Add associated domain capability` (`https://clerk.com/docs/ios/getting-started/quickstart#add-associated-domain-capability`) and ensure the associated-domain entry matches quickstart requirements (`webcredentials:{YOUR_FRONTEND_API_URL}`).

9. Custom-flow AuthView structure parity is mandatory
- For `custom` flow, layout and flow structure must remain materially close to ClerkKitUI `AuthView` defaults.
- If the developer did not explicitly request a different UX, do not introduce major structural/layout deviations from `AuthView`.
- If unsure/confused about custom sequencing, gating, or `Environment` usage/semantics, defer to installed `ClerkKitUI` behavior and mirror it.

## Workflow

1. Detect native iOS/Swift vs Expo/React Native.
2. If flow type is not explicitly provided, ask user for `prebuilt` or `custom`.
3. If publishable key is not explicitly provided, ask user for it.
4. Wait for both answers before changing files.
5. Load matching flow reference file.
6. Ensure publishable key is valid and directly wired in `Clerk.configure`.
7. Ensure package install/products match selected flow and package requirement follows latest up-to-next-major policy when newly added.
8. Inspect installed `ClerkKitUI` source to map `Environment` fields used for gating/required behavior in the selected flow.
9. Call `/v1/environment` and interpret response through the step 8 field map.
10. Find iOS quickstart URL from installed `clerk-ios` package README, append `.md`, then visit and read it.
11. Build quickstart checklist from the visited markdown quickstart, detect missing required setup, and apply the missing setup in the current project.
12. Ensure the quickstart associated-domain capability step is fully applied (`webcredentials:{YOUR_FRONTEND_API_URL}` when missing).
13. Implement using selected reference checklist.
14. Verify using selected reference checklist plus shared gates.

## Common Pitfalls

| Level | Issue | Prevention |
|-------|-------|------------|
| CRITICAL | Not asking for missing flow choice before implementation | Ask for `prebuilt` vs `custom` and wait before edits |
| CRITICAL | Not asking for missing publishable key before implementation | Ask for key and wait before edits |
| CRITICAL | Starting implementation before flow type is confirmed | Confirm flow first and load matching reference |
| CRITICAL | Using plist/local/env indirection for publishable key without request | Wire key directly in configuration by default |
| CRITICAL | Skipping `/v1/environment` call before implementation | Always call environment endpoint for both prebuilt and custom flows |
| CRITICAL | Calling `/v1/environment` before package install + ClerkKitUI `Environment` field inspection | Install `clerk-ios` first, inspect ClerkKitUI `Environment` usage, then call endpoint |
| HIGH | Installing `clerk-ios` with exact/stale version by default | If missing, install latest available release using up-to-next-major requirement |
| CRITICAL | Skipping quickstart prerequisite audit | Visit/read quickstart URL from installed `clerk-ios` package README and verify all required setup steps are completed |
| CRITICAL | Detecting missing quickstart capabilities/domains but not applying them | Add all missing required quickstart capabilities and Associated Domains before completing |
| CRITICAL | Skipping quickstart associated-domain capability step | Execute quickstart `Add associated domain capability` and ensure `webcredentials:{YOUR_FRONTEND_API_URL}` is present |
| CRITICAL | Writing capability/required-field matrices into app code | Keep matrices agent-internal and only apply resulting behavior in UI/auth flow code |
| CRITICAL | Custom flow layout diverges from `AuthView` without explicit request | Keep custom screens materially close to `AuthView` structure and step composition by default |
| CRITICAL | Collapsing custom auth into a single all-fields screen | Follow `AuthView`-style multi-step progression and step-specific field collection |
| CRITICAL | Guessing custom sequencing/gating/`Environment` usage when uncertain | Reference installed `ClerkKitUI` behavior and mirror it for final implementation |
| HIGH | Using this skill for Expo/React Native | Detect and route away before implementation |

## See Also

- `clerk` skill for top-level Clerk routing
- `clerk-setup` skill for non-native or cross-framework setup
- installed `clerk-ios` package `README.md` (source for current iOS quickstart link)
- `https://github.com/clerk/clerk-ios`
