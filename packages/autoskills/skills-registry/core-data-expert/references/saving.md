# Saving in Core Data

Saving data efficiently is crucial for app performance and user experience. This guide covers best practices for when, how, and where to save your Core Data changes.

## The Problem with Always Saving

Calling `save()` unconditionally has performance costs:

```swift
// ❌ Bad: Always saving, even when nothing changed
func updateUI() {
    article.lastViewed = Date()
    try? context.save() // Expensive even if nothing changed!
}
```

**Problems:**
- Writes to disk even when no changes exist
- Triggers merge notifications unnecessarily
- Wastes CPU and battery
- Slows down your app

## Conditional Saving with hasChanges

The first improvement is checking `hasChanges`:

```swift
// ✅ Better: Only save if there are changes
if context.hasChanges {
    try context.save()
}
```

**Benefits:**
- Avoids unnecessary disk writes
- Faster performance
- Still simple to use

**Limitation:**
- `hasChanges` returns `true` for transient properties too
- Transient changes don't need to be persisted

## Best Practice: hasPersistentChanges

Check for **persistent** changes only, excluding transient properties:

```swift
extension NSManagedObjectContext {
    var hasPersistentChanges: Bool {
        return !insertedObjects.isEmpty || 
               !deletedObjects.isEmpty || 
               updatedObjects.contains(where: { $0.hasPersistentChangedValues })
    }
    
    func saveIfNeeded() throws {
        guard hasPersistentChanges else { return }
        try save()
    }
}

// Usage
try context.saveIfNeeded()
```

**Why this is better:**
- Excludes transient property changes
- Only saves when data actually needs persisting
- Most efficient approach

### Understanding hasPersistentChangedValues

```swift
extension NSManagedObject {
    var hasPersistentChangedValues: Bool {
        return !changedValues().isEmpty
    }
}
```

This checks if the object has **any** changed values. For more granular control:

```swift
extension NSManagedObject {
    var hasPersistentChangedValues: Bool {
        let changedKeys = Set(changedValues().keys)
        let persistentKeys = Set(entity.attributesByName.keys)
            .union(entity.relationshipsByName.keys)
            .subtracting(entity.transientAttributeNames)
        return !changedKeys.intersection(persistentKeys).isEmpty
    }
}

extension NSEntityDescription {
    var transientAttributeNames: Set<String> {
        return Set(attributesByName.filter { $0.value.isTransient }.map { $0.key })
    }
}
```

## When to Save

### Save on App Lifecycle Events

```swift
// AppDelegate or SceneDelegate
func applicationWillTerminate(_ application: UIApplication) {
    try? CoreDataStack.shared.viewContext.saveIfNeeded()
}

func sceneDidEnterBackground(_ scene: UIScene) {
    try? CoreDataStack.shared.viewContext.saveIfNeeded()
}
```

### Save After User Actions

```swift
// After user completes an action
@IBAction func saveButtonTapped(_ sender: UIButton) {
    article.name = nameTextField.text
    article.content = contentTextView.text
    
    do {
        try context.saveIfNeeded()
        dismiss(animated: true)
    } catch {
        // Handle error
        showError(error)
    }
}
```

### Save Periodically for Long-Running Operations

```swift
func importLargeDataset() {
    let context = container.newBackgroundContext()
    context.perform {
        for (index, data) in largeDataset.enumerated() {
            let article = Article(context: context)
            article.name = data.name
            
            // Save every 100 objects
            if index % 100 == 0 {
                try? context.saveIfNeeded()
            }
        }
        
        // Final save
        try? context.saveIfNeeded()
    }
}
```

### Don't Save Too Frequently

```swift
// ❌ Bad: Saving on every keystroke
func textFieldDidChange(_ textField: UITextField) {
    article.name = textField.text
    try? context.save() // Too frequent!
}

// ✅ Better: Save when editing ends
func textFieldDidEndEditing(_ textField: UITextField) {
    article.name = textField.text
    try? context.saveIfNeeded()
}

// ✅ Best: Use debouncing for auto-save
private var saveWorkItem: DispatchWorkItem?

func textFieldDidChange(_ textField: UITextField) {
    article.name = textField.text
    
    // Cancel previous save
    saveWorkItem?.cancel()
    
    // Schedule new save after 2 seconds of inactivity
    let workItem = DispatchWorkItem { [weak self] in
        try? self?.context.saveIfNeeded()
    }
    saveWorkItem = workItem
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
}
```

