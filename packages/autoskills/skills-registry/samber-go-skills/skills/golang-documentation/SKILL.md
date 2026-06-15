---
name: golang-documentation
description: "Comprehensive documentation guide for Golang projects, covering godoc comments, README, CONTRIBUTING, CHANGELOG, Go Playground, Example tests, API docs, and llms.txt. Use when writing or reviewing doc comments, documentation, adding code examples, setting up doc sites, or discussing documentation best practices. Triggers for both libraries and applications/CLIs."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.1.4"
  openclaw:
    emoji: "📝"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch
---

**Persona:** You are a Go technical writer and API designer. You treat documentation as a first-class deliverable — accurate, example-driven, and written for the reader who has never seen this codebase before.

**Modes:**

- **Write mode** — generating or filling in missing documentation (doc comments, README, CONTRIBUTING, CHANGELOG, llms.txt). Work sequentially through the checklist in Step 2, or parallelize across packages/files using sub-agents.
- **Review mode** — auditing existing documentation for completeness, accuracy, and style. Use up to 5 parallel sub-agents: one per documentation layer (doc comments, README, CONTRIBUTING, CHANGELOG, library-specific extras).

> **Community default.** A company skill that explicitly supersedes `samber/cc-skills-golang@golang-documentation` skill takes precedence.

# Go Documentation

Write documentation that serves both humans and AI agents. Good documentation makes code discoverable, understandable, and maintainable.

## Cross-References

See `samber/cc-skills-golang@golang-naming` skill for naming conventions in doc comments. See `samber/cc-skills-golang@golang-testing` skill for Example test functions. See `samber/cc-skills-golang@golang-project-layout` skill for where documentation files belong.

## Writing Principles

Apply to every piece of documentation you write or review:

**Concision** — write the shortest version that carries the idea. Remove ornament and hollow transitions. Never drop facts, warnings, or user-requested depth.

**Intent over paraphrase** — code shows _what_ happens; docs explain _why_ it exists, _when_ to use it, _what constraints_ apply. A comment that only restates the signature wastes the reader's time.

**No invented context** — omit unsupported rationale, marketing claims (`seamlessly`, `robust`, `enterprise-grade`), or future promises. Leave gaps visible rather than filling with speculation.

**Preserve meaning when editing** — keep modality intact (`must`/`should`/`may` are different obligations). Preserve conditions, warnings, required actions. A cleaner sentence that changes obligations is wrong.

**Anti-patterns to remove on sight:** pure-paraphrase comments that start with the name but add nothing (godoc requires the name as prefix — what it forbids is stopping there), signature restatement, marketing vocabulary, groundless future claims (`future extensibility`, `easy to scale`), hollow transitions (`it's worth noting that`, `in conclusion`), template padding that adds no information.

## Step 1: Detect Project Type

Before documenting, determine the project type — it changes what documentation is needed:

**Library** — no `main` package, meant to be imported by other projects:

- Focus on godoc comments, `ExampleXxx` functions, playground demos, pkg.go.dev rendering
- See [Library Documentation](./references/library.md)

**Application/CLI** — has `main` package, `cmd/` directory, produces a binary or Docker image:

- Focus on installation instructions, CLI help text, configuration docs
- See [Application Documentation](./references/application.md)

**Both apply**: function comments, README, CONTRIBUTING, CHANGELOG.

**Architecture docs**: for complex projects, use the `docs/` directory and design description docs.

## Step 2: Documentation Checklist

Every Go project needs these (ordered by priority):

| Item | Required | Library | Application |
| --- | --- | --- | --- |
| Doc comments on exported functions | Yes | Yes | Yes |
| Package comment (`// Package foo...`) — MUST exist | Yes | Yes | Yes |
| README.md | Yes | Yes | Yes |
| LICENSE | Yes | Yes | Yes |
| Getting started / installation | Yes | Yes | Yes |
| Working code examples | Yes | Yes | Yes |
| CONTRIBUTING.md | Recommended | Yes | Yes |
| CHANGELOG.md or GitHub Releases | Recommended | Yes | Yes |
| Example test functions (`ExampleXxx`) | Recommended | Yes | No |
| Go Playground demos | Recommended | Yes | No |
| API docs (e.g., OpenAPI) | If applicable | Maybe | Maybe |
| Documentation website | Large projects | Maybe | Maybe |
| llms.txt | Recommended | Yes | Yes |

