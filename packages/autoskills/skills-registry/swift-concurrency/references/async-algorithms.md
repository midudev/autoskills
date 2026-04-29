# AsyncAlgorithms Package

Use this when:

- You need time-based operators (debounce, throttle, timers).
- You need to combine multiple async sequences (merge, combineLatest, zip).
- You are migrating from Combine or RxSwift operators to Swift Concurrency equivalents.

Skip this file if:

- You need basic `AsyncStream` bridging for callbacks or delegates. Use `async-sequences.md`.
- You are choosing between `Task`, `async let`, or task groups. Use `tasks.md`.

Jump to:

- Quick Start
- Time-Based Operators
- Combining Operators
- Multi-Consumer Scenarios
- Combine Migration Guide
- Best Practices

---

## Quick Start

Top 5 most common operators:

```swift
import AsyncAlgorithms

// 1. Debounce rapid inputs
for await query in searchQueryStream.debounce(for: .milliseconds(500)) {
    await performSearch(query)
}

// 2. Throttle repeated actions
for await _ in buttonClicks.throttle(for: .seconds(1)) {
    await performAction()
}

// 3. Merge multiple independent streams
for await message in chat1Messages.merge(chat2Messages) {
    display(message)
}

// 4. Combine dependent values
for await (username, email) in usernameStream.combineLatest(emailStream) {
    validateForm(username: username, email: email)
}

// 5. Zip paired operations
for await (image, metadata) in imageStream.zip(metadataStream) {
    await cache(image: image, metadata: metadata)
}
```

