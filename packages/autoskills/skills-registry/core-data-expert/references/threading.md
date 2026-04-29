# Threading and Concurrency

Core Data threading rules are strict but essential for data integrity. This guide covers safe multi-threading patterns, common pitfalls, and debugging techniques.

## The Golden Rule

**Never pass `NSManagedObject` instances between threads. Always use `NSManagedObjectID`.**

```swift
// ❌ WRONG: Passing object between contexts
let article = viewContext.object(...)
backgroundContext.perform {
    article.name = "Updated" // CRASH!
}

// ✅ CORRECT: Pass object ID
let objectID = article.objectID
backgroundContext.perform {
    guard let article = try? backgroundContext.existingObject(with: objectID) as? Article else { return }
    article.name = "Updated" // Safe!
    try? backgroundContext.save()
}
```

## Why NSManagedObjectID is Thread-Safe

`NSManagedObjectID` is immutable and thread-safe. It's a unique identifier that works across contexts and threads.

```swift
// Object IDs are thread-safe
let objectID: NSManagedObjectID = article.objectID

// Can be passed to any thread/context
DispatchQueue.global().async {
    let context = container.newBackgroundContext()
    context.perform {
        if let article = try? context.existingObject(with: objectID) as? Article {
            // Work with article safely
        }
    }
}
```

## Context Types and Concurrency

### View Context (Main Queue)

Runs on the main thread. Use for all UI operations.

```swift
let viewContext = container.viewContext
viewContext.perform {
    // Runs on main thread
    let article = Article(context: viewContext)
    article.name = "New Article"
    try? viewContext.save()
}
```

**Characteristics:**
- Main queue concurrency type
- Runs on main thread
- Use for UI-related operations only
- Keep operations lightweight

### Background Context (Private Queue)

Runs on a private queue. Use for heavy work.

```swift
let backgroundContext = container.newBackgroundContext()
backgroundContext.perform {
    // Runs on private background queue
    for i in 0..<1000 {
        let article = Article(context: backgroundContext)
        article.name = "Article \(i)"
    }
    try? backgroundContext.save()
}
```

**Characteristics:**
- Private queue concurrency type
- Runs on background thread
- Use for imports, exports, batch operations
- Doesn't block UI

## perform vs performAndWait

### perform (Asynchronous - Preferred)

```swift
context.perform {
    // Work happens asynchronously
    let article = Article(context: context)
    try? context.save()
}
// Code here runs immediately, before perform block finishes
```

**Benefits:**
- Non-blocking
- Better performance
- Recommended for most cases

### performAndWait (Synchronous - Use Sparingly)

```swift
context.performAndWait {
    // Work happens synchronously
    let article = Article(context: context)
    try? context.save()
}
// Code here runs after perform block finishes
```

**Caution:**
- Blocks the calling thread
- Can block main thread even for background contexts
- Use only when you need the result immediately

**Example of blocking behavior:**

```swift
// Called from main thread
let backgroundContext = container.newBackgroundContext()

// This BLOCKS the main thread!
backgroundContext.performAndWait {
    // Heavy work here blocks UI
    for i in 0..<10000 {
        let article = Article(context: backgroundContext)
    }
}
```

## Common Threading Patterns

### Pattern 1: Background Import

```swift
func importArticles(_ data: [ArticleData]) {
    let backgroundContext = container.newBackgroundContext()
    backgroundContext.perform {
        for item in data {
            let article = Article(context: backgroundContext)
            article.name = item.name
            article.content = item.content
        }
        
        do {
            try backgroundContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
}
```

### Pattern 2: Update Object from Background

```swift
func updateArticle(_ article: Article, newName: String) {
    let objectID = article.objectID
    let backgroundContext = container.newBackgroundContext()
    
    backgroundContext.perform {
        guard let article = try? backgroundContext.existingObject(with: objectID) as? Article else {
            return
        }
        
        article.name = newName
        try? backgroundContext.save()
    }
}
```

### Pattern 3: Fetch in Background, Update UI on Main

```swift
func loadArticles(completion: @escaping ([Article]) -> Void) {
    let backgroundContext = container.newBackgroundContext()
    
    backgroundContext.perform {
        let fetchRequest = Article.fetchRequest()
        guard let articles = try? backgroundContext.fetch(fetchRequest) else {
            return
        }
        
        // Get object IDs (thread-safe)
        let objectIDs = articles.map { $0.objectID }
        
        // Switch to main context for UI update
        DispatchQueue.main.async {
            let viewContext = self.container.viewContext
            let mainArticles = objectIDs.compactMap { 
                try? viewContext.existingObject(with: $0) as? Article 
            }
            completion(mainArticles)
        }
    }
}
```

