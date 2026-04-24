# Schema Migration

Schema migration is the process of updating your Core Data model as your app evolves. Core Data provides three migration strategies: lightweight, staged (iOS 17+), and deferred (iOS 14+).

## When Migration is Required

Core Data refuses to open a store when the model doesn't match:

```
Error: NSPersistentStoreIncompatibleVersionHashError
```

**This means:** Your data model changed, and you need to migrate.

## Lightweight Migration (Recommended)

Lightweight migration is automatic and handles most common changes.

### Enabling Lightweight Migration

With `NSPersistentContainer` (automatic):
```swift
let container = NSPersistentContainer(name: "Model")
// Lightweight migration enabled by default
```

With `NSPersistentStoreDescription` (automatic):
```swift
let description = NSPersistentStoreDescription(url: storeURL)
// Lightweight migration enabled by default
```

Manual setup (if needed):
```swift
let options = [
    NSMigratePersistentStoresAutomaticallyOption: true,
    NSInferMappingModelAutomaticallyOption: true
]
try coordinator.addPersistentStore(
    ofType: NSSQLiteStoreType,
    configurationName: nil,
    at: storeURL,
    options: options
)
```

### Supported Operations

**Attributes:**
- Add attribute
- Remove attribute
- Make optional attribute non-optional (with default value)
- Make non-optional attribute optional
- Rename attribute (using renaming identifier)

**Relationships:**
- Add relationship
- Remove relationship
- Rename relationship (using renaming identifier)
- Change cardinality (to-one ↔ to-many)
- Change ordering (ordered ↔ non-ordered)

**Entities:**
- Add entity
- Remove entity
- Rename entity (using renaming identifier)
- Create parent/child entity
- Move attributes up/down hierarchy
- Move entities in/out of hierarchy

