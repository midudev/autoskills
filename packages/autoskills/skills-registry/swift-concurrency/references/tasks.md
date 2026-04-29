# Tasks

Use this when:

- You need to start async work from synchronous code.
- You are choosing between `Task`, `async let`, and task groups.
- You need cancellation, priorities, or structured vs unstructured guidance.

Skip this file if:

- The problem is mainly actor isolation or sendability. Use `actors.md` or `sendable.md`.
- The work is stream-shaped. Use `async-sequences.md` or `async-algorithms.md`.

Jump to:

- What is a Task?
- Cancellation
- Task Groups
- Discarding Task Groups
- Advanced: Task Timeout Pattern
- SwiftUI Integration
- Structured vs Unstructured Tasks
- Task Priorities

## What is a Task?

Tasks bridge synchronous and asynchronous contexts. They start executing immediately upon creation—no `resume()` needed.

```swift
func synchronousMethod() {
    Task {
        await someAsyncMethod()
    }
}
```

## Task References

Storing a reference is optional but enables cancellation and result waiting:

```swift
final class ImageLoader {
    var loadTask: Task<UIImage, Error>?
    
    func load() {
        loadTask = Task {
            try await fetchImage()
        }
    }
    
    deinit {
        loadTask?.cancel()
    }
}
```

