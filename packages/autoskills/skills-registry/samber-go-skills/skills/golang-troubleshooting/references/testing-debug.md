# Test-Driven Debugging

A failing test MUST be written before fixing a bug. Writing a failing test is often the fastest debugging path. It gives you a reproducible, isolated environment.

## Reproduce the Bug in a Test

```go
func TestBugDescription(t *testing.T) {
    // Setup: exact conditions that trigger the bug
    svc := NewService(testConfig)

    // Act: the operation that fails
    result, err := svc.Process(badInput)

    // Assert: what should happen
    if err != nil {
        t.Fatalf("unexpected error: %v", err)
    }
    if result.Status != "ok" {
        t.Errorf("got status %q, want %q", result.Status, "ok")
    }
}
```

## Expand Edge Cases with Table Tests

When debugging, add edge cases to find the boundary of the bug:

```go
tests := []struct {
    name    string
    input   string
    want    time.Duration
    wantErr bool
}{
    {"valid", "5s", 5 * time.Second, false},
    {"empty", "", 0, true},
    {"negative", "-1s", -time.Second, false},
    {"zero", "0s", 0, false},
    {"overflow", "99999999h", 0, true},
    {"whitespace", " 5s ", 0, true},
}
for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) {
        got, err := ParseDuration(tt.input)
        if (err != nil) != tt.wantErr {
            t.Errorf("error = %v, wantErr %v", err, tt.wantErr)
        }
        if got != tt.want {
            t.Errorf("got %v, want %v", got, tt.want)
        }
    })
}
```

## Useful Test Flags

```bash
go test -v ./...                          # verbose output
go test -run TestName -v ./pkg/...        # single test
go test -count=1 ./...                    # disable cache
go test -timeout 10s ./...                # short timeout (find hangs)
go test -parallel 1 ./...                 # sequential execution
go test -race ./...                       # race detector
go test -cover ./...                      # coverage summary
go test -coverprofile=c.out ./... && go tool cover -html=c.out  # coverage report
go test -failfast ./...                   # stop on first failure
go test -shuffle=on ./...                # randomize test order (Go 1.17+)
```

## Debugging Flaky Tests

Flaky tests (pass sometimes, fail sometimes) are usually caused by one of:

1. **Shared mutable state between tests** — global variables, package-level maps, singletons
   - Fix: reset state in `TestMain` or use `t.Cleanup`
2. **Test order dependence** — one test sets up state another test relies on
   - Diagnose: `go test -run TestSuspect -count=1` (run in isolation)
   - Diagnose: `go test -shuffle=on` (randomize order)
   - Fix: each test must set up its own preconditions
3. **Timing sensitivity** — `time.Sleep` in tests, race between goroutines
   - Fix: use channels/waitgroups to synchronize, not sleeps
4. **Port conflicts** — tests binding to fixed ports
   - Fix: use port `0` and read the assigned port
5. **File system pollution** — tests writing to shared temp directories
   - Fix: use `t.TempDir()` for per-test directories

```bash
# Confirm flakiness by running many times
go test -count=100 -run TestSuspect ./pkg/... -failfast

# Check for parallelism issues
go test -parallel 1 -count=10 ./pkg/...

# Check for order dependence
go test -shuffle=on ./pkg/...
```
