# Code Review Red Flags

If you see these in code review, flag them:

| Pattern | Why It's Bad |
| --- | --- |
| `result, _ := doSomething()` | Silent error — mystery bugs later |
| `go func() { }()` without context | Can't cancel, leaks goroutine |
| Channel without close | Goroutine leak when sender exits |
| `time.After` in hot loop | Repeated timer allocation/churn; use a reusable timer when reset semantics matter |
| Global map without mutex | Data race |
| `defer` inside hot loop | Deferred calls pile up until return |
| `json.Marshal` in hot path | Expensive, causes GC pressure |
| `for range` without `ok` check | Misses channel close |
| `var err *MyError; return err` | Interface nil gotcha |
| `http.Get` without timeout | Default client has no timeout |
| `fmt.Errorf("...: %v", err)` | Use `%w` to preserve error chain |
| `:=` shadowing outer `err` | Inner err is a new variable, outer stays nil |
| `func (c Counter) Lock()` | Value receiver copies sync types |
| `wg.Add(1)` inside goroutine | Race: Wait() may return before Add() |
| `http.Error(...)` without return | Handler keeps executing after error |
| `iota` starting at 0 for enums | Zero value ambiguous with first constant |
| `strings.Trim(s, "prefix")` | Strips char set, not substring |
| `log.Fatal(err)` in func w/ defer | `os.Exit` skips all deferred cleanup |
| `t1 == t2` for `time.Time` | Use `.Equal()` — monotonic clock differs |
| `rows, _ := db.Query(...)` no Close | Leaks database connections |
| `ch <- val` after `close(ch)` | Panics — only sender should close |
| `select { default: }` in loop | Busy loop — burns CPU without blocking |
| `int32(bigInt64)` | Silent truncation — no overflow check |
| `filepath.Join(base, userInput)` | Doesn't prevent `../` path traversal |
| `regexp.MustCompile` in handler | Recompiles every call — move to package var |
| `fallthrough` in switch | Executes next case unconditionally |
