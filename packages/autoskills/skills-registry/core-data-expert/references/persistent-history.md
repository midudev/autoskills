# Persistent History Tracking

Persistent history tracking enables Core Data to track changes across contexts, app extensions, and batch operations. This is essential for keeping your UI synchronized and supporting multi-target apps.

## Why Persistent History Tracking?

**Without persistent history tracking:**
- Batch operations don't update UI
- App extensions can't notify main app of changes
- Multiple contexts don't stay synchronized

**With persistent history tracking:**
- All changes are recorded in a transaction log
- Changes can be merged into any context
- Works across app targets (main app, extensions, etc.)

## Enabling Persistent History Tracking

### In NSPersistentContainer

```swift
class PersistentContainer: NSPersistentContainer {
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
        
        guard let description = persistentStoreDescriptions.first else {
            fatalError("No store description")
        }
        
        // Enable persistent history tracking
        description.setOption(true as NSNumber,
                            forKey: NSPersistentHistoryTrackingKey)
        
        // Enable remote change notifications
        description.setOption(true as NSNumber,
                            forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
    }
}
```

### For App Groups (Extensions)

```swift
let storeURL = FileManager.default.containerURL(
    forSecurityApplicationGroupIdentifier: "group.com.example.app"
)?.appendingPathComponent("Shared.sqlite")

let description = NSPersistentStoreDescription(url: storeURL!)
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

container.persistentStoreDescriptions = [description]
```

## The Four Components

Persistent history tracking typically involves four components:

1. **Observer** - Listens for remote change notifications
2. **Fetcher** - Retrieves relevant transactions
3. **Merger** - Merges transactions into view context
4. **Cleaner** - Removes old transactions

## 1. Observer: Listening for Changes

```swift
final class PersistentHistoryObserver {
    private let coordinator: NSPersistentStoreCoordinator
    private let historyContext: NSManagedObjectContext
    private let merger: PersistentHistoryMerger

    init(container: NSPersistentContainer, viewContext: NSManagedObjectContext) {
        self.coordinator = container.persistentStoreCoordinator
        self.historyContext = container.newBackgroundContext()
        self.historyContext.name = "PersistentHistoryContext"
        self.historyContext.transactionAuthor = "PersistentHistory"
        self.merger = PersistentHistoryMerger(historyContext: historyContext, viewContext: viewContext)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(processStoreRemoteChanges),
            name: .NSPersistentStoreRemoteChange,
            object: coordinator
        )
    }

    @objc private func processStoreRemoteChanges(_ notification: Notification) {
        merger.merge()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
```

## 2. Fetcher: Retrieving Transactions

```swift
class PersistentHistoryFetcher {
    private let context: NSManagedObjectContext
    private let lastToken: NSPersistentHistoryToken?
    
    init(context: NSManagedObjectContext, lastToken: NSPersistentHistoryToken?) {
        self.context = context
        self.lastToken = lastToken
    }
    
    func fetch() throws -> [NSPersistentHistoryTransaction] {
        let fetchRequest = createFetchRequest()
        
        guard let historyResult = try context.execute(fetchRequest) as? NSPersistentHistoryResult,
              let transactions = historyResult.result as? [NSPersistentHistoryTransaction] else {
            return []
        }
        
        return transactions
    }
    
    private func createFetchRequest() -> NSPersistentHistoryChangeRequest {
        let request: NSPersistentHistoryChangeRequest
        
        if let token = lastToken {
            request = NSPersistentHistoryChangeRequest.fetchHistory(after: token)
        } else {
            request = NSPersistentHistoryChangeRequest.fetchHistory(after: Date.distantPast)
        }
        
        // Filter out transactions from this app target
        if let fetchRequest = request.fetchRequest {
            fetchRequest.predicate = NSPredicate(
                format: "author != %@",
                "MainApp" // Your app's transaction author
            )
        }
        
        return request
    }
}
```

## 3. Merger: Applying Changes

