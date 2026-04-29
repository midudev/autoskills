# Reference Index

Quick navigation for Core Data topics.

## Fundamentals

- `stack-setup.md`: NSPersistentContainer setup, merge policies, context configuration
- `saving.md`: Conditional saving, hasPersistentChanges, save timing strategies
- `glossary.md`: Term definitions for quick lookup
- `project-audit.md`: Checklist for discovering a project’s Core Data setup and constraints

## Data Access

- `fetch-requests.md`: Query optimization, NSFetchedResultsController, aggregates
- `threading.md`: NSManagedObjectID, perform vs performAndWait, concurrency
- `concurrency.md`: Swift Concurrency integration, async/await, actors, Sendable
- `batch-operations.md`: NSBatchInsertRequest, NSBatchDeleteRequest, NSBatchUpdateRequest

## Model & Schema

- `model-configuration.md`: Constraints, derived attributes, transformables, validation, lifecycle
- `migration.md`: Lightweight, staged, and deferred migration strategies

## Advanced Topics

- `persistent-history.md`: History tracking setup, Observer/Fetcher/Merger/Cleaner pattern
- `cloudkit-integration.md`: NSPersistentCloudKitContainer, schema design, monitoring
- `performance.md`: Profiling with Instruments, memory management, optimization
- `testing.md`: In-memory stores, shared models, data generators

## Quick Links by Problem

### "I need to..."

- **Set up Core Data** → `stack-setup.md`
- **Save data efficiently** → `saving.md`
- **Fetch and display data** → `fetch-requests.md`
- **Work with background threads** → `threading.md`
- **Use async/await with Core Data** → `concurrency.md`
- **Import large datasets** → `batch-operations.md`
- **Configure my model** → `model-configuration.md`
- **Migrate my schema** → `migration.md`
- **Sync with CloudKit** → `cloudkit-integration.md`
- **Optimize performance** → `performance.md`
- **Write tests** → `testing.md`

### "I'm getting an error about..."

- **"NSPersistentStoreIncompatibleVersionHashError"** → `migration.md`
- **"Cannot delete objects in other contexts"** → `threading.md`
- **"NSMergeConflict"** → `stack-setup.md` (merge policies), `model-configuration.md` (constraints)
- **"Failed to find unique match for NSEntityDescription"** → `testing.md` (shared model)
- **Batch operations not updating UI** → `persistent-history.md`
- **CloudKit sync issues** → `cloudkit-integration.md`
- **Memory growing unbounded** → `performance.md`, `fetch-requests.md`
- **Validation errors** → `model-configuration.md`

### "I want to..."

- **Optimize queries** → `fetch-requests.md`, `performance.md`
- **Handle relationships** → `model-configuration.md`, `fetch-requests.md`
- **Validate data** → `model-configuration.md`
- **Track changes across contexts** → `persistent-history.md`
- **Debug performance issues** → `performance.md`
- **Test my Core Data code** → `testing.md`

## File Statistics

- `project-audit.md`: Project discovery checklist (deployment target, stack, history tracking, concurrency risks)
- `stack-setup.md`: NSPersistentContainer, merge policies, context configuration
- `saving.md`: hasPersistentChanges, conditional saving, error handling
- `fetch-requests.md`: Optimization, NSFetchedResultsController, aggregates, diffable data sources
- `threading.md`: NSManagedObjectID, perform/performAndWait, traditional threading
- `concurrency.md`: Swift Concurrency, async/await, actors, Sendable, @MainActor, DAOs
- `batch-operations.md`: NSBatchInsertRequest, NSBatchDeleteRequest, NSBatchUpdateRequest
- `model-configuration.md`: Constraints, derived attributes, transformables, validation, lifecycle
- `migration.md`: Lightweight, staged (iOS 17+), deferred (iOS 14+), composite attributes
- `persistent-history.md`: Observer, Fetcher, Merger, Cleaner, batch operation integration
- `cloudkit-integration.md`: NSPersistentCloudKitContainer, schema design, monitoring, debugging
- `performance.md`: Instruments profiling, memory management, optimization strategies
- `testing.md`: In-memory stores, shared models, data generators, XCTest patterns
- `glossary.md`: Core Data terminology and quick definitions
