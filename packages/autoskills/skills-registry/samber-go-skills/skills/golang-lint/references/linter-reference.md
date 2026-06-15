# Linter Reference

golangci-lint v2 uses a `.golangci.yml` with `version: "2"` at the project root.

Key sections of `.golangci.yml`:

- **`run`** — concurrency, timeout, test inclusion, directory exclusions
- **`linters.enable`** / **`linters.disable`** — which linters are active
- **`linters.settings`** — per-linter thresholds and options
- **`formatters`** — code formatters (gofmt, gofumpt)
- **`issues`** — output limits, exclusion rules

To add a linter: add it to `linters.enable` and optionally configure it in `linters.settings`.

To disable a linter: move it to `linters.disable` with a comment explaining why.

## Linter Categories

The recommended configuration enables linters across these domains:

| Domain | Linters | Catches |
| --- | --- | --- |
| Correctness | govet, staticcheck, unused, errcheck, errorlint, nilerr, forcetypeassert, copyloopvar, durationcheck, reassign | Bugs, unchecked errors, stdlib misuse |
| Style | gocritic, revive, wsl_v5, whitespace, godot, misspell, dupword, predeclared, errname, asciicheck | Readability, naming, consistency |
| Complexity | gocyclo, nestif, funlen, dupl | Overly complex or duplicated code |
| Performance | perfsprint, unconvert, ineffassign, goconst | Conversions, string ops, dead assigns |
| Security | gosec, bidichk, bodyclose, noctx, containedctx, fatcontext, sqlclosecheck, rowserrcheck | Security issues, resource leaks (HTTP, SQL) |
| Logging | sloglint, loggercheck | Structured log consistency |
| Testing | thelper, paralleltest, testifylint, usetesting | Test hygiene and best practices |
| Modernization | modernize, exptostd, intrange, usestdlibvars, exhaustive, nolintlint | Modern Go idioms, lint hygiene |
| Formatting | gofmt, gofumpt | Code formatting |

All linters are enabled in the [recommended .golangci.yml](../assets/.golangci.yml), organized by domain.

### Correctness & Safety

- **govet** — Go's built-in checker: copylocks, printf format mismatches, struct tag validation, context stored in structs, unreachable code, nil dereferences
- **staticcheck** — Extensive static analysis: deprecated APIs, common mistakes, unnecessary code, simplifications, misuse of standard library
- **unused** — Detects unused variables, functions, types, and struct fields
- **errcheck** — Ensures all error returns are checked, including type assertions (configured with `check-type-assertions: true`)
- **nilerr** — Detects returning nil error when `err` is non-nil (common source of silent failures)
- **forcetypeassert** — Flags type assertions without the comma-ok check (`v := x.(T)` instead of `v, ok := x.(T)`)
- **copyloopvar** — Detects loop variable copy issues (Go 1.22+)
- **errorlint** — Enforces correct use of `errors.Is`/`errors.As` and `%w` wrapping (Go 1.13+ error wrapping)
- **durationcheck** — Detects `time.Duration * time.Duration` multiplication bugs (e.g., `2 * time.Second * time.Minute` produces nanoseconds squared, not seconds)
- **reassign** — Detects reassignment of package-level variables outside `init()`, which hides state mutations

### Style & Readability

- **gocritic** — Opinionated style checks: unnecessary conversions, range copies, append-assign patterns, redundant code
- **revive** — Naming conventions for exported types, unexported returns, receiver naming, error naming, stuttered package names
- **wsl_v5** — Whitespace and blank line rules for visual grouping and readability
- **whitespace** — Detects trailing whitespace and unnecessary blank lines in function bodies
- **godot** — Ensures exported-symbol comments end with a period
- **misspell** — Catches common English misspellings in identifiers and comments
- **predeclared** — Flags shadowing of Go built-in identifiers (e.g., naming a variable `len`, `cap`, `error`)
- **errname** — Enforces error naming conventions: error types suffixed with `Error` (e.g., `DecodeError`), error variables prefixed with `Err` (e.g., `ErrNotFound`)
- **dupword** — Detects duplicate words in comments and strings (e.g., "the the", "is is") — often copy-paste artifacts
- **asciicheck** — Flags non-ASCII identifiers that enable homoglyph/trojan source attacks (visually identical but different Unicode codepoints)

