# Parameterized Testing

## When to use this reference

Use this file when you have repeated tests with identical logic and only input changes.

## When to parameterize

- Use one parameterized test when behavior is identical and only input changes.
- Replace copy-pasted tests and in-test `for` loops with `@Test(arguments: ...)`.
- Keep one responsibility per parameterized test to preserve clarity.

### Before -> after

```swift
// Before: multiple near-duplicate tests.
// @Test func freeFeatureA() { ... }
// @Test func freeFeatureB() { ... }

import Testing

enum Feature: CaseIterable {
 case recording, darkMode, networkMonitor
 var isPremium: Bool { self == .networkMonitor }
}

@Test("Free features are not premium", arguments: [Feature.recording, .darkMode])
func freeFeatures(_ feature: Feature) {
 #expect(feature.isPremium == false)
}
```

## Single input collection

- Pass any sendable collection (arrays, ranges, dictionaries, etc.) as arguments.
- Each argument becomes its own independent test case with separate diagnostics.
- Individual failing arguments can be rerun without rerunning all inputs.

### Range-based arguments example

```swift
import Testing

func isValidAge(_ value: Int) -> Bool { (18...120).contains(value) }

@Test(arguments: 18...21)
func validAges(_ age: Int) {
 #expect(isValidAge(age))
}
```

## Multiple inputs

- Swift Testing supports up to two argument collections directly.
- Two collections generate all combinations (cartesian product).
- Control explosion by:
  - reducing argument sets
  - splitting tests by concern
  - pairing related values via `zip(...)`

### Cartesian product example

```swift
import Testing

enum Region { case eu, us }
enum Plan { case free, pro }

func canUseVATInvoice(region: Region, plan: Plan) -> Bool {
 region == .eu && plan == .pro
}

@Test(arguments: [Region.eu, .us], [Plan.free, .pro])
func vatInvoiceAccess(region: Region, plan: Plan) {
 let allowed = canUseVATInvoice(region: region, plan: plan)
 #expect((region == .eu && plan == .pro) == allowed)
}
```

## `zip` for paired scenarios

- Use `zip` when input A must pair with a corresponding input B.
- Prefer `zip` over full combinations when you need aligned tuples only.
- Keep tuples readable and intentional.

### `zip` example

```swift
import Testing

enum Tier { case basic, premium }
func freeTries(for tier: Tier) -> Int { tier == .basic ? 3 : 10 }

@Test(arguments: zip([Tier.basic, .premium], [3, 10]))
func freeTryLimits(_ tier: Tier, expected: Int) {
 #expect(freeTries(for: tier) == expected)
}
```

### `zip` pitfalls to avoid

**Silent truncation**: `zip` stops at the shorter collection. If the two arrays differ in length, the extra elements are silently dropped — no compiler error, no test failure, just missing coverage.

```swift
// ❌ Silent gap: the fifth input is never tested
@Test(arguments: zip(
  [Status.active, .inactive, .pending, .banned, .suspended],
  ["Active", "Inactive", "Pending", "Banned"]  // one short
))
func statusLabel(_ status: Status, expected: String) {
 #expect(label(for: status) == expected)
}
```

**Case-order fragility with `CaseIterable`**: pairing two `allCases` arrays with `zip` breaks silently if enum cases are ever reordered (e.g., by alphabetizing).

```swift
// ❌ Fragile: reordering either enum misaligns all pairs
enum Ingredient: CaseIterable { case rice, potato, egg }
enum Dish: CaseIterable { case onigiri, fries, omelette }

@Test(arguments: zip(Ingredient.allCases, Dish.allCases))
func cook(_ ingredient: Ingredient, into dish: Dish) {
 #expect(cook(ingredient) == dish)
}
```

Prefer explicit array literals or one of the alternatives below.

## Paired input alternatives

When inputs and expected outputs must be paired, prefer these over `zip` to avoid the silent-truncation and case-ordering problems.

### Array of tuples (recommended)

Pairs are co-located and impossible to misalign. Adding a new case forces a matching output to be written at the same time.

```swift
import Testing

@Test(arguments: [
 (Ingredient.rice, Dish.onigiri),
 (.potato, .fries),
 (.egg, .omelette)
])
func cook(_ ingredient: Ingredient, into dish: Dish) {
 #expect(cook(ingredient) == dish)
}
```

### Dictionary arguments

Expresses a clear mapping; each entry is self-documenting. Requires `Hashable` keys.

