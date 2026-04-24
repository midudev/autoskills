# CloudKit Integration

`NSPersistentCloudKitContainer` syncs Core Data with CloudKit, enabling seamless data synchronization across devices.

## Setup

### Basic Setup

```swift
import CoreData
import CloudKit

let container = NSPersistentCloudKitContainer(name: "Model")

container.loadPersistentStores { description, error in
    if let error = error {
        fatalError("Failed to load store: \(error)")
    }
}
```

### Configure CloudKit Container

In Xcode:
1. Add CloudKit capability
2. Select or create CloudKit container
3. Enable "Use CloudKit" in Core Data model

### Schema Design Limitations

CloudKit has restrictions Core Data doesn't:

**Not Supported:**
- Unique constraints on entities
- `Undefined` attribute type
- `ObjectID` attribute type
- Non-optional relationships (must be optional)
- Relationships without inverse
- Deny deletion rule

**Supported:**
- Adding new fields to record types
- Adding new record types

**Important:** Production schema is **immutable**. Plan carefully!

## Schema Initialization

### Development Environment

```swift
// First run initializes schema in Development
container.loadPersistentStores { description, error in
    // Schema created automatically
}
```

### Promoting to Production

1. Test thoroughly in Development
2. Open CloudKit Dashboard
3. Deploy schema to Production
4. **Cannot modify after deployment!**

## Monitoring Sync

### Observe Events

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(storeDidChange),
    name: NSPersistentCloudKitContainer.eventChangedNotification,
    object: container
)

@objc func storeDidChange(_ notification: Notification) {
    guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey]
            as? NSPersistentCloudKitContainer.Event else {
        return
    }
    
    switch event.type {
    case .setup:
        print("Setup: \(event.succeeded ? "succeeded" : "failed")")
    case .import:
        print("Import: \(event.succeeded ? "succeeded" : "failed")")
    case .export:
        print("Export: \(event.succeeded ? "succeeded" : "failed")")
    @unknown default:
        break
    }
    
    if let error = event.error {
        print("Error: \(error)")
    }
}
```

### Testing Sync

```swift
func testSync() {
    let expectation = XCTestExpectation(description: "Export")
    
    // Create expectation for export
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
    
    // Make changes
    let article = Article(context: container.viewContext)
    article.name = "Test"
    try? container.viewContext.save()
    
    wait(for: [expectation], timeout: 60)
    NotificationCenter.default.removeObserver(observer)
}
```

## Cross-Version Compatibility

### Strategy 1: Incremental Fields

Add new fields, keep old ones:

```swift
// V1: name
// V2: name, subtitle (new)
// Old versions see records but not subtitle
```

### Strategy 2: Version Attribute

```swift
// Add version attribute
article.schemaVersion = 2

// Filter in fetch requests
fetchRequest.predicate = NSPredicate(format: "schemaVersion <= %d", currentVersion)
```

### Strategy 3: New Container

```swift
let options = NSPersistentCloudKitContainerOptions(
    containerIdentifier: "iCloud.com.example.app.v2"
)

let description = NSPersistentStoreDescription(url: storeURL)
description.cloudKitContainerOptions = options
```

**Caution:** Large datasets take time to upload.

## Debugging

### System Logs

Monitor these processes:
- **Application** - Core Data activity
- **dasd** - Scheduling decisions
- **cloudd** - CloudKit operations
- **apsd** - Push notifications

### Using log stream

```bash
# Application logs
log stream --predicate 'process == "YourApp"'

# CloudKit logs
log stream --predicate 'process == "cloudd" AND message CONTAINS "your.container.id"'

# Push notifications
log stream --predicate 'process == "apsd"'

# Scheduling
log stream --predicate 'process == "dasd" AND message CONTAINS "YourApp"'
```

### CloudKit Logging Profile

1. Download from [Apple Developer Portal](https://developer.apple.com/bug-reporting/profiles-and-logs/)
2. Install on device
3. Reboot device
4. Reproduce issue
5. Collect sysdiagnose

### Collecting Diagnostics

**sysdiagnose:**
- iOS: Volume Up + Volume Down + Power (hold)
- macOS: Shift + Control + Option + Command + Period

## Common Issues

### Schema Mismatch

**Problem:** Local schema doesn't match CloudKit schema.

**Solution:**
1. Delete app
2. Reinstall
3. Let schema reinitialize

### Sync Not Working

**Checklist:**
- [ ] CloudKit capability enabled
- [ ] Signed in to iCloud
- [ ] Network connection available
- [ ] CloudKit container configured
- [ ] Schema initialized in Development
- [ ] Schema promoted to Production

### Large Initial Sync

**Problem:** First sync takes too long.

**Solutions:**
- Use background fetch
- Show progress indicator
- Implement data generators for testing

## Best Practices

1. **Test in Development first** - Schema is mutable
2. **Plan schema carefully** - Production is immutable
3. **Make relationships optional** - Required by CloudKit
4. **Add inverse relationships** - Required by CloudKit
5. **Version your data** - For cross-version compatibility
6. **Monitor sync events** - Detect and handle errors
7. **Test with multiple devices** - Verify sync behavior
8. **Handle conflicts** - Use appropriate merge policy
9. **Collect diagnostics** - For debugging sync issues
10. **Consider data size** - Large datasets take time to sync

## Summary

- Use `NSPersistentCloudKitContainer` for CloudKit sync
- Schema has limitations (optional relationships, no constraints)
- Production schema is immutable
- Monitor sync with event notifications
- Test thoroughly in Development before promoting
- Plan for cross-version compatibility
- Use system logs for debugging
- Collect sysdiagnose for complex issues