### Pattern 4: Batch Delete with Object IDs

```swift
func deleteArticles(_ articles: [Article]) {
    let objectIDs = articles.map { $0.objectID }
    let backgroundContext = container.newBackgroundContext()
    
    backgroundContext.perform {
        for objectID in objectIDs {
            guard let article = try? backgroundContext.existingObject(with: objectID) else {
                continue
            }
            backgroundContext.delete(article)
        }
        
        try? backgroundContext.save()
    }
}
```

## Context Hierarchy and Parent Contexts

### Child Context Pattern

```swift
// Parent context (view context)
let parentContext = container.viewContext

// Child context for editing
let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
childContext.parent = parentContext

// Make changes in child
let article = childContext.object(with: articleID) as! Article
article.name = "Updated"

// Save to parent (not to disk yet)
try? childContext.save()

// Save parent to persist
try? parentContext.save()
```

**Benefits:**
- Can discard changes by not saving child
- Useful for forms/editing
- Isolates changes

**Caution:**
- Adds complexity
- Two saves required for persistence
- Parent must be saved for changes to persist

## Debugging Threading Issues

### Enable Concurrency Debug

Add launch argument:
```
-com.apple.CoreData.ConcurrencyDebug 1
```

**What it catches:**
- Objects accessed from wrong thread
- Contexts used from wrong queue
- Thread safety violations

**Example error:**
```
CoreData: error: Serious application error.
An exception was caught from the delegate of NSFetchedResultsController during a call to -controllerDidChangeContent:.
*** -[NSManagedObjectContext performSelector:withObject:] called from thread which is not the context's thread with userInfo (null)
```

### Common Threading Errors

#### Error 1: Accessing Object from Wrong Context

```swift
// ❌ Wrong
let article = viewContext.object(...)
backgroundContext.perform {
    print(article.name) // CRASH!
}

// ✅ Correct
let objectID = article.objectID
backgroundContext.perform {
    if let article = try? backgroundContext.existingObject(with: objectID) as? Article {
        print(article.name)
    }
}
```

#### Error 2: Not Using perform

```swift
// ❌ Wrong
let backgroundContext = container.newBackgroundContext()
let article = Article(context: backgroundContext) // CRASH!

// ✅ Correct
let backgroundContext = container.newBackgroundContext()
backgroundContext.perform {
    let article = Article(context: backgroundContext)
}
```

#### Error 3: Passing Context Between Threads

```swift
// ❌ Wrong
DispatchQueue.global().async {
    try? viewContext.save() // CRASH!
}

// ✅ Correct
viewContext.perform {
    try? viewContext.save()
}
```

## Merging Changes Between Contexts

### Automatic Merging

Enable automatic merging from parent:

```swift
context.automaticallyMergesChangesFromParent = true
```

**Benefits:**
- Changes from other contexts automatically merge
- No manual merge code needed
- Recommended for most cases

### Manual Merging

Listen for save notifications:

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(contextDidSave),
    name: .NSManagedObjectContextDidSave,
    object: backgroundContext
)

@objc func contextDidSave(_ notification: Notification) {
    viewContext.perform {
        viewContext.mergeChanges(fromContextDidSave: notification)
    }
}
```

## Async/Await with Core Data (iOS 15+)

### Using async/await

```swift
func fetchArticles() async throws -> [Article] {
    let context = container.newBackgroundContext()
    
    return try await context.perform {
        let fetchRequest = Article.fetchRequest()
        return try context.fetch(fetchRequest)
    }
}

// Usage
Task {
    do {
        let articles = try await fetchArticles()
        // Update UI with articles
    } catch {
        print("Failed to fetch: \(error)")
    }
}
```

### Saving with async/await

```swift
func saveArticle(name: String) async throws {
    let context = container.newBackgroundContext()
    
    try await context.perform {
        let article = Article(context: context)
        article.name = name
        try context.save()
    }
}
```

## Performance Considerations

### Context Reuse

```swift
// ❌ Bad: Creating new context for each operation
func updateArticle1() {
    let context = container.newBackgroundContext()
    context.perform { /* ... */ }
}