```swift
final class PersistentHistoryMerger {
    private let historyContext: NSManagedObjectContext
    private let viewContext: NSManagedObjectContext
    private var lastToken: NSPersistentHistoryToken?

    init(historyContext: NSManagedObjectContext, viewContext: NSManagedObjectContext) {
        self.historyContext = historyContext
        self.viewContext = viewContext
        self.lastToken = loadLastToken()
    }

    func merge() {
        historyContext.perform {
            do {
                let fetcher = PersistentHistoryFetcher(
                    context: self.historyContext,
                    lastToken: self.lastToken
                )

                let transactions = try fetcher.fetch()
                guard !transactions.isEmpty else { return }

                self.viewContext.perform {
                    self.mergeTransactions(transactions)
                }

                if let newToken = transactions.last?.token {
                    self.lastToken = newToken
                    self.saveLastToken(newToken)
                }
            } catch {
                print("Failed to merge history: \(error)")
            }
        }
    }

    private func mergeTransactions(_ transactions: [NSPersistentHistoryTransaction]) {
        for transaction in transactions {
            guard let userInfo = transaction.objectIDNotification().userInfo else { continue }
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: userInfo, into: [viewContext])
        }
    }
    
    private func loadLastToken() -> NSPersistentHistoryToken? {
        guard let data = UserDefaults.standard.data(forKey: "lastHistoryToken") else {
            return nil
        }
        return try? NSKeyedUnarchiver.unarchivedObject(
            ofClass: NSPersistentHistoryToken.self,
            from: data
        )
    }
    
    private func saveLastToken(_ token: NSPersistentHistoryToken) {
        if let data = try? NSKeyedArchiver.archivedData(
            withRootObject: token,
            requiringSecureCoding: true
        ) {
            UserDefaults.standard.set(data, forKey: "lastHistoryToken")
        }
    }
}
```

## 4. Cleaner: Removing Old Transactions

```swift
class PersistentHistoryCleaner {
    private let context: NSManagedObjectContext
    private let targets: [AppTarget]
    
    enum AppTarget {
        case mainApp
        case shareExtension
        case widgetExtension
        
        var lastTokenKey: String {
            switch self {
            case .mainApp: return "mainApp.lastHistoryToken"
            case .shareExtension: return "shareExtension.lastHistoryToken"
            case .widgetExtension: return "widgetExtension.lastHistoryToken"
            }
        }
    }
    
    init(context: NSManagedObjectContext, targets: [AppTarget]) {
        self.context = context
        self.targets = targets
    }
    
    func clean() {
        context.perform {
            // Find the oldest token across all targets
            guard let oldestToken = self.findOldestToken() else { return }
            
            // Delete history before that token
            let deleteRequest = NSPersistentHistoryChangeRequest.deleteHistory(before: oldestToken)
            
            do {
                try self.context.execute(deleteRequest)
            } catch {
                print("Failed to clean history: \(error)")
            }
        }
    }
    
    private func findOldestToken() -> NSPersistentHistoryToken? {
        var oldestDate: Date?
        var oldestToken: NSPersistentHistoryToken?
        
        for target in targets {
            guard let token = loadToken(for: target) else { continue }
            
            // Get timestamp from token (requires fetching transaction)
            let historyRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: token)
            historyRequest.fetchRequest?.fetchLimit = 1
            
            guard let result = try? context.execute(historyRequest) as? NSPersistentHistoryResult,
                  let transactions = result.result as? [NSPersistentHistoryTransaction],
                  let transaction = transactions.first else {
                continue
            }
            
            let date = transaction.timestamp
            if oldestDate == nil || date < oldestDate! {
                oldestDate = date
                oldestToken = token
            }
        }
        
        return oldestToken
    }
    
    private func loadToken(for target: AppTarget) -> NSPersistentHistoryToken? {
        guard let data = UserDefaults.standard.data(forKey: target.lastTokenKey) else {
            return nil
        }
        return try? NSKeyedUnarchiver.unarchivedObject(
            ofClass: NSPersistentHistoryToken.self,
            from: data
        )
    }
}
```

## Complete Integration Example

```swift
class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        // Configure store
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No store description")
        }
        
        // Enable persistent history tracking
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }

            self.setupHistoryTracking(container: container)
        }
        
        // Configure view context
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.name = "ViewContext"
        container.viewContext.transactionAuthor = "MainApp"
        
        return container
    }()
    
    private var historyObserver: PersistentHistoryObserver?
    
    private init() {}
    
    private func setupHistoryTracking(container: NSPersistentContainer) {
        historyObserver = PersistentHistoryObserver(container: container, viewContext: container.viewContext)
        cleanHistoryPeriodically(container: container)
    }
    
    private func cleanHistoryPeriodically(container: NSPersistentContainer) {
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
            let context = container.newBackgroundContext()
            let cleaner = PersistentHistoryCleaner(
                context: context,
                targets: [.mainApp, .shareExtension]
            )
            cleaner.clean()
        }
    }
}
```

