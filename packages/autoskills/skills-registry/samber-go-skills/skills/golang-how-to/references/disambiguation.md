# Competing clusters — deep disambiguation

Eleven clusters where skills overlap. Each cluster includes a boundary table, concrete routing examples, and notes on gap cases not yet explicit in source skill descriptions.

---

## 1. Performance cluster

Four skills form a "deep analysis" cluster. `golang-observability` is the always-on counterpart; the other three are activated on demand.

| Skill | Unique territory | Does NOT own |
| --- | --- | --- |
| `samber/cc-skills-golang@golang-performance` | Optimization patterns — "if allocation bottleneck → use sync.Pool", "if hot-path → avoid reflection" | Measurement, profile capture, root cause analysis |
| `samber/cc-skills-golang@golang-benchmark` | pprof/trace capture, flame graph interpretation, benchstat comparison, CI regression detection | Deciding which optimization to apply |
| `samber/cc-skills-golang@golang-troubleshooting` | Debugging workflow: reproduce, bisect, Delve, race detector, GODEBUG, test-driven debugging | Profile interpretation, optimization patterns |
| `samber/cc-skills-golang@golang-observability` | Always-on production signals: structured logs, Prometheus counters, OTel traces, alerting | Temporary investigation, benchmark runs |

**Routing examples:**

- "My HTTP handler is slow in production" → start with `golang-observability` (check metrics/traces), then `golang-benchmark` (capture profiles), then `golang-performance` (apply fixes).
- "My benchmark regressed by 20%" → `golang-benchmark` (benchstat comparison, detect root cause via pprof).
- "I need to reduce allocations in the hot path" → `golang-performance` (pooling, struct layout, escape analysis).
- "The process crashes after 10 minutes under load" → `golang-troubleshooting` (race detector, memory leak, Delve attach).

---

## 2. Dependency injection cluster

Start with `golang-dependency-injection` for library selection. Then use the library-specific skill once the choice is made.

| Skill | Unique territory |
| --- | --- |
| `samber/cc-skills-golang@golang-dependency-injection` | Concepts (why DI, manual injection), constructor patterns, library comparison table |
| `samber/cc-skills-golang@golang-google-wire` | Compile-time codegen: `wire.Build`, `wire.NewSet`, `wire.Bind`, `ProviderSet` |
| `samber/cc-skills-golang@golang-uber-dig` | Runtime reflection: `dig.Provide`, `dig.In`/`dig.Out`, value groups, `Decorate` |
| `samber/cc-skills-golang@golang-uber-fx` | Full application framework on top of dig: `fx.New`, `fx.Module`, lifecycle hooks, `fx.Annotate` |
| `samber/cc-skills-golang@golang-samber-do` | Type-safe container, `do.Provide`, scopes, health checks, graceful shutdown |

**Routing examples:**

- "Should I use DI in my project?" → `golang-dependency-injection`.
- "My project uses google/wire, `wire.Build` is failing" → `golang-google-wire`.
- "I want lifecycle hooks with my DI container" → `golang-uber-fx` (not `golang-uber-dig` — dig is lower-level).
- "I want type-safe DI without code generation" → `golang-samber-do` or `golang-uber-dig`.

---

## 3. samber/\* functional cluster

The three core skills cover three distinct programming models. They rarely compete in the same task.

| Skill | Unique territory | Does NOT own |
| --- | --- | --- |
| `samber/cc-skills-golang@golang-samber-lo` | Finite collections: `lo.Map`, `lo.Filter`, `lo.Reduce`, `lo.Uniq`, `lo.GroupBy` — 500+ helpers | Infinite streams, event-driven pipelines |
| `samber/cc-skills-golang@golang-samber-ro` | Infinite/event-driven: observables, subjects, operators like `Map`/`Filter`/`Throttle`, backpressure | Finite slice transforms |
| `samber/cc-skills-golang@golang-samber-mo` | Monadic types: `mo.Option[T]`, `mo.Result[T]`, `mo.Either[L,R]`, `mo.Future[T]` | Slice helpers, reactive streams |

**Routing examples:**

- "Transform a slice of users into a map by ID" → `golang-samber-lo` (`lo.KeyBy`).
- "Stream events from a channel with backpressure and rate limiting" → `golang-samber-ro`.
- "Return an optional value without using nil" → `golang-samber-mo` (`mo.Some`/`mo.None`).
- "Compose error-returning functions without if-err chains" → `golang-samber-mo` (`mo.Result[T]`).