```swift
import Testing

@Test(arguments: [
 Ingredient.rice: Dish.onigiri,
 .potato: .fries,
 .egg: .omelette
])
func cook(_ ingredient: Ingredient, into dish: Dish) {
 #expect(cook(ingredient) == dish)
}
```

### Fixed-size `zip` with `InlineArray` (Swift 6.2+)

A custom `zip` overload for `InlineArray` enforces equal-length arrays at compile time via a generic length parameter. This is not part of the standard library — you must define the helper yourself.

```swift
import Testing

// Custom helper: `zip` for two `InlineArray` values of the same length.
func zip<let N: Int, A, B>(
  _ a: InlineArray<N, A>,
  _ b: InlineArray<N, B>
) -> Zip2Sequence<[A], [B]> {
  zip(Array(a), Array(b))
}

// ✅ Compile error if lengths differ — enforced at compile time
@Test(arguments: zip(
  InlineArray<2, Ingredient>(.rice, .potato),
  InlineArray<2, Dish>(.onigiri, .curry)
))
func cook(_ ingredient: Ingredient, into dish: Dish) {
  #expect(cook(ingredient) == dish)
}
```

## Naming and output quality

- Use meaningful parameter labels and display names.
- Ensure argument types are readable in output; provide custom test description if noisy.
- Keep argument lists easy to scan (multi-line formatting is recommended).

## When `CaseIterable.allCases` is appropriate

Using `allCases` as arguments is a valid pattern for **property-based tests** — tests that verify a universal property holds for every member of a type. The key distinction: the expected result is derived from the *property being tested*, not from a hard-coded mapping.

```swift
import Testing

// ✅ Valid: verifying a mathematical property holds for all orientations.
@Test(
  "Rotating clockwise four times returns to the original orientation",
  arguments: Orientation.allCases
)
func fullRotation(orientation: Orientation) {
 #expect(
  orientation
   .rotated(.clockwise)
   .rotated(.clockwise)
   .rotated(.clockwise)
   .rotated(.clockwise)
  == orientation
 )
}
```

Avoid `allCases` when you need concrete, case-specific expected values — use explicit arrays or tuples instead.

## Common pitfalls

- **Derived expected values masking bugs**: when the expected value is derived from the same input expression as the system under test, both sides shift together and bugs pass silently. Use concrete literals in `#expect` for case-specific expectations.

```swift
// ❌ Masking: if format(day) returns "monday" instead of "Monday",
//    this test still passes because rawValue has the same casing bug.
@Test(arguments: Day.allCases)
func dayLabel(day: Day) {
 #expect(format(day) == day.rawValue)
}

// ✅ Concrete: each expectation is an independent data point.
@Test(arguments: [
 (Day.monday, "Monday"),
 (.friday, "Friday")
])
func dayLabel(day: Day, expected: String) {
 #expect(format(day) == expected)
}
```

- **Control flow in test bodies**: `if`/`switch` inside a parameterized test body mirrors implementation logic. Tests that branch the same way as production code verify themselves rather than the behavior independently.

```swift
// ❌ Mirrors implementation — not independent verification.
@Test(arguments: Day.allCases)
func greeting(day: Day) {
 if day == .friday {
  #expect(greet(day) == "TGIF!")
 } else {
  #expect(greet(day) == "Hello, \(day)!")
 }
}

// ✅ Separate the special case into its own test.
@Test func fridayGreeting() {
 #expect(greet(.friday) == "TGIF!")
}

@Test(arguments: [Day.monday, .tuesday, .wednesday, .thursday, .saturday, .sunday])
func standardGreeting(day: Day) {
 #expect(greet(day) == "Hello, \(day)!")
}
```

- **Using in-test `for` loops instead of parameterized arguments** (worse diagnostics).
- **Passing huge argument sets that explode combinations** and slow CI.
- **Mixing multiple concerns into one parameterized function**.
- **Extracting argument arrays into separate properties or extensions**: this hides what the test covers and forces readers to jump between definitions. Keep arguments inline unless the list is genuinely reused across multiple test functions.

## Review checklist

- Repetitive tests are consolidated into one parameterized test.
- Arguments reflect domain vocabulary and produce readable failures.
- Paired inputs are modeled as arrays of tuples or dictionaries; use `zip` with equal-length explicit arrays only when the inputs must remain as separate collections.
- Paired inputs use tuples or dictionaries rather than `zip(allCases, allCases)`.
- `#expect` uses concrete literal expectations, not values derived from the input itself.
- No `if`/`switch` branching inside parameterized test bodies.
- `CaseIterable.allCases` is only used for property-based assertions, not example-based mappings.
