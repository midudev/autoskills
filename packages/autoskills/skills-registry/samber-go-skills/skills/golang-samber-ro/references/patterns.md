# Reactive Patterns

Real-world patterns for building production reactive pipelines with samber/ro.

## Pattern 1: Remote Call with Retry and Timeout

Wrap a remote call (HTTP, gRPC, database) with automatic retry, exponential backoff, timeout, and fallback.

```go
result := ro.Pipe3(
    fetchUser(userID),  // ro.Observable[User] — wraps your remote call
    ro.Timeout[User](5*time.Second),
    ro.RetryWithConfig[User](ro.RetryConfig{
        Max:               3,
        Delay:             500 * time.Millisecond,
        BackoffMultiplier: 2.0,
        MaxDelay:          5 * time.Second,
    }),
    ro.Catch[User](func(err error) ro.Observable[User] {
        log.Printf("remote call failed after retries: %v, using cache", err)
        return getCachedUser(userID)
    }),
)

user, err := ro.Collect(result)
```

**Why ro over plain calls:** declarative retry + timeout + fallback in 10 lines vs manual for-loops with sleep, context, and error tracking.

## Pattern 2: Continuous Event Stream (Hot Observable)

Share a single long-lived connection (WebSocket, SSE, message queue) across multiple consumers.

```go
// Cold observable wrapping any event stream source
eventStream := ro.NewObservable[TickerEvent](func(ctx context.Context, obs ro.Observer[TickerEvent]) error {
    // connect to your stream source (WebSocket, NATS, Kafka, etc.)
    for {
        event, err := streamSource.Read(ctx)
        if err != nil {
            return err
        }
        obs.Next(event)
    }
})

// Share: one connection, multiple consumers
shared := ro.Pipe1(eventStream, ro.Share[TickerEvent]())

// Consumer 1: update UI
shared.Subscribe(ro.OnNext(func(e TickerEvent) {
    updateDashboard(e)
}))

// Consumer 2: record metrics
shared.Subscribe(ro.OnNext(func(e TickerEvent) {
    metrics.RecordTick(e.Symbol, e.Price)
}))

// Consumer 3: alert on threshold
ro.Pipe1(shared, ro.Filter(func(e TickerEvent) bool {
    return e.Price > alertThreshold
})).Subscribe(ro.OnNext(sendAlert))
```

The `rohttp` plugin provides WebSocket and HTTP streaming observables (see [Plugin Ecosystem](./plugin-ecosystem.md)).

## Pattern 3: Fan-In from Multiple Sources

Merge events from multiple independent sources, batch, and process.

```go
combined := ro.Pipe2(
    ro.Merge(
        apiStream,
        pushStream,
        cronScheduleStream,
    ),
    ro.Distinct[Event](),
    ro.BufferWithTimeOrCount[Event](100, 5*time.Second),
    ro.Map(func(batch []Event) ProcessResult {
        return processBatch(batch)
    }),
)
```

**When to use Merge vs Concat vs Zip:**

| Operator | Behavior | Use when |
| --- | --- | --- |
| `Merge` | Interleave: emit from any source as it arrives | Independent streams, order doesn't matter |
| `Concat` | Sequential: finish first source, then start second | Ordered processing, fallback chains |
| `Zip` | Pair: wait for one value from each source | Correlated data (user + settings, request + response) |
| `CombineLatest` | Latest: re-emit combined whenever any source changes | Dependent state (price \* quantity, config + data) |

## Pattern 4: Dependent Data Combination

Combine data from multiple async sources that depend on each other.

```go
// Fetch user and their orders in parallel, combine
profile := ro.Pipe1(
    ro.CombineLatest2(
        fetchUser(userID),
        fetchOrders(userID),
    ),
    ro.Map(func(pair lo.Tuple2[User, []Order]) UserProfile {
        return UserProfile{
            User:   pair.A,
            Orders: pair.B,
        }
    }),
)
```

For independent data where you need exactly one value from each:

```go
// Zip: waits for one value from each, pairs them
configAndData := ro.Zip2(loadConfig(), loadData())
```

## Pattern 5: Running Aggregation with Scan

