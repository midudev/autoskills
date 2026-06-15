# Dependency Conflicts & Resolution

## Diagnosing Conflicts

```bash
# See why a module is in your build
go mod why -m github.com/some/module

# See which version is selected
go list -m github.com/some/module

# See the full requirement graph
go mod graph

# List all modules in the build
go list -m all
```

## Resolution Strategies

**Force a specific version** (when two deps require incompatible versions):

```bash
go mod edit -replace=example.com/pkg@v1.2.0=example.com/pkg@v1.3.1
```

```go
// go.mod
replace example.com/pkg v1.2.0 => example.com/pkg v1.3.1
```

**Use a local fork** (for debugging or patching):

```go
replace example.com/pkg => ../my-local-fork
```

**Block a problematic version**:

```bash
go mod edit -exclude=example.com/pkg@v1.3.0
```

When a version is excluded, any requirement on that version is redirected to the next higher available version.

**Force upgrade a transitive dependency**:

```bash
go get github.com/transitive/dep@v1.5.0
```

This adds an explicit requirement in your `go.mod`, overriding whatever the transitive dependency chain would select via MVS.

## Resolution Workflow

1. Run `go mod graph` and `go mod why -m <module>` to understand the dependency chain
2. Identify which of your direct dependencies pulls in the conflicting version
3. Try upgrading the direct dependency first: `go get github.com/direct/dep@latest`
4. If that doesn't resolve it, use `replace` or `exclude` as a temporary fix
5. Run `go mod tidy` to clean up
6. Verify with `go build ./...` and `go test ./...`

**Important**: `replace` and `exclude` directives only take effect in the **main module's** `go.mod`. They are ignored when your module is used as a dependency. Remove `replace` directives before publishing a library.

## Retract (For Module Authors)

Mark versions as broken or accidentally published:

```go
// go.mod
retract v1.0.0         // Contains critical bug in auth
retract [v1.1.0, v1.2.0] // Range of broken versions
```

Retracted versions are still downloadable but `go get` will not select them by default, and `go list -m -u` warns about them.
