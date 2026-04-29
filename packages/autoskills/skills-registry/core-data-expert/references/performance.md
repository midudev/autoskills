# Performance Optimization

Optimizing Core Data performance requires understanding where bottlenecks occur and applying targeted solutions.

## Profiling with Instruments

### Time Profiler

1. In Xcode: Product → Profile
2. Select Time Profiler
3. Record while using app
4. Find heaviest stack traces

**Look for:**
- Excessive faulting
- Slow fetch requests
- Save operations taking too long

### Allocations Instrument

1. Product → Profile
2. Select Allocations
3. Monitor memory growth
4. Identify retained objects

**Look for:**
- Unbounded memory growth
- Objects not being released
- Large allocations

## SQL Debug Logging

Enable SQL logging:
```
-com.apple.CoreData.SQLDebug 1
```

**Output:**
```sql
CoreData: sql: SELECT Z_PK, ZNAME FROM ZARTICLE WHERE ZVIEWS > ? LIMIT 20
CoreData: annotation: sql execution time: 0.0023s
```

**Analyze:**
- Query complexity
- Execution time
- Number of queries (N+1 problem)

## Common Performance Issues

### 1. N+1 Query Problem

**Problem:**
```swift
// Fetches articles
let articles = try context.fetch(Article.fetchRequest())

// Each access fires a fault (N queries)
for article in articles {
    print(article.category?.name) // Fault!
}
```

**Solution:**
```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.relationshipKeyPathsForPrefetching = ["category"]
let articles = try context.fetch(fetchRequest)

// No faults fired
for article in articles {
    print(article.category?.name) // Already loaded
}
```

### 2. Fetching Too Much Data

**Problem:**
```swift
// Fetches all properties of all objects
let articles = try context.fetch(Article.fetchRequest())
let count = articles.count
```

**Solution:**
```swift
// Only counts, doesn't fetch objects
let count = try context.count(for: Article.fetchRequest())
```

### 3. Not Using Batch Sizes

**Problem:**
```swift
// Loads 10,000 objects into memory
let fetchRequest = Article.fetchRequest()
let articles = try context.fetch(fetchRequest)
```

**Solution:**
```swift
fetchRequest.fetchBatchSize = 20
// Only loads 20 at a time
```

### 4. Fetching Unnecessary Properties

**Problem:**
```swift
// Fetches all properties
let fetchRequest = Article.fetchRequest()
```

**Solution:**
```swift
fetchRequest.propertiesToFetch = ["name", "creationDate"]
// Only fetches needed properties
```

### 5. Saving Too Frequently

**Problem:**
```swift
for item in items {
    item.processed = true
    try? context.save() // Very slow!
}
```

**Solution:**
```swift
for item in items {
    item.processed = true
}
try? context.save() // Save once
```

### 6. Not Resetting Context

**Problem:**
```swift
// Context accumulates objects
for i in 0..<10000 {
    let article = Article(context: context)
    // Memory grows unbounded
}
```

**Solution:**
```swift
for i in 0..<10000 {
    let article = Article(context: context)
    
    if i % 100 == 0 {
        try? context.save()
        context.reset() // Clear memory
    }
}
```

## Memory Management

### Context Reset

```swift
context.reset()
```

**When to use:**
- After processing large batches
- When context accumulates many objects
- To free memory

**Caution:** Invalidates all fetched objects from this context.

### Refresh Objects

```swift
context.refresh(article, mergeChanges: false)
```

**When to use:**
- Discard in-memory changes
- Free memory for specific object
- Reload from database

### Turn Objects into Faults

```swift
context.refreshAllObjects()
```

**When to use:**
- Free memory across all objects
- After large operations
- When memory is constrained

## Fetch Request Optimization

### Checklist

```swift
let fetchRequest = Article.fetchRequest()

// ✅ Set batch size
fetchRequest.fetchBatchSize = 20

// ✅ Limit properties
fetchRequest.propertiesToFetch = ["name", "views"]

// ✅ Prefetch relationships
fetchRequest.relationshipKeyPathsForPrefetching = ["category"]

// ✅ Use predicate to filter
fetchRequest.predicate = NSPredicate(format: "views > %d", 100)

// ✅ Set fetch limit if applicable
fetchRequest.fetchLimit = 10

// ✅ Specify sort descriptors
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
```

## Batch Operations

For large-scale operations, use batch requests:

```swift
// Instead of:
for article in articles {
    article.isRead = true
}
try context.save()

// Use:
let batchUpdate = NSBatchUpdateRequest(entityName: "Article")
batchUpdate.propertiesToUpdate = ["isRead": true]
try context.execute(batchUpdate)
```

**Benefits:**
- 10-20x faster
- Lower memory usage
- SQL-level operations

## Data Generators for Testing

Create reproducible test datasets:

```swift
class DataGenerator {
    func generate(count: Int, in context: NSManagedObjectContext) {
        for i in 0..<count {
            let article = Article(context: context)
            article.name = "Article \(i)"
            
            if i % 100 == 0 {
                try? context.save()
                context.reset()
            }
        }
        try? context.save()
    }
}

// Usage
let generator = DataGenerator()
generator.generate(count: 10000, in: backgroundContext)
```

## Profiling Checklist

1. **Enable SQL debug** - See actual queries
2. **Profile with Time Profiler** - Find slow operations
3. **Profile with Allocations** - Find memory issues
4. **Test with realistic data** - Small datasets hide problems
5. **Monitor on device** - Simulator performance differs
6. **Test on older devices** - Performance varies

## Quick Wins

1. **Use `count(for:)` instead of fetching** - 100x faster
2. **Set `fetchBatchSize`** - Reduces memory
3. **Prefetch relationships** - Eliminates N+1 queries
4. **Use `propertiesToFetch`** - Reduces data transfer
5. **Reset context periodically** - Frees memory
6. **Use batch operations** - 10-20x faster for bulk changes
7. **Save conditionally** - Check `hasPersistentChanges`
8. **Use background contexts** - Keep UI responsive

## Summary

1. **Profile first** - Measure before optimizing
2. **Use Instruments** - Time Profiler and Allocations
3. **Enable SQL debug** - Understand query behavior
4. **Optimize fetch requests** - Batch size, properties, prefetching
5. **Use batch operations** - For large-scale changes
6. **Reset contexts** - Free memory periodically
7. **Test with real data** - Small datasets hide issues
8. **Monitor on devices** - Real-world performance matters
