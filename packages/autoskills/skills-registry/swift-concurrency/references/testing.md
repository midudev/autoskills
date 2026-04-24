# Testing Concurrent Code

Use this when:

- You are writing async tests.
- A test is flaky because of task scheduling or actor isolation.
- You need to replace XCTest waiting APIs or verify deallocation.

Skip this file if:

- You mainly need production ownership guidance. Use `actors.md`, `tasks.md`, or `memory-management.md`.

Jump to:

- Swift Testing (Recommended)
- Awaiting Async Callbacks
- Setup and Teardown
- Handling Flaky Tests
- Swift Concurrency Extras
- XCTest Patterns (Legacy)
- Memory Management Tests
- Testing Checklist

## Recommendation: Use Swift Testing

**Swift Testing is strongly recommended** for new projects and tests. It provides:
- Modern Swift syntax with macros
- Better concurrency support
- Cleaner test structure
- More flexible test organization

XCTest patterns are included for legacy codebases.

## Swift Testing Basics

### Simple async test

```swift
@Test
@MainActor
func emptyQuery() async {
    let searcher = ArticleSearcher()
    await searcher.search("")
    #expect(searcher.results == ArticleSearcher.allArticles)
}
```

**Key differences from XCTest**:
- `@Test` macro instead of `XCTestCase`
- `#expect` instead of `XCTAssert`
- Structs preferred over classes
- No `test` prefix required

### Testing with actors

```swift
@Test
@MainActor
func searchReturnsResults() async {
    let searcher = ArticleSearcher()
    await searcher.search("swift")
    #expect(!searcher.results.isEmpty)
}
```