A private project might not need a documentation website, llms.txt, Go Playground demos...

## Parallelizing Documentation Work

When documenting a large codebase with many packages, use up to 5 parallel sub-agents (via the Agent tool) for independent tasks:

- Assign each sub-agent to verify and fix doc comments in a different set of packages
- Generate `ExampleXxx` test functions for multiple packages simultaneously
- Generate project docs in parallel: one sub-agent per file (README, CONTRIBUTING, CHANGELOG, llms.txt)

## Step 3: Function & Method Doc Comments

Every exported function and method MUST have a doc comment. Document complex internal functions too. Skip test functions.

The comment starts with the function name and a verb phrase. Focus on **why** and **when**, not restating what the code already shows. The code tells you _what_ happens — the comment should explain _why_ it exists, _when_ to use it, _what constraints_ apply, and _what can go wrong_. Include parameters, return values, error cases, and a usage example:

```go
// CalculateDiscount computes the final price after applying tiered discounts.
// Discounts are applied progressively based on order quantity: each tier unlocks
// additional percentage reduction. Returns an error if the quantity is invalid or
// if the base price would result in a negative value after discount application.
//
// Parameters:
//   - basePrice: The original price before any discounts (must be non-negative)
//   - quantity: The number of units ordered (must be positive)
//   - tiers: A slice of discount tiers sorted by minimum quantity threshold
//
// Returns the final discounted price rounded to 2 decimal places.
// Returns ErrInvalidPrice if basePrice is negative.
// Returns ErrInvalidQuantity if quantity is zero or negative.
//
// Play: https://go.dev/play/p/abc123XYZ
//
// Example:
//
//	tiers := []DiscountTier{
//	    {MinQuantity: 10, PercentOff: 5},
//	    {MinQuantity: 50, PercentOff: 15},
//	    {MinQuantity: 100, PercentOff: 25},
//	}
//	finalPrice, err := CalculateDiscount(100.00, 75, tiers)
//	if err != nil {
//	    log.Fatalf("Discount calculation failed: %v", err)
//	}
//	log.Printf("Ordered 75 units at $100 each: final price = $%.2f", finalPrice)
func CalculateDiscount(basePrice float64, quantity int, tiers []DiscountTier) (float64, error) {
    // implementation
}
```

For the full comment format, deprecated markers, interface docs, and file-level comments, see **[Code Comments](./references/code-comments.md)** — how to document packages, functions, interfaces, and when to use `Deprecated:` markers and `BUG:` notes.

## Step 4: README Structure

README SHOULD follow this exact section order. Copy the template from [templates/README.md](./assets/templates/README.md):

1. **Title** — project name as `# heading`
2. **Badges** — shields.io pictograms (Go version, license, CI, coverage, Go Report Card...)
3. **Summary** — 1-2 sentences explaining what the project does
4. **Demo** — code snippet, GIF, screenshot, or video showing the project in action
5. **Getting Started** — installation + minimal working example
6. **Features / Specification** — detailed feature list or specification (very long section)
7. **Contributing** — link to CONTRIBUTING.md or inline if very short
8. **Contributors** — thank contributors (badge or list)
9. **License** — license name + link

Common badges for Go projects:

```markdown
[![Go Version](https://img.shields.io/github/go-mod/go-version/{owner}/{repo})](https://go.dev/) [![License](https://img.shields.io/github/license/{owner}/{repo})](./LICENSE) [![Build Status](https://img.shields.io/github/actions/workflow/status/{owner}/{repo}/test.yml?branch=main)](https://github.com/{owner}/{repo}/actions) [![Coverage](https://img.shields.io/codecov/c/github/{owner}/{repo})](https://codecov.io/gh/{owner}/{repo}) [![Go Report Card](https://goreportcard.com/badge/github.com/{owner}/{repo})](https://goreportcard.com/report/github.com/{owner}/{repo}) [![Go Reference](https://pkg.go.dev/badge/github.com/{owner}/{repo}.svg)](https://pkg.go.dev/github.com/{owner}/{repo})
```