### Complexity

- **gocyclo** — Cyclomatic complexity threshold (configured: 13). Functions exceeding this should be split
- **nestif** — Detects deeply nested if/else chains that harm readability
- **funlen** — Function length limits (configured: 120 lines, 80 statements)
- **dupl** — Code duplication detection (configured: 100 token threshold)

### Performance

- **perfsprint** — Suggests faster alternatives to `fmt.Sprintf` (e.g., `strconv.Itoa` instead of `fmt.Sprintf("%d", n)`)
- **unconvert** — Detects unnecessary type conversions (e.g., `int(x)` when `x` is already `int`)
- **ineffassign** — Detects assignments to variables that are never subsequently read
- **goconst** — Detects repeated string/number literals that should be extracted to constants (configured: min 3 chars, min 4 occurrences)

### Security & Resources

- **gosec** — Security scanner: SQL injection, hardcoded credentials, weak crypto, path traversal, unsafe usage, and 50+ other rules. The primary SAST tool in the config — never suppress without strong justification.
- **bidichk** — Detects dangerous bidirectional Unicode sequences (CVE-2021-42574 trojan source attack — code that looks safe but executes differently)
- **noctx** — Detects HTTP requests sent without `context.Context` (prevents proper timeouts and cancellation)
- **containedctx** — Flags `context.Context` stored in struct fields instead of passed as a parameter (anti-pattern per Go docs)
- **fatcontext** — Detects `context.WithValue`/`WithCancel` in loops, creating unbounded context chains that grow each iteration and cause memory leaks
- **bodyclose** — Ensures HTTP response bodies are closed (unclosed bodies leak connections)
- **sqlclosecheck** — Ensures `sql.Rows` and `sql.Stmt` are closed after use
- **rowserrcheck** — Ensures `sql.Rows.Err()` is checked after iteration

### Logging

- **sloglint** — Enforces consistent `log/slog` code style: proper key-value pairing, message formatting, and level usage
- **loggercheck** — Validates key-value pair formatting for structured loggers (zap, slog, logr) — detects odd numbers of args, missing keys

### Testing

- **thelper** — Ensures test helpers call `t.Helper()` so failures report the correct call site
- **paralleltest** — Detects tests and subtests missing `t.Parallel()` calls
- **testifylint** — Enforces testify best practices (e.g., `assert.Equal(t, expected, actual)` over `assert.True(t, expected == actual)`)
- **usetesting** — Suggests `t.Setenv`/`t.TempDir` instead of `os.Setenv`/`os.MkdirTemp` in tests (automatic cleanup, proper isolation)

### Modernization & Meta

- **modernize** — Detects code that can be rewritten using newer Go features (requires golangci-lint v2.6.0+)
- **exptostd** — Detects `golang.org/x/exp/` functions that now have stdlib equivalents (e.g., `slices`, `maps`, `cmp` packages added in Go 1.21)
- **intrange** — Suggests `range N` over C-style `for i := 0; i < N; i++` loops (Go 1.22+)
- **usestdlibvars** — Replaces hardcoded strings/numbers with stdlib constants (e.g., `http.MethodGet` instead of `"GET"`)
- **exhaustive** — Ensures switch statements on enum types cover all possible values
- **nolintlint** — Enforces proper `//nolint` directive usage: requires linter name and justification comment (configured with `require-explanation` and `require-specific`)

### Formatting

Formatters run via `golangci-lint fmt ./...`:

- **gofmt** — Standard Go formatter (canonical formatting)
- **gofumpt** — Stricter formatter with extra rules (configured with `extra-rules: true`): consistent empty lines, grouped imports, simplified code patterns
