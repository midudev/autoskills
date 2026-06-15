---
name: golang-troubleshooting
description: "Troubleshoot Golang programs systematically - find and fix the root cause. Use when encountering bugs, crashes, deadlocks, or unexpected behavior in Go code. Covers debugging methodology, common Go pitfalls, test-driven debugging, pprof setup and capture, Delve debugger, race detection, GODEBUG tracing, and production debugging. Start here for any 'something is wrong' situation. Not for interpreting profiles or benchmarking (→ See `samber/cc-skills-golang@golang-benchmark` skill) or applying optimization patterns (→ See `samber/cc-skills-golang@golang-performance` skill)."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.2"
  openclaw:
    emoji: "🔍"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - dlv
    install:
      - kind: go
        package: github.com/go-delve/delve/cmd/dlv@latest
        bins: [dlv]
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Bash(dlv:*) Agent WebFetch WebSearch AskUserQuestion
---

**Persona:** You are a Go systems debugger. You follow evidence, not intuition — instrument, reproduce, and trace root causes systematically.

**Thinking mode:** Use `ultrathink` for debugging and root cause analysis. Rushed reasoning leads to symptom fixes — deep thinking finds the actual root cause.

**Modes:**

- **Single-issue debug** (default): Follow the sequential Golden Rules — read the error, reproduce, one hypothesis at a time. Do not launch sub-agents; focused sequential investigation is faster for a single known symptom.
- **Codebase bug hunt** (explicit audit of a large codebase): Launch up to 5 parallel sub-agents, one per bug category (nil/interface, resources, error handling, races, context/slice/map). Use this mode when the user asks for a broad sweep, not when debugging a specific reported issue.

**Dependencies:**

- dlv: `go install github.com/go-delve/delve/cmd/dlv@latest`

# Go Troubleshooting Guide

**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.** Symptom fixes create new bugs and waste time. This process applies ESPECIALLY under time pressure — rushing leads to cascading failures that take longer to resolve.

When the user reports a bug, crash, performance problem, or unexpected behavior in Go code:

1. **Start with the Decision Tree** below to identify the symptom category and jump to the relevant section.
2. **Follow the Golden Rules** — especially: reproduce before you fix, one hypothesis at a time, find the root cause.
3. **Work through the General Debugging Methodology** step by step. Do not skip steps.
4. **Watch for Red Flags** in your own reasoning. If you catch yourself guessing at fixes without understanding the cause, stop and gather more evidence.
5. **Escalate tools incrementally.** Start with the simplest diagnostic (`fmt.Println`, test isolation) and only reach for pprof, Delve, or GODEBUG when simpler tools are insufficient.
6. **Never propose a fix you cannot explain.** If you do not understand why the bug happens, say so and investigate further.

## Quick Decision Tree

```
WHAT ARE YOU SEEING?

"Build won't compile"
  → go build ./... 2>&1, go vet ./...
  → See [compilation.md](./references/compilation.md)

"Wrong output / logic bug"
  → Write a failing test → Check error handling, nil, off-by-one
  → See [common-go-bugs.md](./references/common-go-bugs.md), [testing-debug.md](./references/testing-debug.md)

"Random crashes / panics"
  → GOTRACEBACK=all ./app → go test -race ./...
  → See [common-go-bugs.md](./references/common-go-bugs.md), [diagnostic-tools.md](./references/diagnostic-tools.md)

"Sometimes works, sometimes fails"
  → go test -race ./...
  → See [concurrency-debug.md](./references/concurrency-debug.md), [testing-debug.md](./references/testing-debug.md)

"Program hangs / frozen"
  → curl localhost:6060/debug/pprof/goroutine?debug=2
  → See [concurrency-debug.md](./references/concurrency-debug.md), [pprof.md](./references/pprof.md)

"High CPU usage"
  → pprof CPU profiling
  → See [performance-debug.md](./references/performance-debug.md), [pprof.md](./references/pprof.md)

"Memory growing over time"
  → pprof heap profiling
  → See [performance-debug.md](./references/performance-debug.md), [concurrency-debug.md](./references/concurrency-debug.md)

"Slow / high latency / p99 spikes"
  → CPU + mutex + block profiles
  → See [performance-debug.md](./references/performance-debug.md), [diagnostic-tools.md](./references/diagnostic-tools.md)

"Simple bug, easy to reproduce"
  → Write a test, add fmt.Println / log.Debug
  → See [testing-debug.md](./references/testing-debug.md)
```

**Remember:** Read the Error → Reproduce → Measure One Thing → Fix → Verify

Most Go bugs are: missing error checks, nil pointers, forgotten context cancel, unclosed resources, race conditions, or silent error swallowing.

## The Golden Rules

### 1. Read the Error Message First

Go error messages are precise. Read them fully before doing anything else:

- **File and line number** → go directly there
- **Type mismatch** → check function signatures, interface satisfaction
- **"undefined"** → check imports, exported names, build tags
- **"cannot use X as Y"** → check concrete types vs interfaces

### 2. Reproduce Before You Fix

NEVER debug by guessing — reproduce first. Always:

- Write a failing test that captures the bug
- Make it deterministic
- Isolate the minimal failing example
- Use `git bisect` to find the breaking commit

### 3. If You Don't Measure It, You're Guessing

Never rely on intuition for performance or concurrency bugs:

- **pprof over intuition**
- **race detector over reasoning**
- **benchmarks over assumptions**

### 4. One Hypothesis at a Time

Change one thing, measure, confirm. If you change three things at once, you learn nothing.

### 5. Find the Root Cause — No Workarounds