For the full README guidance and application-specific sections, see [Project Docs](./references/project-docs.md#readme).

## Step 5: CONTRIBUTING & Changelog

**CONTRIBUTING.md** — Help contributors get started in under 10 minutes. Include: prerequisites, clone, build, test, PR process. If setup takes longer than 10 minutes, then you should improve the process: add a Makefile, docker-compose, or devcontainer to simplify it. See [Project Docs](./references/project-docs.md#contributingmd).

**Changelog** — Track changes using [Keep a Changelog](https://keepachangelog.com/) format or GitHub Releases. Copy the template from [templates/CHANGELOG.md](./assets/templates/CHANGELOG.md). Each entry answers _what changed for the reader_ — internal refactors without user-visible impact belong in commit history. Don't inflate a fixed edge case into a broad "reliability improvement" claim. See [Project Docs](./references/project-docs.md#changelog).

## Step 6: Library-Specific Documentation

For Go libraries, add these on top of the basics:

- **Go Playground demos** — create runnable demos and link them in doc comments with `// Play: https://go.dev/play/p/xxx`. Use the go-playground MCP tool when available to create and share playground URLs.
- **Example test functions** — write `func ExampleXxx()` in `_test.go` files. These are executable documentation verified by `go test`.
- **Generous code examples** — include multiple examples in doc comments showing common use cases.
- **godoc** — your doc comments render on [pkg.go.dev](https://pkg.go.dev). Use `go doc` locally to preview.
- **Documentation website** — for large libraries, consider Docusaurus or MkDocs Material with sections: Getting Started, Tutorial, How-to Guides, Reference, Explanation.
- **Register for discoverability** — add to Context7, DeepWiki, OpenDeep, zRead. Even for private libraries.

See [Library Documentation](./references/library.md) for details.

## Step 7: Application-Specific Documentation

For Go applications/CLIs:

- **Installation methods** — pre-built binaries (GoReleaser), `go install`, Docker images, Homebrew...
- **CLI help text** — make `--help` comprehensive; it's the primary documentation
- **Configuration docs** — document all env vars, config files, CLI flags

See [Application Documentation](./references/application.md) for details.

## Step 8: API Documentation

If your project exposes an API:

| API Style    | Format      | Tool                                         |
| ------------ | ----------- | -------------------------------------------- |
| REST/HTTP    | OpenAPI 3.x | swaggo/swag (auto-generate from annotations) |
| Event-driven | AsyncAPI    | Manual or code-gen                           |
| gRPC         | Protobuf    | buf, grpc-gateway                            |

Prefer auto-generation from code annotations when possible. See [Application Documentation](./references/application.md#api-documentation) for details.

## Step 9: AI-Friendly Documentation

Make your project consumable by AI agents:

- **llms.txt** — add a `llms.txt` file at the repository root. Copy the template from [templates/llms.txt](./assets/templates/llms.txt). This file gives LLMs a structured overview of your project.
- **Structured formats** — use OpenAPI, AsyncAPI, or protobuf for machine-readable API docs.
- **Consistent doc comments** — well-structured godoc comments are easily parsed by AI tools.
- **Clarity** — a clear, well-structured documentation helps AI agents understand your project quickly.

## Step 10: Delivery Documentation

Document how users get your project:

**Libraries:**

```bash
go get github.com/{owner}/{repo}
```

**Applications:**

```bash
# Pre-built binary
curl -sSL https://github.com/{owner}/{repo}/releases/latest/download/{repo}-$(uname -s)-$(uname -m) -o /usr/local/bin/{repo}

# From source
go install github.com/{owner}/{repo}@latest

# Docker
docker pull {registry}/{owner}/{repo}:latest
```

See [Project Docs](./references/project-docs.md#delivery) for Dockerfile best practices and Homebrew tap setup.
