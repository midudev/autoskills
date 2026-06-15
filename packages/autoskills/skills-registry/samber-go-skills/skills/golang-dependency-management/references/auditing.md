# Auditing Dependencies

## Test-Only vs Binary Dependencies

Go's `go.mod` does **not** distinguish between test-only and production dependencies. All modules appear together, with `// indirect` marking transitive dependencies.

### What Gets Included in Your Binary

- `*_test.go` files are **never** compiled by `go build` — only by `go test`
- Packages imported only by test files are not linked into the final binary
- However, their modules still appear in `go.mod`

### Module Graph Pruning (Go 1.17+)

With `go 1.17` or higher in `go.mod`, Go prunes the module graph: transitive dependencies needed only for tests of other modules are excluded from the build graph. This reduces `go.mod` size and avoids downloading unnecessary modules.

### Upgrading With or Without Test Dependencies

```bash
go get -u ./...       # Upgrade deps, EXCLUDING test-only deps
go get -u -t ./...    # Upgrade deps, INCLUDING test-only deps
```

### Impact on Binary Size

To check whether a large dependency is actually linked into your binary (vs. only used in tests), use `goweight` or `go-size-analyzer` — if the package doesn't appear in the binary breakdown, it's test-only and not contributing to binary size.

## Vulnerability Scanning with govulncheck

`govulncheck` reports known vulnerabilities that affect your code. It uses static analysis to narrow reports to vulnerabilities in code paths your project actually calls — unlike generic CVE scanners that flag every dependency regardless of usage.

```bash
# Scan source code (most common)
govulncheck ./...
# Or, when govulncheck is pinned with a Go 1.24+ tool directive:
go tool govulncheck ./...

# Scan a compiled binary
govulncheck -mode=binary ./bin/myapp

# JSON output (for CI integration)
govulncheck -format json ./...

# Include test code in analysis
govulncheck -test ./...
```

Output shows the vulnerability ID, affected module, fixed version, and the call trace from your code to the vulnerable function. If a vulnerability exists in a dependency but your code never calls the affected function, `govulncheck` does not flag it.

For CI pipeline integration, see the `samber/cc-skills-golang@golang-continuous-integration` skill.

## Tracking Outdated Dependencies with go-mod-outdated

`psampaz/go-mod-outdated` lists outdated direct dependencies with available updates.

```bash
# Show outdated direct dependencies with available updates
go list -u -m -json all | go-mod-outdated -update -direct

# Fail in CI if dependencies are outdated
go list -u -m -json all | go-mod-outdated -update -direct -ci

# Markdown output
go list -u -m -json all | go-mod-outdated -update -direct -style markdown
```

Output columns: MODULE, CURRENT version, WANTED (latest minor/patch), LATEST (latest overall), and VALID TIMESTAMPS (warns if an "update" is chronologically older than current).

## Analyzing Dependency Size with goweight

`jondot/goweight` lists every package linked into the binary sorted by size contribution. It helps identify bloated dependencies and evaluate whether a lighter alternative exists.

```bash
goweight          # Sort by size
goweight --json   # JSON output for CI tracking
```

**Modern alternative**: [go-size-analyzer](https://github.com/Zxilly/go-size-analyzer) (`gsa`) supports ELF, Mach-O, PE, and WebAssembly formats with interactive HTML/SVG visualization:

```bash
go get -tool github.com/Zxilly/go-size-analyzer/cmd/gsa@latest
go build -o ./myapp ./cmd/myapp
go tool gsa -f html -o size-report.html ./myapp
```
