# Fundamentals

## When to use this reference

Use this file when creating new Swift Testing suites or refactoring test structure before deeper topics like traits, parameterization, or migration.

## Building blocks

- Import `Testing` only in test targets.
- Use `@Test` to declare tests explicitly (global function or type method).
- Use suites (`struct`, `actor`, or `class`) to group related tests.
- Prefer `struct` suites for value semantics and accidental-state-sharing prevention.
- Use `@Suite` when adding suite-level traits or display names.
- Use nested suites to reflect feature grouping and improve discoverability.

## Core examples

### Global test function

```swift
import Testing
@testable import FoodTruck

@Test("Food truck has a valid default name")
func defaultName() {
 let truck = FoodTruck()
 #expect(truck.name.isEmpty == false)
}
```

### Suite with instance tests

```swift
import Testing
@testable import FoodTruck

@Suite("Menu tests")
struct MenuTests {
 @Test("Returns no duplicates")
 func uniqueItems() {
 let items = Menu.default.items
 #expect(Set(items).count == items.count)
 }
}
```

### Nested suites for feature grouping

```swift
import Testing
@testable import FoodTruck

struct CheckoutTests {
 struct Taxes {
 @Test func taxIsRoundedToTwoDigits() {
 let total = Checkout.total(subtotal: 10.00, taxRate: 0.0825)
 #expect(total == 10.83)
 }
 }

 struct Discounts {
 @Test func promoCodeAppliesFixedAmount() {
 let total = Checkout.total(subtotal: 20.00, discount: .fixed(5))
 #expect(total == 15.00)
 }
 }
}
```

## Recommended defaults

- Keep tests small and behavior-focused.
- Prefer descriptive names over boilerplate `test...` prefixes.
- Use display names where human-readable output helps triage.
- Keep setup local, or centralize in suite init when shared across tests.
- Avoid hidden global mutable state.
- Use `@MainActor` only when code under test requires main-thread isolation.
- Use `@available` on test functions when needed for platform/language gating.

## Organization guidance

- Group by feature behavior, not by implementation class only.
- Promote shared traits (e.g. tags) to suite level when all tests inherit them.
- Use tags for cross-cutting grouping across files/targets.
- Keep unrelated tests in separate suites to preserve clear ownership.

## Suite constraints to enforce

- If a suite has instance test methods, it must have a callable zero-argument initializer (implicit or explicit, sync/async, throwing or non-throwing).
- If initialization requirements cannot be met, convert tests to static/global functions or refactor suite state.
- Suite types (and containing types) must always be available; do not apply `@available` to suite declarations.

### Zero-argument initializer requirement example

```swift
import Testing

@Suite
struct SessionTests {
 let config: URLSessionConfiguration

 // Valid: callable with zero args due to default value.
 init(config: URLSessionConfiguration = .ephemeral) {
 self.config = config
 }

 @Test func usesEphemeralByDefault() {
 #expect(config == .ephemeral)
 }
}
```

### Invalid availability placement

```swift
import Testing

// Do not do this on suite types:
// @available(iOS 18, *)
@Suite
struct PushTests {
 @available(iOS 18, *)
 @Test func supportsNewPushFormat() {
 #expect(true)
 }
}
```

## Do / Don't

- Do keep each test focused on one behavior.
- Do use display names where they improve failure readability.
- Don't rely on test execution order.
- Don't annotate suites with `@available`; annotate test functions instead.

## Review checklist

- Test target imports `Testing`, app targets do not.
- Suite choice (`struct`/`actor`/`class`) matches setup and teardown needs.
- Instance tests have a callable zero-argument init path.
- Availability is applied to test functions, not suite types.