Maintain running state across stream values — useful for dashboards, analytics, monitoring.

```go
type Stats struct {
    Count int
    Sum   float64
    Avg   float64
    Max   float64
}

statsStream := ro.Pipe2(
    metricsStream,
    ro.Scan(func(acc Stats, v float64) Stats {
        acc.Count++
        acc.Sum += v
        acc.Avg = acc.Sum / float64(acc.Count)
        if v > acc.Max {
            acc.Max = v
        }
        return acc
    }, Stats{}),
    ro.SampleTime[Stats](5*time.Second), // emit stats every 5s
)
```

**Scan vs Reduce:** `Scan` emits every intermediate state (good for live dashboards). `Reduce` emits only the final accumulated value (good for batch summaries).

## Pattern 6: Error Recovery Cascade

Layer multiple error recovery strategies.

```go
resilient := ro.Pipe3(
    primaryDataSource,
    // Strategy 1: retry transient failures
    ro.RetryWithConfig[Data](ro.RetryConfig{
        Max:   2,
        Delay: time.Second,
    }),
    // Strategy 2: fall back to secondary source
    ro.Catch[Data](func(err error) ro.Observable[Data] {
        log.Warn("primary failed, trying secondary", "err", err)
        return secondaryDataSource
    }),
    // Strategy 3: return cached/default value
    ro.OnErrorReturn[Data](cachedDefault),
)
```

**Order matters:** retry first (transient errors), then fallback source (persistent errors), then default value (total failure).

## Pattern 7: File System Watcher

React to file changes with debouncing.

```go
import rofsnotify "github.com/samber/ro/plugins/fsnotify"

watcher := ro.Pipe3(
    rofsnotify.Watch("/etc/app/config/"),
    ro.Filter(func(e fsnotify.Event) bool {
        return e.Op&fsnotify.Write != 0
    }),
    ro.ThrottleTime[fsnotify.Event](2*time.Second), // debounce rapid saves
    ro.Map(func(e fsnotify.Event) Config {
        return reloadConfig(e.Name)
    }),
)

watcher.Subscribe(ro.NewObserver(
    func(cfg Config) { applyConfig(cfg) },
    func(err error) { log.Error("config watch failed", "err", err) },
    func() { log.Info("config watcher stopped") },
))
```

## Pattern 8: Graceful Shutdown

Use context or signal observable to cleanly terminate infinite streams.

```go
import rosignal "github.com/samber/ro/plugins/signal"

// Method 1: OS signal
shutdown := rosignal.Notify(syscall.SIGTERM, syscall.SIGINT)

sub := ro.Pipe1(
    workStream,
    ro.TakeUntil[Work, os.Signal](shutdown),
).Subscribe(ro.NewObserver(
    processWork,
    handleError,
    func() { log.Info("gracefully stopped") },
))

sub.Wait() // blocks until SIGTERM/SIGINT

// Method 2: Context cancellation
ctx, cancel := context.WithCancel(context.Background())

sub := ro.Pipe2(
    workStream,
    ro.ContextReset[Work](ctx),
    ro.ThrowOnContextCancel[Work](),
).Subscribe(worker)

// Later: cancel() triggers clean shutdown
```

## Pattern 9: Event-Driven Pipeline with Logging

Full production pipeline with observability at each stage.

```go
import roslog "github.com/samber/ro/plugins/observability/slog"

pipeline := ro.Pipe5(
    eventSource,
    ro.TapOnSubscribe[Event](func() {
        slog.Info("pipeline started")
    }),
    ro.Filter(func(e Event) bool { return e.Valid() }),
    roslog.TapOnNext[Event](logger, slog.LevelDebug), // log each event
    ro.Map(enrichEvent),
    ro.BufferWithTimeOrCount[EnrichedEvent](50, 10*time.Second),
    ro.MapErr(func(batch []EnrichedEvent) (Result, error) {
        return persistBatch(batch)
    }),
    ro.TapOnError[Result](func(err error) {
        slog.Error("pipeline error", "err", err)
        metrics.IncrCounter("pipeline.errors", 1)
    }),
    ro.RetryWithConfig[Result](ro.RetryConfig{Max: 3, Delay: time.Second}),
)
```
