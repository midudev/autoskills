# Fetch Requests and Querying

Optimizing fetch requests is crucial for app performance. This guide covers best practices for querying Core Data efficiently, from basic fetches to advanced aggregations.

## Basic Fetch Request

```swift
let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
let articles = try context.fetch(fetchRequest)
```

## Optimization Strategies

### 1. Limit Properties Fetched

Only fetch the properties you actually need:

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.propertiesToFetch = ["name", "creationDate"]

// For list view, you might only need:
fetchRequest.propertiesToFetch = ["name", "categoryName", "views"]
```

**SQL Impact:**
```sql
-- Without propertiesToFetch
SELECT * FROM ZARTICLE

-- With propertiesToFetch
SELECT Z_PK, ZNAME, ZCREATIONDATE FROM ZARTICLE
```

**Benefits:**
- Reduces memory usage
- Faster query execution
- Less data transferred from disk

### 2. Use Batch Fetching

Fetch objects in batches to avoid loading everything at once:

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.fetchBatchSize = 20
```

**How it works:**
- Initially fetches only 20 objects
- Fetches next batch when needed (scrolling, iteration)
- Keeps memory usage predictable

**When to use:**
- List views (table/collection views)
- Large datasets
- Scrollable content

### 3. Set Fetch Limit

When you only need a specific number of results:

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.fetchLimit = 1 // Only fetch one result
```

**Common use cases:**
```swift
// Get newest article
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
fetchRequest.fetchLimit = 1

// Get top 10 most viewed
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "views", ascending: false)]
fetchRequest.fetchLimit = 10
```

### 4. Fetch Only Object IDs

For counting or checking existence, fetch only IDs:

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.resultType = .managedObjectIDResultType

let objectIDs = try context.fetch(fetchRequest) as! [NSManagedObjectID]
```

**Benefits:**
- Minimal memory usage
- Very fast
- No faulting overhead

**Use for:**
- Counting objects
- Checking existence
- Batch operations
- Validation

## Sort Descriptors

Always specify sort descriptors for predictable results:

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.sortDescriptors = [
    NSSortDescriptor(key: "creationDate", ascending: false)
]
```

### Multiple Sort Descriptors

```swift
fetchRequest.sortDescriptors = [
    NSSortDescriptor(key: "category.name", ascending: true),
    NSSortDescriptor(key: "name", ascending: true)
]
```

### Case-Insensitive Sorting

```swift
let sortDescriptor = NSSortDescriptor(
    key: "name",
    ascending: true,
    selector: #selector(NSString.caseInsensitiveCompare(_:))
)
fetchRequest.sortDescriptors = [sortDescriptor]
```

### Localized Sorting

```swift
let sortDescriptor = NSSortDescriptor(
    key: "name",
    ascending: true,
    selector: #selector(NSString.localizedStandardCompare(_:))
)
fetchRequest.sortDescriptors = [sortDescriptor]
```

## Predicates

Filter results using predicates:

### Basic Predicates

```swift
// Exact match
fetchRequest.predicate = NSPredicate(format: "name == %@", "SwiftLee")

// Contains
fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", "swift")
// [c] = case insensitive, [d] = diacritic insensitive

// Begins with
fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[c] %@", "Swift")

// Greater than
fetchRequest.predicate = NSPredicate(format: "views > %d", 100)

// Date range
let startDate = Calendar.current.startOfDay(for: Date())
let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
fetchRequest.predicate = NSPredicate(
    format: "creationDate >= %@ AND creationDate < %@",
    startDate as NSDate,
    endDate as NSDate
)
```

### Compound Predicates

```swift
// AND
let predicate1 = NSPredicate(format: "views > %d", 100)
let predicate2 = NSPredicate(format: "category.name == %@", "Swift")
fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])

// OR
fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])

// NOT
fetchRequest.predicate = NSCompoundPredicate(notPredicateWithSubpredicate: predicate1)
```

### Relationship Predicates

```swift
// Articles with a specific category
fetchRequest.predicate = NSPredicate(format: "category.name == %@", "Swift")

// Articles with any attachments
fetchRequest.predicate = NSPredicate(format: "attachments.@count > 0")

// Articles with more than 5 attachments
fetchRequest.predicate = NSPredicate(format: "attachments.@count > 5")

// Using ANY
fetchRequest.predicate = NSPredicate(format: "ANY attachments.size > %d", 1000000)

