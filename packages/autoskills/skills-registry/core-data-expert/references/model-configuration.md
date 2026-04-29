# Model Configuration

Core Data's data model offers powerful configuration options beyond basic attributes and relationships. This guide covers constraints, derived attributes, transformables, validation, and lifecycle events.

## Constraints

Constraints ensure uniqueness of attribute values. When combined with the correct merge policy, Core Data automatically handles duplicates.

### Setting Up Constraints

In Xcode's Data Model Editor:
1. Select your entity
2. In the Data Model Inspector, find "Constraints"
3. Click "+" and add attribute names

**Example:** Make `name` unique in the `Category` entity.

### Required Merge Policy

```swift
viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
```

**Without this merge policy, constraint violations will crash your app.**

### How Constraints Work

```swift
// First save
let category1 = Category(context: context)
category1.name = "Swift"
try context.save() // Saves successfully

// Duplicate attempt
let category2 = Category(context: context)
category2.name = "Swift" // Same name
try context.save() // With correct merge policy: keeps first, discards second
```

### Multiple Constraints

```swift
// Constraints on multiple attributes
// In model: constraints = ["email", "username"]

// Both must be unique
user1.email = "test@example.com"
user1.username = "testuser"
```

### Compound Constraints

```swift
// Unique combination of attributes
// In model: constraints = ["firstName,lastName"]

// These are different (unique combinations)
person1.firstName = "John"
person1.lastName = "Doe"

person2.firstName = "John"
person2.lastName = "Smith" // Different combination, allowed
```

## Derived Attributes

Derived attributes are computed from other attributes or relationships and stored in the database. They're calculated on save or refresh.

### Benefits

- No need to manually update computed values
- Better performance than accessing relationships
- Optimized for queries

### Common Derivations

#### 1. Count of Relationships

```swift
// In Data Model Editor:
// Derived attribute: articlesCount
// Derivation: articles.@count
```

**Why this is better than `articles.count`:**
- Doesn't fire faults
- Faster queries
- Always up-to-date after save

#### 2. Related Object Property

```swift
// Derived attribute: categoryName
// Derivation: category.name
```

**Use case:** Avoid firing faults when displaying list views.

#### 3. Current Timestamp

```swift
// Derived attribute: lastModified
// Derivation: now()
```

**Automatically updates on every save.**

#### 4. Canonical String (Search Optimization)

```swift
// Derived attribute: searchName
// Derivation: canonical:(name)
```

**What it does:**
- Converts to lowercase
- Removes diacritics
- Perfect for case-insensitive, diacritic-insensitive searches

**Example:**
```swift
// name = "Café"
// searchName = "cafe"

// Search query
fetchRequest.predicate = NSPredicate(format: "searchName CONTAINS %@", "cafe")
// Matches "Café", "CAFE", "café", etc.
```

#### 5. Sum of Related Values

```swift
// Derived attribute: totalViews
// Derivation: @sum.articles.views
```

### Important Notes

- Derived attributes are calculated **on save** or **refresh**
- In-memory changes don't update derived attributes until saved
- Can't be set manually (they're computed)

### Example Usage

```swift
class Article: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var category: Category?
    
    // Derived from category.name
    @NSManaged var categoryName: String?
    
    // Derived from canonical:(name)
    @NSManaged var searchName: String?
}

// Usage
article.name = "Core Data Best Practices"
try context.save()

// After save, derived attributes are updated
print(article.searchName) // "core data best practices"
print(article.categoryName) // "Swift"
```

## Transformables

Transformables allow storing custom types that aren't natively supported by Core Data.

### Creating a Value Transformer

```swift
import UIKit

@objc(ColorTransformer)
class ColorTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(
                withRootObject: color,
                requiringSecureCoding: true
            )
            return data
        } catch {
            print("Failed to transform color: \(error)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self,
                from: data
            )
            return color
        } catch {
            print("Failed to reverse transform color: \(error)")
            return nil
        }
    }
}
```

### Registering the Transformer

```swift
// In your stack setup, before loading stores
ValueTransformer.setValueTransformer(
    ColorTransformer(),
    forName: NSValueTransformerName("ColorTransformer")
)
```

