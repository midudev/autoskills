---
name: golang-lint
description: "Linting best practices and golangci-lint configuration for Golang projects — running linters, configuring .golangci.yml, suppressing warnings with nolint directives, interpreting lint output, and selecting linters. Use when configuring golangci-lint, asking about lint warnings or nolint suppressions, setting up code quality tooling, or choosing linters. Also use when the user mentions golangci-lint, go vet, staticcheck, or revive."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.2"
  openclaw:
    emoji: "🧹"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - golangci-lint
    install:
      - kind: brew
        formula: golangci-lint
        bins: [golangci-lint]
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent
---

**Persona:** You are a Go code quality engineer. You treat linting as a first-class part of the development workflow — not a post-hoc cleanup step.

**Modes:**

- **Setup mode** — configuring `.golangci.yml`, choosing linters, enabling CI: follow the configuration and workflow sections sequentially.
- **Coding mode** — writing new Go code: launch a background agent running `golangci-lint run --fix` on the modified files only while the main agent continues implementing the feature; surface results when it completes.
- **Interpret/fix mode** — reading lint output, suppressing warnings, fixing issues on existing code: start from "Interpreting Output" and "Suppressing Lint Warnings"; use parallel sub-agents for large-scale legacy cleanup.

**Dependencies:**

- golangci-lint: `go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest`

# Go Linting

## Overview

`golangci-lint` is the standard Go linting tool. It aggregates 100+ linters into a single binary, runs them in parallel, and provides a unified configuration format. Run it frequently during development and always in CI.

Every Go project MUST have a `.golangci.yml` — it is the **source of truth** for which linters are enabled and how they are configured. See the [recommended configuration](./assets/.golangci.yml) for a production-ready setup with 48 linters enabled.

## Quick Reference

```bash
# Run all configured linters
golangci-lint run ./...

# Auto-fix issues where possible
golangci-lint run --fix ./...

# Format code (golangci-lint v2+)
golangci-lint fmt ./...

# Run a single linter only
golangci-lint run --enable-only govet ./...

# List all available linters
golangci-lint linters

# Verbose output with timing info
golangci-lint run --verbose ./...
```

## Configuration

The [recommended .golangci.yml](./assets/.golangci.yml) provides a production-ready setup with 33 linters. For configuration details, linter categories, and per-linter descriptions, see the **[linter reference](./references/linter-reference.md)** — which linters check for what (correctness, style, complexity, performance, security), descriptions of all 33+ linters, and when each one is useful.

## Suppressing Lint Warnings

Use `//nolint` directives sparingly — fix the root cause first.

```go
// Good: specific linter + justification
//nolint:errcheck // fire-and-forget logging, error is not actionable
_ = logger.Sync()

// Bad: blanket suppression without reason
//nolint
_ = logger.Sync()
```

Rules:

1. **//nolint directives MUST specify the linter name**: `//nolint:errcheck` not `//nolint`
2. **//nolint directives MUST include a justification comment**: `//nolint:errcheck // reason`
3. **The `nolintlint` linter enforces both rules above** — it flags bare `//nolint` and missing reasons
4. **NEVER suppress security linters** (gosec, bodyclose, sqlclosecheck) without a very strong reason

For comprehensive patterns and examples, see **[nolint directives](./references/nolint-directives.md)** — when to suppress, how to write justifications, patterns for per-line vs per-function suppression, and anti-patterns.

## Development Workflow

1. **Linters SHOULD be run after every significant change**: `golangci-lint run ./...`
2. **Auto-fix what you can**: `golangci-lint run --fix ./...`
3. **Format before committing**: `golangci-lint fmt ./...`
4. **Incremental adoption on legacy code**: set `issues.new-from-rev` in `.golangci.yml` to only lint new/changed code, then gradually clean up old code

Makefile targets (recommended):

```makefile
lint:
	golangci-lint run ./...

lint-fix:
	golangci-lint run --fix ./...

fmt:
	golangci-lint fmt ./...
```

For CI pipeline setup (GitHub Actions with `golangci-lint-action`), see the `samber/cc-skills-golang@golang-continuous-integration` skill.

## Interpreting Output

Each issue follows this format:

```
path/to/file.go:42:10: message describing the issue (linter-name)
```

The linter name in parentheses tells you which linter flagged it. Use this to:

- Look up the linter in the [reference](./references/linter-reference.md) to understand what it checks
- Suppress with `//nolint:linter-name // reason` if it's a false positive
- Use `golangci-lint run --verbose` for additional context and timing

## Common Issues

| Problem | Solution |
| --- | --- |
| "deadline exceeded" | Set or increase `run.timeout` in `.golangci.yml`; golangci-lint v2 defaults to no timeout (`0`) |
| Too many issues on legacy code | Set `issues.new-from-rev: HEAD~1` to lint only new code |
| Linter not found | Check `golangci-lint linters` — linter may need a newer version |
| Conflicts between linters | Disable the less useful one with a comment explaining why |
| v1 config errors after upgrade | Run `golangci-lint migrate` to convert config format |
| Slow on large repos | Reduce `run.concurrency` or exclude paths with `linters.exclusions.paths` / `formatters.exclusions.paths` |

## Parallelizing Legacy Codebase Cleanup

When adopting linting on a legacy codebase, use up to 5 parallel sub-agents (via the Agent tool) to fix independent linter categories simultaneously:

- Sub-agent 1: Run `golangci-lint run --fix ./...` for auto-fixable issues
- Sub-agent 2: Fix security linter findings (bodyclose, sqlclosecheck, gosec)
- Sub-agent 3: Fix error handling issues (errcheck, nilerr, wrapcheck)
- Sub-agent 4: Fix style and formatting (gofumpt, goimports, revive)
- Sub-agent 5: Fix code quality (gocritic, unused, ineffassign)

## Cross-References

- → See `samber/cc-skills-golang@golang-continuous-integration` skill for CI pipeline with golangci-lint-action
- → See `samber/cc-skills-golang@golang-code-style` skill for style rules that linters enforce
- → See `samber/cc-skills-golang@golang-security` skill for SAST tools beyond linting (gosec, govulncheck)
- → See `samber/cc-skills-golang@golang-continuous-integration` skill for automated AI-driven code review in CI using these guidelines
