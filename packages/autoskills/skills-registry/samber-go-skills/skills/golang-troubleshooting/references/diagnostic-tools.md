# Diagnostic Tools

## Runtime Diagnostics (GODEBUG)

### Go documentation command

Use `go doc`, not `go tool doc`. Go 1.26 removed the old `cmd/doc` / `go tool doc` path.

### GC Tracing

```bash
GODEBUG=gctrace=1 ./app
```

**Output:**

```
gc 123 @45.67s 4%: 0.8+10+0.3 ms clock, 6+5/10/0 ms cpu, 512->300->150 MB
```

| Field            | Meaning                                         |
| ---------------- | ----------------------------------------------- |
| 4%               | GC CPU overhead (if >10%, over-allocating)      |
| 512->300->150 MB | Heap at GC start -> heap at GC end -> live heap |
| Large pause      | Allocation storm                                |

### Scheduler Tracing

```bash
GODEBUG=schedtrace=1000,scheddetail=1 ./app
```

| Signal               | Meaning                            |
| -------------------- | ---------------------------------- |
| runqueue high        | CPU saturation, goroutines waiting |
| idleprocs=0          | Fully busy, at capacity            |
| spinningthreads      | Lock contention                    |
| threads > gomaxprocs | Blocking syscalls                  |

### GOTRACEBACK

Get full stack traces on panic:

```bash
GOTRACEBACK=all ./app
```

| Level    | Shows                                 |
| -------- | ------------------------------------- |
| `none`   | No stack traces                       |
| `single` | Current goroutine only (default)      |
| `all`    | All goroutines (useful for deadlocks) |
| `system` | All goroutines + runtime frames       |

---

## Delve Debugger

### Installation

```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Basic Usage

```bash
dlv debug ./cmd/myapp          # debug a program
dlv test ./mypackage           # debug a test
dlv attach 12345               # attach to running process
dlv exec ./myapp -- --flag=v   # execute binary with args
```

### Common Commands

```
break main.main      # set breakpoint
break file.go:42     # break at line
continue             # continue execution
next                 # step over (n)
step                 # step into (s)
stepout              # step out
print variable       # print variable
locals               # print all locals
args                 # print function arguments
goroutines           # list all goroutines
goroutine 5          # switch to goroutine 5
stack                # show stack trace
```

### IDE Integration

**VS Code:**

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch Package",
      "type": "go",
      "request": "launch",
      "mode": "auto",
      "program": "${workspaceFolder}",
      "env": { "GOTRACEBACK": "all" }
    }
  ]
}
```

**GoLand:** Run -> Edit Configurations -> Go Build. Click gutter to set breakpoints. Use Debugger tab.

---

## Advanced Analysis

→ See `samber/cc-skills-golang@golang-benchmark` skill (compiler-analysis.md) for detailed guides on escape analysis interpretation, assembly inspection, and compiler diagnostics (SSA dump, inlining decisions). See also trace.md for execution tracer analysis.
