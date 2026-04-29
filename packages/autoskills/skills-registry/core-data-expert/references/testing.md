# Testing Core Data

Testing Core Data requires special setup to avoid conflicts and ensure fast, reliable tests.

## In-Memory Stores

Use in-memory stores for fast, isolated tests:

```swift
class CoreDataTestCase: XCTestCase {
    var container: NSPersistentContainer!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        container = NSPersistentContainer(name: "Model", managedObjectModel: Self.sharedModel)
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { description, error in
            XCTAssertNil(error)
        }
        
        context = container.viewContext
    }
    
    override func tearDown() {
        context = nil
        container = nil
        super.tearDown()
    }
}
```

## Shared Model Pattern

**Problem:** Multiple model instances cause entity description conflicts.

**Error:**
```
Failed to find a unique match for an NSEntityDescription
```

**Solution:** Use shared model instance:

```swift
extension NSManagedObjectModel {
    static let shared: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load model")
        }
        return model
    }()
}

// Use in tests
container = NSPersistentContainer(name: "Model", managedObjectModel: .shared)
```

## Data Generators

Create reproducible test data:

```swift
class TestDataGenerator {
    static func createArticle(
        name: String = "Test Article",
        views: Int = 0,
        in context: NSManagedObjectContext
    ) -> Article {
        let article = Article(context: context)
        article.name = name
        article.views = Int64(views)
        article.creationDate = Date()
        return article
    }
    
    static func createArticles(
        count: Int,
        in context: NSManagedObjectContext
    ) -> [Article] {
        return (0..<count).map { i in
            createArticle(name: "Article \(i)", in: context)
        }
    }
}

// Usage
func testFetchArticles() throws {
    let articles = TestDataGenerator.createArticles(count: 10, in: context)
    try context.save()
    
    let fetchRequest = Article.fetchRequest()
    let results = try context.fetch(fetchRequest)
    
    XCTAssertEqual(results.count, 10)
}
```

## Testing Fetch Requests

```swift
func testFetchWithPredicate() throws {
    // Setup
    TestDataGenerator.createArticle(name: "Swift", views: 100, in: context)
    TestDataGenerator.createArticle(name: "iOS", views: 50, in: context)
    try context.save()
    
    // Test
    let fetchRequest = Article.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "views > %d", 75)
    
    let results = try context.fetch(fetchRequest)
    
    // Verify
    XCTAssertEqual(results.count, 1)
    XCTAssertEqual(results.first?.name, "Swift")
}
```

## Testing Saves

```swift
func testSaveArticle() throws {
    let article = TestDataGenerator.createArticle(in: context)
    
    XCTAssertTrue(context.hasChanges)
    
    try context.save()
    
    XCTAssertFalse(context.hasChanges)
    
    // Verify persistence
    let fetchRequest = Article.fetchRequest()
    let results = try context.fetch(fetchRequest)
    
    XCTAssertEqual(results.count, 1)
    XCTAssertEqual(results.first?.name, "Test Article")
}
```

## Testing Validation

```swift
func testValidation() {
    let article = Article(context: context)
    article.name = "" // Invalid
    
    XCTAssertThrowsError(try context.save()) { error in
        let nsError = error as NSError
        XCTAssertEqual(nsError.domain, NSCocoaErrorDomain)
    }
}
```

## Testing Relationships

```swift
func testArticleCategoryRelationship() throws {
    let category = Category(context: context)
    category.name = "Swift"
    
    let article = Article(context: context)
    article.name = "Test"
    article.category = category
    
    try context.save()
    
    XCTAssertEqual(article.category?.name, "Swift")
    XCTAssertTrue(category.articles?.contains(article) ?? false)
}
```

## Testing Threading

```swift
func testBackgroundContext() {
    let expectation = XCTestExpectation(description: "Background save")
    
    let backgroundContext = container.newBackgroundContext()
    backgroundContext.perform {
        let article = Article(context: backgroundContext)
        article.name = "Background Article"
        
        do {
            try backgroundContext.save()
            expectation.fulfill()
        } catch {
            XCTFail("Save failed: \(error)")
        }
    }
    
    wait(for: [expectation], timeout: 5.0)
}
```

## Testing CloudKit Sync

```swift
func testCloudKitExport() {
    let expectation = XCTestExpectation(description: "Export")
    
    let observer = NotificationCenter.default.addObserver(
        forName: NSPersistentCloudKitContainer.eventChangedNotification,
        object: container,
        queue: nil
    ) { notification in
        guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey]
                as? NSPersistentCloudKitContainer.Event else {
            return
        }
        
        if event.type == .export && event.endDate != nil {
            expectation.fulfill()
        }
    }
    
    let article = Article(context: context)
    article.name = "Test"
    try? context.save()
    
    wait(for: [expectation], timeout: 60)
    NotificationCenter.default.removeObserver(observer)
}
```

## Performance Testing

```swift
func testBatchInsertPerformance() {
    measure {
        let context = container.newBackgroundContext()
        context.performAndWait {
            var index = 0
            let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
                guard index < 1000 else { return true }
                guard let article = object as? Article else { return true }
                article.name = "Article \(index)"
                index += 1
                return false
            }
            try? context.execute(batchInsert)
        }
    }
}
```

## Test Utilities

```swift
extension XCTestCase {
    func createTestContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(
            name: "Model",
            managedObjectModel: .shared
        )
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        let expectation = self.expectation(description: "Load store")
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
        return container
    }
}
```

## Best Practices

1. **Use in-memory stores** - Fast, isolated tests
2. **Use shared model** - Avoid entity description conflicts
3. **Create data generators** - Reproducible test data
4. **Test on background contexts** - Verify threading
5. **Use expectations** - For asynchronous operations
6. **Measure performance** - Use `measure` blocks
7. **Clean up** - Reset context between tests
8. **Test validation** - Verify business rules
9. **Test relationships** - Ensure integrity
10. **Test migrations** - Verify upgrade paths

## Summary

- Use in-memory stores for fast tests
- Share model instance to avoid conflicts
- Create data generators for reproducible tests
- Test fetch requests, saves, validation, and relationships
- Use expectations for async operations
- Measure performance with `measure` blocks
- Test threading with background contexts
- Test CloudKit sync with event notifications
