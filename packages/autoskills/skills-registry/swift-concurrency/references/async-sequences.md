# Async Sequences and Streams

Use this when:

- You need to iterate over values that arrive over time.
- You are bridging callback-based or delegate-based APIs to async/await.
- You need to choose between `AsyncSequence`, `AsyncStream`, or a regular async method.

Skip this file if:

- You need time-based operators like debounce, throttle, or merge. Use `async-algorithms.md`.
- You are choosing between `Task`, `async let`, or task groups. Use `tasks.md`.

Jump to:

- AsyncSequence Protocol
- AsyncStream / AsyncThrowingStream
- Bridging Callbacks and Delegates
- Stream Lifecycle and Cleanup
- Buffer Policies
- Standard Library Integration
- Limitations
- When to Use AsyncAlgorithms

## AsyncSequence

Protocol for asynchronous iteration over values that become available over time.

### Basic usage

```swift
for await value in someAsyncSequence {
    print(value)
}
```

**Key difference from Sequence**: Values may not all be available immediately.

### Custom implementation

```swift
struct Counter: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Int
    
    let limit: Int
    var current = 1
    
    mutating func next() async -> Int? {
        guard !Task.isCancelled else { return nil }
        guard current <= limit else { return nil }
        
        let result = current
        current += 1
        return result
    }
    
    func makeAsyncIterator() -> Counter {
        self
    }
}

// Usage
for await count in Counter(limit: 5) {
    print(count) // 1, 2, 3, 4, 5
}
```

### Standard operators

Same functional operators as regular sequences:

```swift
// Filter
for await even in Counter(limit: 5).filter({ $0 % 2 == 0 }) {
    print(even) // 2, 4
}

// Map
let mapped = Counter(limit: 5).map { $0 % 2 == 0 ? "Even" : "Odd" }
for await label in mapped {
    print(label)
}

// Contains (awaits until found or sequence ends)
let contains = await Counter(limit: 5).contains(3) // true
```

### Termination

Return `nil` from `next()` to end iteration:

```swift
mutating func next() async -> Int? {
    guard !Task.isCancelled else {
        return nil // Stop on cancellation
    }
    
    guard current <= limit else {
        return nil // Stop at limit
    }
    
    return current
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 6.1: Working with asynchronous sequences](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## AsyncStream

Convenient way to create async sequences without implementing protocols.

### Basic creation

```swift
let stream = AsyncStream<Int> { continuation in
    for i in 1...5 {
        continuation.yield(i)
    }
    continuation.finish()
}

for await value in stream {
    print(value)
}
```

### AsyncThrowingStream

For streams that can fail:

```swift
let throwingStream = AsyncThrowingStream<Int, Error> { continuation in
    continuation.yield(1)
    continuation.yield(2)
    continuation.finish(throwing: SomeError())
}