> Note: `golang-samber-mo` is currently absent from the mutual cross-reference between `lo` and `ro` in their descriptions. The boundary above reflects the intended design.

---

## 4. Error handling cluster

| Skill | Unique territory |
| --- | --- |
| `samber/cc-skills-golang@golang-error-handling` | Idiomatic error flow: `fmt.Errorf("%w")`, `errors.Is`/`errors.As`, sentinel errors, single-handling rule, `panic`/`recover` |
| `samber/cc-skills-golang@golang-samber-oops` | `oops.New().Code().User().Hint()` builder, stack traces, APM integration, `oops.Recover` |
| `samber/cc-skills-golang@golang-safety` | Preventing errors from occurring: nil checks, zero-value design, integer overflow guards, append aliasing |

**Routing examples:**

- "How should I wrap errors so callers can match them?" → `golang-error-handling`.
- "I want structured errors with HTTP codes and stack traces" → `golang-samber-oops`.
- "My service panics on nil pointer dereference" → `golang-safety` (defensive coding) AND `golang-troubleshooting` (debugging the existing crash).

---

## 5. Style / naming / lint / docs cluster

These four skills each own a distinct slice of "code quality". Source descriptions include explicit mutual disclaimers.

| Skill | Unique territory |
| --- | --- |
| `samber/cc-skills-golang@golang-code-style` | Line formatting, blank lines between declarations, short variable names in small scopes, comment placement |
| `samber/cc-skills-golang@golang-naming` | All identifier naming rules: `MixedCaps`, no `GetX`, no `IFoo` prefixes, package names, error variable names |
| `samber/cc-skills-golang@golang-lint` | golangci-lint YAML config, which linters to enable, `//nolint` usage, CI integration |
| `samber/cc-skills-golang@golang-documentation` | Exported symbol comments, package-level docs, README sections, `example_test.go`, `llms.txt` |

**Routing examples:**

- "How do I name my constructor?" → `golang-naming`.
- "My `golangci-lint` run reports `exhaustive` errors" → `golang-lint`.
- "How should I format my package-level godoc comment?" → `golang-documentation`.
- "When should I use a blank line between two function bodies?" → `golang-code-style`.

---

## 6. CLI cluster

| Skill | Unique territory |
| --- | --- |
| `samber/cc-skills-golang@golang-cli` | Exit codes, signal handling (SIGTERM), stdin/stdout/stderr patterns, progress bars, terminal detection |
| `samber/cc-skills-golang@golang-spf13-cobra` | `cobra.Command`, `PersistentPreRunE`, `Args` validators, `ValidArgsFunction`, `SetArgs` in tests |
| `samber/cc-skills-golang@golang-spf13-viper` | `viper.BindPFlag`, `AutomaticEnv`, `ReadInConfig`, `OnConfigChange`, test isolation with `viper.Reset()` |

**Routing examples:**

- "My CLI should exit with code 2 on bad args" → `golang-cli`.
- "How do I add shell completion to my cobra command?" → `golang-spf13-cobra`.
- "How do I override config values with env vars?" → `golang-spf13-viper`.
- "I'm building a new CLI from scratch" → `golang-cli` (architecture) + `golang-spf13-cobra` (command tree) + `golang-spf13-viper` (config).

---

## 7. Testing cluster

| Skill | Unique territory |
| --- | --- |
| `samber/cc-skills-golang@golang-testing` | Test strategy, table-driven patterns, `t.Parallel()`, `testcontainers`, goleak, coverage, fuzz |
| `samber/cc-skills-golang@golang-stretchr-testify` | `assert.Equal`, `require.NoError`, `mock.On`, `mock.AssertExpectations`, `testify/suite` lifecycle |

**Routing examples:**

- "How do I write a table-driven test in Go?" → `golang-testing`.
- "How do I assert a mock was called with specific args?" → `golang-stretchr-testify`.
- "How do I detect goroutine leaks in tests?" → `golang-testing` (goleak).

---

## 8. design-patterns vs structs-interfaces

These two skills overlap on "how to design Go types". The split is: type-level design vs. architectural use of types.

