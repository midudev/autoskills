# Batch Operations

Batch operations provide significant performance improvements for large-scale data modifications. They operate directly at the SQL level, bypassing the object graph.

## Overview

Core Data provides three batch operation types:
- **NSBatchInsertRequest** - Bulk inserts (iOS 14+)
- **NSBatchDeleteRequest** - Bulk deletes
- **NSBatchUpdateRequest** - Bulk updates

**Key Characteristics:**
- Operate at SQL level (very fast)
- Don't load objects into memory
- Don't trigger validation
- Don't send change notifications (requires persistent history tracking)
- Can't set relationships during batch insert

## NSBatchInsertRequest (iOS 14+)

### Basic Usage

```swift
let context = container.newBackgroundContext()

context.perform {
    let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { (object: NSManagedObject) -> Bool in
        guard let article = object as? Article else { return true }
        
        article.name = "Sample Article"
        article.content = "Content here"
        article.creationDate = Date()
        
        return false // Continue inserting
    }
    
    do {
        try context.execute(batchInsert)
    } catch {
        print("Batch insert failed: \(error)")
    }
}
```

### Inserting Multiple Objects

```swift
func batchInsertArticles(_ data: [ArticleData]) {
    let context = container.newBackgroundContext()
    
    context.perform {
        var index = 0
        let batchInsert = NSBatchInsertRequest(
            entity: Article.entity()
        ) { (object: NSManagedObject) -> Bool in
            guard index < data.count else { return true } // Stop
            guard let article = object as? Article else { return true }
            
            let articleData = data[index]
            article.name = articleData.name
            article.content = articleData.content
            article.creationDate = Date()
            
            index += 1
            return false // Continue
        }
        
        do {
            try context.execute(batchInsert)
        } catch {
            print("Batch insert failed: \(error)")
        }
    }
}
```

### Using Dictionary Representation (Alternative)

```swift
let context = container.newBackgroundContext()

context.perform {
    let objects: [[String: Any]] = [
        ["name": "Article 1", "content": "Content 1", "creationDate": Date()],
        ["name": "Article 2", "content": "Content 2", "creationDate": Date()],
        ["name": "Article 3", "content": "Content 3", "creationDate": Date()]
    ]
    
    let batchInsert = NSBatchInsertRequest(
        entity: Article.entity(),
        objects: objects
    )
    
    do {
        try context.execute(batchInsert)
    } catch {
        print("Batch insert failed: \(error)")
    }
}
```

### Limitations

**Cannot set relationships:**
```swift
// ❌ This won't work
let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
    guard let article = object as? Article else { return true }
    article.category = someCategory // Can't set relationships!
    return false
}
```

**Workaround:** Set relationships after batch insert:
```swift
// 1. Batch insert articles
let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
    guard let article = object as? Article else { return true }
    article.name = "Article"
    return false
}
try context.execute(batchInsert)

// 2. Fetch and set relationships
let fetchRequest = Article.fetchRequest()
let articles = try context.fetch(fetchRequest)
for article in articles {
    article.category = defaultCategory
}
try context.save()
```

## NSBatchDeleteRequest

### Basic Usage

```swift
let context = container.newBackgroundContext()

context.perform {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Article.fetchRequest()
    let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        try context.execute(batchDelete)
    } catch {
        print("Batch delete failed: \(error)")
    }
}
```

### With Predicate

```swift
let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Article.fetchRequest()
fetchRequest.predicate = NSPredicate(format: "views < %d", 10)

let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)

context.perform {
    do {
        try context.execute(batchDelete)
    } catch {
        print("Batch delete failed: \(error)")
    }
}
```

### Getting Deleted Object IDs

```swift
let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Article.fetchRequest()
let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
batchDelete.resultType = .resultTypeObjectIDs

context.perform {
    do {
        let result = try context.execute(batchDelete) as? NSBatchDeleteResult
        if let objectIDs = result?.result as? [NSManagedObjectID] {
            print("Deleted \(objectIDs.count) objects")
        }
    } catch {
        print("Batch delete failed: \(error)")
    }
}
```

