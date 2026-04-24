# Core Data and Swift Concurrency

Thread-safe patterns for using Core Data with Swift Concurrency.

## Core Principles

### Thread safety still matters

Core Data's thread safety rules don't change with Swift Concurrency:
- Can't pass `NSManagedObject` between threads
- Must access objects on their context's thread
- `NSManagedObjectID` is thread-safe (can pass around)

### NSManagedObject cannot be Sendable

```swift
@objc(Article)
public class Article: NSManagedObject {
    @NSManaged public var title: String // ❌ Mutable, can't be Sendable
}
```

**Don't use `@unchecked Sendable`** - hides warnings without fixing safety.

## Available Async APIs

### Context perform

```swift
extension NSManagedObjectContext {
    func perform<T>(_ block: @escaping () throws -> T) async rethrows -> T
}
```

### What's missing

No async alternative for:
```swift
func loadPersistentStores(
    completionHandler: @escaping (NSPersistentStoreDescription, Error?) -> Void
)
```

Must bridge manually (see below).

## Data Access Objects (DAO)

Thread-safe value types representing managed objects.

### Pattern

```swift
// Managed object (not Sendable)
@objc(Article)
public class Article: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var timestamp: Date?
}

// DAO (Sendable)
struct ArticleDAO: Sendable, Identifiable {
    let id: NSManagedObjectID
    let title: String
    let timestamp: Date
    
    init?(managedObject: Article) {
        guard let title = managedObject.title,
              let timestamp = managedObject.timestamp else {
            return nil
        }
        self.id = managedObject.objectID
        self.title = title
        self.timestamp = timestamp
    }
}
```

### Benefits

- **Sendable**: Safe to pass across isolation domains
- **Immutable**: No accidental mutations
- **Clear API**: Explicit data transfer

### Drawbacks

- **Requires rewrite**: All fetch/mutation logic
- **Boilerplate**: DAO for each entity
- **Complexity**: Additional layer of abstraction

## Working Without DAOs

Pass only `NSManagedObjectID` between contexts.

### Basic pattern

```swift
@MainActor
func fetchArticle(id: NSManagedObjectID) -> Article? {
    viewContext.object(with: id) as? Article
}

func processInBackground(articleID: NSManagedObjectID) async throws {
    let backgroundContext = container.newBackgroundContext()
    try await backgroundContext.perform {
        guard let article = backgroundContext.object(with: articleID) as? Article else {
            return
        }
        // Process article
        try backgroundContext.save()
    }
}
```

### NSManagedObjectID is Sendable

```swift
// Safe to pass between tasks
let articleID = article.objectID

Task {
    try? await processInBackground(articleID: articleID)
}
```

## Bridging Closures to Async

### Load persistent stores

```swift
extension NSPersistentContainer {
    func loadPersistentStores() async throws {
        try await withCheckedThrowingContinuation { continuation in
            self.loadPersistentStores { description, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
}

// Usage
try await container.loadPersistentStores()
```

## Simple CoreDataStore Pattern

Enforce isolation at API level:

```swift
final class CoreDataStore {
    let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    // View context operations (main thread)
    @MainActor
    func read<T>(_ block: (NSManagedObjectContext) throws -> T) rethrows -> T {
        try block(viewContext)
    }

    // Background operations
    func performInBackground<T>(
        _ block: @Sendable @escaping (NSManagedObjectContext) throws -> T
    ) async rethrows -> T {
        let context = persistentContainer.newBackgroundContext()
        return try await context.perform {
            try block(context)
        }
    }
}
```

### Usage

```swift
let store = CoreDataStore(persistentContainer: container)

// Main thread operations
@MainActor
func loadArticles() throws -> [Article] {
    try store.read { context in
        let request = Article.fetchRequest()
        return try context.fetch(request)
    }
}

// Background operations
func deleteAll() async throws {
    try await store.performInBackground { context in
        let request = Article.fetchRequest()
        let articles = try context.fetch(request)
        articles.forEach { context.delete($0) }
        try context.save()
    }
}
```

### Why this pattern works

- **@MainActor**: Enforces view context on main thread
- **Dedicated entry points**: Read/write APIs prevent accidental cross-context use
- **Simple**: No custom executors needed

## Custom Actor Executor (Advanced)

**Note**: Usually not needed. Consider simple pattern first.

### Implementation

```swift
final class NSManagedObjectContextExecutor: @unchecked Sendable, SerialExecutor {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func enqueue(_ job: consuming ExecutorJob) {
        let unownedJob = UnownedJob(job)
        let executor = asUnownedSerialExecutor()
        
        context.perform {
            unownedJob.runSynchronously(on: executor)
        }
    }
    
    func asUnownedSerialExecutor() -> UnownedSerialExecutor {
        UnownedSerialExecutor(ordinary: self)
    }
}
```

### Actor usage

```swift
actor CoreDataStore {
    let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    nonisolated let modelExecutor: NSManagedObjectContextExecutor
    
    nonisolated var unownedExecutor: UnownedSerialExecutor {
        modelExecutor.asUnownedSerialExecutor()
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MyApp")
        context = persistentContainer.newBackgroundContext()
        modelExecutor = NSManagedObjectContextExecutor(context: context)
    }
    
    func deleteAll<T: NSManagedObject>(
        using request: NSFetchRequest<T>
    ) throws {
        let objects = try context.fetch(request)
        objects.forEach { context.delete($0) }
        try context.save()
    }
}
```

