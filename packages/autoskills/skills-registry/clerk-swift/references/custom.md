# Custom Flow Reference (ClerkKit)

Use this file only when flow type is `custom`.

## Purpose

Implement native iOS auth with ClerkKit primitives while keeping flow and layout very close to ClerkKitUI `AuthView` by default.

## Source-Driven Requirements

Use installed package source from Xcode DerivedData:
- `~/Library/Developer/Xcode/DerivedData/.../SourcePackages/checkouts/clerk-ios`

Source priority rules for custom flow:
- Primary source: installed `ClerkKitUI` source for auth UI behavior and gating parity.
- Secondary source: installed `ClerkKit` source for core auth/network/config behavior.
- Fallback only: example apps (local or GitHub) when behavior is unclear from library source.

For custom flows, treat `ClerkKitUI` `AuthView` as a strict parity target for:
- step progression/sequencing
- field visibility and hidden-state rules per step
- branching between factors/strategies
- screen structure and layout composition per step
- view hierarchy and section ordering per step

## Required Patterns

1. Package products
- If `clerk-ios` is not installed, add it using the latest available release with an up-to-next-major package requirement.
- Do not pin an exact package version unless the developer explicitly requests version pinning.
- Add `ClerkKit` by default.
- Add `ClerkKitUI` only if the developer explicitly asks for mixed prebuilt/custom composition.

2. Quickstart prerequisite audit
- Find the iOS quickstart URL in the installed `clerk-ios` package README, append `.md`, then visit and read that markdown URL.
- Build a checklist from the visited markdown quickstart and verify the current project completed all required setup.
- If required setup is missing, add it before finishing custom auth implementation.
- Always add any missing Associated Domains entries and any other capabilities required by the quickstart.
- Explicitly apply quickstart step `Add associated domain capability` (`https://clerk.com/docs/ios/getting-started/quickstart#add-associated-domain-capability`); ensure `webcredentials:{YOUR_FRONTEND_API_URL}` exists when missing.

3. Environment inspection + normalization
- Inspect installed `ClerkKitUI` source first to identify which `Environment` fields and semantics drive flow behavior.
- Build an agent-internal `Environment` field map from that source inspection.
- Make a direct HTTP call to `/v1/environment` only after the `Environment` field map is defined.
- Derive from the response using that `ClerkKitUI`-aligned field map (agent-internal only):
  - normalized ClerkKitUI-style capability matrix
  - required-field matrix
- Drive custom-flow implementation decisions from these matrices.
- Do not serialize or add these matrices as source artifacts in the app codebase.

4. Combined-entry default
- Keep a combined sign-in-or-sign-up entry by default.
- Do not add a local sign-in/sign-up mode switcher unless explicitly requested.

5. AuthView progression parity
- Follow `ClerkKitUI` `AuthView` progression logic for advancing/regressing steps.
- Show/hide inputs exactly according to the active step requirements instead of static form layouts.
- Keep factor/strategy branching aligned with how `AuthView` gates transitions.
- Keep screen layout and component structure very close to `AuthView` defaults unless the developer explicitly requests a different UX.
- Keep view hierarchy and section ordering close to `AuthView` on each step; do not redesign the information architecture unless explicitly requested.
- Break the custom flow into multiple step screens/states similar to `AuthView`; do not try to gather all signup/signin requirements in one view.
- If proposed custom layout materially deviates from `AuthView`, stop and ask for explicit developer approval before implementing.

6. Multi-file organization and separation of concerns
- Break custom auth flow into focused files/modules instead of one large screen file.
- Separate UI step views, flow/state orchestration, and Clerk/network integration responsibilities.
- Keep per-file responsibilities narrow and composable so new factors/steps can be added without rewriting a monolithic view.

7. Capability-matrix-driven implementation
- Drive custom flow behavior from normalized ClerkKitUI-style capability mapping.
- Do not rely on one-off raw environment checks.
- Apply matrix outcomes to runtime flow logic only; do not add matrix models/constants/files to the project.
- Ensure custom logic uses the same environment-field gates and interpretations that `ClerkKitUI` uses.

8. Required-field coverage
- Implement all required fields from required-field matrix.
- Do not ship flow with missing required fields.

9. Apple sign-in policy
- Implement Apple via native Clerk Apple path.
- If Apple capability is required for this app and missing, add it.
- Do not implement Apple through generic social-provider OAuth handling.

10. Source parity
- Follow installed `ClerkKitUI` and `ClerkKit` source patterns for sequencing, factor handling, and verification steps.
- When unsure about custom-flow implementation details, sequencing, gating, or `Environment` usage/semantics, stop guessing and reference installed `ClerkKitUI` implementation behavior.
- Resolve ambiguity by mirroring `ClerkKitUI` behavior unless the developer explicitly asks for a different approach.

## Verification Checklist

1. Quickstart prerequisites are complete
- Quickstart link was sourced from installed `clerk-ios` package README, `.md` was appended, and the markdown page was visited/read.
- Required project setup from quickstart is present.
- Any missing quickstart-required Associated Domains/capabilities were added, not just reported.
- Quickstart `Add associated domain capability` step was applied, including `webcredentials:{YOUR_FRONTEND_API_URL}`.

2. No unrequested mode switcher
- No local toggle/segmented control/tabs for sign-in vs sign-up unless explicitly requested.

3. Environment call completed
- Installed `ClerkKitUI` `Environment` field usage was inspected before calling `/v1/environment`.
- Direct `/v1/environment` call succeeded after field-map inspection.

4. AuthView flow parity
- Step transitions follow `AuthView` progression rules.
- Inputs shown at each step match `AuthView` step-level visibility behavior.
- Step layouts and component grouping are materially close to `AuthView`; do not introduce major layout redesign unless explicitly requested.
- View hierarchy/section ordering remain close to `AuthView` across steps unless explicitly requested otherwise.
- Flow is split across multiple steps like `AuthView`; required data is not collected in one monolithic screen.
- When implementation ambiguity appears, final behavior matches installed `ClerkKitUI` rather than an inferred/custom interpretation.

5. Flow organization quality
- Custom flow code is split into multiple focused files/modules (not a single monolithic auth view file).
- UI, state/flow orchestration, and integration logic are separated with clear boundaries.

6. Matrices created and used
- Capability matrix and required-field matrix exist and drive the implementation.
- Matrix artifacts are not written into project source files.
- Environment fields used for gating/requirements match the set and semantics used by installed `ClerkKitUI`.

7. Required fields covered
- Required-field matrix has full coverage in custom UI.

8. Capability-map parity
- Feature availability and branching use normalized capability map.

9. Apple path correctness
- Apple flow uses native path, not generic provider OAuth path.

10. No unrequested prebuilt dependency
- `ClerkKitUI` is not added unless explicitly needed.