Mark test with actor if system under test requires it.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 11.2: Testing concurrent code using Swift Testing](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

## Awaiting Async Callbacks

### Using continuations

When testing unstructured tasks:

```swift
@Test
@MainActor
func searchTaskCompletes() async {
    let searcher = ArticleSearcher()
    
    await withCheckedContinuation { continuation in
        _ = withObservationTracking {
            searcher.results
        } onChange: {
            continuation.resume()
        }
        
        searcher.startSearchTask("swift")
    }
    
    #expect(searcher.results.count > 0)
}
```

**Use when**: Testing code that spawns unstructured tasks.

### Using confirmations

For structured async code:

```swift
@Test
@MainActor
func searchTriggersObservation() async {
    let searcher = ArticleSearcher()
    
    await confirmation { confirm in
        _ = withObservationTracking {
            searcher.results
        } onChange: {
            confirm()
        }
        
        // Must await here for confirmation to work
        await searcher.search("swift")
    }
    
    #expect(!searcher.results.isEmpty)
}
```

**Critical**: Must `await` async work for confirmation to validate.

## Setup and Teardown

### Using init/deinit

```swift
@MainActor
final class DatabaseTests {
    let database: Database
    
    init() async throws {
        database = Database()
        await database.prepare()
    }
    
    deinit {
        // Synchronous cleanup only
    }
    
    @Test
    func insertsData() async throws {
        try await database.insert(item)
        #expect(await database.count() == 1)
    }
}
```

**Limitation**: `deinit` cannot call async methods.

### Test Scoping Traits

For async teardown:

```swift
@MainActor
struct DatabaseTrait: SuiteTrait, TestTrait, TestScoping {
    func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: () async throws -> Void
    ) async throws {
        let database = Database()
        
        try await Environment.$database.withValue(database) {
            await database.prepare()
            try await function()
            await database.cleanup() // Async teardown
        }
    }
}

// Environment for task-local storage
@MainActor
struct Environment {
    @TaskLocal static var database = Database()
}

// Apply to suite
@Suite(DatabaseTrait())
@MainActor
final class DatabaseTests {
    @Test
    func insertsData() async throws {
        try await Environment.database.insert(item)
    }
}

// Or apply to individual test
@Test(DatabaseTrait())
func specificTest() async throws {
    // Test code
}
```

**Use when**: Need async cleanup after each test.

## Handling Flaky Tests

### Problem: Race conditions

```swift
@Test
@MainActor
func isLoadingState() async throws {
    let fetcher = ImageFetcher()
    
    let task = Task { try await fetcher.fetch(url) }
    
    // ❌ Flaky - may pass or fail
    #expect(fetcher.isLoading == true)
    
    try await task.value
    #expect(fetcher.isLoading == false)
}
```

**Issue**: Task may complete before we check `isLoading`.

### Solution: Swift Concurrency Extras

```swift
import ConcurrencyExtras

@Test
@MainActor
func isLoadingState() async throws {
    try await withMainSerialExecutor {
        let fetcher = ImageFetcher { url in
            await Task.yield() // Allow test to check state
            return Data()
        }
        
        let task = Task { try await fetcher.fetch(url) }
        
        await Task.yield() // Switch to task
        
        #expect(fetcher.isLoading == true) // ✅ Reliable
        
        try await task.value
        #expect(fetcher.isLoading == false)
    }
}
```

**Add package**: `https://github.com/pointfreeco/swift-concurrency-extras.git`

> **Course Deep Dive**: This topic is covered in detail in [Lesson 11.3: Using Swift Concurrency Extras by Point-Free](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

### Serial execution required

```swift
@Suite(.serialized)
@MainActor
final class ImageFetcherTests {
    // Tests run serially when using withMainSerialExecutor
}
```

**Critical**: Main serial executor doesn't work with parallel test execution.

## XCTest Patterns (Legacy)

### Basic async test

```swift
final class ArticleSearcherTests: XCTestCase {
    @MainActor
    func testEmptyQuery() async {
        let searcher = ArticleSearcher()
        await searcher.search("")
        XCTAssertEqual(searcher.results, ArticleSearcher.allArticles)
    }
}
```

### Using expectations

```swift
@MainActor
func testSearchTask() async {
    let searcher = ArticleSearcher()
    let expectation = expectation(description: "Search complete")
    
    _ = withObservationTracking {
        searcher.results
    } onChange: {
        expectation.fulfill()
    }
    
    searcher.startSearchTask("swift")
    
    // Use fulfillment, not wait
    await fulfillment(of: [expectation], timeout: 10)
    
    XCTAssertEqual(searcher.results.count, 1)
}
```

**Critical**: Use `await fulfillment(of:)`, not `wait(for:)` to avoid deadlocks.

### Setup and teardown

```swift
final class DatabaseTests: XCTestCase {
    override func setUp() async throws {
        // Async setup
    }
    
    override func tearDown() async throws {
        // Async teardown
    }
}
```

Mark as `async throws` to call async methods.

> **Course Deep Dive**: This topic is covered in detail in [Lesson 11.1: Testing concurrent code using XCTest](https://www.swiftconcurrencycourse.com?utm_source=github&utm_medium=agent-skill&utm_campaign=lesson-reference)

### Main serial executor for all tests

```swift
final class MyTests: XCTestCase {
    override func invokeTest() {
        withMainSerialExecutor {
            super.invokeTest()
        }
    }
}
```

## Common Patterns

### Testing @MainActor code

```swift
@Test
@MainActor
func viewModelUpdates() async {
    let viewModel = ViewModel()
    await viewModel.loadData()
    #expect(viewModel.items.count > 0)
}
```

### Testing actors

```swift
@Test
func actorIsolation() async {
    let store = DataStore()
    await store.insert(item)
    let count = await store.count()
    #expect(count == 1)
}
```

### Testing cancellation

```swift
@Test
func cancellationStopsWork() async throws {
    let processor = DataProcessor()
    
    let task = Task {
        try await processor.processLargeDataset()
    }
    
    task.cancel()
    
    do {
        try await task.value
        Issue.record("Should have thrown cancellation error")
    } catch is CancellationError {
        // Expected
    }
}
```

### Testing with delays

```swift
@Test
func debouncedSearch() async throws {
    try await withMainSerialExecutor {
        let searcher = DebouncedSearcher()
        
        searcher.search("a")
        await Task.yield()
        
        searcher.search("ab")
        await Task.yield()
        
        searcher.search("abc")
        
        // Wait for debounce
        try await Task.sleep(for: .milliseconds(600))
        
        #expect(searcher.searchCount == 1) // Only last search executed
    }
}
```

### Testing task groups

```swift
@Test
func taskGroupProcessesAll() async throws {
    let processor = BatchProcessor()
    
    let results = await withTaskGroup(of: Int.self) { group in
        for i in 1...5 {
            group.addTask { await processor.process(i) }
        }
        
        var collected: [Int] = []
        for await result in group {
            collected.append(result)
        }
        return collected
    }
    
    #expect(results.count == 5)
}
```

## Testing Memory Management

### Verify deallocation

```swift
@Test
func viewModelDeallocates() async {
    var viewModel: ViewModel? = ViewModel()
    weak var weakViewModel = viewModel
    
    viewModel?.startWork()
    viewModel = nil
    
    try? await Task.sleep(for: .milliseconds(100))
    
    #expect(weakViewModel == nil)
}
```

### Detect retain cycles

```swift
@Test
func noRetainCycle() async {
    var manager: Manager? = Manager()
    weak var weakManager = manager
    
    manager?.startLongRunningTask()
    manager = nil
    
    #expect(weakManager == nil)
}
```

## Best Practices

1. **Use Swift Testing for new code** - modern, better concurrency support
2. **Mark tests with correct isolation** - @MainActor when needed
3. **Use confirmations over continuations** - when structured concurrency allows
4. **Serialize tests with main serial executor** - avoid flaky tests
5. **Test cancellation explicitly** - ensure proper cleanup
6. **Verify deallocation** - catch retain cycles early
7. **Use Task.yield() strategically** - control execution in tests
8. **Avoid sleep in tests** - use continuations/confirmations instead
9. **Test actor isolation** - verify thread safety
10. **Keep tests deterministic** - avoid timing dependencies

## Migration from XCTest

### XCTest → Swift Testing

```swift
// XCTest
final class MyTests: XCTestCase {
    func testExample() async {
        XCTAssertEqual(value, expected)
    }
}

// Swift Testing
@Suite
struct MyTests {
    @Test
    func example() async {
        #expect(value == expected)
    }
}
```

### Expectations → Confirmations

```swift
// XCTest
let expectation = expectation(description: "Done")
doWork { expectation.fulfill() }
await fulfillment(of: [expectation])

// Swift Testing
await confirmation { confirm in
    await doWork { confirm() }
}
```

### Setup/Teardown → Traits

```swift
// XCTest
override func setUp() async throws {
    await prepare()
}

// Swift Testing
struct SetupTrait: TestTrait, TestScoping {
    func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: () async throws -> Void
    ) async throws {
        await prepare()
        try await function()
    }
}
```

## Troubleshooting

### Test hangs

**Cause**: Waiting for expectation that never fulfills.

**Solution**: Add timeout, verify observation tracking.

### Flaky test

**Cause**: Race condition in unstructured task.

**Solution**: Use main serial executor + Task.yield().

### Deadlock

**Cause**: Using `wait(for:)` in async context.

**Solution**: Use `await fulfillment(of:)` instead.

### Confirmation fails

**Cause**: Not awaiting async work in confirmation block.

**Solution**: Add `await` before async calls.

### Actor isolation error

**Cause**: Test not marked with required actor.

**Solution**: Add `@MainActor` or appropriate actor to test.

## Common Mistakes Agents Make

- **Flaky intermediate-state assertions**: Asserting `isLoading == true` immediately after creating a `Task` is a race condition — the task may not have started yet. Use `withMainSerialExecutor` + `Task.yield()` to control scheduling before asserting intermediate state.
- **Using `Task.sleep` as a synchronization primitive** in tests instead of deterministic scheduling.
- **Asserting intermediate state without controlling scheduling**: Always use `withMainSerialExecutor` when you need to observe state between task creation and completion. Note: `withMainSerialExecutor` does not work with parallel test execution — mark the suite `@Suite(.serialized)`.
- **Reaching into isolated internals** instead of testing public behavior.
- **Keeping both Swift Testing and XCTest versions** of the same example unless they teach different migration paths.

## Testing Checklist

- [ ] Tests marked with correct isolation
- [ ] Using Swift Testing (recommended)
- [ ] Async methods properly awaited
- [ ] Cancellation tested
- [ ] Memory leaks checked
- [ ] Race conditions handled
- [ ] Timeouts appropriate
- [ ] Flaky tests fixed with serial executor
- [ ] Actor isolation verified
- [ ] Cleanup in traits (not deinit)

## Further Learning

For advanced testing patterns, real-world examples, and migration strategies:
- [Swift Testing Documentation](https://developer.apple.com/documentation/testing)
- [Swift Concurrency Extras](https://github.com/pointfreeco/swift-concurrency-extras)
- [Swift Concurrency Course](https://www.swiftconcurrencycourse.com)