### Drawbacks

- **Hidden complexity**: Executor details obscure Core Data
- **Forces concurrency**: Even for main thread operations
- **Not simpler**: More code than `perform { }`
- **Error prone**: Easy to use wrong context

**Recommendation**: Use simple pattern instead.

## Default MainActor Isolation

### Problem with auto-generated code

When default isolation set to `@MainActor`, auto-generated managed objects conflict:

```swift
// Auto-generated (can't modify)
class Article: NSManagedObject {
    // Inherits @MainActor, conflicts with NSManagedObject
}
```

**Error**: `Main actor-isolated initializer has different actor isolation from nonisolated overridden declaration`

### Solution: Manual code generation

1. Set entity to "Manual/None" code generation
2. Generate class definitions
3. Mark as `nonisolated`:

```swift
nonisolated class Article: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var timestamp: Date?
}
```

**Benefit**: Full control over isolation.

## Common Patterns

### Fetch on main thread

```swift
@MainActor
func fetchArticles() throws -> [Article] {
    let request = Article.fetchRequest()
    return try viewContext.fetch(request)
}
```

### Background save

```swift
func saveInBackground() async throws {
    let context = container.newBackgroundContext()
    try await context.perform {
        let article = Article(context: context)
        article.title = "New Article"
        try context.save()
    }
}
```

### Pass ID, fetch in context

```swift
@MainActor
func displayArticle(id: NSManagedObjectID) {
    guard let article = viewContext.object(with: id) as? Article else {
        return
    }
    // Use article
}

func processArticle(id: NSManagedObjectID) async throws {
    let context = container.newBackgroundContext()
    try await context.perform {
        guard let article = context.object(with: id) as? Article else { return }
        // Process article
        try context.save()
    }
}
```

### Batch operations

```swift
func deleteAllArticles() async throws {
    let context = container.newBackgroundContext()
    try await context.perform {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
    }
}
```

## SwiftUI Integration

### Environment injection

```swift
@main
struct MyApp: App {
    let persistentContainer = NSPersistentContainer(name: "MyApp")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
```

### View usage

```swift
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Article.timestamp, ascending: true)]
    ) private var articles: FetchedResults<Article>
    
    var body: some View {
        List(articles) { article in
            Text(article.title ?? "")
        }
    }
}
```

## Best Practices

1. **Pass NSManagedObjectID only** - never managed objects
2. **Use perform { }** - don't access context directly
3. **@MainActor for view context** - enforce main thread
4. **Use background contexts** - run heavy work off the main thread
5. **Manual code generation** - control isolation
6. **Keep it simple** - avoid custom executors unless needed
7. **Enable Core Data debugging** - catch thread violations
8. **Merge changes automatically** - `automaticallyMergesChangesFromParent = true`
9. **Use background contexts** - for heavy operations
10. **Test with Thread Sanitizer** - catch violations early

## Debugging

### Enable Core Data concurrency debugging

```swift
// Launch argument
-com.apple.CoreData.ConcurrencyDebug 1
```

Crashes immediately on thread violations.

### Thread Sanitizer

Enable in scheme settings to catch data races.

### Assertions

```swift
@MainActor
func fetchArticles() -> [Article] {
    assert(Thread.isMainThread)
    // Fetch from viewContext
}
```

## Decision Tree

```
Need to access Core Data?
├─ UI/View context?
│  └─ Use @MainActor + viewContext
│
├─ Background operation?
│  ├─ Quick operation? → perform { } on background context
│  └─ Batch operation? → NSBatchDeleteRequest/NSBatchUpdateRequest
│
├─ Pass between contexts?
│  └─ Use NSManagedObjectID only
│
└─ Need Sendable type?
   ├─ Can refactor? → Use DAO pattern
   └─ Can't refactor? → Pass NSManagedObjectID
```

## Migration Strategy

### For existing projects

1. **Enable manual code generation** for all entities
2. **Mark entities as nonisolated** if using default @MainActor
3. **Wrap Core Data access** in CoreDataStore
4. **Use @MainActor** for view context operations
5. **Use background contexts** for write-heavy work
6. **Pass NSManagedObjectID** between contexts
7. **Test with debugging enabled**

### For new projects

1. **Start with simple pattern** (CoreDataStore)
2. **Manual code generation** from the start
3. **Consider DAOs** if heavy cross-context usage
4. **Enable strict concurrency** early

## Common Mistakes

### ❌ Passing managed objects

```swift
func process(article: Article) async {
    // ❌ Article not Sendable
}
```

### ❌ Accessing context from wrong thread

```swift
func background() async {
    let articles = viewContext.fetch(request) // ❌ Not on main thread
}
```

### ❌ Using @unchecked Sendable

```swift
extension Article: @unchecked Sendable {} // ❌ Doesn't make it safe
```

### ❌ Not using perform

```swift
func save() async {
    backgroundContext.save() // ❌ Not on context's thread
}
```

## Related References

- See `threading.md` for general Core Data threading patterns
- See `batch-operations.md` for async batch operation patterns
- See `stack-setup.md` for container setup with async/await
- See `testing.md` for testing async Core Data code

## Further Learning

For Core Data best practices, migration strategies, and advanced patterns:
- [Core Data Best Practices Repository](https://github.com/avanderlee/CoreDataBestPractices)
- [Swift Concurrency Course](https://www.swiftconcurrencycourse.com)