do {
    for try await value in throwingStream {
        print(value)
    }
} catch {
    print("Error: \(error)")
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 6.2: Using AsyncStream and AsyncThrowingStream in your code](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Bridging Closures to Streams

### Progress + completion handlers

```swift
// Old closure-based API
struct FileDownloader {
    enum Status {
        case downloading(Float)
        case finished(Data)
    }
    
    func download(
        _ url: URL,
        progressHandler: @escaping (Float) -> Void,
        completion: @escaping (Result<Data, Error>) -> Void
    ) throws {
        // Implementation
    }
}

// Modern stream-based API
extension FileDownloader {
    func download(_ url: URL) -> AsyncThrowingStream<Status, Error> {
        AsyncThrowingStream { continuation in
            do {
                try self.download(url, progressHandler: { progress in
                    continuation.yield(.downloading(progress))
                }, completion: { result in
                    switch result {
                    case .success(let data):
                        continuation.yield(.finished(data))
                        continuation.finish()
                    case .failure(let error):
                        continuation.finish(throwing: error)
                    }
                })
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }
}

// Usage
for try await status in downloader.download(url) {
    switch status {
    case .downloading(let progress):
        print("Progress: \(progress)")
    case .finished(let data):
        print("Done: \(data.count) bytes")
    }
}
```

### Simplified with Result

```swift
AsyncThrowingStream { continuation in
    try self.download(url, progressHandler: { progress in
        continuation.yield(.downloading(progress))
    }, completion: { result in
        continuation.yield(with: result.map { .finished($0) })
        continuation.finish()
    })
}
```

## Bridging Delegates

### Location updates example

```swift
final class LocationMonitor: NSObject {
    private var continuation: AsyncThrowingStream<CLLocation, Error>.Continuation?
    let stream: AsyncThrowingStream<CLLocation, Error>
    
    override init() {
        var capturedContinuation: AsyncThrowingStream<CLLocation, Error>.Continuation?
        stream = AsyncThrowingStream { continuation in
            capturedContinuation = continuation
        }
        super.init()
        self.continuation = capturedContinuation
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension LocationMonitor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            continuation?.yield(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.finish(throwing: error)
    }
}

// Usage
let monitor = LocationMonitor()
for try await location in monitor.stream {
    print("Location: \(location.coordinate)")
}
```

## Stream Lifecycle

### Termination callback

```swift
AsyncThrowingStream<Int, Error> { continuation in
    continuation.onTermination = { @Sendable reason in
        print("Terminated: \(reason)")
        // Cleanup: remove observers, cancel work, etc.
    }
    
    continuation.yield(1)
    continuation.finish()
}
```

**Termination reasons**:
- `.finished` - Normal completion
- `.finished(Error?)` - Completed with error (throwing stream)
- `.cancelled` - Task canceled

### Cancellation

Streams cancel when:
- Enclosing task cancels
- Stream goes out of scope

```swift
let task = Task {
    for try await status in download(url) {
        print(status)
    }
}

task.cancel() // Triggers onTermination with .cancelled
```

**No explicit cancel method** - rely on task cancellation.

## Buffer Policies

Control what happens to values when no one is awaiting:

### .unbounded (default)

Buffers all values until consumed:

```swift
let stream = AsyncStream<Int> { continuation in
    (0...5).forEach { continuation.yield($0) }
    continuation.finish()
}

try await Task.sleep(for: .seconds(1))

for await value in stream {
    print(value) // Prints all: 0, 1, 2, 3, 4, 5
}
```

### .bufferingNewest(n)

Keeps only the newest N values:

```swift
let stream = AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
    (0...5).forEach { continuation.yield($0) }
    continuation.finish()
}

try await Task.sleep(for: .seconds(1))

for await value in stream {
    print(value) // Prints only: 5
}
```

### .bufferingOldest(n)

Keeps only the oldest N values:

```swift
let stream = AsyncStream(bufferingPolicy: .bufferingOldest(1)) { continuation in
    (0...5).forEach { continuation.yield($0) }
    continuation.finish()
}

try await Task.sleep(for: .seconds(1))

for await value in stream {
    print(value) // Prints only: 0
}
```

### .bufferingNewest(0)

Only receives values emitted after iteration starts:

```swift
let stream = AsyncStream(bufferingPolicy: .bufferingNewest(0)) { continuation in
    continuation.yield(1) // Discarded
    
    Task {
        try await Task.sleep(for: .seconds(2))
        continuation.yield(2) // Received
        continuation.finish()
    }
}

try await Task.sleep(for: .seconds(1))

for await value in stream {
    print(value) // Prints only: 2
}
```

**Use case**: Location updates, file system changes - only care about latest.

## Repeated Async Calls

Use `init(unfolding:onCancel:)` for polling:

```swift
struct PingService {
    func startPinging() -> AsyncStream<Bool> {
        AsyncStream {
            try? await Task.sleep(for: .seconds(5))
            return await ping()
        } onCancel: {
            print("Pinging cancelled")
        }
    }
    
    func ping() async -> Bool {
        // Network request
        return true
    }
}

// Usage
for await result in pingService.startPinging() {
    print("Ping: \(result)")
}
```

## Standard Library Integration

### NotificationCenter

```swift
let stream = NotificationCenter.default.notifications(
    named: .NSSystemTimeZoneDidChange
)

for await notification in stream {
    print("Time zone changed")
}
```

### Combine publishers

```swift
let numbers = [1, 2, 3, 4, 5]
let filtered = numbers.publisher.filter { $0 % 2 == 0 }

for await number in filtered.values {
    print(number) // 2, 4
}
```

### Task groups

```swift
await withTaskGroup(of: Image.self) { group in
    for url in urls {
        group.addTask { await download(url) }
    }
    
    for await image in group {
        display(image)
    }
}
```

## Limitations

### Single consumer only

Unlike Combine, streams support one consumer at a time:

```swift
let stream = AsyncStream { continuation in
    (0...5).forEach { continuation.yield($0) }
    continuation.finish()
}

Task {
    for await value in stream {
        print("Consumer 1: \(value)")
    }
}

Task {
    for await value in stream {
        print("Consumer 2: \(value)")
    }
}

// Unpredictable output - values split between consumers
// Consumer 1: 0
// Consumer 2: 1
// Consumer 1: 2
// Consumer 2: 3
```

**Solution**: Create separate streams or use third-party libraries (AsyncExtensions).

### No values after termination

Once finished, stream won't emit new values:

```swift
let stream = AsyncStream<Int> { continuation in
    continuation.finish() // Terminate immediately
    continuation.yield(1) // Never received
}

for await value in stream {
    print(value) // Loop exits immediately
}
```

## Decision Guide

### Use AsyncSequence when:

- Implementing standard library-style protocols
- Need fine-grained control over iteration
- Building reusable sequence types
- Working with existing sequence protocols

**Reality**: Rarely needed in application code.

### Use AsyncStream when:

- Bridging delegates to async/await
- Converting closure-based APIs
- Emitting events manually
- Polling or repeated async operations
- Most common use case

---

## When to Use AsyncAlgorithms vs Standard Library

### Use AsyncAlgorithms when:

- **Time-based operations** need debounce/throttle/timer
- **Combining multiple async sequences** (merge, combineLatest, zip)
- **Multi-consumer scenarios** require backpressure (AsyncChannel)
- **Complex operator chains** that Combine would handle naturally
- **Need specific operators** not in standard library

### Use Standard Library when:

- **Bridging callback APIs** → AsyncStream
- **Simple iteration** → for await in sequence
- **Single-value operations** → async/await
- **Basic transformations** → map/filter/contains

### Quick Decision Table

| Need | Solution |
|------|----------|
| Debounce search input | ✅ AsyncAlgorithms.debounce() |
| Throttle button clicks | ✅ AsyncAlgorithms.throttle() |
| Merge independent streams | ✅ AsyncAlgorithms.merge() |
| Combine dependent values | ✅ AsyncAlgorithms.combineLatest() or async let |
| Pair values from two sources | ✅ AsyncAlgorithms.zip() |
| Bridge callback API | AsyncStream |
| Multi-consumer with backpressure | ✅ AsyncChannel |
| Periodic timer | ✅ AsyncTimerSequence |
| Simple async iteration | for await in... |

> **See**: [async-algorithms.md](async-algorithms.md) for detailed usage examples with real-world patterns.

### Use regular async methods when:

- Single value returned
- No progress updates needed
- Simple request/response pattern

```swift
// Use this
func fetchData() async throws -> Data

// Not this
func fetchData() -> AsyncThrowingStream<Data, Error>

> **Course Deep Dive**: This topic is covered in detail in [Lesson 6.3: Deciding between AsyncSequence, AsyncStream, or regular asynchronous methods](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)
```

## Common Patterns

### Progress reporting

```swift
func download(_ url: URL) -> AsyncThrowingStream<DownloadEvent, Error> {
    AsyncThrowingStream { continuation in
        Task {
            do {
                var progress: Double = 0
                while progress < 1.0 {
                    progress += 0.1
                    continuation.yield(.progress(progress))
                    try await Task.sleep(for: .milliseconds(100))
                }
                
                let data = try await URLSession.shared.data(from: url).0
                continuation.yield(.completed(data))
                continuation.finish()
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }
}
```

### Monitoring file system

```swift
func watchDirectory(_ path: String) -> AsyncStream<FileEvent> {
    AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fd,
            eventMask: .write,
            queue: .main
        )
        
        source.setEventHandler {
            continuation.yield(.fileChanged(path))
        }
        
        continuation.onTermination = { _ in
            source.cancel()
        }
        
        source.resume()
    }
}
```

### Timer/polling

```swift
func timer(interval: Duration) -> AsyncStream<Date> {
    AsyncStream { continuation in
        Task {
            while !Task.isCancelled {
                continuation.yield(Date())
                try? await Task.sleep(for: interval)
            }
            continuation.finish()
        }
    }
}

// Usage
for await date in timer(interval: .seconds(1)) {
    print("Tick: \(date)")
}
```

## Best Practices

1. **Always call finish()** - Streams stay alive until terminated
2. **Use buffer policies wisely** - Match your use case (latest value vs all values)
3. **Handle cancellation** - Set `onTermination` for cleanup
4. **Single consumer** - Don't share streams across multiple consumers
5. **Prefer streams over closures** - More composable and cancellable
6. **Check Task.isCancelled** - Respect cancellation in custom sequences
7. **Use throwing variant** - When operations can fail
8. **Consider regular async** - If only returning single value

## Debugging

### Add termination logging

```swift
continuation.onTermination = { reason in
    print("Stream ended: \(reason)")
}
```

### Validate finish() calls

```swift
// ❌ Forgot to finish
AsyncStream { continuation in
    continuation.yield(1)
    // Stream never ends!
}

// ✅ Always finish
AsyncStream { continuation in
    continuation.yield(1)
    continuation.finish()
}
```

### Check for dropped values

```swift
let stream = AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
    for i in 1...100 {
        continuation.yield(i)
        print("Yielded: \(i)")
    }
    continuation.finish()
}

// If consumer is slow, many values dropped
for await value in stream {
    print("Received: \(value)")
    try? await Task.sleep(for: .seconds(1))
}
```

## Common Mistakes Agents Make

```swift
// ❌ Values after finish() are silently dropped
continuation.finish()
continuation.yield(1) // Never received

// ❌ Stream never terminates (forgot finish)
AsyncStream { continuation in
    continuation.yield(1)
    // Missing: continuation.finish()
}

// ❌ Wrapping a single-value API in a stream — use a regular async function instead
func fetchUser() -> AsyncStream<User> { ... } // Overkill for one result
```

- **Sharing a single `AsyncStream` between multiple consumers**: Values split unpredictably. There is no built-in broadcast; use `AsyncChannel` for point-to-point multi-consumer patterns.
- **Forgetting `onTermination`** when bridging delegate or observer APIs, causing resources to leak.

## Further Learning

For real-world migration examples, performance patterns, and advanced stream techniques, see [Swift Concurrency Course](https://www.swiftconcurrencycourse.com).