// Using ALL
fetchRequest.predicate = NSPredicate(format: "ALL attachments.isDownloaded == YES")
```

### IN Predicate

```swift
let names = ["Swift", "iOS", "Core Data"]
fetchRequest.predicate = NSPredicate(format: "name IN %@", names)
```

## NSFetchedResultsController

For table and collection views, use `NSFetchedResultsController` for automatic updates:

```swift
class ArticlesViewController: UIViewController {
    var fetchedResultsController: NSFetchedResultsController<Article>!
    
    func setupFetchedResultsController() {
        let fetchRequest = Article.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        fetchRequest.fetchBatchSize = 20
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: "ArticlesCache"
        )
        
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
    }
}
```

### With Sections

```swift
fetchedResultsController = NSFetchedResultsController(
    fetchRequest: fetchRequest,
    managedObjectContext: viewContext,
    sectionNameKeyPath: "category.name", // Group by category
    cacheName: "ArticlesByCategoryCache"
)
```

### Delegate Methods (UITableView)

```swift
extension ArticlesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                   didChange anObject: Any,
                   at indexPath: IndexPath?,
                   for type: NSFetchedResultsChangeType,
                   newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
```

## Diffable Data Sources (iOS 13+)

Modern approach using `NSDiffableDataSourceSnapshot`:

```swift
class ArticlesViewController: UICollectionViewController {
    private var dataSource: UICollectionViewDiffableDataSource<String, NSManagedObjectID>!
    private var fetchedResultsController: NSFetchedResultsController<Article>!
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, NSManagedObjectID>(
            collectionView: collectionView
        ) { collectionView, indexPath, objectID in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ArticleCell",
                for: indexPath
            ) as! ArticleCell
            
            if let article = try? self.viewContext.existingObject(with: objectID) as? Article {
                cell.configure(with: article)
            }
            
            return cell
        }
    }
    
    func setupFetchedResultsController() {
        let fetchRequest = Article.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
}

extension ArticlesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                   didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let snapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
```

## Aggregate Fetching with NSExpression

For statistics and aggregations:

### Count

```swift
// Simple count
let count = try context.count(for: Article.fetchRequest())

// Count with predicate
let fetchRequest = Article.fetchRequest()
fetchRequest.predicate = NSPredicate(format: "views > %d", 100)
let count = try context.count(for: fetchRequest)
```

### Sum, Average, Min, Max

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.resultType = .dictionaryResultType

// Sum of views
let sumExpression = NSExpression(format: "@sum.views")
let sumDescription = NSExpressionDescription()
sumDescription.name = "totalViews"
sumDescription.expression = sumExpression
sumDescription.expressionResultType = .integer64AttributeType

fetchRequest.propertiesToFetch = [sumDescription]

let results = try context.fetch(fetchRequest) as! [[String: Any]]
if let totalViews = results.first?["totalViews"] as? Int {
    print("Total views: \(totalViews)")
}
```

### Group By with Aggregates

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.resultType = .dictionaryResultType

// Category name
let categoryExpression = NSExpression(forKeyPath: "category.name")
let categoryDescription = NSExpressionDescription()
categoryDescription.name = "categoryName"
categoryDescription.expression = categoryExpression
categoryDescription.expressionResultType = .stringAttributeType

// Sum of views per category
let sumExpression = NSExpression(format: "@sum.views")
let sumDescription = NSExpressionDescription()
sumDescription.name = "totalViews"
sumDescription.expression = sumExpression
sumDescription.expressionResultType = .integer64AttributeType

fetchRequest.propertiesToFetch = [categoryDescription, sumDescription]
fetchRequest.propertiesToGroupBy = ["category.name"]
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "categoryName", ascending: true)]

let results = try context.fetch(fetchRequest) as! [[String: Any]]
for result in results {
    let category = result["categoryName"] as? String ?? "Unknown"
    let views = result["totalViews"] as? Int ?? 0
    print("\(category): \(views) views")
}
```

### Count Per Group

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.resultType = .dictionaryResultType

let categoryExpression = NSExpression(forKeyPath: "category.name")
let categoryDescription = NSExpressionDescription()
categoryDescription.name = "categoryName"
categoryDescription.expression = categoryExpression
categoryDescription.expressionResultType = .stringAttributeType

let countExpression = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "objectID")])
let countDescription = NSExpressionDescription()
countDescription.name = "count"
countDescription.expression = countExpression
countDescription.expressionResultType = .integer64AttributeType

fetchRequest.propertiesToFetch = [categoryDescription, countDescription]
fetchRequest.propertiesToGroupBy = ["category.name"]

let results = try context.fetch(fetchRequest) as! [[String: Any]]
```

