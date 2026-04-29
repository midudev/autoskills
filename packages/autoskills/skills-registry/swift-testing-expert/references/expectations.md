# Expectations

## When to use this reference

Use this file when writing assertions, migrating from `XCTAssert*`, testing thrown errors, or documenting known failures.

## `#expect` as the default

- Use `#expect` for most assertions.
- Pass natural Swift expressions (`==`, `>`, `.contains`, `.isEmpty`, etc.).
- Rely on captured sub-expression values for rich diagnostics in Xcode.
- Avoid old XCTest assertion families in Swift Testing tests.

### Example: expressive assertions

```swift
import Testing

@Test func pricingRules() {
 let subtotal = 25
 let discount = 5
 let total = subtotal - discount

 #expect(total == 20)
 #expect(total > 0)
 #expect([10, 20, 30].contains(total))
}
```

## `#require` for prerequisites

- Use `try #require(...)` when later assertions depend on this condition.
- Treat `#require` as "guard + fail test early".
- Use return value to unwrap optionals safely and reduce noisy optional chaining.
- Prefer this pattern over manual optional checks when failure should halt test flow.

### Example: optional precondition + unwrapped usage

```swift
import Testing

@Test func parsedURLHasHTTPS() throws {
 let value = "https://www.avanderlee.com"
 let url = try #require(URL(string: value), "URL should parse")
 #expect(url.scheme == "https")
}
```

## Throwing behavior checks

- For success-path calls to throwing functions, call directly and assert returned value.
- For expected failure, use throw-aware expectations to verify:
  - any throw
  - specific error type
  - specific error case/value
- Avoid verbose hand-written `do/catch` unless custom branching is truly needed.

### Example: expected throw and no-throw

```swift
import Testing

enum BrewError: Error, Equatable {
 case missingBeans
}

func brew(_ hasBeans: Bool) throws -> String {
 guard hasBeans else { throw BrewError.missingBeans }
 return "coffee"
}

@Test func expectedThrows() {
 #expect(throws: BrewError.self) {
 try brew(false)
 }
}

@Test func expectedNoThrow() {
 #expect(throws: Never.self) {
 try brew(true)
 }
}
```

## Known issue handling

- Use `withKnownIssue` for temporary expected failures you still want to compile/run.
- Prefer `withKnownIssue` over blanket disabling when you need ongoing visibility.
- Remove known-issue wrappers once failure condition is fixed.

### Example: scope only failing section

```swift
import Testing

@Test func checkoutFlow() {
 #expect(true) // still validated

 withKnownIssue("Checkout backend intermittently returns 503", isIntermittent: true) {
 Issue.record("Known upstream issue")
 }

 #expect(2 + 2 == 4) // rest of test still executes
}
```

## Readability upgrade

- Conform complex domain types to `CustomTestStringConvertible` for concise test output.
- Keep production `CustomStringConvertible` separate from test-specific descriptions when needed.

### Example: clean diagnostic descriptions

```swift
import Testing

struct Receipt: CustomTestStringConvertible {
 let id: UUID
 let total: Decimal

 var testDescription: String {
 "Receipt(total: \(total))"
 }
}
```

## XCTest mapping quick examples

```swift
// XCTAssertEqual(total, 20)
#expect(total == 20)

// try XCTUnwrap(user)
let user = try #require(user)

// XCTFail("Unreachable")
Issue.record("Unreachable")
```

## Do / Don't

- Do use `#require` when later checks depend on a value.
- Do keep `withKnownIssue` scopes narrow.
- Don't use XCTest assertions in Swift Testing tests.
- Don't hide prerequisite failures inside later optional chaining.
