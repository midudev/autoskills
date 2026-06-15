# Versioning & Minimal Version Selection

## Semantic Versioning (SemVer)

Go modules use **`vMAJOR.MINOR.PATCH`** (the `v` prefix is required):

- **MAJOR**: Breaking changes to the public API
- **MINOR**: Backward-compatible new functionality
- **PATCH**: Backward-compatible bug fixes

### Stability Rules

| Version     | Stability                                 |
| ----------- | ----------------------------------------- |
| `v0.x.x`    | Unstable — no compatibility guarantees    |
| `v1.x.x`+   | Stable — backward-compatible within major |
| Pre-release | Unstable (e.g., `v1.5.0-beta.1`)          |

### Major Version Suffix Rule

For `v2` and above, the module path must include a `/vN` suffix. This is Go's import compatibility rule — different major versions are treated as entirely separate modules, allowing them to coexist in the same build:

```go
// go.mod
module github.com/example/pkg/v2

// Import in code
import "github.com/example/pkg/v2/subpkg"
```

Tags: `v2.0.0`, `v2.1.0`, etc. The `v0` and `v1` versions have no suffix.

### Special Cases

- **Pseudo-versions**: For untagged commits — `v0.0.0-20210101120000-abcdef123456` (base version + timestamp + commit hash)
- **`+incompatible`**: Marks `v2+` modules that have not adopted the `/vN` path convention
- **`gopkg.in`**: Always uses a version suffix with a dot — `gopkg.in/yaml.v3`

## Minimal Version Selection (MVS)

Go's dependency resolution algorithm is fundamentally different from npm, pip, or cargo.

### How It Works

Most package managers select the **latest** compatible version of each dependency. Go does the opposite: it selects the **minimum version that satisfies all requirements**. If module A requires `pkg@v1.2.0` and module B requires `pkg@v1.3.0`, MVS selects `v1.3.0` — the highest minimum required, not the latest available.

### Why This Design

- **Deterministic without a lock file**: Given the same `go.mod` inputs, MVS always produces the same build list. `go.sum` is just integrity verification.
- **High fidelity**: Builds closely match what module authors tested against, since the nearest compatible version is selected rather than the latest.
- **No solver needed**: The algorithm is simple graph traversal (under 50 lines of code), not an NP-hard constraint satisfaction problem.
- **Reproducible across machines**: No "works on my machine" from different lock file states.

### Upgrades and Downgrades

- **Upgrade**: `go get pkg@v1.5.0` adds an edge to `v1.5.0` in the module graph and reruns MVS. Only the minimum necessary changes propagate.
- **Downgrade**: `go get pkg@v1.2.0` removes all versions above `v1.2.0` from the graph, then walks backward to find the latest remaining versions of affected dependencies.
