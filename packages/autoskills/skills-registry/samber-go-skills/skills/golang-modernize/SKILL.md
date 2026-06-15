---
name: golang-modernize
description: "Modernize Golang code to use recent language features, standard library improvements, and idiomatic patterns. Trigger proactively when writing or reviewing Go code and old-style patterns are detected, or when encountering a deprecation warning. Also use when the user explicitly asks for modernization, a Go version upgrade, or a CI/tooling refresh."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.2"
  openclaw:
    emoji: "🔄"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch WebSearch AskUserQuestion
---

<!-- markdownlint-disable ol-prefix -->

**Persona:** You are a Go modernization engineer. You keep codebases current with the latest Go idioms and standard library improvements — you prioritize safety and correctness fixes first, then readability, then gradual improvements.

**Modes:**

- **Inline mode** (developer is actively coding): suggest only modernizations relevant to the current file or feature; mention other opportunities you noticed but do not touch unrelated files.
- **Full-scan mode** (explicit `/golang-modernize` invocation or CI): use up to 5 parallel sub-agents — Agent 1 scans deprecated packages and API replacements, Agent 2 scans language feature opportunities (range-over-int, min/max, any, iterators), Agent 3 scans standard library upgrades (slices, maps, cmp, slog), Agent 4 scans testing patterns (t.Context, b.Loop, synctest), Agent 5 scans tooling and infra (golangci-lint v2, govulncheck, PGO, CI pipeline) — then consolidate and prioritize by the migration priority guide.

# Go Code Modernization Guide

This skill helps you continuously modernize Go codebases by replacing outdated patterns with their modern equivalents.

**Scope**: This skill covers the last 3 years of Go modernization (Go 1.21 through Go 1.26, released 2023-2026). While this skill can be used for projects targeting Go 1.20 or older, modernization suggestions may be limited for those versions. For best results, consider upgrading the Go version first. Some older modernizations (e.g., `any` instead of `interface{}`, `errors.Is`/`errors.As`, `strings.Cut`) are included because they are still commonly missed, but many pre-1.21 improvements are intentionally omitted because they should have been adopted long ago and are considered baseline Go practices by now.

You MUST NEVER conduct large refactoring if the developer is working on a different task. But TRY TO CONVINCE your human it would improve the code quality.

**Consent check (contextual triggers only):** When this skill triggers while the developer is working on something else (not an explicit `/golang-modernize` invocation), ask once: "I noticed some modernization opportunities — want me to suggest them, or skip for now?" If the user says skip (or any equivalent), stop immediately and do not apply or mention any modernization for the rest of the session. Do not ask again in the current session.

## Workflow

When invoked:

1. **Check the project's `go.mod` or `go.work`** to determine the current Go version (`go` directive)
2. **Check the latest Go version** using the Go Version Changelogs table below and suggest upgrading if the project's `go.mod` is behind
3. **Read `.modernize`** in the project root — this file contains previously ignored suggestions; do NOT re-suggest anything listed there
4. **Scan the codebase** for modernization opportunities based on the target Go version
5. **Run `golangci-lint`** with the `modernize` linter if available
6. **Suggest improvements contextually**:
   - If the developer is actively coding, **only suggest improvements related to the code they are currently working on**. Do not refactor unrelated files. Instead, mention opportunities you noticed and explain why the change would be beneficial — but let the developer decide.
   - If invoked explicitly via `/golang-modernize` or in CI, scan and suggest across the entire codebase.
7. **For large codebases**, parallelize the scan using up to 5 sub-agents (via the Agent tool), each targeting a different modernization category (e.g. deprecated packages, language features, standard library upgrades, testing patterns, tooling and infra)
8. **Before suggesting a dependency update**, run `go mod tidy` and the test suite to verify compatibility. Ask the developer to review the dependency's changelog and release notes for breaking changes before proceeding.
9. **If the developer explicitly ignores a suggestion**, write a short memo to `.modernize` in the project root so it is not suggested again. Format: one line per ignored suggestion, with a short description.

### `.modernize` file format

```
# Ignored modernization suggestions
# Format: <date> <category> <description>
2026-01-15 slog-migration Team decided to keep zap for now
2026-02-01 math-rand-v2 Legacy module requires math/rand compatibility
```

## Go Version Changelogs

Reference the relevant changelog when suggesting a modernization:

| Version | Release       | Changelog                   |
| ------- | ------------- | --------------------------- |
| Go 1.21 | August 2023   | <https://go.dev/doc/go1.21> |
| Go 1.22 | February 2024 | <https://go.dev/doc/go1.22> |
| Go 1.23 | August 2024   | <https://go.dev/doc/go1.23> |
| Go 1.24 | February 2025 | <https://go.dev/doc/go1.24> |
| Go 1.25 | August 2025   | <https://go.dev/doc/go1.25> |
| Go 1.26 | February 2026 | <https://go.dev/doc/go1.26> |

For versions newer than Go 1.26, consult the official Go release notes.