func updateArticle2() {
    let context = container.newBackgroundContext() // New context!
    context.perform { /* ... */ }
}

// ✅ Better: Reuse context for related operations
class DataManager {
    private lazy var backgroundContext = container.newBackgroundContext()
    
    func updateArticle1() {
        backgroundContext.perform { /* ... */ }
    }
    
    func updateArticle2() {
        backgroundContext.perform { /* ... */ }
    }
}
```

### Context Reset

For long-running contexts, periodically reset to free memory:

```swift
backgroundContext.perform {
    for (index, data) in largeDataset.enumerated() {
        let article = Article(context: backgroundContext)
        article.name = data.name
        
        if index % 100 == 0 {
            try? backgroundContext.save()
            backgroundContext.reset() // Clear memory
        }
    }
}
```

## Thread Confinement

Each context is confined to its queue. You can call `perform` from any thread, but all Core Data work must run inside `perform`/`performAndWait` on that context.

```swift
let context = container.newBackgroundContext()

// ✅ Allowed: scheduling work from anywhere
DispatchQueue.global().async {
    context.perform {
        // Work executes on context's queue
    }
}

DispatchQueue.main.async {
    context.perform {
        // Also executes on context's queue
    }
}

// ❌ Wrong: touching the context or its objects outside perform
DispatchQueue.global().async {
    let article = Article(context: context) // Not inside perform
    try? context.save()                     // Not inside perform
}
```

## Common Pitfalls

### ❌ Passing Objects Directly

```swift
func updateInBackground(_ article: Article) {
    backgroundContext.perform {
        article.name = "Updated" // CRASH!
    }
}
```

### ❌ Not Using perform

```swift
let backgroundContext = container.newBackgroundContext()
let article = Article(context: backgroundContext) // CRASH!
```

### ❌ Accessing UI from Background Context

```swift
backgroundContext.perform {
    let articles = try? backgroundContext.fetch(Article.fetchRequest())
    tableView.reloadData() // CRASH! Wrong thread
}
```

### ❌ Using performAndWait on Main Thread

```swift
// On main thread
backgroundContext.performAndWait {
    // Heavy work - blocks UI!
}
```

### ✅ Correct Patterns

```swift
// Pass object IDs
func updateInBackground(_ article: Article) {
    let objectID = article.objectID
    backgroundContext.perform {
        guard let article = try? backgroundContext.existingObject(with: objectID) as? Article else {
            return
        }
        article.name = "Updated"
        try? backgroundContext.save()
    }
}

// Always use perform
let backgroundContext = container.newBackgroundContext()
backgroundContext.perform {
    let article = Article(context: backgroundContext)
}

// Update UI on main thread
backgroundContext.perform {
    let articles = try? backgroundContext.fetch(Article.fetchRequest())
    let objectIDs = articles?.map { $0.objectID } ?? []
    
    DispatchQueue.main.async {
        // Update UI with objectIDs
    }
}

// Use perform (async) instead of performAndWait
backgroundContext.perform {
    // Heavy work doesn't block UI
}
```

## Testing Threading

```swift
func testThreadSafety() {
    let expectation = XCTestExpectation(description: "Background save")
    
    let objectID = article.objectID
    let backgroundContext = container.newBackgroundContext()
    
    backgroundContext.perform {
        guard let article = try? backgroundContext.existingObject(with: objectID) as? Article else {
            XCTFail("Failed to fetch article")
            return
        }
        
        article.name = "Updated"
        
        do {
            try backgroundContext.save()
            expectation.fulfill()
        } catch {
            XCTFail("Failed to save: \(error)")
        }
    }
    
    wait(for: [expectation], timeout: 5.0)
}
```

## Summary

1. **Never pass NSManagedObject between contexts** - Always use NSManagedObjectID
2. **Always use `perform` or `performAndWait`** - Never access context directly
3. **Prefer `perform` over `performAndWait`** - Avoid blocking
4. **Use view context for UI only** - Heavy work in background contexts
5. **Enable `-com.apple.CoreData.ConcurrencyDebug 1`** - Catch threading violations
6. **Enable `automaticallyMergesChangesFromParent`** - Automatic change propagation
7. **Use async/await on iOS 15+** - Cleaner asynchronous code
8. **Reset contexts periodically** - Free memory in long-running operations
9. **One context per queue** - Don't share contexts across queues
10. **Test threading behavior** - Verify thread safety in tests
