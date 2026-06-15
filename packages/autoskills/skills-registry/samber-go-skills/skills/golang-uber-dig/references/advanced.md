# Advanced — uber-go/dig

Detail topics that are referenced from `SKILL.md`. Each section is self-contained.

## Decorate

`Decorate` modifies a value already provided in the container — the decorator receives the original instance and returns a replacement. Common uses: enriching a logger with context, wrapping a metrics scope with tags, swapping a real client for a recording one in a child scope.

```go
c.Decorate(func(log *zap.Logger) *zap.Logger {
    return log.Named("worker")
})
```

Decorators apply to the scope they were registered in and to that scope's descendants. Use them at scope boundaries or package wiring boundaries, not in main(), so changes stay local.

## Scopes

A `Scope` is a child container that inherits providers from its parent and can add or override its own. Scopes let request-, tenant-, or module-level dependencies coexist with shared singletons:

```go
root := dig.New()
root.Provide(NewLogger)
root.Provide(NewDatabase)

requestScope := root.Scope("request")
requestScope.Provide(NewRequestContext)            // only visible inside requestScope
requestScope.Decorate(func(l *zap.Logger) *zap.Logger {
    return l.With(zap.String("scope", "request"))
})
```

By default, providers registered to a scope are private to that scope and its children. Pass `dig.Export(true)` to `Provide` inside a scope to make the type visible from the parent:

```go
requestScope.Provide(NewSharedCache, dig.Export(true))
```

## Optional Dependencies

`optional:"true"` lets a consumer compile and run when a provider is missing. Use it sparingly — optional dependencies hide configuration mistakes. They make sense for genuinely optional features (a tracing exporter, an in-memory cache) but not for core services like a database.

```go
type Params struct {
    dig.In

    Logger *zap.Logger
    Tracer trace.Tracer `optional:"true"`
}
```

## Error Handling

dig wraps the constructor error with the dependency path so you can see _which_ graph edge failed:

```go
if err := c.Invoke(run); err != nil {
    // err describes the chain: "could not build *http.Server: ..."
}
```

Useful helpers:

- `errors.As(err, &dig.Error{})` — true if the error originated inside dig
- `dig.RootCause(err)` — unwrap to the original constructor error returned by user code
- `dig.IsCycleDetected(err)` — true if the graph contains a cycle (typically reported at first `Invoke` unless `DeferAcyclicVerification` is set)
- `errors.As(err, &dig.PanicError{})` — when `RecoverFromPanics` is enabled, a panicking constructor surfaces as this typed error

## Visualization

dig can emit the dependency graph in DOT format — useful when wiring becomes too tangled to reason about by reading code:

```go
f, _ := os.Create("graph.dot")
_ = dig.Visualize(c, f)
// then: dot -Tpng graph.dot -o graph.png
```

`dig.VisualizeError(err)` highlights the failed edges when an `Invoke` returns an error — invaluable for debugging "missing type" failures in deep graphs.

## Quick Reference

### Container

| Function/Method | Purpose |
| --- | --- |
| `dig.New(opts...)` | Create a root container |
| `c.Provide(ctor, opts...)` | Register a constructor |
| `c.Invoke(fn, opts...)` | Run a function with injected dependencies |
| `c.Decorate(fn, opts...)` | Modify a previously-provided value within a scope |
| `c.Scope(name, opts...)` | Create a child scope (private providers by default) |
| `c.String()` | Human-readable text summary of providers (not DOT; use `dig.Visualize` for DOT) |

### Provide options

| Option | Purpose |
| --- | --- |
| `dig.Name("...")` | Disambiguate same-typed providers |
| `dig.Group("...")` | Add the result to a value group |
| `dig.As(new(I))` | Provide the concrete value as one or more interfaces |
| `dig.Export(true)` | Make a scope-level provider visible from the root |
| `dig.FillProvideInfo(&info)` | Capture metadata for tooling |

### Container options

| Option | Purpose |
| --- | --- |
| `dig.DeferAcyclicVerification()` | Defer cycle check to first `Invoke` |
| `dig.RecoverFromPanics()` | Convert constructor panics into `dig.PanicError` |
| `dig.DryRun(true)` | Validate without invoking constructors |

### Errors

| Helper                              | Purpose                           |
| ----------------------------------- | --------------------------------- |
| `dig.RootCause(err)`                | Unwrap to the user-returned error |
| `dig.IsCycleDetected(err)`          | True if the graph has a cycle     |
| `errors.As(err, &dig.PanicError{})` | Detect a recovered panic          |
| `dig.Visualize(c, w, opts...)`      | Write the graph in DOT format     |
