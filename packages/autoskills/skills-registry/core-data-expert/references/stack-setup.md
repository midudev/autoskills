# Core Data Stack Setup

Setting up your Core Data stack correctly is foundational to a well-architected app. This guide covers best practices for configuring `NSPersistentContainer`, managing contexts, and establishing patterns that scale.

## Custom NSPersistentContainer

Create a custom subclass instead of configuring everything in `AppDelegate`. This keeps your stack configuration organized and testable.

```swift
import CoreData

class PersistentContainer: NSPersistentContainer {
    static let shared = PersistentContainer(name: "DataModel")
    
    private override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
        configure()
    }
    
    convenience init(name: String) {
        guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load data model")
        }
        self.init(name: name, managedObjectModel: model)
    }
    
    private func configure() {
        // Set merge policy for constraint handling
        viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        // Enable automatic merging from parent
        viewContext.automaticallyMergesChangesFromParent = true
        
        // Name the view context for debugging
        viewContext.name = "ViewContext"

        // Configure store options before loading
        configureStoreDescription()
        
        // Load persistent stores
        loadPersistentStores { description, error in
            if let error = error {
                // Handle error appropriately
                fatalError("Failed to load persistent store: \(error)")
            }
        }
    }
    
    private func configureStoreDescription() {
        guard let description = persistentStoreDescriptions.first else { return }

        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
    }
}
```

## Singleton Pattern vs Dependency Injection

### Singleton Pattern (Recommended for Most Apps)

```swift
class PersistentContainer: NSPersistentContainer {
    static let shared = PersistentContainer(name: "DataModel")
    
    // Prevent external initialization
    private override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
}

// Usage
let context = PersistentContainer.shared.viewContext
```

**Pros:**
- Simple, consistent access across the app
- No need to pass container through the app
- Works well with SwiftUI environment

**Cons:**
- Harder to test with different configurations
- Global state

### Dependency Injection (Better for Testing)

```swift
class DataController {
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
}

// Usage
let dataController = DataController()
let context = dataController.viewContext

// Testing
let testController = DataController(inMemory: true)
```

**Pros:**
- Easier to test with in-memory stores
- More flexible configuration
- Better for unit testing

**Cons:**
- Must pass controller through the app
- More boilerplate

## Merge Policies

Merge policies determine how Core Data resolves conflicts when saving. Choose based on your app's needs.

### NSMergeByPropertyStoreTrumpMergePolicy (Recommended)

Store values win over in-memory values. **Required for constraints to work.**

```swift
viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
```

**Use when:**
- Using unique constraints
- Store data should take precedence
- Multiple contexts might modify the same objects

### NSMergeByPropertyObjectTrumpMergePolicy

In-memory values win over store values.

```swift
viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
```

**Use when:**
- User edits should always win
- In-memory changes are more important

### NSOverwriteMergePolicy

In-memory object completely replaces store object.

```swift
viewContext.mergePolicy = NSOverwriteMergePolicy
```

**Use when:**
- You want complete replacement
- Conflicts should never occur

### NSRollbackMergePolicy

Discard in-memory changes, keep store values.

```swift
viewContext.mergePolicy = NSRollbackMergePolicy
```

**Use when:**
- Store is source of truth
- In-memory changes should be discarded on conflict

### NSErrorMergePolicy (Default)

Throws an error on conflict. You must handle manually.

```swift
viewContext.mergePolicy = NSErrorMergePolicy

do {
    try context.save()
} catch let error as NSError {
    if error.code == NSManagedObjectMergeError {
        // Handle merge conflict
    }
}
```

**Use when:**
- You need custom conflict resolution
- Conflicts should be explicitly handled

## Context Configuration

### View Context

The view context runs on the main thread and should be used for all UI operations.

```swift
let viewContext = container.viewContext
viewContext.name = "ViewContext"
viewContext.automaticallyMergesChangesFromParent = true
viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
```

**Best Practices:**
- Only use for UI-related fetches and updates
- Keep operations lightweight
- Enable automatic merging from parent
- Set a descriptive name for debugging

### Background Context

