# Traits and Tags

## When to use this reference

Use this file when controlling test execution behavior, linking bug context, and organizing large test suites for targeted runs and CI filtering.

## Trait categories

- **Informational**: display names, bug links, tags.
- **Conditional**: `.enabled(if:)`, `.disabled(...)`, availability attributes.
- **Behavioral**: `.timeLimit(...)`, `.serialized`.

## Basic trait examples

```swift
import Testing

@Test("Uploads complete quickly", .timeLimit(.seconds(10)))
func uploadWithinTimeLimit() async throws {
 #expect(true)
}

@Test(.disabled("Flaky on CI while investigating issue"), .bug("https://example.com/issues/12"))
func temporaryDisabledTest() {
 #expect(true)
}
```

## Conditions and disabling

- Use `.enabled(if:)` or `.disabled(if:)` for runtime-evaluated environments.
- Use `.disabled("reason")` instead of commenting tests out.
- Include actionable reason text in disabled traits for CI/test reports.
- Add `.bug(...)` to link issue trackers and aid future cleanup.

### Runtime condition example

```swift
import Testing

enum Runtime {
 static let isCI = ProcessInfo.processInfo.environment["CI"] == "true"
}

@Test(.enabled(if: Runtime.isCI))
func ciOnlySmokeTest() {
 #expect(true)
}
```

## Availability

- Use `@available` on tests when entire behavior is OS-gated.
- Prefer `@available` over inline runtime checks for clearer reporting semantics.

```swift
import Testing

@available(iOS 18, *)
@Test func modernPushPayload() {
 #expect(true)
}
```

## Tags

- Declare custom tags and apply to tests/suites for cross-suite grouping.
- Use tags for test-plan include/exclude, navigator filtering, and failure analytics.
- Treat tags as cross-cutting metadata, not a replacement for suite structure.
- Use meaningful domain labels (e.g. `networking`, `regression`, `spicy`) over vague terms.

### Defining and applying tags

```swift
import Testing

extension Tag {
 @Tag static var networking: Self
 @Tag static var regression: Self
}

@Suite(.tags(.networking))
struct APITests {
 @Test func fetchUser() async throws {
 #expect(true)
 }
}

struct CheckoutTests {
 @Test(.tags(.regression))
 func orderTotal() {
 #expect(3 * 3 == 9)
 }
}
```

## Inheritance and scope

- Traits and tags on suites cascade to contained tests.
- Apply at suite level when broadly true; apply per test when specific.
- Keep trait intent explicit to avoid accidental broad behavior changes.

## Do / Don't

- Do put shared tags at suite level for consistency.
- Do attach bug links for temporary disables or known failures.
- Don't use tags as a replacement for meaningful suite grouping.
- Don't overuse `.serialized` as a blanket reliability fix.

## Review checklist

- Every disabled test has a reason (and ideally a bug link).
- Tags reflect domain concerns and are reused consistently.
- Availability and condition traits are applied to the smallest correct scope.