### Configuring in Data Model

1. Select the attribute
2. Set Type to "Transformable"
3. Set "Custom Class" to your type (e.g., `UIColor`)
4. Set "Transformer" to your transformer name (e.g., `ColorTransformer`)

### Using Transformable Attributes

```swift
class Article: NSManagedObject {
    @NSManaged var color: UIColor?
}

// Usage
article.color = .systemBlue
try context.save()

// Retrieval
let color = article.color // UIColor
```

### NSSecureCoding Requirement

Modern Core Data requires secure coding:

```swift
// Make your custom type conform to NSSecureCoding
extension CustomType: NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    
    func encode(with coder: NSCoder) {
        // Encode properties
    }
    
    required init?(coder: NSCoder) {
        // Decode properties
    }
}
```

## Validation

Core Data provides built-in validation that runs before saving.

### Model-Level Validation

Set in Data Model Editor:

**String Validation:**
- Minimum Length
- Maximum Length
- Regular Expression

**Numeric Validation:**
- Minimum Value
- Maximum Value

**Example:**
```
Attribute: name
Type: String
Min Length: 3
Max Length: 100
```

### Code-Level Validation

Override validation methods in your `NSManagedObject` subclass:

```swift
class Article: NSManagedObject {
    @NSManaged var name: String?
    
    // Validate before insert
    override func validateForInsert() throws {
        try super.validateForInsert()
        try validateName()
    }
    
    // Validate before update
    override func validateForUpdate() throws {
        try super.validateForUpdate()
        try validateName()
    }
    
    // Validate before delete
    override func validateForDelete() throws {
        try super.validateForDelete()
        
        // Example: Can't delete if has related objects
        if let attachments = attachments, !attachments.isEmpty {
            throw NSError(
                domain: "ArticleValidation",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: "Cannot delete article with attachments"]
            )
        }
    }
    
    // Custom validation
    private func validateName() throws {
        guard let name = name, !name.isEmpty else {
            throw NSError(
                domain: "ArticleValidation",
                code: 1000,
                userInfo: [NSLocalizedDescriptionKey: "Name cannot be empty"]
            )
        }
        
        // Check for protected names
        let protectedNames = ["Admin", "System", "Root"]
        if protectedNames.contains(name) {
            throw NSError(
                domain: "ArticleValidation",
                code: 1002,
                userInfo: [NSLocalizedDescriptionKey: "'\(name)' is a protected name"]
            )
        }
    }
}
```

### Property-Level Validation

```swift
class Article: NSManagedObject {
    @NSManaged var name: String?
    
    override func validateName(_ value: AutoreleasingUnsafeMutablePointer<AnyObject?>) throws {
        guard let name = value.pointee as? String, !name.isEmpty else {
            throw NSError(
                domain: "ArticleValidation",
                code: 1000,
                userInfo: [NSLocalizedDescriptionKey: "Name cannot be empty"]
            )
        }
    }
}
```

### Handling Validation Errors

```swift
do {
    try context.save()
} catch let error as NSError {
    if error.domain == NSCocoaErrorDomain {
        switch error.code {
        case NSValidationStringTooShortError:
            print("String too short")
        case NSValidationStringTooLongError:
            print("String too long")
        case NSManagedObjectValidationError:
            print("Validation failed")
        default:
            print("Other error: \(error.localizedDescription)")
        }
    }
}
```

## Lifecycle Events

Override lifecycle methods to perform actions at specific points in an object's life.

### awakeFromInsert()

Called once when object is first inserted into context.

```swift
override func awakeFromInsert() {
    super.awakeFromInsert()
    
    // Set default values
    setPrimitiveValue(Date(), forKey: #keyPath(Article.creationDate))
    setPrimitiveValue(Date(), forKey: #keyPath(Article.lastModified))
    setPrimitiveValue(0, forKey: #keyPath(Article.views))
}
```

**Use `setPrimitiveValue` to avoid:**
- KVO notifications
- Marking object as changed
- Infinite loops

### willSave()

Called before every save. Use for updating modification dates or cleaning up.