## Typed Fetch Requests with Managed Protocol

Create a protocol for type-safe fetch requests:

```swift
protocol Managed: NSManagedObject {
    static var entityName: String { get }
}

extension Managed {
    static var entityName: String {
        return String(describing: self)
    }
    
    static func fetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: entityName)
    }
}

// Conform your entities
extension Article: Managed {}

// Usage
let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
```

## Asynchronous Fetching

For large datasets, fetch asynchronously:

```swift
let fetchRequest = Article.fetchRequest()
let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
    guard let articles = result.finalResult else { return }
    
    DispatchQueue.main.async {
        // Update UI with articles
    }
}

try? context.execute(asyncFetchRequest)
```

## Faulting Control

### Prefetching Relationships

```swift
let fetchRequest = Article.fetchRequest()
fetchRequest.relationshipKeyPathsForPrefetching = ["category", "attachments"]
```

**Benefits:**
- Reduces number of database trips
- Improves performance when accessing relationships
- Prevents N+1 query problem

### Returning Faults

```swift
fetchRequest.returnsObjectsAsFaults = false
```

**When to use:**
- You know you'll access all properties immediately
- Small result sets
- Avoid for large datasets (high memory usage)

## Common Patterns

### Fetch Single Object by ID

```swift
func fetchArticle(withID id: NSManagedObjectID) -> Article? {
    return try? context.existingObject(with: id) as? Article
}
```

### Fetch or Create

```swift
func fetchOrCreateArticle(withName name: String) -> Article {
    let fetchRequest = Article.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    fetchRequest.fetchLimit = 1
    
    if let existing = try? context.fetch(fetchRequest).first {
        return existing
    }
    
    let article = Article(context: context)
    article.name = name
    return article
}
```

### Check Existence

```swift
func articleExists(withName name: String) -> Bool {
    let fetchRequest = Article.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    fetchRequest.fetchLimit = 1
    fetchRequest.resultType = .countResultType
    
    let count = (try? context.count(for: fetchRequest)) ?? 0
    return count > 0
}
```

## Performance Tips

### ❌ Don't Fetch Everything

```swift
// Bad: Fetches all properties, all objects
let articles = try context.fetch(Article.fetchRequest())
let count = articles.count
```

### ✅ Use Count Request

```swift
// Good: Only counts, doesn't fetch objects
let count = try context.count(for: Article.fetchRequest())
```

### ❌ Don't Access Relationships in Loops

```swift
// Bad: Fires fault for each article
for article in articles {
    print(article.category?.name) // Fault!
}
```

### ✅ Prefetch Relationships

```swift
// Good: Prefetches all categories at once
let fetchRequest = Article.fetchRequest()
fetchRequest.relationshipKeyPathsForPrefetching = ["category"]
let articles = try context.fetch(fetchRequest)

for article in articles {
    print(article.category?.name) // No fault!
}
```

### ❌ Don't Fetch in Loops

```swift
// Bad: Multiple fetch requests
for name in names {
    let fetchRequest = Article.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    let articles = try? context.fetch(fetchRequest)
}
```

### ✅ Use IN Predicate

```swift
// Good: Single fetch request
let fetchRequest = Article.fetchRequest()
fetchRequest.predicate = NSPredicate(format: "name IN %@", names)
let articles = try context.fetch(fetchRequest)
```

## Debugging Fetch Requests

### Enable SQL Debug

Add launch argument:
```
-com.apple.CoreData.SQLDebug 1
```

**Output:**
```sql
CoreData: sql: SELECT Z_PK, ZNAME, ZVIEWS FROM ZARTICLE WHERE ZVIEWS > ? ORDER BY ZCREATIONDATE DESC LIMIT 20
```

### Measure Fetch Performance

```swift
let startTime = CFAbsoluteTimeGetCurrent()
let articles = try context.fetch(fetchRequest)
let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
print("Fetch took \(timeElapsed) seconds")
```

## Summary

1. **Use `propertiesToFetch`** to limit fetched properties
2. **Set `fetchBatchSize`** for large datasets (typically 20-50)
3. **Use `fetchLimit`** when you only need a few results
4. **Always specify sort descriptors** for predictable results
5. **Use predicates** to filter at the database level
6. **Use `NSFetchedResultsController`** for list views
7. **Prefetch relationships** to avoid N+1 queries
8. **Use count requests** instead of fetching for counts
9. **Use aggregate expressions** for statistics
10. **Enable SQL debug** to understand query performance