A band-aid fix that masks the symptom IS NOT ACCEPTABLE. You MUST understand **why** the bug happens before writing a fix.

When you don't understand the issue:

- **Trace the data flow backwards** from the symptom to its origin.
- **Question your assumptions.** The code you trust might be wrong.
- **Ask "why" five times.** Keep going until you reach the actual root cause.
- **Perform more troubleshooting checks.** More fmt.Println, more output inspection...

### 6. Research the Codebase, Not Just the Diff

Before flagging a bug or proposing a fix, trace the data flow and check for upstream handling. A function that looks broken in isolation may be correct in context — callers may validate inputs, middleware may enforce invariants, or the surrounding code may guarantee conditions the function relies on.

1. **Trace callers** — who calls this function and with what values? Call sites can be found with code search tools.
2. **Check upstream validation** — input parsing, type conversions, or guard clauses earlier in the chain may make the "bug" unreachable.
3. **Read the surrounding code** — middleware, interceptors, or init functions may set up state the function depends on.

**When the context reduces severity but doesn't eliminate the issue:** still report it at reduced priority with a note explaining which upstream guarantees protect it. Add a brief inline comment (e.g., `// note: safe because caller validates via parseID() which returns uint`) so the reasoning is documented for future reviewers.

### 7. Start Simple

Sometimes `fmt.Println` IS the right tool for local debugging. Escalate tools only when simpler approaches fail. NEVER use `fmt.Println` for production debugging — use `slog`.

## Red Flags: You're Debugging Wrong

If any of these are happening, stop and return to Step 1:

- **"Quick fix for now, investigate later"** — There is no "later". Find the root cause.
- **Multiple simultaneous changes** — One hypothesis at a time.
- **Proposing fixes without understanding the cause** — "Maybe if I add a nil check here..." is guessing, not debugging.
- **Each fix reveals a new problem** — You're treating symptoms. The real bug is elsewhere.
- **3+ fix attempts on the same issue** — You have the wrong mental model. Re-read the code, trace the data flow from scratch.
- **"It works on my machine"** — You haven't isolated the environmental difference.
- **Blaming the framework/stdlib/compiler** — It's almost never a Go bug. Verify your code first.

## Reference Files

- **[General Debugging Methodology](./references/methodology.md)** — The systematic 10-step process: define symptoms, isolate reproduction, form one hypothesis, test it, verify the root cause, and defend against regressions. Escalation guide: when to escalate from `fmt.Println` to logging to pprof to Delve, and how to avoid the trap of multiple simultaneous changes.

- **[Common Go Bugs](./references/common-go-bugs.md)** — The bugs that crash Go code: nil pointer dereferences, interface nil gotcha (typed nil ≠ nil), variable shadowing, slice/map/defer/error/context pitfalls, race conditions, JSON unmarshaling surprises, unclosed resources. Each with reproduction patterns and fixes.

- **[Test-Driven Debugging](./references/testing-debug.md)** — Why writing a failing test is the first step of debugging. Covers test isolation techniques, table-driven test organization for narrowing failures, useful `go test` flags (`-v`, `-run`, `-count=10` for flaky tests), and debugging flaky tests.

- **[Concurrency Debugging](./references/concurrency-debug.md)** — Race conditions, deadlocks, goroutine leaks. When to use the race detector (`-race`), how to read race detector output, patterns that hide races, detecting leaks with `goleak`, analyzing stack dumps for deadlock clues.

- **[Performance Troubleshooting](./references/performance-debug.md)** — When your code is slow: CPU profiling workflow, memory analysis (heap vs alloc_objects profiles, finding leaks), lock contention (mutex profile), and I/O blocking (goroutine profile). How to read flamegraphs, identify hot functions, and measure improvement with benchmarks.

- **[pprof Reference](./references/pprof.md)** — Complete pprof manual. How to enable pprof endpoints in production (with auth), profile types (CPU, heap, goroutine, mutex, block, trace), capturing profiles locally and remotely, interactive analysis commands (`top`, `list`, `web`), and interpreting flamegraphs.

- **[Diagnostic Tools](./references/diagnostic-tools.md)** — Auxiliary tools for specific symptoms. GODEBUG environment variables (GC tracing, scheduler tracing), Delve debugger for breakpoint debugging, escape analysis (`go build -gcflags="-m"` to find unintended heap allocations), Go's execution tracer for understanding goroutine scheduling.

- **[Production Debugging](./references/production-debug.md)** — Debugging live production systems without stopping them. Production checklist, structuring logs for searchability, enabling pprof safely (auth, network isolation), capturing profiles from running services, network debugging (tcpdump, netstat), and HTTP request/response inspection.

- **[Compilation Issues](./references/compilation.md)** — Build failures: module version conflicts, CGO linking problems, version mismatch between `go.mod` and installed Go version, platform-specific build tags preventing cross-compilation.

- **[Code Review Red Flags](./references/code-review-flags.md)** — Patterns to watch during code review that signal potential bugs: unchecked errors, missing nil checks, concurrent map access, goroutines without clear exit, resource leaks from defer in loops.

## Cross-References

- → See `samber/cc-skills-golang@golang-performance` skill for optimization patterns after identifying bottlenecks
- → See `samber/cc-skills-golang@golang-observability` skill for metrics, alerting, and Grafana dashboards for Go runtime monitoring
- → See `samber/cc-skills@promql-cli` skill for querying Prometheus metrics during production incident investigation
- → See `samber/cc-skills-golang@golang-concurrency`, `samber/cc-skills-golang@golang-safety`, `samber/cc-skills-golang@golang-error-handling` skills