## NSBatchUpdateRequest

### Basic Usage

```swift
let context = container.newBackgroundContext()

context.perform {
    let batchUpdate = NSBatchUpdateRequest(entityName: "Article")
    batchUpdate.predicate = NSPredicate(format: "isRead == NO")
    batchUpdate.propertiesToUpdate = ["isRead": true]
    
    do {
        try context.execute(batchUpdate)
    } catch {
        print("Batch update failed: \(error)")
    }
}
```

### Updating Multiple Properties

```swift
let batchUpdate = NSBatchUpdateRequest(entityName: "Article")
batchUpdate.predicate = NSPredicate(format: "views < %d", 100)
batchUpdate.propertiesToUpdate = [
    "views": 100,
    "lastModified": Date(),
    "isPopular": true
]

context.perform {
    try? context.execute(batchUpdate)
}
```

### Using Expressions

```swift
// Increment views by 1
let batchUpdate = NSBatchUpdateRequest(entityName: "Article")
batchUpdate.propertiesToUpdate = [
    "views": NSExpression(format: "views + 1")
]

context.perform {
    try? context.execute(batchUpdate)
}
```

### Getting Updated Object IDs

```swift
let batchUpdate = NSBatchUpdateRequest(entityName: "Article")
batchUpdate.propertiesToUpdate = ["isRead": true]
batchUpdate.resultType = .updatedObjectIDsResultType

context.perform {
    do {
        let result = try context.execute(batchUpdate) as? NSBatchUpdateResult
        if let objectIDs = result?.result as? [NSManagedObjectID] {
            print("Updated \(objectIDs.count) objects")
        }
    } catch {
        print("Batch update failed: \(error)")
    }
}
```

## Persistent History Tracking Integration

**Critical:** Batch operations don't send change notifications. You **must** enable persistent history tracking for UI updates.

### Enable Persistent History Tracking

```swift
guard let description = container.persistentStoreDescriptions.first else { return }

description.setOption(true as NSNumber, 
                     forKey: NSPersistentHistoryTrackingKey)
description.setOption(true as NSNumber,
                     forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
```

### Observe Remote Changes

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(storeRemoteChange),
    name: .NSPersistentStoreRemoteChange,
    object: container.persistentStoreCoordinator
)