| Skill | Unique territory | Does NOT own |
| --- | --- | --- |
| `samber/cc-skills-golang@golang-structs-interfaces` | Composition over inheritance, embedding, type assertions, struct tag conventions, pointer vs value receivers, interface segregation | How types combine into architectural patterns |
| `samber/cc-skills-golang@golang-design-patterns` | Functional options, middleware chains, circuit breaker, graceful shutdown, retry patterns | Low-level type mechanics |

**Overlap zone:** "DI via interfaces" — defining small interfaces is `golang-structs-interfaces`; wiring multiple components together via those interfaces is `golang-design-patterns`.

**Routing examples:**

- "Should my method take a value or pointer receiver?" → `golang-structs-interfaces`.
- "How do I implement a middleware chain for my HTTP handlers?" → `golang-design-patterns`.
- "How do I embed a struct without exposing its methods?" → `golang-structs-interfaces`.
- "How do I implement the functional options pattern?" → `golang-design-patterns`.

> Note: neither skill currently carries a description-level `→ See` disclaimer for this overlap. The boundary above is the intended design, not yet explicit in the source skills.

---

## 9. concurrency vs context

These skills overlap when goroutines are cancelled via context.

| Skill | Unique territory | Does NOT own |
| --- | --- | --- |
| `samber/cc-skills-golang@golang-concurrency` | Goroutine lifecycle, channel patterns, `sync.WaitGroup`, `errgroup`, worker pools, fan-out/fan-in, detecting races | Context propagation rules |
| `samber/cc-skills-golang@golang-context` | `context.WithCancel`, `context.WithTimeout`, `context.WithValue`, propagation through call chains, `WithoutCancel` | Goroutine coordination patterns |

**Overlap zone:** "cancelling goroutines via context" — load both skills. `golang-context` owns the context API; `golang-concurrency` owns the goroutine coordination.

**Routing examples:**

- "How do I cancel a goroutine from outside?" → both (`golang-context` for `cancel()`, `golang-concurrency` for `select { case <-ctx.Done() }`).
- "How do I fan out N workers and collect results?" → `golang-concurrency`.
- "How do I pass a deadline through multiple layers of function calls?" → `golang-context`.

> Note: no description-level disclaimer currently exists between these two skills. Load both when the task involves both concerns.

---

## 10. safety vs security

Both skills prevent bugs, but with different threat models.

| Skill | Unique territory | Does NOT own |
| --- | --- | --- |
| `samber/cc-skills-golang@golang-safety` | Nil panics, integer overflow, slice aliasing via append, concurrent map write, float equality, zero-value design | External attackers, cryptography, secrets |
| `samber/cc-skills-golang@golang-security` | SQL/command/LDAP injection, weak crypto (`math/rand`), hardcoded secrets, TLS misconfiguration, SSRF, path traversal | Internal runtime correctness |

**Routing examples:**

- "My service panics with nil pointer dereference" → `golang-safety`.
- "Is this SQL query safe from injection?" → `golang-security`.
- "I'm using `math/rand` to generate a token" → `golang-security` (predictable output; use `crypto/rand`).
- "My slice grows unexpectedly after append" → `golang-safety` (append aliasing).

> Note: no description-level disclaimer currently exists between these two skills. The source descriptions cross-reference in their bodies but not in the YAML frontmatter.

---

## 11. modernize vs lint

Both skills suggest code changes, but for different reasons.

| Skill | Unique territory | Does NOT own |
| --- | --- | --- |
| `samber/cc-skills-golang@golang-modernize` | Adopting language features: range-over-int, `min`/`max` builtins, `iter.Seq`, `slices.SortFunc`, `log/slog`, `testing.T.Context` | Static analysis configuration |
| `samber/cc-skills-golang@golang-lint` | golangci-lint YAML config, enabling/disabling linters, interpreting linter output, `//nolint` policy | Language feature adoption |

**Overlap zone:** Some linters (`govet`, `deadcode`, `perfsprint`) produce warnings that overlap with modernize suggestions (e.g., "use `slog` instead of `log`"). The boundary: lint owns the tool configuration and suppression policy; modernize owns the rewrite patterns to apply once you've decided to adopt the feature.

**Routing examples:**

- "How do I replace a `for i := 0; i < n; i++` loop with the new range syntax?" → `golang-modernize`.
- "My CI fails on `perfsprint` lint rule" → `golang-lint` (interpret the rule and decide whether to fix or suppress).
- "Should I migrate from `log` to `slog`?" → `golang-modernize`.
- "How do I configure golangci-lint to run only security-relevant linters?" → `golang-lint`.