> **See**: [AsyncAlgorithms on GitHub](https://github.com/apple/swift-async-algorithms)

---

## Overview & Installation

### What is AsyncAlgorithms?

Extends Swift's AsyncSequence with time-based operators, stream combination tools, and multi-consumer primitives.

**Use for**:
- Time-based operations: debounce, throttle, timers
- Combining streams: merge, combineLatest, zip, chain
- Multi-consumer scenarios: AsyncChannel for backpressure
- Specific operators: removeDuplicates, chunks, adjacentPairs, compacted

**Use standard library for**:
- Bridging callbacks: AsyncStream
- Simple iteration: for await in sequence
- Single-value operations: async/await

### Installation

```swift
dependencies: [
    .package(url: "https://github.com/apple/swift-async-algorithms", from: "1.0.0")
]

targets: [
    .target(
        name: "MyTarget",
        dependencies: [
            .product(name: "AsyncAlgorithms", package: "swift-async-algorithms")
        ]
    )
]
```

Import:

```swift
import AsyncAlgorithms
```

---

## Time-Based Operators

### debounce(for:tolerance:clock:)

Wait for inactivity before emitting. Use for rapid inputs like search fields.

#### Example: ArticleSearcher

```swift
import AsyncAlgorithms

@Observable
final class ArticleSearcher {
    @MainActor private(set) var results: [Article] = []
    private var searchQueryContinuation: AsyncStream<String>.Continuation?

    private lazy var searchQueryStream: AsyncStream<String> = {
        AsyncStream { continuation in
            searchQueryContinuation = continuation
        }
    }()

    func search(_ query: String) {
        searchQueryContinuation?.yield(query)
    }

    func startDebouncedSearch() {
        Task { @MainActor in
            for await query in searchQueryStream.debounce(for: .milliseconds(500)) {
                self.results = []
                self.results = await APIClient.searchArticles(query)
            }
        }
    }
}
```

**Benefits**: Automatic cancellation, backpressure, cleaner than manual Task.sleep.

#### ❌ Anti-Pattern

```swift
// Bad: Every keystroke spawns new task
func search(_ query: String) {
    Task {
        try? await Task.sleep(for: .milliseconds(500))
        await performSearch(query)
    }
}
```

**Problem**: Multiple tasks execute simultaneously, causing out-of-order results.

**Solution**: Use `debounce()` for automatic backpressure.

---

### throttle(for:clock:reducing:)

Emit at most one value per interval. Use for repeated actions like button taps.

#### Example: Like Button

```swift
import AsyncAlgorithms

struct LikeButton: View {
    @State private var tapStream = AsyncStream<Void> { continuation in
        // Continuation stored externally
    }
    @State private var isLiked = false

    var body: some View {
        Button(action: {
            tapStream.continuation?.yield()
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
        }
        .task {
            await handleThrottledTaps()
        }
    }

    private func handleThrottledTaps() async {
        for await _ in tapStream.throttle(for: .seconds(1)) {
            await toggleLike()
        }
    }

    private func toggleLike() async {
        isLiked.toggle()
        await APIClient.updateLikeStatus(isLiked: isLiked)
    }
}
```

#### Understanding reducing Parameter

```swift
// .latest (default): Keep most recent value
for await value in events.throttle(for: .seconds(1)) {
    process(value)
}

// .oldest: Keep first value
for await value in events.throttle(for: .seconds(1), reducing: .oldest) {
    process(value)
}

// Custom: Sum all values
for await value in events.throttle(for: .seconds(1)) { $0 + $1 } {
    process(value)
}
```

---

### AsyncTimerSequence

Emit values at regular intervals. Use for periodic refresh or countdown timers.

#### Example: Feed Refresh

```swift
import AsyncAlgorithms

@MainActor @Observable
final class FeedViewModel {
    private(set) var articles: [Article] = []
    private var refreshTask: Task<Void, Never>?

    func startAutoRefresh() {
        refreshTask = Task {
            for await _ in AsyncTimerSequence(interval: .seconds(30)) {
                await refreshFeed()
            }
        }
    }

    private func refreshFeed() async {
        articles = await APIClient.fetchLatestArticles()
    }
}
```

#### ❌ Anti-Pattern

```swift
// Bad: Manual timer implementation
func startTimer() {
    Task {
        while !Task.isCancelled {
            performAction()
            try? await Task.sleep(for: .seconds(1))
        }
    }
}
```

**Solution**: Use `AsyncTimerSequence`.

---

## Combining Operators

### merge(_:...)

Combine sequences into one, emitting as they arrive. **Stable operator ✅**

Use for independent data sources that don't depend on each other.

#### Example: Multi-Room Chat

```swift
import AsyncAlgorithms

actor ChatManager {
    private var messageContinuations: [String: AsyncStream<ChatMessage>.Continuation] = [:]

    func getMessagesStream(roomID: String) -> AsyncStream<ChatMessage> {
        AsyncStream { continuation in
            messageContinuations[roomID] = continuation
        }
    }

    func receiveMessage(_ message: ChatMessage) {
        messageContinuations[message.roomID]?.yield(message)
    }

    func startMonitoring(rooms: [String]) -> AsyncStream<ChatMessage> {
        let streams = rooms.map { getMessagesStream(roomID: $0) }
        return streams.merge()
    }
}

// Usage
let manager = ChatManager()
let mergedMessages = await manager.startMonitoring(rooms: ["general", "random"])

for await message in mergedMessages {
    print("[\(message.roomID)] \(message.text)")
}
```

**Behavior**: Values emit as they arrive from any source. Order interleaved by timing. Cancellation propagates to all sources.

---

### combineLatest(_:...)

Combine sequences, emitting tuple when any source emits. Always uses latest values. **Stable operator ✅**

Use for dependent values that need synchronization.

#### Example: Form Validation

```swift
import AsyncAlgorithms

struct SignupForm: View {
    @State private var usernameStream = AsyncStream<String> { /* ... */ }
    @State private var emailStream = AsyncStream<String> { /* ... */ }
    @State private var passwordStream = AsyncStream<String> { /* ... */ }
    @State private var formState = FormState.incomplete

    var body: some View {
        Form {
            TextField("Username", text: $username)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
        }
        .task {
            await validateForm()
        }
    }

    private func validateForm() async {
        for await (username, email, password) in
                usernameStream.combineLatest(emailStream, passwordStream)
        {
            formState = await validate(
                username: username,
                email: email,
                password: password
            )
        }
    }
}
```

#### ❌ Anti-Pattern

```swift
// Bad: Manual value combining
actor FormValidator {
    private var currentUsername: String = ""
    private var currentEmail: String = ""

    func updateUsername(_ username: String) {
        currentUsername = username
        checkForm()
    }
}
```

**Solution**: Use `combineLatest()`.

---

### zip(_:...)

Combine sequences by pairing elements in order. **Stable operator ✅**

#### Example: Image + Metadata

```swift
import AsyncAlgorithms

struct ImageLoader {
    func loadImagesWithMetadata(urls: [URL]) async throws -> [LoadedImage] {
        let imageStream = AsyncThrowingStream<UIImage, Error> { continuation in
            Task {
                for url in urls {
                    let image = try await downloadImage(from: url)
                    continuation.yield(image)
                }
                continuation.finish()
            }
        }

        let metadataStream = AsyncThrowingStream<ImageMetadata, Error> { continuation in
            Task {
                for url in urls {
                    let metadata = try await fetchMetadata(for: url)
                    continuation.yield(metadata)
                }
                continuation.finish()
            }
        }

        var results: [LoadedImage] = []
        for try await (image, metadata) in imageStream.zip(metadataStream) {
            results.append(LoadedImage(image: image, metadata: metadata))
        }
        return results
    }
}
```

**Behavior**: Emits tuple when all sequences emit. Maintains order. Finishes when shortest sequence finishes.

---

### chain(_:...)

Concatenate sequences sequentially. **Stable operator ✅**

#### Example: Paginated Loading

```swift
import AsyncAlgorithms

struct ArticlePaginator {
    func loadAllArticles() -> AsyncStream<[Article]> {
        AsyncStream { continuation in
            Task {
                var page = 1
                var hasMore = true
                while hasMore {
                    let articles = try await fetchPage(page: page)
                    continuation.yield(articles)
                    hasMore = articles.count == 20
                    page += 1
                }
                continuation.finish()
            }
        }
    }
}

// Usage: Chain cache + network
for await articles in loadFromCacheStream().chain(loadFromNetworkStream()) {
    display(articles)
}
```

**Behavior**: Emits all values from first sequence before starting second.

---

## Utility Operators

### removeDuplicates()

Remove adjacent duplicates. **Stable operator ✅**

```swift
import AsyncAlgorithms

actor ChatHistory {
    private var messageStream = AsyncStream<ChatMessage> { /* ... */ }

    func getUniqueMessages() -> AsyncStream<ChatMessage> {
        messageStream.removeDuplicates()
    }
}
```

---

### chunks() and chunked()

Collect values into batches. **Stable operator ✅**

```swift
import AsyncAlgorithms

struct BatchProcessor {
    func processLargeDataset(dataStream: AsyncStream<DataItem>) async {
        for await batch in dataStream.chunks(count: 100) {
            await processBatch(batch)
        }
    }

    func chunkedByTime(dataStream: AsyncStream<DataItem>) async {
        for await batch in dataStream.chunked(by: .seconds(5)) {
            await processBatch(batch)
        }
    }
}
```

---

### compacted() and adjacentPairs()

```swift
import AsyncAlgorithms

// Remove nil values
for await value in optionalValuesStream.compacted() {
    process(value)
}

// Pair adjacent elements
for await (previous, current) in valuesStream.adjacentPairs() {
    let difference = current - previous
}
```

---

## Multi-Consumer Scenarios

### AsyncChannel

AsyncSequence with backpressure. **Stable operator ✅**

Use for producer-consumer patterns with flow control.

#### Example: Message Queue

```swift
import AsyncAlgorithms

actor MessageQueue {
    private let channel = AsyncChannel<Message>()

    func getMessages() -> AsyncStream<Message> {
        channel
    }

    func enqueue(_ message: Message) async {
        await channel.send(message)
    }

    func startProcessing() {
        Task {
            for await message in channel {
                await process(message)
            }
        }
    }
}

// Multiple producers
let queue = MessageQueue()
Task { await queue.enqueue(Message(type: .userAction, content: "tap")) }
Task { await queue.enqueue(Message(type: .network, content: "data")) }
queue.startProcessing()
```

#### ❌ Anti-Pattern

```swift
// Bad: Values split unpredictably
let stream = AsyncStream<Int> { continuation in
    for i in 1...10 {
        continuation.yield(i)
    }
    continuation.finish()
}

Task { for await value in stream { print("Consumer 1: \(value)") } }
Task { for await value in stream { print("Consumer 2: \(value)") } }
```

**Problem**: Each value goes to only one consumer.

**Solution**: Use `AsyncChannel` for multi-consumer scenarios.

---

### AsyncThrowingChannel

Like AsyncChannel but can emit errors. **Stable operator ✅**

#### Example: WebSocket

```swift
import AsyncAlgorithms

actor WebSocketConnection {
    private let channel = AsyncThrowingChannel<WebSocketMessage, Error>()

    func getMessages() -> AsyncThrowingStream<WebSocketMessage, Error> {
        channel
    }

    func receiveMessage(_ message: WebSocketMessage) async {
        await channel.send(message)
    }

    func reportError(_ error: Error) async {
        await channel.finish(throwing: error)
    }
}

// Usage
do {
    for await message in connection.getMessages() {
        handle(message)
    }
} catch {
    print("WebSocket error: \(error)")
}
```

---

## Combine Migration Guide

### Operator Mapping Table

| Combine | AsyncAlgorithms | Status | Alternative |
|---------|-----------------|---------|-------------|
| `.debounce()` | `debounce()` | ✅ Stable | - |
| `.throttle()` | `throttle()` | ✅ Stable | - |
| `.merge()` | `merge()` | ✅ Stable | - |
| `.combineLatest()` | `combineLatest()` | ✅ Stable | - |
| `.zip()` | `zip()` | ✅ Stable | - |
| `.concat()` | `chain()` | ✅ Stable | - |
| `.removeDuplicates()` | `removeDuplicates()` | ✅ Stable | - |
| `.timer()` | `AsyncTimerSequence` | ✅ Stable | - |
| `.share()` | - | - | `AsyncChannel` |
| `.flatMap()` | - | - | `TaskGroup` |
| `.receive(on:)` | - | - | `Task` / `@MainActor` |
| `.eraseToAnyPublisher()` | - | - | `any AsyncSequence` |

---

### Migration Examples

#### Example 1: ArticleSearcher

**Before: Combine**

```swift
import Combine

final class ArticleSearcher: ObservableObject {
    @Published private(set) var results: [Article] = []
    @Published var searchQuery = ""

    init() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { query in
                APIClient.searchArticles(query)
                    .catch { _ in Just([]) }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$results)
    }
}
```

**After: AsyncAlgorithms**

```swift
import AsyncAlgorithms

@Observable
final class ArticleSearcher {
    @MainActor private(set) var results: [Article] = []
    private var searchQueryContinuation: AsyncStream<String>.Continuation?

    private lazy var searchQueryStream: AsyncStream<String> = {
        AsyncStream { continuation in
            searchQueryContinuation = continuation
        }
    }()

    func search(_ query: String) {
        searchQueryContinuation?.yield(query)
    }

    func startDebouncedSearch() {
        Task { @MainActor in
            for await query in searchQueryStream
                .debounce(for: .milliseconds(500))
                .removeDuplicates()
            {
                do {
                    self.results = try await APIClient.searchArticles(query)
                } catch {
                    self.results = []
                }
            }
        }
    }
}
```

**Benefits**: Simpler error handling, no cancellables, automatic cancellation.

---

#### Example 2: Multi-Source Loading

**Before: Combine Merge**

```swift
import Combine

final class ArticleLoader: ObservableObject {
    @Published private(set) var items: [Item] = []

    func loadAllSources() {
        let source1 = APIClient.fetchItems(from: .source1)
        let source2 = APIClient.fetchItems(from: .source2)

        Publishers.Merge(source1, source2)
            .scan([]) { accumulated, new in
                accumulated + new
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$items)
    }
}
```

**After: TaskGroup**

```swift
import AsyncAlgorithms

@Observable
final class ArticleLoader {
    @MainActor private(set) var items: [Item] = []

    func loadAllSourcesParallel() async {
        await withTaskGroup(of: [Item].self) { group in
            group.addTask {
                await APIClient.fetchItems(from: .source1)
            }
            group.addTask {
                await APIClient.fetchItems(from: .source2)
            }

            for await newItems in group {
                items.append(contentsOf: newItems)
            }
        }
    }
}
```

**Key difference**: For parallel execution, use `TaskGroup` instead of `flatMap`.

---

#### Example 3: Form Validation

**Before: Combine**

```swift
import Combine

final class FormValidator: ObservableObject {
    @Published var username = ""
    @Published var email = ""

    @Published private(set) var formState: FormState = .incomplete

    init() {
        Publishers.CombineLatest2($username, $email)
            .map { username, email in
                validate(username: username, email: email)
            }
            .assign(to: &$formState)
    }
}
```

**After: AsyncAlgorithms or async let**

```swift
import AsyncAlgorithms

@Observable
final class FormValidator {
    var username = ""
    var email = ""

    @MainActor private(set) var formState: FormState = .incomplete

    // Option 1: combineLatest for stream-based validation
    func startStreamValidation() {
        Task { @MainActor in
            for await (username, email) in
                    usernameStream.combineLatest(emailStream)
            {
                self.formState = validate(
                    username: username,
                    email: email
                )
            }
        }
    }

    // Option 2: async let for simple validation
    func validateForm() async {
        let (username, email) = await (username, email)
        formState = validate(
            username: username,
            email: email
        )
    }
}
```

**Choose**:
- `combineLatest()`: Continuous validation as fields change
- `async let`: One-time validation when all values available

---

## Common Mistakes Agents Make

- **Manual debounce with `Task.sleep`**: This creates multiple concurrent tasks and risks out-of-order results. Use the stream-based `debounce(for:)` operator from AsyncAlgorithms instead.
- **Sharing `AsyncStream` across multiple consumers**: Values split unpredictably between consumers. Use `AsyncChannel` for multi-consumer scenarios with backpressure. Note: `AsyncChannel` is point-to-point, not broadcast like Combine's `.share()`.
- **Looking for a `.flatMap` equivalent**: Use `TaskGroup` for fan-out; the semantics differ from Combine/Rx `flatMap`.
- **Looking for `.receive(on:)` equivalent**: Use `@MainActor` or `Task` context for isolation instead.

## Best Practices

1. **Use time-based operators** for rapid inputs: debounce() for search, throttle() for buttons
2. **Combine streams** with merge/combineLatest instead of manual state management
3. **Use AsyncChannel** for multi-consumer scenarios with backpressure
4. **Ensure Sendable conformance** when using operators across isolation boundaries
5. **Leverage cancellation** - Task cancellation propagates through all operators
6. **Choose right tool**: AsyncAlgorithms for complex streams, AsyncStream for bridging callbacks
7. **Avoid manual sleep loops** - use AsyncTimerSequence instead

---

## Further Learning

- [AsyncAlgorithms Documentation](https://github.com/apple/swift-async-algorithms)
- [Combine Migration Guide](migration.md)
- [Async Sequences](async-sequences.md)
- [Tasks](tasks.md) - Task groups and structured concurrency
