# Parallelization and Isolation

## When to use this reference

Use this file when tests are flaky in CI, have hidden ordering dependencies, or need to scale execution speed safely.

## Default execution model

- Swift Testing runs test functions in parallel by default.
- Execution order is randomized to expose hidden test dependencies.
- Parallelization applies to synchronous and asynchronous tests.

## Example: hidden dependency exposed by parallel execution

```swift
import Testing

enum SharedStore {
 static var counter = 0
}

@Test func incrementsCounter() {
 SharedStore.counter += 1
 #expect(SharedStore.counter >= 1)
}

@Test func expectsFreshCounter() {
 // Flaky if tests run in parallel or random order.
 #expect(SharedStore.counter == 0)
}
```

## Why this matters

- Faster CI feedback and shorter local iteration loops.
- Better detection of shared-state coupling and flaky behavior.
- More realistic stress on concurrency-sensitive code paths.

## Isolation strategy first

- Make tests independent by default.
- Avoid shared mutable globals and singleton mutation across tests.
- Isolate state per test invocation (fresh suite instance helps).
- Prefer deterministic test data setup over implicit ordering assumptions.

### Better pattern: isolate per test

```swift
import Testing

struct CounterStore {
 var counter = 0
 mutating func increment() { counter += 1 }
}

@Test func isolatedCounter() {
 var store = CounterStore()
 store.increment()
 #expect(store.counter == 1)
}
```

## `.serialized` as a targeted tool

- Apply `.serialized` to suites when tests must run one-at-a-time.
- Use it as a transitional safety measure during migration from serial XCTest suites.
- Refactor toward parallel-safe tests before normalizing serialization everywhere.
- Serialized suites can still run alongside unrelated suites in parallel.

### Transitional serialization example

```swift
import Testing

@Suite(.serialized)
struct LegacyDatabaseTests {
 @Test func migrationStepA() { #expect(true) }
 @Test func migrationStepB() { #expect(true) }
}
```

## Shared resource scenarios

- If tests hit a shared DB/file/service, choose one:
  - isolate backing state per test
  - use in-memory substitutes
  - create separate serial test plan for integration path
- Prefer architecture that supports both fast in-memory tests and selective real integration tests.

## Do / Don't

- Do fix shared-state coupling before adding broad serialization.
- Do use in-memory fakes for the fast path.
- Don't rely on execution order.
- Don't mutate singletons across tests without reset/isolation.
