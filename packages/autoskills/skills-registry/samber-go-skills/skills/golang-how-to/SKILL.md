---
name: golang-how-to
description: "Golang skills orchestrator — always active on any Golang coding, review, debug, or setup task. Reads the task context and loads the most relevant skills from samber/cc-skills-golang, often multiple at once: writing a gRPC service loads golang-grpc + golang-testing + golang-error-handling; debugging a panic loads golang-troubleshooting + golang-safety; auditing security loads golang-security + golang-lint + golang-safety. Also: disambiguates competing clusters when two skills seem to overlap (performance vs benchmark vs troubleshooting, samber/lo vs mo vs ro, DI cluster, safety vs security), and configures CLAUDE.md or AGENTS.md to force-trigger skills in a project (/golang-how-to configure)."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents. Requires git.
metadata:
  author: samber
  version: "1.0.0"
  openclaw:
    emoji: "🧭"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(git:*) Agent AskUserQuestion
---

**Persona:** You are a Go skills orchestrator. For every Go task, identify all relevant skills and load them together — a task rarely belongs to a single skill.

**Modes:**

- **Orchestrate** — for any Go coding, review, debug, or setup task, load the primary skill plus all applicable secondary skills simultaneously.
- **Disambiguate** — when two skills seem to overlap, show the boundary table. See [disambiguation.md](references/disambiguation.md).
- **Configure** — add a `## Required Go skills` block to the project's `CLAUDE.md` or `AGENTS.md`. Follow [project-config.md](references/project-config.md).

## Skill loading

For each task, load the **primary skill** and all applicable **secondary skills** at the same time. Do not wait — load them together at the start.

| Intent | Primary | Also load |
| --- | --- | --- |
| Design an API, choose a pattern | `golang-design-patterns` | `golang-structs-interfaces`, `golang-naming` |
| Name a type, function, or package | `golang-naming` | `golang-code-style` |
| Handle errors idiomatically | `golang-error-handling` | `golang-safety` (nil-heavy code) |
| Write goroutines, channels, sync | `golang-concurrency` | `golang-context` (if cancellation) |
| Pass deadlines / cancel operations | `golang-context` | `golang-concurrency` (if goroutines) |
| Design structs, embed, use interfaces | `golang-structs-interfaces` | `golang-design-patterns` |
| Database queries and transactions | `golang-database` | `golang-error-handling`, `golang-security` |
| Build a gRPC service | `golang-grpc` | `golang-testing`, `golang-error-handling` |
| Build a GraphQL API | `golang-graphql` | `golang-testing`, `golang-error-handling` |
| Build a CLI command tree | `golang-spf13-cobra` | `golang-cli`, `golang-spf13-viper` (if config) |
| Layer config from flags/env/file | `golang-spf13-viper` | `golang-spf13-cobra` |
| Write tests | `golang-testing` | `golang-stretchr-testify` (if using testify) |
| Apply optimization patterns | `golang-performance` | `golang-benchmark` (measure first) |
| Measure with pprof / benchstat | `golang-benchmark` | `golang-performance` (fix), `golang-troubleshooting` (root cause) |
| Debug a panic or unexpected behavior | `golang-troubleshooting` | `golang-safety`, `golang-benchmark` (if perf-related) |
| Monitor in production | `golang-observability` | `golang-performance` (if SLO breach) |
| Audit security vulnerabilities | `golang-security` | `golang-safety`, `golang-lint` |
| Review formatting and style | `golang-code-style` | `golang-naming`, `golang-lint` |
| Configure golangci-lint | `golang-lint` | `golang-code-style` |
| Write godoc / README / CHANGELOG | `golang-documentation` | `golang-naming` |
| Set up a new project structure | `golang-project-layout` | `golang-design-patterns`, `golang-dependency-injection`, `golang-lint` |
| Set up CI/CD pipeline | `golang-continuous-integration` | `golang-lint`, `golang-security` |
| Choose a library | `golang-popular-libraries` | relevant library-specific skill |
| Adopt new Go language features | `golang-modernize` | `golang-lint` |
| Use samber/lo (slice/map helpers) | `golang-samber-lo` | `golang-data-structures`, `golang-performance` |
| Use samber/oops (structured errors) | `golang-samber-oops` | `golang-error-handling` |
| Use log/slog | `golang-samber-slog` | `golang-observability`, `golang-error-handling` |
| Use dependency injection | `golang-dependency-injection` | `golang-google-wire` or `golang-uber-dig` or `golang-uber-fx` or `golang-samber-do` |

