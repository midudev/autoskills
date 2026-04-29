# Async Testing and Waiting

## When to use this reference

Use this file when tests involve async/await functions, completion handlers, streams/events, or timing-related flakiness.

## Preferred approach

- Use async test functions and `await` naturally.
- Keep async test code close to production async patterns.
- Prefer structured concurrency patterns over ad-hoc synchronization.
- Prefer confirmations for async event-style tests that are not naturally awaitable.

### Async function test example

```swift
import Testing

struct APIClient {
 func fetchName() async throws -> String { "Antoine" }
}

@Test func fetchNameReturnsValue() async throws {
 let client = APIClient()
 let value = try await client.fetchName()
 #expect(value == "Antoine")
}
```

## Callback bridging

- For completion-handler APIs without async overloads, bridge with:
  - `withCheckedContinuation`
  - `withCheckedThrowingContinuation`
- Keep continuation wrappers minimal and test-focused.

### Completion-handler to async bridge

```swift
import Testing

func legacyLoad(_ completion: @escaping (Result<Int, Error>) -> Void) {
 completion(.success(42))
}

@Test func legacyAPI() async throws {
 let value = try await withCheckedThrowingContinuation { continuation in
 legacyLoad { result in
 continuation.resume(with: result)
 }
 }
 #expect(value == 42)
}
```

## Confirmations for asynchronous events

- Use confirmations when validating event delivery/count semantics that do not map cleanly to direct `await`.
- Set expected counts explicitly:
  - exact count for strict validation
  - lower-bounded range for at-least semantics
- Keep confirmation scope small and ensure confirmations happen before the confirmation block returns.

### Confirmation example

```swift
import Testing

@Test func eventIsPublishedTwice() async {
 await confirmation("Publishes two events", expectedCount: 2) { confirm in
 confirm()
 confirm()
 }
}
```

## Event handlers and multi-fire callbacks

- Avoid unsafe mutable shared counters from callback closures in strict concurrency mode.
- Use isolation-safe patterns (actor state, AsyncSequence wrappers, or thread-safe containers).
- Verify callback counts and ordering explicitly when behavior depends on it.

### Actor-isolated counting pattern

```swift
import Testing

actor EventCounter {
 private(set) var count = 0
 func increment() { count += 1 }
}

@Test func countEventsSafely() async {
 let counter = EventCounter()
 await counter.increment()
 await counter.increment()
 #expect(await counter.count == 2)
}
```

## Avoid legacy waiting anti-patterns

- Do not return from test before async callback work completes.
- Avoid sleeping/time-based waits as primary synchronization.
- Replace brittle waiting with awaitable conditions and deterministic synchronization points.

```swift
// Avoid this pattern:
// try await Task.sleep(nanoseconds: 500_000_000)
// #expect(flag == true)
```

## Actor isolation in tests

- Isolate tests to a global actor (e.g. `@MainActor`) only when behavior truly requires it.
- Keep non-UI tests off main actor to preserve realistic concurrency behavior.

### Main-actor test only when required

```swift
import Testing

@MainActor
@Test func uiModelMutation() {
 #expect(true)
}
```