Tasks run regardless of whether you keep a reference.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.1: Introduction to tasks in Swift Concurrency](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Cancellation

### Checking for cancellation

Tasks must manually check for cancellation:

```swift
// Throws CancellationError if canceled
try Task.checkCancellation()

// Boolean check for custom handling
guard !Task.isCancelled else {
    return fallbackValue
}
```

### Where to check

Add checks at natural breakpoints:

```swift
let task = Task {
    // Before expensive work
    try Task.checkCancellation()
    
    let data = try await URLSession.shared.data(from: url)
    
    // After network, before processing
    try Task.checkCancellation()
    
    return processData(data)
}
```

### Child task cancellation

Canceling a parent automatically notifies all children:

```swift
let parent = Task {
    async let child1 = work(1)
    async let child2 = work(2)
    let results = try await [child1, child2]
}

parent.cancel() // Both children notified
```

Children must still check `Task.isCancelled` to stop work.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.2: Task cancellation](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Error Handling

Task error types are inferred from the operation:

```swift
// Can throw
let throwingTask: Task<String, Error> = Task {
    throw URLError(.badURL)
}

// Cannot throw
let nonThrowingTask: Task<String, Never> = Task {
    "Success"
}
```

### Awaiting results

```swift
do {
    let result = try await task.value
} catch {
    // Handle error
}
```

### Handling errors internally

```swift
let safeTask: Task<String, Never> = Task {
    do {
        return try await riskyOperation()
    } catch {
        return "Fallback value"
    }
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.3: Error handling in Tasks](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## SwiftUI Integration

### The .task modifier

Automatically manages task lifetime with view lifecycle:

```swift
struct ContentView: View {
    @State private var data: Data?
    
    var body: some View {
        Text(data?.description ?? "Loading...")
            .task {
                data = try? await fetchData()
            }
    }
}
```

Task cancels automatically when view disappears.

### Reacting to value changes

```swift
.task(id: searchQuery) {
    await performSearch(searchQuery)
}
```

When `searchQuery` changes:
1. Previous task cancels
2. New task starts with updated value

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.12: Running tasks in SwiftUI](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

### Priority configuration

```swift
// High priority (default for SwiftUI)
.task(priority: .userInitiated) {
    await fetchUserData()
}

// Lower priority for background work
.task(priority: .low) {
    await trackAnalytics()
}
```

## Task Groups

Dynamic parallel task execution with compile-time unknown task count.

### Basic usage

```swift
await withTaskGroup(of: UIImage.self) { group in
    for url in photoURLs {
        group.addTask {
            await downloadPhoto(url: url)
        }
    }
}
```

### Collecting results

```swift
let images = await withTaskGroup(of: UIImage.self) { group in
    for url in photoURLs {
        group.addTask { await downloadPhoto(url: url) }
    }
    
    return await group.reduce(into: []) { $0.append($1) }
}
```

### Error handling

```swift
let images = try await withThrowingTaskGroup(of: UIImage.self) { group in
    for url in photoURLs {
        group.addTask { try await downloadPhoto(url: url) }
    }
    
    // Iterate to propagate errors
    var results: [UIImage] = []
    for try await image in group {
        results.append(image)
    }
    return results
}
```

**Critical**: Errors in child tasks don't automatically fail the group. Use iteration (`for try await`, `next()`, `reduce()`) to propagate errors.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.5: Task Groups](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

### Early termination on error

```swift
try await withThrowingTaskGroup(of: Data.self) { group in
    for id in ids {
        group.addTask { try await fetch(id) }
    }
    
    // First error cancels remaining tasks
    while let data = try await group.next() {
        process(data)
    }
}
```

### Cancellation

```swift
await withTaskGroup(of: Result.self) { group in
    for item in items {
        group.addTask { await process(item) }
    }
    
    // Cancel all remaining tasks
    group.cancelAll()
}
```

Or prevent adding to canceled group:

```swift
let didAdd = group.addTaskUnlessCancelled {
    await work()
}
```

## Discarding Task Groups

For fire-and-forget operations where results don't matter:

```swift
await withDiscardingTaskGroup { group in
    group.addTask { await logEvent("user_login") }
    group.addTask { await preloadCache() }
    group.addTask { await syncAnalytics() }
}
```

### Benefits

- More memory efficient (doesn't store results)
- No `next()` calls needed
- Automatically waits for completion
- Ideal for side effects

### Error handling

```swift
try await withThrowingDiscardingTaskGroup { group in
    group.addTask { try await uploadLog() }
    group.addTask { try await syncSettings() }
}
// First error cancels group and throws
```

### Real-world pattern: Multiple notifications

```swift
extension NotificationCenter {
    func notifications(named names: [Notification.Name]) -> AsyncStream<()> {
        AsyncStream { continuation in
            let task = Task {
                await withDiscardingTaskGroup { group in
                    for name in names {
                        group.addTask {
                            for await _ in self.notifications(named: name) {
                                continuation.yield(())
                            }
                        }
                    }
                }
                continuation.finish()
            }
            
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}

// Usage
for await _ in NotificationCenter.default.notifications(
    named: [.userDidLogin, UIApplication.didBecomeActiveNotification]
) {
    refreshData()
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.6: Discarding Task Groups](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Structured vs Unstructured Tasks

### Structured (preferred)

Bound to parent, inherit context, automatic cancellation:

```swift
// async let
async let data1 = fetch(1)
async let data2 = fetch(2)
let results = await [data1, data2]

// Task groups
await withTaskGroup(of: Data.self) { group in
    group.addTask { await fetch(1) }
    group.addTask { await fetch(2) }
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.7: The difference between structured and unstructured tasks](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

### Unstructured (use sparingly)

Independent lifecycle, manual cancellation:

```swift
// Regular task (unstructured but inherits priority)
let task = Task {
    await doWork()
}

// Detached task (completely independent)
Task.detached(priority: .background) {
    await cleanup()
}
```

## Detached Tasks

**Use as last resort.** They don't inherit:
- Priority
- Task-local values
- Cancellation state

```swift
Task.detached(priority: .background) {
    await DirectoryCleaner.cleanup()
}
```

### When to use

- Independent background work
- No connection to parent needed
- Acceptable to complete after parent cancels
- No `self` references needed

**Prefer**: Task groups or `async let` for most parallel work.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.4: Detached Tasks](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Task Priorities

### Available priorities

```swift
.high           // Immediate user feedback
.userInitiated  // User-triggered work (same as .high)
.medium         // Default for detached tasks
.utility        // Longer-running, non-urgent
.low            // Similar to .background
.background     // Lowest priority
```

### Setting priority

```swift
Task(priority: .background) {
    await prefetchData()
}
```

### Priority inheritance

Structured tasks inherit parent priority:

```swift
Task(priority: .high) {
    async let result = work() // Also .high
    await result
}
```

Detached tasks don't inherit:

```swift
Task(priority: .high) {
    Task.detached {
        // Runs at .medium (default)
    }
}
```

### Priority escalation

System automatically elevates priority to prevent priority inversion:
- Actor waiting on lower-priority task
- High-priority task awaiting `.value` of lower-priority task

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.8: Managing Task priorities](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Task.sleep() vs Task.yield()

### Task.sleep()

Suspends for fixed duration, non-blocking:

```swift
try await Task.sleep(for: .seconds(5))
```

**Use for:**
- Debouncing user input
- Polling intervals
- Rate limiting
- Artificial delays

**Respects cancellation** (throws `CancellationError`)

### Task.yield()

Temporarily suspends to allow other tasks to run:

```swift
await Task.yield()
```

**Use for:**
- Testing async code
- Allowing cooperative scheduling

**Note**: If current task is highest priority, may resume immediately.

### Practical: Debounced search

```swift
func search(_ query: String) async {
    guard !query.isEmpty else {
        searchResults = allResults
        return
    }
    
    do {
        try await Task.sleep(for: .milliseconds(500))
        searchResults = allResults.filter { $0.contains(query) }
    } catch {
        // Canceled (user kept typing)
    }
}

// In SwiftUI
.task(id: searchQuery) {
    await searcher.search(searchQuery)
}
```

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.10: Task.yield() vs. Task.sleep()](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## async let vs TaskGroup

| Feature | async let | TaskGroup |
|---------|-----------|-----------|
| Task count | Fixed at compile-time | Dynamic at runtime |
| Syntax | Lightweight | More verbose |
| Cancellation | Automatic on scope exit | Manual via `cancelAll()` |
| Use when | 2-5 known parallel tasks | Loop-based parallel work |

```swift
// async let: Known task count
async let user = fetchUser()
async let settings = fetchSettings()
let profile = Profile(user: await user, settings: await settings)

// TaskGroup: Dynamic task count
await withTaskGroup(of: Image.self) { group in
    for url in urls {
        group.addTask { await download(url) }
    }
}
```

## Advanced: Task Timeout Pattern

Create timeout wrapper using task groups:

```swift
func withTimeout<T>(
    _ duration: Duration,
    operation: @Sendable @escaping () async throws -> T
) async throws -> T {
    try await withThrowingTaskGroup(of: T.self) { group in
        group.addTask { try await operation() }
        
        group.addTask {
            try await Task.sleep(for: duration)
            throw TimeoutError()
        }
        
        guard let result = try await group.next() else {
            throw TimeoutError()
        }
        
        group.cancelAll()
        return result
    }
}

// Usage
let data = try await withTimeout(.seconds(5)) {
    try await slowNetworkRequest()
}
```

**`cancelAll()` is critical** — without it, the losing task keeps running until scope exit.

`Task.sleep` throws `CancellationError` when the task is cancelled, making it a useful cancellation checkpoint in polling loops. `Task.yield()` only gives other tasks a chance to run and does not check cancellation — if the current task has the highest priority, it may resume immediately.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 3.14: Creating a Task timeout handler using a Task Group (advanced)](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Common Patterns

### Sequential with early exit

```swift
let user = try await fetchUser()
guard user.isActive else { return }

let posts = try await fetchPosts(userId: user.id)
```

### Parallel independent work

```swift
async let user = fetchUser()
async let settings = fetchSettings()
async let notifications = fetchNotifications()

let data = try await (user, settings, notifications)
```

### Mixed: Sequential then parallel

```swift
let user = try await fetchUser()

async let posts = fetchPosts(userId: user.id)
async let followers = fetchFollowers(userId: user.id)

let profile = Profile(
    user: user,
    posts: try await posts,
    followers: try await followers
)
```

## Common Mistakes Agents Make

- Replacing structured child work with many unrelated top-level tasks.
- Using `Task.detached` just to "make it background."
- Ignoring cancellation in long-running operations.
- Keeping a stored task forever without a clear owner or cleanup path.
- Priorities are hints, not guarantees. The system automatically elevates priority to prevent inversion (e.g., a high-priority task awaiting `.value` of a lower-priority task). Do not rely on priority for correctness.

## Best Practices

1. **Check cancellation regularly** in long-running tasks
2. **Use structured concurrency** (avoid detached tasks)
3. **Leverage SwiftUI's `.task` modifier** for view-bound work
4. **Choose the right tool**: `async let` for fixed, TaskGroup for dynamic
5. **Handle errors explicitly** in throwing task groups
6. **Set priority only when needed** (inherit by default)
7. **Don't mutate task groups** from outside their creation context

## Further Learning

For hands-on examples, advanced patterns, and migration strategies, see [Swift Concurrency Course](https://www.swiftconcurrencycourse.com).