All skill identifiers above are short forms of `samber/cc-skills-golang@<name>`.

## Categories at a glance

Full catalog with "use when" hooks: [by-category.md](references/by-category.md)

| Category | Skills |
| --- | --- |
| Code Quality | `golang-code-style` `golang-documentation` `golang-error-handling` `golang-lint` `golang-naming` `golang-safety` `golang-security` `golang-structs-interfaces` |
| Architecture & Design | `golang-concurrency` `golang-context` `golang-data-structures` `golang-database` `golang-dependency-injection` `golang-design-patterns` `golang-modernize` |
| QA & Performance | `golang-benchmark` `golang-observability` `golang-performance` `golang-testing` `golang-troubleshooting` |
| Project Setup | `golang-cli` `golang-continuous-integration` `golang-dependency-management` `golang-popular-libraries` `golang-project-layout` `golang-stay-updated` |
| APIs | `golang-graphql` `golang-grpc` `golang-swagger` |
| Dependency Injection | `golang-dependency-injection` `golang-google-wire` `golang-uber-dig` `golang-uber-fx` `golang-samber-do` |
| Frameworks | `golang-spf13-cobra` `golang-spf13-viper` |
| samber/\* | `golang-samber-do` `golang-samber-hot` `golang-samber-lo` `golang-samber-mo` `golang-samber-oops` `golang-samber-ro` `golang-samber-slog` |
| Testing | `golang-stretchr-testify` `golang-testing` |

## Competing clusters — boundary lines

Full boundary tables with routing examples: [disambiguation.md](references/disambiguation.md)

Key clusters and their owners:

- **Performance**: `golang-performance` (optimization patterns) · `golang-benchmark` (measurement) · `golang-troubleshooting` (root cause) · `golang-observability` (always-on production)
- **DI**: `golang-dependency-injection` (concepts/decision) · `golang-google-wire` (compile-time) · `golang-uber-dig` (runtime reflection) · `golang-uber-fx` (lifecycle framework) · `golang-samber-do` (type-safe container)
- **samber/\***: `golang-samber-lo` (finite transforms) · `golang-samber-ro` (reactive streams) · `golang-samber-mo` (monadic types)
- **Errors**: `golang-error-handling` (idioms) · `golang-samber-oops` (structured errors) · `golang-safety` (prevent panics)
- **Style**: `golang-code-style` · `golang-naming` · `golang-lint` · `golang-documentation`
- **CLI**: `golang-cli` (architecture) · `golang-spf13-cobra` (command tree) · `golang-spf13-viper` (config layering)
- **Gap — type vs arch**: `golang-structs-interfaces` (type design) vs `golang-design-patterns` (architectural patterns)
- **Gap — goroutine vs cancel**: `golang-concurrency` + `golang-context` — load both when cancelling goroutines via context
- **Gap — correctness vs threat**: `golang-safety` (internal bugs) vs `golang-security` (external threats)
- **Gap — features vs rules**: `golang-modernize` (language adoption) vs `golang-lint` (static analysis config)

## Configure mode

Force-trigger specific skills in a project's `CLAUDE.md` or `AGENTS.md` so they always load.

When invoked as `/golang-how-to configure`, follow [project-config.md](references/project-config.md).

---

This skill is not exhaustive. Refer to individual skill files and the official Go documentation for detailed guidance.

If you encounter a bug or unexpected behavior in this skill plugin, open an issue at <https://github.com/samber/cc-skills-golang/issues>.
