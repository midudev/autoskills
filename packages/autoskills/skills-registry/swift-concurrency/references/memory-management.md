# Memory Management

Use this when:

- A task or async sequence is keeping objects alive longer than expected.
- You suspect a retain cycle between a task and its owner.
- You need to verify deallocation behavior or use `isolated deinit`.

Skip this file if:

- You mainly need to protect mutable state from races. Use `actors.md`.
- You are debugging slow async code. Use `performance.md`.

Jump to:

- Core Concepts (Task Capture)
- Retain Cycles
- One-Way Retention
- Async Sequences and Retention
- Isolated Deinit (Swift 6.2+)
- Detection and Testing
- Common Patterns

## Core Concepts

### Tasks capture like closures

Tasks capture variables and references just like regular closures. Swift doesn't automatically prevent retain cycles in concurrent code.

```swift
Task {
    self.doWork() // ⚠️ Strong capture of self
}
```

### Why concurrency hides memory issues

- Tasks may live longer than expected
- Async operations delay execution
- Harder to track when memory should be released
- Long-running tasks can hold references indefinitely

> **Course Deep Dive**: This topic is covered in detail in [Lesson 8.1: Overview of memory management in Swift Concurrency](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Retain Cycles

### What is a retain cycle?

Two or more objects hold strong references to each other, preventing deallocation.

```swift
class A {
    var b: B?
}

class B {
    var a: A?
}

let a = A()
let b = B()
a.b = b
b.a = a // Retain cycle - neither can be deallocated
```

### Retain cycles with Tasks

When task captures `self` strongly and `self` owns the task:

```swift
@MainActor
final class ImageLoader {
    var task: Task<Void, Never>?
    
    func startPolling() {
        task = Task {
            while true {
                self.pollImages() // ⚠️ Strong capture
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }
}

var loader: ImageLoader? = .init()
loader?.startPolling()
loader = nil // ⚠️ Loader never deallocated - retain cycle!
```

**Problem**: Task holds `self`, `self` holds task → neither released.

## Breaking Retain Cycles

### Use weak self

```swift
func startPolling() {
    task = Task { [weak self] in
        while let self = self {
            self.pollImages()
            try? await Task.sleep(for: .seconds(1))
        }
    }
}

var loader: ImageLoader? = .init()
loader?.startPolling()
loader = nil // ✅ Loader deallocated, task stops
```

### Pattern for long-running tasks

```swift
task = Task { [weak self] in
    while let self = self {
        await self.doWork()
        try? await Task.sleep(for: interval)
    }
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 8.2: Preventing retain cycles when using Tasks](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

Loop exits when `self` becomes `nil`.

## One-Way Retention

Task retains `self`, but `self` doesn't retain task. Object stays alive until task completes.

```swift
@MainActor
final class ViewModel {
    func fetchData() {
        Task {
            await performRequest()
            updateUI() // ⚠️ Strong capture
        }
    }
}

var viewModel: ViewModel? = .init()
viewModel?.fetchData()
viewModel = nil // ViewModel stays alive until task completes
```

**Execution order**:
1. Task starts
2. `viewModel = nil` (but object not deallocated)
3. Task completes
4. ViewModel finally deallocated

### When one-way retention is acceptable

Short-lived tasks that complete quickly:

```swift
func saveData() {
    Task {
        await database.save(self.data) // OK - completes quickly
    }
}
```

### When to use weak self

Long-running or indefinite tasks:

```swift
func startMonitoring() {
    Task { [weak self] in
        for await event in eventStream {
            self?.handle(event)
        }
    }
}
```

## Async Sequences and Retention

### Problem: Infinite sequences

```swift
@MainActor
final class AppLifecycleViewModel {
    private(set) var isActive = false
    private var task: Task<Void, Never>?
    
    func startObserving() {
        task = Task {
            for await _ in NotificationCenter.default.notifications(
                named: .didBecomeActive
            ) {
                isActive = true // ⚠️ Strong capture, never ends
            }
        }
    }
}

var viewModel: AppLifecycleViewModel? = .init()
viewModel?.startObserving()
viewModel = nil // ⚠️ Never deallocated - sequence continues
```

**Problem**: Async sequence never finishes, task holds `self` indefinitely.

### Solution 1: Manual cancellation

```swift
func startObserving() {
    task = Task {
        for await _ in NotificationCenter.default.notifications(
            named: .didBecomeActive
        ) {
            isActive = true
        }
    }
}

func stopObserving() {
    task?.cancel()
}

// Usage
viewModel?.startObserving()
viewModel?.stopObserving() // Must call before release
viewModel = nil
```

### Solution 2: Weak self with guard

```swift
func startObserving() {
    task = Task { [weak self] in
        for await _ in NotificationCenter.default.notifications(
            named: .didBecomeActive
        ) {
            guard let self = self else { return }
            self.isActive = true
        }
    }
}
```

Task exits when `self` deallocates.

## Isolated deinit (Swift 6.2+)

Clean up actor-isolated state in deinit:

```swift
@MainActor
final class ViewModel {
    private var task: Task<Void, Never>?
    
    isolated deinit {
        task?.cancel()
    }
}
```

**Limitation**: Won't break retain cycles (deinit never called if cycle exists).

**Use for**: Cleanup when object is being deallocated normally.

## Common Patterns

### Short-lived task (strong capture OK)

```swift
func saveData() {
    Task {
        await database.save(self.data)
        self.updateUI()
    }
}
```

**When safe**: Task completes quickly, acceptable for object to live until done.

### Long-running task (weak self required)

```swift
func startPolling() {
    task = Task { [weak self] in
        while let self = self {
            await self.fetchUpdates()
            try? await Task.sleep(for: .seconds(5))
        }
    }
}
```

### Async sequence monitoring (weak self + guard)

```swift
func startMonitoring() {
    task = Task { [weak self] in
        for await event in eventStream {
            guard let self = self else { return }
            self.handle(event)
        }
    }
}
```

### Cancellable work with cleanup

```swift
func startWork() {
    task = Task { [weak self] in
        defer { self?.cleanup() }
        
        while let self = self {
            await self.doWork()
            try? await Task.sleep(for: .seconds(1))
        }
    }
}
```

## Detection Strategies

### Add deinit logging

```swift
deinit {
    print("✅ \(type(of: self)) deallocated")
}
```

If deinit never prints → likely retain cycle.

### Memory graph debugger

1. Run app in Xcode
2. Debug → Debug Memory Graph
3. Look for cycles in object graph

### Instruments

Use Leaks instrument to detect retain cycles at runtime.

## Decision Tree

```
Task captures self?
├─ Task completes quickly?
│  └─ Strong capture OK
│
├─ Long-running or infinite?
│  ├─ Can use weak self? → Use [weak self]
│  ├─ Need manual control? → Store task, cancel explicitly
│  └─ Async sequence? → [weak self] + guard
│
└─ Self owns task?
   ├─ Yes → High risk of retain cycle
   └─ No → Lower risk, but check lifetime
```

## Best Practices

1. **Default to weak self** for long-running tasks
2. **Use guard let self** in async sequences
3. **Cancel tasks explicitly** when possible
4. **Add deinit logging** during development
5. **Test object deallocation** in unit tests
6. **Use Memory Graph** to verify no cycles
7. **Document lifetime expectations** in comments
8. **Prefer cancellation** over weak self when possible
9. **Avoid nested strong captures** in task closures
10. **Use isolated deinit** for cleanup (Swift 6.2+)

## Testing for Leaks

### Unit test pattern

```swift
func testViewModelDeallocates() async {
    var viewModel: ViewModel? = ViewModel()
    weak var weakViewModel = viewModel
    
    viewModel?.startWork()
    viewModel = nil
    
    // Give tasks time to complete
    try? await Task.sleep(for: .milliseconds(100))
    
    XCTAssertNil(weakViewModel, "ViewModel should be deallocated")
}
```

### SwiftUI view test

```swift
func testViewDeallocates() {
    var view: MyView? = MyView()
    weak var weakView = view
    
    view = nil
    
    XCTAssertNil(weakView)
}
```

## Common Mistakes

### ❌ Forgetting weak self in loops

```swift
Task {
    while true {
        self.poll() // Retain cycle
        try? await Task.sleep(for: .seconds(1))
    }
}
```

### ❌ Strong capture in async sequences

```swift
Task {
    for await item in stream {
        self.process(item) // May never release
    }
}
```

### ❌ Not canceling stored tasks

```swift
class Manager {
    var task: Task<Void, Never>?
    
    func start() {
        task = Task {
            await self.work() // Retain cycle
        }
    }
    
    // Missing: deinit { task?.cancel() }
}
```

### ❌ Assuming deinit breaks cycles

```swift
deinit {
    task?.cancel() // Never called if retain cycle exists
}
```

## Examples by Use Case

### Polling service

```swift
final class PollingService {
    private var task: Task<Void, Never>?
    
    func start() {
        task = Task { [weak self] in
            while let self = self {
                await self.poll()
                try? await Task.sleep(for: .seconds(5))
            }
        }
    }
    
    func stop() {
        task?.cancel()
    }
}
```

### Notification observer

```swift
@MainActor
final class NotificationObserver {
    private var task: Task<Void, Never>?
    
    func startObserving() {
        task = Task { [weak self] in
            for await notification in NotificationCenter.default.notifications(
                named: .someNotification
            ) {
                guard let self = self else { return }
                self.handle(notification)
            }
        }
    }
    
    isolated deinit {
        task?.cancel()
    }
}
```

### Download manager

```swift
final class DownloadManager {
    private var tasks: [URL: Task<Data, Error>] = [:]
    
    func download(_ url: URL) async throws -> Data {
        let task = Task { [weak self] in
            defer { self?.tasks.removeValue(forKey: url) }
            return try await URLSession.shared.data(from: url).0
        }
        
        tasks[url] = task
        return try await task.value
    }
    
    func cancelAll() {
        tasks.values.forEach { $0.cancel() }
        tasks.removeAll()
    }
}
```

### Timer

```swift
actor Timer {
    private var task: Task<Void, Never>?
    
    func start(interval: Duration, action: @Sendable () async -> Void) {
        task = Task {
            while !Task.isCancelled {
                await action()
                try? await Task.sleep(for: interval)
            }
        }
    }
    
    func stop() {
        task?.cancel()
    }
}
```

## Common Mistakes Agents Make

- **Forgetting `[weak self]` in stored tasks**: When `self` owns the task and the task captures `self`, a retain cycle prevents deallocation.
- **Strong capture in infinite `AsyncSequence` loops**: `for await` over an infinite sequence with a strong `self` capture keeps the object alive forever.
- **Not cancelling stored tasks on cleanup**: If the task outlives its owner, it retains captured objects indefinitely.
- **Assuming `isolated deinit` breaks retain cycles**: `isolated deinit` runs cleanup on the correct actor, but if a cycle prevents `deinit` from being called at all, the cleanup never executes.
- **Using `try?` in loops with `Task.sleep`**: `try?` can swallow `CancellationError`, causing the loop to continue running after cancellation. Always check `Task.isCancelled` explicitly.

## Debugging Checklist

When object won't deallocate:

- [ ] Check for strong self captures in tasks
- [ ] Verify tasks are canceled or complete
- [ ] Look for infinite loops or sequences
- [ ] Check if self owns the task
- [ ] Use Memory Graph to find cycles
- [ ] Add deinit logging to verify
- [ ] Test with weak references
- [ ] Review async sequence usage
- [ ] Check nested task captures
- [ ] Verify cleanup in deinit

## Further Learning

For migration strategies, real-world examples, and advanced memory patterns, see [Swift Concurrency Course](https://www.swiftconcurrencycourse.com).