## Error Handling

### Basic Error Handling

```swift
do {
    try context.save()
} catch {
    print("Failed to save: \(error)")
}
```

### Detailed Error Handling

```swift
do {
    try context.save()
} catch let error as NSError {
    print("Failed to save context: \(error)")
    print("User info: \(error.userInfo)")
    
    // Check for specific errors
    if error.domain == NSCocoaErrorDomain {
        switch error.code {
        case NSValidationStringTooShortError:
            print("String too short")
        case NSValidationStringTooLongError:
            print("String too long")
        case NSManagedObjectValidationError:
            print("Validation error")
        case NSManagedObjectConstraintValidationError:
            print("Constraint violation")
        default:
            print("Other error: \(error.code)")
        }
    }
}
```

### User-Friendly Error Messages

```swift
extension NSError {
    var userFriendlyMessage: String {
        guard domain == NSCocoaErrorDomain else {
            return localizedDescription
        }
        
        switch code {
        case NSValidationStringTooShortError:
            return "The text is too short. Please enter at least 3 characters."
        case NSValidationStringTooLongError:
            return "The text is too long. Please keep it under 100 characters."
        case NSManagedObjectConstraintValidationError:
            return "This item already exists. Please use a different name."
        case NSManagedObjectValidationError:
            return "Please check your input and try again."
        default:
            return "Failed to save: \(localizedDescription)"
        }
    }
}

// Usage
do {
    try context.save()
} catch let error as NSError {
    showAlert(message: error.userFriendlyMessage)
}
```

## Saving in Different Contexts

### View Context (Main Thread)

```swift
// Always on main thread
let context = container.viewContext

// Simple save
try? context.saveIfNeeded()

// With error handling
do {
    try context.saveIfNeeded()
} catch {
    print("Failed to save: \(error)")
}
```

### Background Context

```swift
let context = container.newBackgroundContext()
context.perform {
    // Make changes
    let article = Article(context: context)
    article.name = "New Article"
    
    // Save within perform block
    do {
        try context.saveIfNeeded()
    } catch {
        print("Failed to save: \(error)")
    }
}
```

### Nested Contexts (Advanced)

```swift
// Parent context (view context)
let parentContext = container.viewContext

// Child context for editing
let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
childContext.parent = parentContext

// Make changes in child
let article = childContext.object(with: articleID) as! Article
article.name = "Updated"

// Save child (pushes to parent, not to disk)
try? childContext.save()

// Save parent to persist to disk
try? parentContext.save()
```

**Use nested contexts for:**
- Cancellable editing (discard child without saving parent)
- Temporary changes
- Complex forms

## Saving with Validation

Core Data validates objects before saving. Handle validation errors appropriately:

```swift
do {
    try context.save()
} catch let error as NSError {
    if error.code == NSValidationMultipleErrorsError {
        // Multiple validation errors
        if let errors = error.userInfo[NSDetailedErrorsKey] as? [NSError] {
            for validationError in errors {
                print("Validation error: \(validationError.localizedDescription)")
                
                // Get the object that failed validation
                if let object = validationError.userInfo[NSValidationObjectErrorKey] as? NSManagedObject {
                    print("Failed object: \(object)")
                }
                
                // Get the property that failed
                if let key = validationError.userInfo[NSValidationKeyErrorKey] as? String {
                    print("Failed property: \(key)")
                }
            }
        }
    }
}
```

## Optimizing Save Performance

### Batch Saves During Import