@objc func storeRemoteChange(_ notification: Notification) {
    // Merge changes into view context
    // See persistent-history.md for full implementation
}
```

## Performance Comparison

### Traditional Insert (Slow)

```swift
// Inserting 1000 objects: ~10 seconds
for i in 0..<1000 {
    let article = Article(context: context)
    article.name = "Article \(i)"
}
try context.save()
```

### Batch Insert (Fast)

```swift
// Inserting 1000 objects: ~0.5 seconds
var index = 0
let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
    guard index < 1000 else { return true }
    guard let article = object as? Article else { return true }
    article.name = "Article \(index)"
    index += 1
    return false
}
try context.execute(batchInsert)
```

**Performance gain: ~20x faster**

## When to Use Batch Operations

### Use Batch Insert When:
- Importing large datasets (>100 objects)
- Initial data seeding
- Syncing data from server
- Performance is critical

### Use Batch Delete When:
- Deleting many objects at once
- Clearing old data
- Implementing data retention policies
- Performance is critical

### Use Batch Update When:
- Updating many objects with same values
- Bulk status changes
- Incrementing counters
- Performance is critical

### Don't Use Batch Operations When:
- Need to set relationships
- Need validation
- Need to trigger lifecycle events (willSave, etc.)
- Working with small datasets (<50 objects)
- Need immediate UI updates without persistent history tracking

## Complete Example: Import with Batch Insert

```swift
class DataImporter {
    let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func importArticles(_ data: [ArticleData]) {
        let context = container.newBackgroundContext()
        
        context.perform {
            var index = 0
            let batchInsert = NSBatchInsertRequest(
                entity: Article.entity()
            ) { (object: NSManagedObject) -> Bool in
                guard index < data.count else { return true }
                guard let article = object as? Article else { return true }
                
                let articleData = data[index]
                article.name = articleData.name
                article.content = articleData.content
                article.views = 0
                article.creationDate = Date()
                
                index += 1
                return false
            }
            
            do {
                let result = try context.execute(batchInsert) as? NSBatchInsertResult
                print("Inserted \(data.count) articles")
                
                // If you need the object IDs
                if let objectIDs = result?.result as? [NSManagedObjectID] {
                    print("Object IDs: \(objectIDs)")
                }
            } catch {
                print("Batch insert failed: \(error)")
            }
        }
    }
}
```

## Complete Example: Cleanup with Batch Delete

```swift
class DataCleaner {
    let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func deleteOldArticles(olderThan days: Int) {
        let context = container.newBackgroundContext()
        
        context.perform {
            let cutoffDate = Calendar.current.date(
                byAdding: .day,
                value: -days,
                to: Date()
            )!
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Article.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "creationDate < %@",
                cutoffDate as NSDate
            )
            
            let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDelete.resultType = .resultTypeCount
            
            do {
                let result = try context.execute(batchDelete) as? NSBatchDeleteResult
                if let count = result?.result as? Int {
                    print("Deleted \(count) old articles")
                }
            } catch {
                print("Batch delete failed: \(error)")
            }
        }
    }
}
```

## Common Pitfalls

### ❌ Not Enabling Persistent History Tracking

```swift
// Batch insert happens
let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { ... }
try context.execute(batchInsert)

// UI doesn't update! No notifications sent
```

### ❌ Trying to Set Relationships

```swift
let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
    guard let article = object as? Article else { return true }
    article.category = category // Won't work!
    return false
}
```

### ❌ Expecting Validation

```swift
// No validation happens!
let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
    guard let article = object as? Article else { return true }
    article.name = "" // Empty name - no validation error
    return false
}
```

### ❌ Using on View Context

```swift
// Don't use batch operations on view context
viewContext.perform {
    let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { ... }
    try? viewContext.execute(batchInsert) // Blocks UI!
}
```

### ✅ Correct Approach

```swift
// 1. Enable persistent history tracking
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

// 2. Use background context
let context = container.newBackgroundContext()

// 3. Execute batch operation
context.perform {
    let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
        guard let article = object as? Article else { return true }
        article.name = "Valid Name"
        return false
    }
    try? context.execute(batchInsert)
}

// 4. UI updates via persistent history tracking
```

## Testing Batch Operations

```swift
func testBatchInsert() throws {
    let context = container.newBackgroundContext()
    
    let expectation = XCTestExpectation(description: "Batch insert")
    
    context.perform {
        var count = 0
        let batchInsert = NSBatchInsertRequest(entity: Article.entity()) { object in
            guard count < 10 else { return true }
            guard let article = object as? Article else { return true }
            article.name = "Article \(count)"
            count += 1
            return false
        }
        
        do {
            try context.execute(batchInsert)
            expectation.fulfill()
        } catch {
            XCTFail("Batch insert failed: \(error)")
        }
    }
    
    wait(for: [expectation], timeout: 5.0)
    
    // Verify
    let fetchRequest = Article.fetchRequest()
    let articles = try context.fetch(fetchRequest)
    XCTAssertEqual(articles.count, 10)
}
```

## Summary

1. **Use batch operations for large datasets** - 10-20x performance improvement
2. **Enable persistent history tracking** - Required for UI updates
3. **Use background contexts** - Don't block UI
4. **Can't set relationships in batch insert** - Set them separately if needed
5. **No validation or lifecycle events** - Batch operations bypass object graph
6. **Get result types** - Use resultType to get object IDs or counts
7. **Test thoroughly** - Verify data integrity after batch operations
8. **Consider trade-offs** - Speed vs validation/relationships/lifecycle events