## Transaction Authors

Set unique transaction authors for each app target:

```swift
// Main app
viewContext.transactionAuthor = "MainApp"

// Share extension
viewContext.transactionAuthor = "ShareExtension"

// Widget extension
viewContext.transactionAuthor = "WidgetExtension"
```

**Why this matters:**
- Filter out your own transactions (avoid redundant merges)
- Identify which target made changes
- Debug multi-target issues

## Filtering Transactions

### By Author

```swift
let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastToken)
if let request = fetchRequest.fetchRequest {
    request.predicate = NSPredicate(format: "author != %@", "MainApp")
}
```

### By Date

```swift
let cutoffDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: cutoffDate)
```

### By Entity

```swift
let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastToken)
if let request = fetchRequest.fetchRequest {
    request.predicate = NSPredicate(format: "ANY changes.changedObjectID.entity.name == %@", "Article")
}
```

## Batch Operations Integration

Persistent history tracking is **required** for batch operations to update the UI:

```swift
// 1. Enable persistent history tracking
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

// 2. Perform batch operation
let context = container.newBackgroundContext()
context.perform {
    let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
        // Insert logic
        return false
    }
    try? context.execute(batchInsert)
}

// 3. UI updates automatically via persistent history tracking
// The observer detects the change and merges it into the view context
```

## Testing Persistent History

```swift
func testPersistentHistory() throws {
    // Enable persistent history
    let description = container.persistentStoreDescriptions.first!
    description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
    
    // Create object in background
    let backgroundContext = container.newBackgroundContext()
    backgroundContext.transactionAuthor = "Test"
    
    let expectation = XCTestExpectation(description: "Save")
    
    backgroundContext.perform {
        let article = Article(context: backgroundContext)
        article.name = "Test"
        try? backgroundContext.save()
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
    
    // Fetch history
    let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: Date.distantPast)
    let result = try container.viewContext.execute(fetchRequest) as? NSPersistentHistoryResult
    let transactions = result?.result as? [NSPersistentHistoryTransaction]
    
    XCTAssertNotNil(transactions)
    XCTAssertFalse(transactions!.isEmpty)
}
```

## Common Pitfalls

### ❌ Not Enabling Remote Change Notifications

```swift
// Only this isn't enough
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

// Need both!
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
```

### ❌ Not Filtering Own Transactions

```swift
// Merges own transactions (redundant)
let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastToken)
```

### ❌ Not Cleaning Old Transactions

```swift
// History grows unbounded, wastes space
// Always implement cleaning!
```

### ❌ Not Setting Transaction Authors

```swift
// Can't filter transactions by source
context.transactionAuthor = nil // Bad!
```

### ✅ Correct Approach

```swift
// 1. Enable both options
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

// 2. Set transaction author
context.transactionAuthor = "MainApp"

// 3. Filter own transactions
fetchRequest.predicate = NSPredicate(format: "author != %@", "MainApp")

// 4. Clean periodically
let cleaner = PersistentHistoryCleaner(context: context, targets: [.mainApp, .shareExtension])
cleaner.clean()
```

## Performance Considerations

### Clean History Regularly

```swift
// Clean daily
Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
    cleaner.clean()
}

// Or on app launch
func applicationDidFinishLaunching() {
    cleaner.clean()
}
```

### Limit Fetch Range

```swift
// Don't fetch all history
let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
let fetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: sevenDaysAgo)
```

### Batch Merge Changes

```swift
// Merge multiple transactions at once
let transactions = try fetcher.fetch()
for transaction in transactions {
    let userInfo = transaction.objectIDNotification().userInfo
    NSManagedObjectContext.mergeChanges(
        fromRemoteContextSave: userInfo!,
        into: [viewContext]
    )
}
```

## Summary

1. **Enable persistent history tracking** - Required for batch operations and multi-target apps
2. **Enable remote change notifications** - Required for cross-context updates
3. **Set transaction authors** - Identify change sources
4. **Filter own transactions** - Avoid redundant merges
5. **Implement all four components** - Observer, Fetcher, Merger, Cleaner
6. **Clean history regularly** - Prevent unbounded growth
7. **Use with batch operations** - Essential for UI updates
8. **Test thoroughly** - Verify history tracking works across targets
