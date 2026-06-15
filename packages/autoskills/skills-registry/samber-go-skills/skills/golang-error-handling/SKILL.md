---
name: golang-error-handling
description: "Idiomatic Golang error handling — creation, wrapping with %w, errors.Is/As, errors.Join, custom error types, sentinel errors, panic/recover, the single handling rule, structured logging with slog, HTTP request logging middleware, and samber/oops for production errors. Built to make logs usable at scale with log aggregation 3rd-party tools. Apply when creating, wrapping, inspecting, or logging errors in Go code. For samber/oops specifics → See `samber/cc-skills-golang@golang-samber-oops` skill; for slog handler ecosystem → See `samber/cc-skills-golang@golang-samber-slog` skill."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.0"
  openclaw:
    emoji: "⚠"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent
---

**Persona:** You are a Go reliability engineer. You treat every error as an event that must either be handled or propagated with context — silent failures and duplicate logs are equally unacceptable.

**Modes:**

- **Coding mode** — writing new error handling code. Follow the best practices sequentially; optionally launch a background sub-agent to grep for violations in adjacent code (swallowed errors, log-and-return pairs) without blocking the main implementation.
- **Review mode** — reviewing a PR's error handling changes. Focus on the diff: check for swallowed errors, missing wrapping context, log-and-return pairs, and panic misuse. Sequential.
- **Audit mode** — auditing existing error handling across a codebase. Use up to 5 parallel sub-agents, each targeting an independent category (creation, wrapping, single-handling rule, panic/recover, structured logging).

> **Community default.** A company skill that explicitly supersedes `samber/cc-skills-golang@golang-error-handling` skill takes precedence.

# Go Error Handling Best Practices

This skill guides the creation of robust, idiomatic error handling in Go applications. Follow these principles to write maintainable, debuggable, and production-ready error code.

## Best Practices Summary

1. **Returned errors MUST always be checked** — NEVER discard with `_`
2. **Errors MUST be wrapped with context** using `fmt.Errorf("{context}: %w", err)`
3. **Error strings MUST be lowercase**, without trailing punctuation
4. **Use `%w` internally, `%v` at system boundaries** to control error chain exposure
5. **MUST use `errors.Is` for sentinel matching and `errors.As`/`errors.AsType` for typed chain inspection** instead of direct comparison or bare type assertions. For Go 1.26+, prefer `errors.AsType[T](err)` when `T` implements `error`; use `errors.As(err, &target)` for Go <1.26 or for non-error interface targets.
6. **SHOULD use `errors.Join`** (Go 1.20+) to combine independent errors
7. **Errors MUST be either logged OR returned**, NEVER both (single handling rule)
8. **Use sentinel errors** for expected conditions, custom types for carrying data
9. **NEVER use `panic` for expected error conditions** — reserve for truly unrecoverable states
10. **SHOULD use `slog`** (Go 1.21+) for structured error logging — not `fmt.Println` or `log.Printf`
11. **Use `samber/oops`** for production errors needing stack traces, user/tenant context, or structured attributes
12. **Log HTTP requests** with structured middleware capturing method, path, status, and duration
13. **Use log levels** to indicate error severity
14. **Never expose technical errors to users** — translate internal errors to user-friendly messages, log technical details separately
15. **Keep log grouping low-cardinality** — at logging/APM boundaries, keep message templates stable and attach IDs, paths, line numbers, and counts as structured attributes. Error values may include useful operational context, but avoid putting high-cardinality data into the stable log message used for grouping.

## Detailed Reference

- **[Error Creation](./references/error-creation.md)** — How to create errors that tell the story: error messages should be lowercase, no punctuation, and describe what happened without prescribing action. Covers sentinel errors (one-time preallocation for performance), custom error types (for carrying rich context), and the decision table for which to use when.

- **[Error Wrapping and Inspection](./references/error-wrapping.md)** — Why `fmt.Errorf("{context}: %w", err)` beats `fmt.Errorf("{context}: %v", err)` (chains vs concatenation). How to inspect chains with `errors.Is`, `errors.As`, and Go 1.26+ `errors.AsType` for type-safe error handling, and `errors.Join` for combining independent errors.

- **[Error Handling Patterns and Logging](./references/error-handling.md)** — The single handling rule: errors are either logged OR returned, NEVER both (prevents duplicate logs cluttering aggregators). Panic/recover design, `samber/oops` for production errors, and `slog` structured logging integration for APM tools.

## Parallelizing Error Handling Audits

When auditing error handling across a large codebase, use up to 5 parallel sub-agents (via the Agent tool) — each targets an independent error category:

- Sub-agent 1: Error creation — validate `errors.New`/`fmt.Errorf` usage, low-cardinality messages, custom types
- Sub-agent 2: Error wrapping — audit `%w` vs `%v`, verify `errors.Is`/`errors.As` patterns
- Sub-agent 3: Single handling rule — find log-and-return violations, swallowed errors, discarded errors (`_`)
- Sub-agent 4: Panic/recover — audit `panic` usage, verify recovery at goroutine boundaries
- Sub-agent 5: Structured logging — verify `slog` usage at error sites, check for PII in error messages

## Cross-References

- → See `samber/cc-skills-golang@golang-samber-oops` for full samber/oops API, builder patterns, and logger integration
- → See `samber/cc-skills-golang@golang-observability` for structured logging setup, log levels, and request logging middleware
- → See `samber/cc-skills-golang@golang-safety` for nil interface trap and nil error comparison pitfalls
- → See `samber/cc-skills-golang@golang-naming` for error naming conventions (ErrNotFound, PathError)
- → See `samber/cc-skills-golang@golang-continuous-integration` skill for automated AI-driven code review in CI using these guidelines

## References

- [lmittmann/tint](https://github.com/lmittmann/tint)
- [samber/oops](https://github.com/samber/oops)
- [samber/slog-multi](https://github.com/samber/slog-multi)
- [samber/slog-sampling](https://github.com/samber/slog-sampling)
- [samber/slog-formatter](https://github.com/samber/slog-formatter)
- [samber/slog-http](https://github.com/samber/slog-http)
- [samber/slog-sentry](https://github.com/samber/slog-sentry)
- [log/slog package](https://pkg.go.dev/log/slog)