Background contexts run on private queues and should be used for heavy work.

```swift
override func newBackgroundContext() -> NSManagedObjectContext {
    let context = super.newBackgroundContext()
    context.name = "BackgroundContext"
    context.transactionAuthor = "BackgroundAuthor"
    context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    context.automaticallyMergesChangesFromParent = true
    return context
}

// Usage
let context = container.newBackgroundContext()
context.perform {
    // Heavy work here
    try? context.save()
}
```

**Best Practices:**
- Use for imports, exports, batch operations
- Always wrap work in `perform { }`
- Set transaction author for persistent history tracking
- Enable automatic merging

### Context Naming and Transaction Authors

Naming contexts helps with debugging and persistent history tracking.

```swift
context.name = "ImportContext"
context.transactionAuthor = "ImportAuthor"
```

**Benefits:**
- Identify contexts in Instruments
- Filter persistent history transactions
- Debug threading issues more easily
- Track which part of app made changes

**Example with App Extensions:**

```swift
// Main app
mainContext.transactionAuthor = "MainApp"

// Share extension
shareContext.transactionAuthor = "ShareExtension"

// Filter transactions by author
let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastToken)
if let historyFetch = fetchRequest as? NSPersistentHistoryChangeRequest {
    historyFetch.fetchRequest?.predicate = NSPredicate(
        format: "author != %@", "MainApp"
    )
}
```

## Understanding Store Loading Behavior

The `loadPersistentStores` method is **always asynchronous** - it uses a completion handler that's called when loading finishes. There is no synchronous version of this API.

### Standard Pattern (Recommended)

```swift
container.loadPersistentStores { description, error in
    if let error = error {
        fatalError("Failed to load store: \(error)")
    }
}
// Code here executes immediately, before stores finish loading
// However, in typical setup() methods, the app waits for completion
```

**Characteristics:**
- Completion handler called asynchronously when loading finishes
- Code after `loadPersistentStores` executes immediately
- App typically waits for stores to load before showing UI
- Most common and recommended pattern

**When to use:**
- Standard app initialization
- When you control the setup flow
- When you can ensure UI doesn't appear until stores are ready

### Modern async/await Pattern (iOS 15+)

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

// Usage in async context
func setupCoreData() async throws {
    let container = NSPersistentContainer(name: "Model")
    try await container.loadPersistentStores()
    // Stores are guaranteed loaded here
}
```

**Benefits:**
- Cleaner async/await syntax
- Better error handling with try/catch
- Easier to compose with other async operations
- Explicit about async nature

**When to use:**
- iOS 15+ deployment target
- Modern Swift concurrency codebase
- When composing with other async operations

### Deferred Loading Pattern (Advanced)

For rare cases where you need the app to start before stores are loaded:

```swift
class CoreDataStack {
    let container: NSPersistentContainer
    private(set) var isStoreLoaded = false
    
    init() {
        container = NSPersistentContainer(name: "Model")
        loadStoresInBackground()
    }
    
    private func loadStoresInBackground() {
        container.loadPersistentStores { [weak self] description, error in
            if let error = error {
                print("Failed to load store: \(error)")
                return
            }
            self?.isStoreLoaded = true
            NotificationCenter.default.post(name: .storeDidLoad, object: nil)
        }
    }
    