```swift
override func willSave() {
    super.willSave()
    
    // Update modification date
    setPrimitiveValue(Date(), forKey: #keyPath(Article.lastModified))
    
    // Delete local files if object is deleted
    if isDeleted, let localResource = localResourceURL {
        try? FileManager.default.removeItem(at: localResource)
    }
}
```

**Caution:** Don't call `save()` inside `willSave()` - infinite loop!

### didSave()

Called after save completes.

```swift
override func didSave() {
    super.didSave()
    
    // Post notification, update cache, etc.
    NotificationCenter.default.post(
        name: .articleDidSave,
        object: self
    )
}
```

### prepareForDeletion()

Called when object is marked for deletion (before save).

```swift
override func prepareForDeletion() {
    super.prepareForDeletion()
    
    // Cancel ongoing operations
    downloadTask?.cancel()
    
    // Don't delete files here! Use willSave() instead
    // (prepareForDeletion is called even if save is rolled back)
}
```

**Important:** Don't delete files in `prepareForDeletion()`. The deletion might be rolled back, leaving your data inconsistent.

### awakeFromFetch()

Called when object is fetched from store.

```swift
override func awakeFromFetch() {
    super.awakeFromFetch()
    
    // Initialize transient properties
    setupObservers()
}
```

### Complete Lifecycle Example

```swift
class Article: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var creationDate: Date?
    @NSManaged var lastModified: Date?
    @NSManaged var localResourceURL: URL?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // Set creation date once
        setPrimitiveValue(Date(), forKey: #keyPath(Article.creationDate))
        setPrimitiveValue(Date(), forKey: #keyPath(Article.lastModified))
    }
    
    override func willSave() {
        super.willSave()
        
        // Update modification date on every save
        if !isDeleted && changedValues().keys.contains("name") {
            setPrimitiveValue(Date(), forKey: #keyPath(Article.lastModified))
        }
        
        // Clean up files when deleted
        if isDeleted, let url = localResourceURL {
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    override func prepareForDeletion() {
        super.prepareForDeletion()
        
        // Cancel ongoing operations
        // Don't delete files here!
    }
}
```

## Common Pitfalls

### ❌ Not Setting Merge Policy with Constraints

```swift
// Constraint violation will crash
let category = Category(context: context)
category.name = "Duplicate"
try context.save() // CRASH!
```

### ❌ Manually Setting Derived Attributes

```swift
// Derived attributes are read-only
article.categoryName = "Swift" // Ignored!
```

### ❌ Using KVO Methods in Lifecycle Events

```swift
override func awakeFromInsert() {
    super.awakeFromInsert()
    
    // ❌ Triggers KVO, marks as changed
    self.creationDate = Date()
    
    // ✅ Use primitive values
    setPrimitiveValue(Date(), forKey: #keyPath(Article.creationDate))
}
```

### ❌ Deleting Files in prepareForDeletion

```swift
override func prepareForDeletion() {
    super.prepareForDeletion()
    
    // ❌ Bad: Deletion might be rolled back
    try? FileManager.default.removeItem(at: fileURL)
}
```

### ✅ Correct Approaches

```swift
// Set merge policy
viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy

// Let derived attributes compute themselves
article.name = "New Name"
try context.save()
print(article.searchName) // Automatically updated

// Use primitive values in lifecycle events
setPrimitiveValue(Date(), forKey: #keyPath(Article.creationDate))

// Delete files in willSave when isDeleted
override func willSave() {
    super.willSave()
    if isDeleted {
        try? FileManager.default.removeItem(at: fileURL)
    }
}
```

## Summary

1. **Use constraints for uniqueness** - Requires NSMergeByPropertyStoreTrumpMergePolicy
2. **Use derived attributes** - Better performance than accessing relationships
3. **Use canonical: for search** - Case and diacritic insensitive
4. **Use transformables for custom types** - With NSSecureCoding
5. **Validate in code** - For complex business rules
6. **Use awakeFromInsert for defaults** - Called once on creation
7. **Use willSave for updates** - Called before every save
8. **Use setPrimitiveValue** - Avoid KVO in lifecycle events
9. **Delete files in willSave** - When isDeleted is true
10. **Don't save in willSave** - Causes infinite loop