When the project's `go.mod` targets an older version, suggest upgrading and explain the benefits they'd unlock.

## Using the modernize linter

The `modernize` linter (available since **golangci-lint v2.6.0**) automatically detects code that can be rewritten using newer Go features. It originates from `golang.org/x/tools/go/analysis/passes/modernize`; `gopls` and Go 1.26's rewritten `go fix` cover overlapping modernization checks, but exact coverage differs by tool version. See the `samber/cc-skills-golang@golang-lint` skill for configuration.

## Version-specific modernizations

For detailed before/after examples for each Go version (1.21–1.26) and general modernizations, see [Go version modernizations](./references/versions.md).

## Tooling modernization

For CI tooling, govulncheck, PGO, golangci-lint v2, and AI-powered modernization pipelines, see [Tooling modernization](./references/tooling.md).

## Deprecated Packages Migration

| Deprecated | Replacement | Since |
| --- | --- | --- |
| `math/rand` | `math/rand/v2` | Go 1.22 |
| `crypto/elliptic` (most functions) | `crypto/ecdh` | Go 1.21 |
| `reflect.SliceHeader`, `StringHeader` | `unsafe.Slice`, `unsafe.String` | Go 1.21 |
| `reflect.PtrTo` | `reflect.PointerTo` | Go 1.22 |
| `runtime.GOROOT()` | `go env GOROOT` | Go 1.24 |
| `runtime.SetFinalizer` | `runtime.AddCleanup` | Go 1.24 |
| `crypto/cipher.NewOFB`, `NewCFB*` | AEAD modes or `NewCTR` | Go 1.24 |
| `golang.org/x/crypto/sha3` | `crypto/sha3` | Go 1.24 |
| `golang.org/x/crypto/hkdf` | `crypto/hkdf` | Go 1.24 |
| `golang.org/x/crypto/pbkdf2` | `crypto/pbkdf2` | Go 1.24 |
| `testing/synctest.Run` | `testing/synctest.Test` | Go 1.25 |
| `crypto/rsa.EncryptPKCS1v15` for new encryption use | RSA-OAEP (`rsa.EncryptOAEP` / `rsa.EncryptOAEPWithOptions`) or HPKE/KEM design | Go 1.26 |
| `net/http/httputil.ReverseProxy.Director` | `ReverseProxy.Rewrite` | Go 1.26 |

## Migration Priority Guide

When modernizing a codebase, prioritize changes by impact:

### High priority (safety and correctness)

1. Remove loop variable shadow copies _(Go 1.22+)_ — prevents subtle bugs
2. Replace `math/rand` with `math/rand/v2` _(Go 1.22+)_ — remove `rand.Seed` calls
3. Use `os.Root` for user-supplied file paths _(Go 1.24+)_ — prevents path traversal
4. Run `govulncheck` _(Go 1.22+)_ — catch known vulnerabilities
5. Use `errors.Is`/`errors.As` instead of direct comparison _(Go 1.13+)_
6. Migrate deprecated crypto packages _(Go 1.24+)_ — security critical

### Medium priority (readability and maintainability)

7. Replace `interface{}` with `any` _(Go 1.18+)_
8. Use `min`/`max` builtins _(Go 1.21+)_
9. Use `range` over int _(Go 1.22+)_
10. Use `slices` and `maps` packages _(Go 1.21+)_
11. Use `cmp.Or` for default values _(Go 1.22+)_
12. Use `sync.OnceValue`/`sync.OnceFunc` _(Go 1.21+)_
13. Use `sync.WaitGroup.Go` _(Go 1.25+)_
14. Use `t.Context()` in tests _(Go 1.24+)_
15. Use `b.Loop()` in benchmarks _(Go 1.24+)_

### Lower priority (gradual improvement)

16. Migrate to `slog` from third-party loggers _(Go 1.21+)_
17. Adopt iterators where they simplify code _(Go 1.23+)_
18. Replace `sort.Slice` with `slices.SortFunc` _(Go 1.21+)_
19. Use `strings.SplitSeq` and iterator variants _(Go 1.24+)_
20. Move tool deps to `go.mod` tool directives _(Go 1.24+)_
21. Enable PGO for production builds _(Go 1.21+)_
22. Upgrade to golangci-lint v2 with modernize linter _(golangci-lint v2.6.0+)_
23. Add `govulncheck` to CI pipeline
24. Set up monthly modernization CI pipeline
25. Evaluate `encoding/json/v2` only when the project explicitly opts into `GOEXPERIMENT=jsonv2` _(Go 1.25+, experimental)_
26. Set up AI-driven code review in CI — loads these skills to guide review per area; see `samber/cc-skills-golang@golang-continuous-integration`

## Related Skills

See `samber/cc-skills-golang@golang-concurrency`, `samber/cc-skills-golang@golang-testing`, `samber/cc-skills-golang@golang-observability`, `samber/cc-skills-golang@golang-error-handling`, `samber/cc-skills-golang@golang-lint`, `samber/cc-skills-golang@golang-continuous-integration` skills.
