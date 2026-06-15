# Agent Skills for production-ready Golang projects

AI agent skills are reusable instruction sets that extend your coding assistant with domain-specific expertise, loaded on demand so they don't bloat your context. This repository covers **Go-specific** skills only (language, testing, security, observability, etc.); for dev workflow skills (git conventions, CI/CD, PR reviews) you'll want to add a separate skills plugin.

For generic skills, please visit [cc-skills](https://github.com/samber/cc-skills).

> [!IMPORTANT] Bootstrapped with Claude Code by distilling my Go project commits. **Edited, tested, reviewed and reworked by a human**.
>
> **No AI slop here.** AI-made skills are useless.

<img width="1414" height="491" alt="image" src="https://github.com/user-attachments/assets/620b5835-c1ba-4ea9-bf47-2293b58b879e" />

## 🚀 How to use

**Install with [skills](https://skills.sh/) CLI** (universal, works with any [Agent Skills](https://agentskills.io)-compatible tool):

```bash
npx skills add https://github.com/samber/cc-skills-golang --all
# or a single skill:
npx skills add https://github.com/samber/cc-skills-golang --skill golang-performance
```

<!-- prettier-ignore-start -->

<details>
<summary>Claude Code</summary>

```bash
/plugin marketplace add samber/cc
/plugin install cc-skills-golang@samber
```

</details>

<details>
<summary>Openclaw</summary>

Copy skills into the cross-client discovery directory:

```bash
git clone https://github.com/samber/cc-skills-golang.git ~/.openclaw/skills/cc-skills-golang
# or in workspace:
git clone https://github.com/samber/cc-skills-golang.git ~/.openclaw/workspace/skills/cc-skills-golang
```

</details>

<details>
<summary>Gemini CLI</summary>

```bash
gemini extensions install https://github.com/samber/cc-skills-golang
```

Update with `gemini extensions update cc-skills-golang`.

</details>

<details>
<summary>Cursor</summary>

Copy skills into the cross-client discovery directory:

```bash
git clone https://github.com/samber/cc-skills-golang.git  ~/.cursor/skills/cc-skills-golang
```

Cursor auto-discovers skills from `.agents/skills/` and `.cursor/skills/`.

</details>

<details>
<summary>Copilot</summary>

Copy skills into the cross-client discovery directory:

```bash
/plugin install https://github.com/samber/cc-skills-golang
# or
git clone https://github.com/samber/cc-skills-golang.git ~/.copilot/skills/cc-skills-golang
```

Copilot auto-discovers skills from `.copilot/skills/`.

</details>

<details>
<summary>OpenCode</summary>

Copy skills into the cross-client discovery directory:

```bash
git clone https://github.com/samber/cc-skills-golang.git ~/.agents/skills/cc-skills-golang
```

OpenCode auto-discovers skills from `.agents/skills/`, `.opencode/skills/`, and `.claude/skills/`.

</details>

<details>
<summary>Codex (OpenAI)</summary>

Clone into the cross-client discovery path:

```bash
git clone https://github.com/samber/cc-skills-golang.git ~/.agents/skills/cc-skills-golang
```

Codex auto-discovers skills from `~/.agents/skills/` and `.agents/skills/`. Update with `cd ~/.agents/skills/cc-skills-golang && git pull`.

</details>

<details>
<summary>Antigravity</summary>

Clone and symlink into the cross-client discovery path:

```bash
git clone https://github.com/samber/cc-skills-golang.git ~/.antigravity/skills/cc-skills-golang
```

Update with `cd ~/.antigravity/skills/cc-skills-golang && git pull`.

</details>

<!-- prettier-ignore-end -->

## 🧩 Skills

These skills are designed as **atomic, cross-referencing units**. A skill may reference conventions defined in another (e.g. error-handling rules that affect logging live in `golang-error-handling`, not `golang-observability`). Installing only a subset will give you a partial and potentially inconsistent view of the guidelines. For best results, install all general-purpose skills together.

```
                         ┌────────────────────────────────────────┐
                         │             Golang Skills              │
                         └──────────────────┬─────────────────────┘
                                            │
   ┌─────────────────┬──────────────────────┼──────────────────────┐
   ▼                 ▼                      ▼                      ▼
┌──────────────┐ ┌──────────────┐ ┌─────────────────┐ ┌──────────────────┐
│ Code Quality │ │ Arch & Design│ │    QA & Perf    │ │  Project Start   │
├──────────────┤ ├──────────────┤ ├─────────────────┤ ├──────────────────┤
│ code-style   │ │ design-patt  │ │ testing         │ │ project-layout   │
│ naming       │ │ concurrency  │ │ benchmark       │ │ popular-libs     │
│ error-handl  │ │ context      │ │ performance     │ │ cli              │
│ safety       │ │ dep-inject   │ │ troubleshoot    │ │ CI               │
│ structs-iface│ │ data-structs │ │ observability   │ │ stay-updated     │
│ documentation│ │ database     │ │                 │ │ dep-management   │
│ lint         │ │ modernize    │ │                 │ │                  │
│ security     │ │              │ │                 │ │                  │
└──────────────┘ └──────────────┘ └─────────────────┘ └──────────────────┘

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                      Framework / Library Skills                         │
    ├──────────────┬────────────────┬──────────────┬─────────────┬───────────┤
    │   APIs       │      DI        │  Frameworks  │  samber/*   │  Testing  │
    ├──────────────┼────────────────┼──────────────┼─────────────┼───────────┤
    │ grpc         │ google-wire    │ spf13-cobra  │ samber-lo   │ stretchr- │
    │ graphql      │ uber-dig       │ spf13-viper  │ samber-mo   │  testify  │
    │ swagger      │ uber-fx        │              │ samber-ro   │           │
    │              │                │              │ samber-do   │           │
    │              │                │              │ samber-hot  │           │
    │              │                │              │ samber-slog │           │
    │              │                │              │ samber-oops │           │
    └──────────────┴────────────────┴──────────────┴─────────────┴───────────┘

```

- ⭐️ Recommended
- ✅ Published
- 👷 Work in progress
- ❌ To-do
- ⚡ Command available
- 🧠 Ultrathink automatically
- ⚙️ Overridable (see doc below)
- **Description (tok)**: weight of the `description` field from YAML frontmatter, always loaded into Claude's context for skill triggering
- **SKILL.md (tok)**: weight of the full `SKILL.md` file loaded when the skill triggers
- **Directory (tok)**: weight of all files in the skill directory (SKILL.md + referenced markdown files)

**General purpose:**

<!-- markdownlint-disable table-column-style -->

|  | Skill | Flags | Error rate gap | Description (tok) | SKILL.md (tok) | Directory (tok) |
| --- | --- | --- | --- | --- | --- | --- |
| ⭐️ | ✅ `golang-code-style` | ⚡ ⚙️ | -40% | 115 | 2,069 | 2,685 |
| ⭐️ | ✅ `golang-data-structures` | ⚡ | -39% | 92 | 2,464 | 6,176 |
| ⭐️ | ✅ `golang-database` | ⚡ ⚙️ | -38% | 97 | 2,725 | 7,248 |
| ⭐️ | ✅ `golang-design-patterns` | ⚡ ⚙️ | -37% | 66 | 2,610 | 9,316 |
| ⭐️ | ✅ `golang-documentation` | ⚡ ⚙️ | -53% | 73 | 2,678 | 10,549 |
| ⭐️ | ✅ `golang-error-handling` | ⚡ ⚙️ | -26% | 139 | 1,520 | 4,394 |
| ⭐️ | ✅ `golang-how-to` | ⚡ | — | 165 | 2,191 | 10,255 |
| ⭐️ | ✅ `golang-modernize` | ⚡ | -61% | 68 | 2,476 | 7,599 |
| ⭐️ | ✅ `golang-naming` | ⚡ ⚙️ | -23% | 158 | 2,865 | 7,233 |
| ⭐️ | ✅ `golang-safety` | ⚡ | -58% | 78 | 2,457 | 5,227 |
| ⭐️ | ✅ `golang-testing` | ⚡ 🧠 ⚙️ | -32% | 113 | 3,105 | 6,212 |
| ⭐️ | ✅ `golang-troubleshooting` | ⚡ 🧠 | -32% | 126 | 2,735 | 15,901 |
| ⭐️ | ✅ `golang-security` | ⚡ 🧠 | -32% | 84 | 2,873 | 20,894 |
|  | ✅ `golang-benchmark` | ⚡ 🧠 | -50% | 99 | 2,135 | 29,248 |
|  | ✅ `golang-cli` | ⚡ | -43% | 122 | 2,274 | 6,089 |
|  | ✅ `golang-concurrency` | ⚡ ⚙️ | -39% | 71 | 1,873 | 6,338 |
|  | ✅ `golang-context` | ⚡ ⚙️ | -34% | 80 | 1,144 | 3,940 |
|  | ✅ `golang-continuous-integration` | ⚡ | -59% | 82 | 2,835 | 6,477 |
|  | ✅ `golang-dependency-injection` | ⚡ ⚙️ | -47% | 176 | 2,842 | 5,113 |
|  | ✅ `golang-dependency-management` | ⚡ | -54% | 77 | 1,877 | 4,957 |
|  | ✅ `golang-structs-interfaces` | ⚡ ⚙️ | -35% | 110 | 2,999 | 2,999 |
|  | ✅ `golang-lint` | ⚡ | -41% | 98 | 1,714 | 5,493 |
|  | ✅ `golang-observability` | ⚡ ⚙️ | -37% | 161 | 2,921 | 18,453 |
|  | ✅ `golang-performance` | ⚡ 🧠 | -39% | 127 | 1,953 | 17,855 |
|  | ✅ `golang-popular-libraries` | ⚡ | -30% | 61 | 788 | 4,131 |
|  | ✅ `golang-project-layout` | ⚡ | -38% | 69 | 1,510 | 5,718 |
|  | ✅ `golang-stay-updated` | ⚡ | -56% | 43 | 1,916 | 1,916 |

**Tools:**

| Skill | Flags | Error rate gap | Description (tok) | SKILL.md (tok) | Directory (tok) |
| --- | --- | --- | --- | --- | --- |
| ✅ `golang-google-wire` | ⚡ | -16% | 122 | 2,511 | 7,243 |
| ✅ `golang-graphql` |  | -16% | 76 | 2,935 | 7,766 |
| ✅ `golang-grpc` | ⚡ | -41% | 69 | 2,149 | 4,965 |
| ✅ `golang-spf13-cobra` | ⚡ | — | 176 | 2,455 | 7,218 |
| ✅ `golang-spf13-viper` | ⚡ | — | 170 | 2,412 | 6,936 |
| ✅ `golang-swagger` | ⚡ | — | 144 | 2,125 | 3,123 |
| ✅ `golang-uber-dig` | ⚡ | -10% | 107 | 2,264 | 5,904 |
| ✅ `golang-uber-fx` | ⚡ | -5% | 118 | 2,499 | 6,747 |
| ✅ `golang-samber-do` | ⚡ | -81% | 71 | 1,746 | 3,269 |
| ✅ `golang-samber-hot` | ⚡ | -54% | 118 | 1,843 | 7,273 |
| ✅ `golang-samber-lo` | ⚡ | -40% | 165 | 2,410 | 10,031 |
| ✅ `golang-samber-mo` | ⚡ 🧠 | -48% | 81 | 2,800 | 11,215 |
| ✅ `golang-samber-oops` | ⚡ | -59% | 69 | 2,380 | 2,692 |
| ✅ `golang-samber-ro` | ⚡ 🧠 | -50% | 152 | 2,845 | 11,136 |
| ✅ `golang-samber-slog` | ⚡ | -19% | 118 | 2,588 | 9,234 |
| ❌ `golang-temporal` |  | — | 0 | 0 | 0 |
| ✅ `golang-stretchr-testify` | ⚡ | -47% | 90 | 1,714 | 2,533 |

## 🧪 Skill evaluations

|             | With Skill          | Without Skill       | Delta     |
| ----------- | ------------------- | ------------------- | --------- |
| **Overall** | **3315/3395 (98%)** | **1915/3395 (56%)** | **+41pp** |

See [EVALUATIONS.md](./EVALUATIONS.md) for the full per-skill breakdown.

## 📖 Skills description

### Code Quality

#### `golang-code-style`

Go code formatting and conventions. gofmt, goimports, linting rules, comment conventions, and project-level style consistency. Overridable by company skills.

#### `golang-documentation`

Go documentation standards. Package docs, godoc conventions, code comments, example functions, README structure, and API reference generation. Overridable.

#### `golang-error-handling`

Go error handling best practices. Error creation, wrapping with fmt.Errorf and errors.Is/As, sentinel errors, custom error types, error codes, and panic recovery. Overridable.

#### `golang-lint`

Go linting best practices and golangci-lint configuration. Presets, custom rules, CI integration, inline suppression, and output interpretation.

#### `golang-naming`

Go naming conventions across all identifier types. Packages, constructors, structs, interfaces, constants, errors, receivers, acronyms, test functions. Covers MixedCaps rules, Get-prefix, and utils/helpers anti-patterns. Overridable.

#### `golang-safety`

Defensive Go coding. Prevents panics, silent data corruption, and runtime bugs. nil safety, append aliasing, map concurrent access, float comparison, zero-value design, numeric overflow.

#### `golang-security`

Go security best practices. Injection prevention (SQL, command, XSS), cryptography, filesystem/network safety, secrets management, cookie security, and tool configuration. Audit and review modes.

#### `golang-structs-interfaces`

Go struct and interface design. Composition, embedding, type assertions, interface segregation, struct tags (JSON/YAML/DB), pointer vs value receivers. Overridable.

### Architecture & Design

#### `golang-concurrency`

Go concurrency patterns. Goroutines, channels, sync primitives, context cancellation, worker pools, fan-out/fan-in, pipelines. Overridable.

#### `golang-context`

Idiomatic context.Context usage. Creation, cancellation, timeouts, values, propagation patterns, and common anti-patterns. Overridable.

#### `golang-data-structures`

Go data structures internals and usage. Slices (capacity growth, append aliasing), maps, channels, sync primitives, and when to use each.

#### `golang-database`

Go database access patterns. Parameter binding, connection pooling, transactions, migrations, sqlboiler/sqlc code generation, query builders. Overridable.

#### `golang-dependency-injection`

Dependency injection patterns in Go. Constructor injection, interface-based DI, wire/dig/fx comparison, and when DI is worth the complexity. Overridable.

#### `golang-design-patterns`

Idiomatic Go design patterns. Functional options, constructors, builder pattern, middleware chains, circuit breaker, and architecture guides with file trees and code. Overridable.

#### `golang-modernize`

Modernize Go code to use recent language features. Range-over-int, min/max builtins, iterators, slices/maps/cmp/slog stdlib packages, testing patterns (t.Context, b.Loop, synctest), and tooling upgrades.

### QA & Performance

#### `golang-benchmark`

Go benchmarking, profiling, and performance measurement. pprof, trace, CPU/memory/block profiles, flame graphs, benchmark comparison (benchstat), continuous profiling.

#### `golang-observability`

Go production observability. Structured logging (slog), Prometheus metrics, OpenTelemetry tracing, pprof profiling, RUM tracking, alerting, Grafana dashboards. Overridable.

#### `golang-performance`

Go performance optimization. Allocation reduction, CPU efficiency, memory layout, GC tuning, pooling, caching, hot-path optimization. Review and hot-path modes.

#### `golang-testing`

Production-ready Go tests. Table-driven tests, fuzzing, fixtures, goroutine leak detection (goleak), snapshot testing, code coverage, integration tests, parallel tests. Overridable.

#### `golang-troubleshooting`

Systematic Go debugging methodology. Common pitfalls, test-driven debugging, pprof capture, Delve debugger, race detection, GODEBUG tracing, production debugging.

### Project Setup

#### `golang-cli`

Go CLI application development. Project layout, exit codes, signal handling, I/O patterns, argument parsing, and terminal UX.

#### `golang-continuous-integration`

CI/CD pipeline configuration for Go projects using GitHub Actions. Build, test, lint, and release workflows.

#### `golang-dependency-management`

Go module dependency strategies. go.mod conventions, versioning, replace directives, tool dependencies, and multi-module workspaces.

#### `golang-popular-libraries`

Curated recommendations for production-ready Go libraries and frameworks. When the stdlib is enough vs when to reach for a package.

#### `golang-project-layout`

Go project structure and workspace setup. cmd/internal/pkg conventions, monorepo layout, CLI project structure, and when to keep things flat.

#### `golang-stay-updated`

Resources to stay current with Go. Official channels, community hubs, key people to follow, and learning resources.

### APIs

#### `golang-graphql`

GraphQL API development in Go using gqlgen/graphql-go. Schema definition, resolvers, subscriptions, dataloader, and federation.

#### `golang-grpc`

gRPC in Go. Protobuf organization, service definitions, streaming, interceptors, error codes, and code generation workflow.

#### `golang-swagger`

OpenAPI/Swagger docs with swaggo/swag. Annotation comments, code generation, framework integrations (gin, echo, fiber, chi), security definitions.

### Dependency Injection

#### `golang-google-wire`

Compile-time dependency injection with google/wire. Provider sets, injector generation, wire.Build, and structured DI patterns.

#### `golang-uber-dig`

Reflection-based DI with uber-go/dig. Provide/Invoke, dig.In/dig.Out, named values, value groups, optional dependencies, and Decorate.

#### `golang-uber-fx`

Application framework with uber-go/fx. fx.New, fx.Provide/Invoke, fx.Module, lifecycle hooks, fx.Annotate, fx.Decorate, signal-aware Run.

### Frameworks

#### `golang-spf13-cobra`

CLI command trees with spf13/cobra. Command hierarchy, RunE hooks, flag management, shell completion, usage templates, and testing with SetArgs.

#### `golang-spf13-viper`

Layered configuration with spf13/viper. Flag > env > file > KV > default precedence, BindPFlag, hot reload, test isolation, and remote KV integration.

### samber/\*

#### `golang-samber-do`

Dependency injection with samber/do. Type-safe service containers, lifecycle management, scopes, health checks, and graceful shutdown.

#### `golang-samber-hot`

In-memory caching with samber/hot. 9 eviction algorithms (LRU, LFU, TinyLFU, W-TinyLFU, S3FIFO, ARC, SIEVE...), TTL, loaders, sharding, stale-while-revalidate, Prometheus metrics.

#### `golang-samber-lo`

Functional programming helpers with samber/lo. 500+ type-safe generic functions for slices, maps, channels, strings. Immutable (lo), parallel (lop), mutable (lom), iterators (loi), SIMD.

#### `golang-samber-mo`

Monadic types with samber/mo. Option, Result, Either, Future, IO, Task, State for type-safe nullable values, error handling, and functional composition.

#### `golang-samber-oops`

Structured error handling with samber/oops. Error builders, stack traces, error codes, context attributes, public vs developer messages, panic recovery, and APM integration.

#### `golang-samber-ro`

Reactive streams with samber/ro. 150+ type-safe operators, cold/hot observables, 5 subject types, 40+ plugins, automatic backpressure, and Go context integration.

#### `golang-samber-slog`

Structured logging pipeline with samber/slog-\*\*\*\* packages. Multi-handler routing (slog-multi), sampling, formatting, HTTP middleware, and 20+ backend sinks.

### Testing

#### `golang-stretchr-testify`

Testing with stretchr/testify. assert, require, mock, and suite packages. Assertions, mock expectations, argument matchers, suite lifecycle, and custom matchers.

## 🕵 Use in CI for AI-driven reviews

Add AI agents as PR reviewers alongside traditional static analysis. When configured with this skill plugin, the agent applies the relevant Go skills per review area — catching architectural drift, logic bugs, and concurrency hazards that linters cannot detect.

See [GOLANG-AI-DRIVEN-REVIEW.md](./GOLANG-AI-DRIVEN-REVIEW.md) for full setup instructions (Claude Code Action and GitHub Copilot).

## 🎯 Tuning Skill Triggers

If a skill triggers too often or not often enough, please [open an issue](https://github.com/samber/cc-skills-golang/issues) suggesting a description change. The `description` field in SKILL.md frontmatter is the primary triggering mechanism — small wording adjustments can significantly improve trigger accuracy. Some `SKILL.md` files might have a `When to use` section which is another level of exclusion. Finally, `SKILL.md` files are an entrypoint for lazy loading references with deep knowledge located in `references/`.

## 🔄 Overlap

Claude reports very little overlap between skills in this repo, thanks to cross-reference. I suggest enabling most of the skills and leveraging lazy loading. The recommended ⭐️ skills load ~1,100 tokens of descriptions at startup; full skill content is only pulled in when relevant. Note:

- I estimate that 50% of `golang-naming` and `golang-code-style` overlap with linters (golangci-lint).
- A large part of the security rules in `golang-security` have been distilled from the Bearer (SAST) checklist. The skill is still useful for methodology.
- If your team has its own conventions, create a company skill and declare the override explicitly near the top of its body: `This skill supersedes samber/cc-skills-golang@golang-naming skill for [company] projects.` Skills marked ⚙️ in the table above support this mechanism.

## ✍️ Contribute

- **100 tokens per skill description** - what? when to use this skill?
- **1.000–2.500 tokens per SKILL.md** — keep the main file focused on essentials
- **Use secondary markdown files for depth** — reference them from SKILL.md with relative links (e.g., `[Logging](./logging.md)`). Claude reads these on demand when the topic is relevant, so they don't count against the context budget until needed
- **Up to 10.000 tokens** for full skill and secondary files
- **2–4 skills loaded simultaneously** in a typical session — design skills to coexist
- **Stay below ~10k tokens of total loaded SKILL.md** anytime to avoid degrading response quality

For more guidelines, please check `CLAUDE.md`.

## 💫 Fuel the Revolution

- ⭐️ **Star this repo** - Your star powers the caffeine engine!
- ☕️ **Buy me a coffee** - I'll literally use it to build more skills while drinking actual coffee

[![GitHub Sponsors](https://img.shields.io/github/sponsors/samber?style=for-the-badge)](https://github.com/sponsors/samber)

## 📝 License

Copyright © 2026 [Samuel Berthe](https://github.com/samber).

This project is under [MIT](./LICENSE) license.