```swift
func importArticles(_ articles: [ArticleData]) {
    let context = container.newBackgroundContext()
    context.perform {
        for (index, data) in articles.enumerated() {
            let article = Article(context: context)
            article.name = data.name
            article.content = data.content
            
            // Save every 100 objects to avoid memory buildup
            if index % 100 == 0 && context.hasChanges {
                try? context.save()
                context.reset() // Clear memory
            }
        }
        
        // Final save
        try? context.save()
    }
}
```

### Avoid Saving in Loops

```swift
// ❌ Bad: Saving inside loop
for data in dataArray {
    let article = Article(context: context)
    article.name = data.name
    try? context.save() // Very slow!
}

// ✅ Good: Save once after loop
for data in dataArray {
    let article = Article(context: context)
    article.name = data.name
}
try? context.save() // Much faster!
```

### Use Batch Operations for Bulk Changes

For large-scale operations, use batch requests instead of saving individual objects:

```swift
// Instead of:
for article in articles {
    article.isRead = true
}
try? context.save()

// Use batch update:
let batchUpdate = NSBatchUpdateRequest(entityName: "Article")
batchUpdate.predicate = NSPredicate(format: "isRead == NO")
batchUpdate.propertiesToUpdate = ["isRead": true]
try? context.execute(batchUpdate)
```

See `batch-operations.md` for more details.

## Checking for Unsaved Changes

### Before Dismissing a View

```swift
func dismiss() {
    if context.hasChanges {
        let alert = UIAlertController(
            title: "Unsaved Changes",
            message: "Do you want to save your changes?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            try? self.context.save()
            self.dismissView()
        })
        
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.context.rollback()
            self.dismissView()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    } else {
        dismissView()
    }
}
```

### Rollback Unsaved Changes

```swift
// Discard all unsaved changes
context.rollback()

// Refresh a specific object to discard its changes
context.refresh(article, mergeChanges: false)
```

## Save Notifications

Observe save notifications to respond to changes:

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(contextDidSave),
    name: .NSManagedObjectContextDidSave,
    object: context
)

@objc func contextDidSave(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    
    if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> {
        print("Inserted: \(inserts.count) objects")
    }
    
    if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> {
        print("Updated: \(updates.count) objects")
    }
    
    if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject> {
        print("Deleted: \(deletes.count) objects")
    }
}
```

## Testing Saves

### In Unit Tests

```swift
func testSaveArticle() throws {
    let context = testContainer.viewContext
    
    let article = Article(context: context)
    article.name = "Test Article"
    
    XCTAssertTrue(context.hasChanges)
    
    try context.save()
    
    XCTAssertFalse(context.hasChanges)
    
    // Verify saved
    let fetchRequest = Article.fetchRequest()
    let results = try context.fetch(fetchRequest)
    XCTAssertEqual(results.count, 1)
    XCTAssertEqual(results.first?.name, "Test Article")
}
```

## Common Pitfalls

### ❌ Not Checking for Changes

```swift
// Wastes resources
try? context.save()
```

### ❌ Saving Too Frequently

```swift
// In a loop - very slow
for item in items {
    item.processed = true
    try? context.save()
}
```

### ❌ Ignoring Errors

```swift
// Silent failures
try? context.save()
```

### ❌ Saving on Wrong Thread

```swift
// Crash! Background context on main thread
let context = container.newBackgroundContext()
try? context.save() // Not in perform block!
```

### ✅ Correct Approach

```swift
// Check for changes
guard context.hasPersistentChanges else { return }

// Handle errors
do {
    try context.save()
} catch {
    print("Save failed: \(error)")
    // Handle appropriately
}

// Use correct thread
context.perform {
    try? context.save()
}
```

## Summary

1. **Use `saveIfNeeded()` with `hasPersistentChanges`** - Most efficient approach
2. **Save at appropriate times** - App lifecycle events, after user actions, periodically
3. **Don't save too frequently** - Debounce auto-saves, avoid saving in loops
4. **Handle errors properly** - Don't ignore save failures
5. **Use correct context type** - View context for UI, background for heavy work
6. **Always use `perform` with background contexts** - Thread safety
7. **Consider batch operations** - For large-scale updates
8. **Test your saves** - Verify data persists correctly
