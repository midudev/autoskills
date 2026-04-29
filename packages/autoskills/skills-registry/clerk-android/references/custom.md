# Custom Flow Reference (Clerk Android API)

Use this file only when flow type is `custom`.

## Purpose

Implement native Android auth with Clerk API primitives while preserving Clerk's multi-step auth semantics and dashboard-driven capability gating.

## Source-Driven Requirements

Use current `clerk-android` source/docs as primary references:
- `source/api` for sign-in/sign-up/session/auth APIs.
- `source/ui/auth` and `samples/custom-flows` for flow sequencing patterns.
- Android quickstart for required project setup.

Source priority rules for custom flow:
- Primary source: Clerk Android API and auth flow source.
- Secondary source: `samples/custom-flows`.
- Fallback only: high-level docs when behavior is unclear from SDK/source.

## Required Patterns

1. Artifact selection
- Ensure `com.clerk:clerk-android-api` is installed.
- Do not add `clerk-android-ui` unless developer explicitly asks for a hybrid prebuilt/custom approach.

2. Quickstart prerequisite audit
- Read the official Android quickstart: `https://clerk.com/docs/android/getting-started/quickstart`.
- Verify required project setup (Native API, min SDK/Java, manifest internet permission, app-level initialization).
- Implement missing required setup before finishing custom auth work.

3. Initialization and state contract
- Initialize via `Clerk.initialize(...)` at app startup.
- Wait for `Clerk.isInitialized` before treating Clerk as ready.
- Drive session/user UI from `Clerk.userFlow`/`Clerk.sessionFlow`.

4. Capability-driven flow logic
- Use Clerk runtime capability/settings fields to drive flow branches (first factors, social providers, MFA, Google One Tap support).
- Do not hardcode fixed factor/provider assumptions.

5. Multi-step flow progression
- Keep sign-in/sign-up progression split into explicit steps/states.
- Avoid collapsing all required auth input into one monolithic screen.
- Keep branching aligned with factor requirements and verification states returned by Clerk.

6. API usage patterns
- Use Clerk sign-in/sign-up APIs and verification methods with structured success/failure handling.
- Keep request/response handling explicit and status-driven.
- Use Clerk error helpers/messages for user-visible errors.

7. OAuth/social policy
- Use provider flows supported by Clerk APIs.
- For Google, honor runtime One Tap capability and use the appropriate Clerk path.
- Do not bypass Clerk by implementing provider-specific token exchange directly unless explicitly requested.

8. Code organization and separation of concerns
- Split custom auth into focused modules:
  - UI step views/components
  - Flow/state orchestration (view models/state machines)
  - Clerk API integration layer
- Keep module boundaries clear and composable.

9. Avoid hidden dependencies
- Do not silently add prebuilt UI dependencies to custom-only implementations.
- Do not introduce local config indirection for publishable key unless requested.

## Verification Checklist

1. Quickstart prerequisites are complete
- Required Android/Clerk setup from quickstart is present.
- Missing required setup was applied.

2. Correct artifact usage
- `clerk-android-api` is present.
- `clerk-android-ui` is absent unless explicitly required.

3. Initialization and auth state handling
- UI/runtime waits for `Clerk.isInitialized`.
- Auth/session/user state derives from Clerk flows.

4. Capability-driven behavior
- Flow branches align with runtime capabilities and dashboard configuration.
- No hardcoded factor/provider matrix independent of Clerk state.

5. Multi-step auth quality
- Flow uses explicit steps with clear transitions.
- Required fields and verifications are fully covered.

6. Architecture quality
- UI, orchestration, and Clerk integration are separated into focused files/modules.

7. OAuth/social correctness
- OAuth handling uses Clerk APIs and supported provider paths.
