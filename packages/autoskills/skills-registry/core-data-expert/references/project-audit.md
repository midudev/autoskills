# Project Audit (Core Data)

Use this checklist to quickly discover how a project uses Core Data and which constraints apply (platform availability, CloudKit, history tracking, etc.).

## Determine platform constraints

- Find the deployment target (iOS/macOS version). Many recommendations depend on this (e.g. staged migration and composite attributes require iOS 17+/macOS 14+).
- Note whether the project is Swift 6 / strict concurrency enabled (Sendable and isolation warnings change the advice).

## Inspect the data model

- Open the model XML (`*.xcdatamodeld/*/contents`) and check:
  - entities, attributes, relationships, constraints
  - versioning setup (multiple model versions)
  - renaming identifiers (for lightweight migration)
  - composite attributes (iOS 17+)

## Identify stack setup

Search for:

- `NSPersistentContainer` vs `NSPersistentCloudKitContainer`
- `loadPersistentStores` configuration
- `persistentStoreDescriptions` (migration options, history tracking, CloudKit options)
- `viewContext` configuration (merge policy, `automaticallyMergesChangesFromParent`, query generations)
- background context creation (`newBackgroundContext`, `performBackgroundTask`)

Then consult:

- `stack-setup.md` for recommended defaults and merge policies
- `cloudkit-integration.md` if CloudKit is enabled

## Check for persistent history tracking (required for some flows)

Search for:

- `NSPersistentHistoryTrackingKey`
- `NSPersistentStoreRemoteChangeNotificationPostOptionKey`
- remote change notifications and history processing/merging

Then consult:

- `persistent-history.md` for the Observer/Fetcher/Merger/Cleaner pattern

## Spot risky concurrency patterns

Search for:

- cross-thread access to managed objects (look for passing `NSManagedObject` into async tasks/closures)
- `performAndWait` usage (risk of deadlocks / UI blocking)
- `@unchecked Sendable` applied to Core Data types (usually hides a real problem)

Then consult:

- `threading.md` and `concurrency.md`

## Useful debugging flags (for repro builds only)

- `-com.apple.CoreData.ConcurrencyDebug 1` (threading violations)
- `-com.apple.CoreData.SQLDebug 1` (SQL logging)