**Cannot do:**
- Merge entity hierarchies (entities without common parent can't share parent)

### Renaming Attributes/Entities

Set the renaming identifier to the **old name**:

```swift
// In Data Model Editor:
// 1. Rename attribute from "color" to "paintColor"
// 2. Set Renaming Identifier to "color"
```

This allows chaining renames across versions:
- V1: `color`
- V2: `paintColor` (renaming ID: `color`)
- V3: `primaryColor` (renaming ID: `paintColor`)

Migration works: V1→V2, V2→V3, and V1→V3.

### Testing Lightweight Migration

```swift
// Check if migration is possible
let sourceModel = // ... load V1 model
let destinationModel = // ... load V2 model

if let mappingModel = try? NSMappingModel.inferredMappingModel(
    forSourceModel: sourceModel,
    destinationModel: destinationModel
) {
    print("Lightweight migration possible")
} else {
    print("Lightweight migration not possible")
}
```

## Composite Attributes (iOS 17+)

New in iOS 17: Structured data within a single attribute.

### Creating Composite Attributes

In Data Model Editor:
1. Add Composite Attribute
2. Add elements (String, Int, Date, etc.)
3. Can nest composite attributes

```swift
// Example: ColorScheme composite
// - primary: String
// - secondary: String
// - tertiary: String

class Aircraft: NSManagedObject {
    @NSManaged var colorScheme: [String: Any]
}

// Usage
aircraft.colorScheme = [
    "primary": "Red",
    "secondary": "White",
    "tertiary": "Blue"
]

// Querying
fetchRequest.predicate = NSPredicate(format: "colorScheme.primary == %@", "Red")
```

### Benefits

- No transformable code needed
- Supports predicates with keypaths
- Better than flattened attributes
- Can prevent faulting across relationships

## Staged Migration (iOS 17+)

For complex migrations that exceed lightweight capabilities.

### When to Use

- Changes don't fit lightweight patterns
- Need to run custom code during migration
- Need to decompose complex changes into steps

### Key Classes

- `NSStagedMigrationManager` - Manages migration event loop
- `NSCustomMigrationStage` - Custom code execution
- `NSLightweightMigrationStage` - Lightweight-eligible changes
- `NSManagedObjectModelReference` - Model references with checksums

### Example: Denormalizing Data

**Problem:** Move `flightData` attribute to separate entity.

**Solution:** Decompose into stages:

**Stage 1 (Lightweight):** Add new entity and relationship
```swift
// ModelV1 → ModelV2
// Add FlightData entity
// Add flightParameters relationship to Aircraft
```

**Stage 2 (Custom):** Copy data
- Fetch rows using generic `NSManagedObject` / `NSFetchRequestResult` types.
- Create new entities and copy data inside the migration stage handler.
- Ensure the custom logic is restartable if the process is interrupted.

**Stage 3 (Lightweight):** Remove old attribute
```swift
// ModelV3 → ModelV4
// Remove flightData attribute from Aircraft
```

### Getting Version Checksum

From Xcode build log:
```
Compile data model Model.xcdatamodeld
version checksum: ABC123...
```

## Deferred Migration (iOS 14+)

Defer cleanup work to keep app responsive.

### When to Use

- Removing attributes/relationships
- Changing relationship hierarchy
- Changing relationship ordering
- Any migration with expensive cleanup

### How It Works

1. Migration runs synchronously (fast)
2. Cleanup (indices, column drops) is deferred
3. App uses latest schema immediately
4. Finish cleanup when resources available

### Enabling Deferred Migration

```swift
let description = NSPersistentStoreDescription(url: storeURL)
description.setOption(
    true as NSNumber,
    forKey: NSPersistentStoreDeferredLightweightMigrationOptionKey
)
```

### Checking for Pending Work

```swift
let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(
    ofType: NSSQLiteStoreType,
    at: storeURL
)

if let hasDeferredWork = metadata[NSPersistentStoreDeferredLightweightMigrationOptionKey] as? Bool,
   hasDeferredWork {
    print("Deferred migration work pending")
}
```

### Finishing Deferred Migration

```swift
func finishDeferredMigration() {
    let coordinator = container.persistentStoreCoordinator
    
    do {
        try coordinator.finishDeferredLightweightMigration()
        print("Deferred migration completed")
    } catch {
        print("Failed to finish deferred migration: \(error)")
    }
}
```

### Scheduling with Background Tasks

```swift
import BackgroundTasks

// Register task
BGTaskScheduler.shared.register(
    forTaskWithIdentifier: "com.example.app.migration",
    using: nil
) { task in
    self.handleMigrationTask(task as! BGProcessingTask)
}

// Schedule task
func scheduleMigration() {
    let request = BGProcessingTaskRequest(identifier: "com.example.app.migration")
    request.requiresNetworkConnectivity = false
    request.requiresExternalPower = false
    
    try? BGTaskScheduler.shared.submit(request)
}

// Handle task
func handleMigrationTask(_ task: BGProcessingTask) {
    task.expirationHandler = {
        task.setTaskCompleted(success: false)
    }
    
    finishDeferredMigration()
    task.setTaskCompleted(success: true)
}
```

## Migration Debugging

### Enable Migration Debug

```
-com.apple.CoreData.MigrationDebug 1
```

**Output:**
```
CoreData: annotation: Migration: Migrating from version 1 to version 2
CoreData: annotation: Migration: Inferred mapping model
CoreData: annotation: Migration: Completed successfully
```

### Common Errors

**NSPersistentStoreIncompatibleVersionHashError**
- Model changed, migration required
- Enable lightweight migration or create mapping model

**NSMigrationMissingSourceModelError**
- Can't find source model
- Ensure all model versions are in bundle

**NSMigrationError**
- Migration failed
- Check if changes are lightweight-compatible
- Use staged migration for complex changes

## Best Practices

1. **Test migrations thoroughly** - Test upgrade paths from all previous versions
2. **Keep model versions** - Don't delete old .xcdatamodel files
3. **Use lightweight when possible** - Simplest and most reliable
4. **Decompose complex changes** - Use staged migration for non-lightweight changes
5. **Defer expensive cleanup** - Use deferred migration for large datasets
6. **Version your models** - Create new model version for each release
7. **Test on real data** - Migration behavior differs with large datasets
8. **Document changes** - Keep migration notes for future reference

## Testing Migrations

```swift
func testMigration() throws {
    // 1. Create store with old model
    let oldModelURL = Bundle.main.url(forResource: "ModelV1", withExtension: "momd")!
    let oldModel = NSManagedObjectModel(contentsOf: oldModelURL)!
    
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: oldModel)
    try coordinator.addPersistentStore(
        ofType: NSSQLiteStoreType,
        configurationName: nil,
        at: storeURL,
        options: nil
    )
    
    // 2. Add test data
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = coordinator
    
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context)
    entity.setValue("Test", forKey: "name")
    try context.save()
    
    // 3. Close store
    try coordinator.remove(coordinator.persistentStores.first!)
    
    // 4. Migrate with new model
    let newModelURL = Bundle.main.url(forResource: "ModelV2", withExtension: "momd")!
    let newModel = NSManagedObjectModel(contentsOf: newModelURL)!
    
    let newCoordinator = NSPersistentStoreCoordinator(managedObjectModel: newModel)
    let options = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true
    ]
    try newCoordinator.addPersistentStore(
        ofType: NSSQLiteStoreType,
        configurationName: nil,
        at: storeURL,
        options: options
    )
    
    // 5. Verify data
    let newContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    newContext.persistentStoreCoordinator = newCoordinator
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
    let results = try newContext.fetch(fetchRequest)
    
    XCTAssertEqual(results.count, 1)
    XCTAssertEqual(results.first?.value(forKey: "name") as? String, "Test")
}
```

## Summary

1. **Use lightweight migration** - Handles most common changes automatically
2. **Enable by default** - NSPersistentContainer enables it automatically
3. **Use renaming identifiers** - For renaming attributes/entities/relationships
4. **Use composite attributes (iOS 17+)** - For structured data
5. **Use staged migration (iOS 17+)** - For complex, non-lightweight changes
6. **Use deferred migration (iOS 14+)** - For expensive cleanup operations
7. **Test thoroughly** - Verify all upgrade paths
8. **Keep all model versions** - Required for migration
9. **Enable migration debug** - Helps diagnose issues
10. **Document changes** - Track what changed in each version
