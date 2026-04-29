# Reference Index

Quick navigation for the Swift Concurrency skill.

## Foundations

| File | Use it for |
|---|---|
| `async-await-basics.md` | closure-to-async bridges and foundational async/await usage |
| `tasks.md` | `Task`, cancellation, task groups, structured vs unstructured work |
| `actors.md` | actor isolation, `@MainActor`, reentrancy, isolated conformances |
| `sendable.md` | `Sendable`, `@Sendable`, region isolation, escape hatches |
| `threading.md` | execution model, suspension points, Swift 6.2 isolation behavior |

## Streams

| File | Use it for |
|---|---|
| `async-sequences.md` | deciding between `AsyncSequence`, `AsyncStream`, and one-shot async APIs |
| `async-algorithms.md` | debounce, throttle, merge, `combineLatest`, channels, timers |

## Applied Topics

| File | Use it for |
|---|---|
| `testing.md` | Swift Testing first, XCTest fallback, leak checks |
| `performance.md` | Instruments workflow, actor hops, suspension cost |
| `memory-management.md` | retain cycles, long-lived tasks, cleanup |
| `core-data.md` | `NSManagedObjectID`, `perform`, default isolation conflicts |

## Migration and Tooling

| File | Use it for |
|---|---|
| `migration.md` | rollout order, build settings, migration guardrails |
| `linting.md` | concurrency-focused lint rules |
| `glossary.md` | quick definitions |

## Problem Router

- "I need to fix a compiler error quickly" → `../SKILL.md`
- "I need to replace a callback with async/await" → `async-await-basics.md`
- "I need to protect shared mutable state" → `actors.md`
- "I need to pass data safely across boundaries" → `sendable.md`
- "I need stream operators" → `async-algorithms.md`
- "I need to understand why code runs where it runs" → `threading.md`
- "I need to stop a leak or lifetime issue" → `memory-management.md`
- "I need to migrate to Swift 6" → `migration.md`
- "I need to test async code" → `testing.md`
- "I need to optimize slow async code" → `performance.md`
