# Glossary

Use this when:

- You need a quick definition of a Swift Concurrency term.
- You encounter unfamiliar terminology in other reference files.

Skip this file if:

- You need implementation patterns, not definitions. Use the relevant reference file instead.

## Actor isolation

A rule enforced by the compiler: actor-isolated state can only be accessed from the actor's executor. Cross-actor access requires `await`.

## Global actor

A shared isolation domain applied via attributes like `@MainActor` or a custom `@globalActor`. Types/functions isolated to the same global actor can interact without crossing isolation.

## Default actor isolation

A module/target-level setting that changes the default isolation of declarations. App targets often choose `@MainActor` as the default to reduce migration noise, but it changes behavior and diagnostics.

## Strict concurrency checking

Compiler enforcement levels for Sendable and isolation diagnostics (minimal/targeted/complete). Raising the level typically reveals more issues and can trigger the “concurrency rabbit hole” unless migrated incrementally.

## Sendable

A marker protocol that indicates a type is safe to transfer across isolation boundaries. The compiler verifies stored properties and captured values for thread-safety.

## @Sendable

An annotation for function types/closures that can be executed concurrently. It tightens capture rules (captured values must be Sendable or safely transferred).

## Suspension point

An `await` site where a task may suspend and later resume. After a suspension point, you must assume other work may have run and (for actors) state may have changed (reentrancy).

## Reentrancy (actors)

While an actor is suspended at an `await`, other tasks can enter the actor and mutate state. Code after `await` must not assume actor state is unchanged.

## nonisolated

Marks a declaration as not isolated to the surrounding actor/global actor. Use only when it truly does not touch isolated mutable state (typically immutable Sendable data).

## nonisolated(nonsending) (Swift 6.2+ behavior)

An opt-out to prevent “sending” non-Sendable values across isolation while still allowing an async function to run in the caller’s isolation. Used to reduce Sendable friction when you do not need to hop executors.

## @concurrent (Swift 6.2+ behavior)

An attribute used to explicitly opt a nonisolated async function into concurrent execution (i.e., not inheriting the caller’s actor). It is used during migration when enabling `NonisolatedNonsendingByDefault`.

## @preconcurrency

An annotation used to suppress Sendable-related diagnostics from a module that predates concurrency annotations. It reduces noise but shifts safety responsibility to you.

## Region-based isolation / sending

Mechanisms that model ownership transfer so certain non-Sendable values can be moved between regions safely. The `sending` keyword enforces that a value is no longer used after transfer.

## AsyncSequence

A protocol for types that provide asynchronous, sequential iteration over elements. Conforms to the `for await` loop pattern. Use for streaming data where elements arrive over time.

## AsyncStream

A concrete implementation of `AsyncSequence` that bridges callback-based or delegate-based APIs to async/await. Provides `yield()` to emit values and `finish()` to complete the stream.

## Continuation

A mechanism to bridge callback-based APIs to async/await. `withCheckedContinuation` and `withCheckedThrowingContinuation` provide safe bridging with runtime checks. `withUnsafeContinuation` variants skip checks for performance-critical code.

## Task Local

Task-scoped storage that propagates values through the task hierarchy automatically. Declared with `@TaskLocal` and accessed via the wrapper's static property. Child tasks inherit parent task locals.

## Cooperative thread pool

Swift's threading model where tasks run on a limited pool of threads managed by the runtime. Tasks yield cooperatively at suspension points, allowing other tasks to run. Avoid blocking operations that would starve the pool.

## Executor

The scheduling mechanism that determines where and when actor code runs. `MainActor` uses the main thread executor. Custom actors use the default executor unless a custom executor is specified.

## Structured concurrency

A pattern where child tasks have a well-defined relationship to parent tasks. Child tasks must complete before the parent scope exits. Provides automatic cancellation propagation and prevents orphaned tasks. Implemented via `async let` and `TaskGroup`.

## Isolation domain

A boundary that protects mutable state from concurrent access. Each actor instance defines its own isolation domain. The `@MainActor` global actor defines a shared isolation domain for UI work. Code must cross isolation boundaries explicitly via `await`.

## Task priority

A hint to the runtime about the relative importance of a task. Priorities include `.high`, `.medium`, `.low`, `.userInitiated`, `.utility`, and `.background`. Higher priority tasks are scheduled before lower priority ones. Priority can escalate when a high-priority task awaits a low-priority one.

## Cancellation

A cooperative mechanism to signal that a task should stop. Check `Task.isCancelled` or call `Task.checkCancellation()` (throws) in long-running work. Cancellation propagates to child tasks in structured concurrency.

## Debounce

Wait for a period of inactivity before emitting a value. Used to reduce API calls for rapid inputs like search fields. Implemented as `debounce(for:tolerance:clock:)` in AsyncAlgorithms.

## Throttle

Emit at most one value per time interval, discarding intermediate values. Used to prevent excessive calls from repeated actions like button taps. Implemented as `throttle(for:clock:reducing:)` in AsyncAlgorithms.

## Merge (AsyncAlgorithms)

Combine multiple asynchronous sequences into one, emitting values as they arrive from any source. Order is interleaved based on emission timing. Stable operator.

## CombineLatest (AsyncAlgorithms)

Combine multiple asynchronous sequences, emitting a tuple whenever any source emits a new value. Always uses the latest value from each sequence. Stable operator.

## Zip (AsyncAlgorithms)

Combine multiple asynchronous sequences by pairing elements in order. Waits for all sequences to emit before producing a tuple. Stable operator.

## AsyncChannel

An AsyncSequence with backpressure sending semantics. Allows multiple producers to send values safely to multiple consumers with flow control. Stable operator.

## AsyncThrowingChannel

Like AsyncChannel but can emit errors through the stream. Stable operator.

## AsyncTimerSequence

An AsyncSequence that emits a value at regular intervals. Replaces timer-based publishers and manual sleep loops. Stable operator.

