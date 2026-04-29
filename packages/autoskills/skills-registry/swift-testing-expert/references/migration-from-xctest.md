# Migration from XCTest

## When to use this reference

Use this file for incremental migration of existing XCTest code to Swift Testing while preserving safety and CI signal.

## Coexistence strategy

- Swift Testing and XCTest can coexist in the same target.
- Migrate incrementally; do not block migration on full rewrite.
- A single source file can import both `XCTest` and `Testing` during migration.
- Keep XCTest where Swift Testing does not apply:
  - UI automation (`XCUIApplication`)
  - performance APIs (`XCTMetric`)
  - Objective-C-only tests

### Mixed import file example

```swift
import XCTest
import Testing
```

## Practical migration order

1. Convert assertions to `#expect` / `#require`.
2. Replace `test...` naming constraints with explicit `@Test`.
3. Reorganize classes into suites where helpful.
4. Collapse repetitive methods into parameterized tests.
5. Add traits/tags for control and test-plan filtering.

## Example conversion: class method -> Swift Testing function

```swift
// Before (XCTest)
final class PriceTests: XCTestCase {
 func testDiscountedTotal() {
 XCTAssertEqual(Price.total(subtotal: 20, discount: 5), 15)
 }
}

// After (Swift Testing)
import Testing

@Test func discountedTotal() {
 #expect(Price.total(subtotal: 20, discount: 5) == 15)
}
```

## Assertion mapping highlights

- Most `XCTAssert*` variants -> `#expect(...)`.
- Optional unwrap checks -> `try #require(optionalValue)`.
- Early-stop semantics -> `#require` instead of global `continueAfterFailure = false`.
- `XCTFail("...")` -> `Issue.record("...")`.

### Table-style quick mappings

```swift
// XCTAssertTrue(isEnabled)
#expect(isEnabled)

// XCTAssertNil(error)
#expect(error == nil)

// XCTAssertThrowsError(try run())
#expect(throws: (any Error).self) { try run() }

// try XCTUnwrap(user)
let user = try #require(user)
```

## Suite model differences

- XCTest: class + `XCTestCase`.
- Swift Testing: struct/actor/class suites, explicit attributes, value-semantics-friendly defaults.
- Setup can move from `setUp` patterns to suite init when appropriate.
- Teardown can move to `deinit` when using class/actor suites.
- XCTest sync tests default to main actor behavior; Swift Testing runs tests on arbitrary tasks unless explicitly isolated (e.g. `@MainActor`).

### Setup migration example

```swift
import Testing

struct SessionTests {
 let session: Session

 init() {
 self.session = Session(environment: .test)
 }

 @Test func startsDisconnected() {
 #expect(session.isConnected == false)
 }
}
```

## Async migration specifics

- Prefer `await` directly for async APIs.
- Convert completion-handler APIs with `withCheckedContinuation`/`withCheckedThrowingContinuation`.
- Replace `XCTestExpectation` patterns with confirmations when testing asynchronous event streams.

### Expectation-style flow -> confirmation

```swift
import Testing

@Test func receivesAtLeastOneEvent() async {
 await confirmation("Receives event", expectedCount: 1...) { confirm in
 confirm()
 }
}
```

## Migration hygiene

- Prefer mechanical, reviewable commits.
- Use editor pattern-replace to accelerate common assertion conversions.
- Avoid mixing XCTest assertions in Swift Testing tests (and vice versa).

## Common pitfalls

- Migrating all files at once instead of phased migration.
- Keeping `continueAfterFailure` patterns instead of targeted `#require`.
- Marking every migrated test `@MainActor` unnecessarily.
