# Prebuilt Flow Reference (Clerk Android UI)

Use this file only when flow type is `prebuilt`.

## Purpose

Implement native Android auth with Clerk prebuilt Compose views (`AuthView`, `UserButton`) instead of building custom auth UI logic.

## Required Patterns

1. Artifact selection
- Ensure `com.clerk:clerk-android-ui` is installed (it includes API artifact transitively).
- Do not add `clerk-android-api` separately unless the project explicitly needs it.
- Use the latest stable release unless the developer requests a specific version.

2. Quickstart prerequisite audit
- Read the official Android quickstart: `https://clerk.com/docs/android/getting-started/quickstart`.
- Verify required setup is present:
  - Native API is enabled in Clerk Dashboard.
  - Project min SDK and Java target meet Clerk Android requirements.
  - `android.permission.INTERNET` is present in `AndroidManifest.xml`.
  - App-level initialization calls `Clerk.initialize(...)` in `Application` startup.
- If any required setup is missing, implement it before finishing prebuilt auth work.

3. Initialization and state gating
- Treat SDK initialization as async/non-blocking.
- Gate signed-in/signed-out rendering using `Clerk.isInitialized` and `Clerk.userFlow`.
- Show loading while initialization is in progress.

4. Signed-in/out presentation pattern
- Default signed-out UI: `AuthView()`.
- Default signed-in UI: `UserButton()` (or app content with `UserButton` entry point).
- Keep `AuthView()` in combined sign-in-or-sign-up behavior unless explicitly requested otherwise.

5. Capability alignment
- If social/OAuth options appear inconsistent with expected behavior, verify dashboard config and runtime capability fields (`Clerk.socialProviders`, `Clerk.isGoogleOneTapEnabled`, MFA flags).
- Do not hardcode provider availability.

6. Minimal customization by default
- Do not replace prebuilt views with custom forms unless the developer asks for custom flow.
- Keep customization focused on layout placement/theme integration.

## Verification Checklist

1. Quickstart prerequisites are complete
- Native API enabled.
- Required Android project setup from quickstart is present.
- Missing required prerequisites were applied, not only reported.

2. Correct prebuilt artifact usage
- `clerk-android-ui` is installed.
- Versioning follows latest stable by default.

3. Auth UI gating correctness
- UI waits for `Clerk.isInitialized`.
- Signed-out state renders `AuthView()`.
- Signed-in state renders `UserButton()` or user content that includes it.

4. Capability correctness
- Social/MFA behavior aligns with runtime capability state and dashboard configuration.

5. No accidental custom-flow rewrite
- No unnecessary custom sign-in/sign-up form logic was introduced.