    func waitForStoreLoad() async {
        guard !isStoreLoaded else { return }
        
        await withCheckedContinuation { continuation in
            let observer = NotificationCenter.default.addObserver(
                forName: .storeDidLoad,
                object: nil,
                queue: nil
            ) { _ in
                continuation.resume()
            }
            
            // Check again in case it loaded while setting up observer
            if self.isStoreLoaded {
                NotificationCenter.default.removeObserver(observer)
                continuation.resume()
            }
        }
    }
}
```

**Cautions:**
- Must handle "not ready" state throughout app
- More complex error handling
- Potential race conditions if not careful
- Only use if you have a specific reason

**When to use:**
- Very large databases where loading takes significant time
- Apps that can show UI before data is available
- Background initialization scenarios

### Recommendation

**Use the standard pattern** with completion handler for most apps. The loading time is typically negligible (milliseconds), and waiting for stores to load before showing UI provides predictable behavior and avoids race conditions.

**Use async/await** if you're on iOS 15+ and want modern Swift concurrency patterns.

**Avoid deferred loading** unless you have a specific, measured need for it. The complexity and potential for bugs usually outweigh any perceived benefits.

## Store Configuration Options

### In-Memory Store (Testing)

```swift
let description = NSPersistentStoreDescription()
description.type = NSInMemoryStoreType
container.persistentStoreDescriptions = [description]
```

**Use for:**
- Unit tests
- Temporary data
- Prototyping

### SQLite Store (Production)

```swift
let description = NSPersistentStoreDescription(url: storeURL)
description.type = NSSQLiteStoreType
container.persistentStoreDescriptions = [description]
```

**Use for:**
- Production apps
- Persistent data
- Most common use case

### Store Location

```swift
// Default location
let storeURL = NSPersistentContainer.defaultDirectoryURL()
    .appendingPathComponent("Model.sqlite")

// Custom location
let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    .appendingPathComponent("MyApp.sqlite")

// App Group (for extensions)
let storeURL = FileManager.default.containerURL(
    forSecurityApplicationGroupIdentifier: "group.com.example.app"
)?.appendingPathComponent("Shared.sqlite")
```

## Complete Example

Here's a production-ready stack setup:

```swift
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    private let containerName = "DataModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        
        // Configure store description
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to retrieve store description")
        }
        
        // Enable persistent history tracking
        description.setOption(true as NSNumber, 
                            forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber,
                            forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        // Load stores
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Handle error appropriately in production
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        // Configure view context
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.name = "ViewContext"
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.name = "BackgroundContext"
        context.transactionAuthor = "BackgroundAuthor"
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask { context in
            context.name = "BackgroundTask"
            context.transactionAuthor = "BackgroundTaskAuthor"
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            block(context)
        }
    }
    
    private init() {}
}

// Usage
let context = CoreDataStack.shared.viewContext

// Background work
CoreDataStack.shared.performBackgroundTask { context in
    // Heavy work here
    try? context.save()
}
```

## SwiftUI Integration

### Environment Object Pattern

```swift
import SwiftUI

@main
struct MyApp: App {
    let persistenceController = PersistentContainer.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}

// Usage in views
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Article.name, ascending: true)],
        animation: .default)
    private var articles: FetchedResults<Article>
    
    var body: some View {
        List(articles) { article in
            Text(article.name ?? "")
        }
    }
}
```

## Common Pitfalls

### ❌ Configuring in AppDelegate

```swift
// Don't do this - hard to test and maintain
class AppDelegate: UIApplicationDelegate {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        // Lots of configuration code here...
        return container
    }()
}
```

### ❌ Not Setting Merge Policy with Constraints

```swift
// This will crash when constraints are violated
let entity = MyEntity(context: context)
entity.uniqueField = "duplicate" // Constraint violation
try context.save() // CRASH!
```

### ❌ Not Naming Contexts

```swift
// Hard to debug which context has issues
let context = container.newBackgroundContext()
// No name, no transaction author
```

### ✅ Correct Approach

```swift
class PersistentContainer: NSPersistentContainer {
    static let shared = PersistentContainer(name: "Model")
    
    override func newBackgroundContext() -> NSManagedObjectContext {
        let context = super.newBackgroundContext()
        context.name = "BackgroundContext"
        context.transactionAuthor = "BackgroundAuthor"
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
```

## Summary

1. **Create a custom NSPersistentContainer subclass** for organized configuration
2. **Use singleton pattern for simplicity** or dependency injection for testability
3. **Set merge policy** to NSMergeByPropertyStoreTrumpMergePolicy (required for constraints)
4. **Name contexts and set transaction authors** for debugging and history tracking
5. **Enable automaticallyMergesChangesFromParent** on all contexts
6. **Load stores using the completion handler (or async bridge)** and gate access until loading completes
7. **Configure persistent history tracking** if using batch operations or app extensions
