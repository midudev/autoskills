# Core Data Glossary

Quick reference for Core Data terminology.

## Core Concepts

**Core Data**
Apple's framework for object graph management and persistence.

**Persistent Store**
The underlying storage (typically SQLite database) where data is saved.

**Managed Object Model**
Describes your data schema (entities, attributes, relationships).

**Entity**
A class definition in your data model (like a database table).

**Attribute**
A property of an entity (like a database column).

**Relationship**
A connection between entities (one-to-one, one-to-many, many-to-many).

## Stack Components

**NSPersistentContainer**
Encapsulates the Core Data stack (model, coordinator, contexts).

**NSPersistentCloudKitContainer**
Extends NSPersistentContainer with CloudKit sync capabilities.

**NSPersistentStoreCoordinator**
Manages one or more persistent stores and coordinates access.

**NSManagedObjectContext**
Scratch pad for working with managed objects. Changes aren't persisted until saved.

**NSManagedObject**
Base class for Core Data objects. Represents a row in a database table.

**NSManagedObjectID**
Unique, immutable identifier for a managed object. Thread-safe.

## Context Types

**View Context**
Main queue context for UI operations. Runs on main thread.

**Background Context**
Private queue context for heavy work. Runs on background thread.

**Child Context**
Context with a parent context. Saves push changes to parent, not to disk.

## Fetching

**NSFetchRequest**
Describes a search for objects in the persistent store.

**NSFetchedResultsController**
Manages fetch results for table/collection views with automatic updates.

**Predicate**
Filter condition for fetch requests (like SQL WHERE clause).

**Sort Descriptor**
Defines ordering for fetch results (like SQL ORDER BY).

**Faulting**
Lazy loading mechanism. Object data loaded only when accessed.

**Prefetching**
Loading related objects eagerly to avoid faulting.

## Operations

**Save**
Persists changes from context to persistent store.

**Fetch**
Retrieves objects from persistent store.

**Insert**
Creates new object in context.

**Delete**
Marks object for deletion. Removed on save.

**Refresh**
Reloads object from persistent store, discarding in-memory changes.

**Reset**
Clears all objects from context, freeing memory.

**Rollback**
Discards all unsaved changes in context.

## Batch Operations

**NSBatchInsertRequest**
Inserts multiple objects at SQL level (iOS 14+).

**NSBatchDeleteRequest**
Deletes multiple objects at SQL level.

**NSBatchUpdateRequest**
Updates multiple objects at SQL level.

## Advanced Features

**Persistent History Tracking**
Records all changes in a transaction log for cross-context synchronization.

**Derived Attribute**
Computed attribute stored in database (e.g., `articles.@count`).

**Transformable**
Custom type stored using value transformer.

**Constraint**
Ensures attribute uniqueness (requires merge policy).

**Merge Policy**
Determines how conflicts are resolved when saving.

## Migration

**Lightweight Migration**
Automatic migration for simple model changes.

**Staged Migration**
Complex migration decomposed into steps (iOS 17+).

**Deferred Migration**
Delays cleanup work for better performance (iOS 14+).

**Composite Attribute**
Structured data within single attribute (iOS 17+).

**Mapping Model**
Describes how to migrate from one model version to another.

**Version Hash**
Checksum identifying a specific model version.

## Threading

**perform**
Executes block asynchronously on context's queue.

**performAndWait**
Executes block synchronously on context's queue (blocks calling thread).

**Thread Confinement**
Each context must be accessed only from its queue.

**automaticallyMergesChangesFromParent**
Context automatically receives changes from parent context.

## Validation

**validateForInsert**
Called before inserting object.

**validateForUpdate**
Called before updating object.

**validateForDelete**
Called before deleting object.

## Lifecycle

**awakeFromInsert**
Called once when object first inserted.

**awakeFromFetch**
Called when object loaded from store.

**willSave**
Called before each save.

**didSave**
Called after save completes.

**prepareForDeletion**
Called when object marked for deletion.

## CloudKit

**Container Identifier**
Unique ID for CloudKit container (e.g., `iCloud.com.example.app`).

**Development Environment**
CloudKit environment for testing (schema mutable).

**Production Environment**
CloudKit environment for released apps (schema immutable).

**Schema Initialization**
First run creates CloudKit schema from Core Data model.

**Event Notification**
Notification sent when CloudKit sync events occur.

## Debugging

**SQL Debug**
Launch argument to log SQL queries: `-com.apple.CoreData.SQLDebug 1`

**Concurrency Debug**
Launch argument to catch threading violations: `-com.apple.CoreData.ConcurrencyDebug 1`

**Migration Debug**
Launch argument to log migration steps: `-com.apple.CoreData.MigrationDebug 1`

## Common Acronyms

**CD** - Core Data
**MOC** - Managed Object Context (NSManagedObjectContext)
**MO** - Managed Object (NSManagedObject)
**FRC** - Fetched Results Controller (NSFetchedResultsController)
**PSC** - Persistent Store Coordinator (NSPersistentStoreCoordinator)
**MOD** - Managed Object Model (NSManagedObjectModel)

## Quick Reference

**Thread-safe:** NSManagedObjectID, NSPersistentStoreCoordinator
**Not thread-safe:** NSManagedObject, NSManagedObjectContext
**Main thread only:** View context operations
**Background thread:** Background context operations
**Automatic:** Lightweight migration (with NSPersistentContainer)
**Manual:** Staged migration, custom mapping models
