# CLAUDE.md

## Project Overview

This is a Claude Code plugin containing AI agent skills for production-ready Go projects. The repository provides reusable skill definitions that Claude Code can invoke when working on Go codebases.

## Project Structure

```
skills/               # Claude Code skill definitions
  <skill-name>/
    SKILL.md          # Required: metadata + instructions
    references/       # Optional: detailed documentation loaded on demand
    scripts/          # Optional: executable code
    assets/           # Optional: templates, resources, linter configs (.golangci.yml, etc.)
.claude-plugin/       # Plugin metadata and configuration
.cursor-plugin/       # Plugin metadata and configuration (version must match .claude-plugin/plugin.json)
gemini-extension.json # Gemini CLI extension manifest (version must match .claude-plugin/plugin.json)
```

## Agent Skills Specification

All skills MUST conform to the [Agent Skills specification](https://agentskills.io/specification.md). Key requirements are summarized below; the spec is the source of truth when in doubt.

## Frontmatter

New skills go in `skills/<skill-name>/SKILL.md`. Each SKILL.md has YAML frontmatter. Fields per the [Agent Skills spec](https://agentskills.io/specification.md) — **this project requires all fields marked "Project-required"**:

| Field | Required | Constraints |
| --- | --- | --- |
| `name` | Spec-required | 1-64 chars. Lowercase `a-z`, digits, hyphens. No leading/trailing/consecutive hyphens. **Must match parent directory name.** |
| `description` | Spec-required | 1-1024 chars. Describes what the skill does **and when to use it** — this is the primary triggering mechanism. Be specific and slightly "pushy" to avoid under-triggering. |
| `license` | Project-required | License name or reference to a bundled license file. Use `MIT` for this project. |
| `compatibility` | Project-required | 1-500 chars. Describe actual requirements. Base: `Designed for Claude Code or similar AI coding agents.` Extend when needed: add `Requires git`, `Requires internet access`, `Requires Python 3.14+ and uv`, etc. Skills with no special requirements use the base string only. |
| `metadata` | Project-required | Must include `author` (string), `version` (semver `a.b.c` string, e.g. `"1.0.0"`), and `openclaw` (object — see below). |
| `user-invocable` | Project-required | Boolean. `true` for skills invocable as slash commands (e.g. `/golang-security`), `false` (default) for contextual skills that auto-trigger. |
| `allowed-tools` | Project-required | Space-delimited list of pre-approved tools. See "Allowed tools" below. |

### ClawHub metadata (`metadata.openclaw`)

Every skill MUST include a `metadata.openclaw` block for [ClawHub](https://github.com/openclaw/clawhub) discoverability and dependency management. See the [ClawHub skill format specification](https://github.com/openclaw/clawhub/blob/main/docs/skill-format.md) for the full reference. Fields used in this project:

| Field | Required | Description |
| --- | --- | --- |
| `emoji` | Yes | Display emoji for the skill (single emoji string) |
| `homepage` | Yes | URL to the skill's homepage. Use `https://github.com/samber/cc-skills-golang` for this project. |
| `requires.bins` | Yes | CLI binaries that must be installed. Always includes `go`. Add skill-specific critical bins (e.g. `protoc`, `dlv`). |
| `install` | Yes | Array of auto-installable dependencies. Use `[]` when no extra deps needed. Supported kinds: `brew`, `go`, `node`, `uv`. Each entry has `kind`, `formula`/`package`, and `bins` fields. |
| `skill-library-version` | Optional (when covering a library/framework) | Semver or release tag of the library/framework/platform the skill was written against (e.g. `"2.1.0"`). Required for skills that document a specific third-party project so staleness can be detected. Omit for generic/content skills with no versioned dependency. |

Example frontmatter:

```yaml
---
name: golang-example
description: "Golang skill for X. Use when doing Y."
user-invocable: false
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents. Requires go compiler and git.
metadata:
  author: samber
  version: "1.0.0"
  openclaw:
    emoji: "🔧"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.2.3"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent
---
```

Example with extra dependencies:

```yaml
metadata:
  author: samber
  version: "1.0.0"
  openclaw:
    emoji: "🌐"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - protoc
    install:
      - kind: brew
        formula: protobuf
        bins: [protoc]
```

**Version discipline:** Versions follow semver (`a.b.c`). New skills start at `1.0.0`. When modifying a skill, the developer must increment its `metadata.version` and the plugin version in `.claude-plugin/plugin.json` before merging. CI enforces both checks on PRs. Do not auto-increment versions — remind the developer as a next step.

### Description quality

Descriptions are the primary triggering mechanism — they determine whether a skill activates or stays silent. A poorly calibrated description wastes context (too broad) or never fires (too vague).

**Too vague** (under-triggering) — one-liner descriptions without "Use when..." clauses. The model cannot match user intent to the skill. Fix by adding specific trigger scenarios, API names, and import paths.

```yaml
# Bad — no trigger context, will be ignored
description: Implements X in Golang using library/foo

# Good — specific triggers, matches real user activity
description: Implements X in Golang using library/foo — feature A, feature B, and feature C. Apply when using or adopting library/foo, or when the codebase imports `github.com/library/foo`.
```

**Too broad** (over-triggering) — phrases like "whenever writing Go code", "when naming any identifier", "essential for ANY conversation". These match virtually all Go work and flood the context with irrelevant skills. Fix by narrowing to the specific concern the skill uniquely addresses.

```yaml
# Bad — triggers on all Go work
description: Use when writing code, reviewing style, or writing comments in Golang.

# Good — triggers only when style is the actual concern
description: Golang code style conventions. Use when the user explicitly asks about formatting, style review, or project coding standards.
```

**Overlap** (competing triggers) — when two skills claim the same trigger keywords, the model may load the wrong one. Fix by adding explicit boundary disclaimers with `→ See` cross-references, following the performance skill cluster pattern.

```yaml
# Good — clear boundary
description: "...Not for measurement methodology (→ See golang-benchmark skill)."
```

**Library-specific skills** follow a consistent pattern: describe what the library does, list key API surface, then "Apply when using or adopting X, or when the codebase imports Y." This is the gold standard for contextual (non-user-invocable) skills.

Every skill description MUST contain the word "Golang" so that skills are only triggered for Go projects, never for other languages.

## Allowed Tools

Every skill MUST declare an `allowed-tools` field. Start from the **default set** and add skill-specific extras as needed.

**Default tools** (include in every skill):

```
Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent
```

**Skill-specific extras** — add only when relevant:

| Extra tool | When to add |
| --- | --- |
| `mcp__context7__resolve-library-id mcp__context7__query-docs` | Library-specific skills that recommend fetching docs via context7 |
| `Bash(benchstat:*)` | Benchmark or performance skills |
| `Bash(dlv:*)` | Troubleshooting or debugging skills |
| `Bash(gotests:*)` | Testing skills that generate test scaffolding |
| `Bash(protoc:*)` | gRPC or protobuf skills |
| `Bash(swag:*)` | Swagger/OpenAPI skills |
| `Bash(wire:*)` | Google Wire DI skills |
| `Bash(goreleaser:*)` | CI/CD or release skills |
| `Bash(gh:*)` | Git or GitHub-related skills |
| `Bash(govulncheck:*)` | Security or dependency management skills |
| `Bash(curl:*)` | API testing or GraphQL skills |
| `WebFetch` | Library-specific skills, skills requiring deep research/analysis, skills fetching external docs or resources |
| `WebSearch` | Skills requiring deep research or analysis (security, benchmarking, performance, troubleshooting, observability) and skills that discover resources or track updates |
| `AskUserQuestion` | Skills that benefit from clarifying user intent, confirming assumptions, or gathering context before proceeding — useful for audit/review modes, architecture decisions, ambiguous requirements, or any skill where acting on wrong assumptions is costly |

When creating a new skill, suggest a tailored `allowed-tools` list based on the skill's purpose.

## Skill Body

The body contains step-by-step instructions. Use secondary markdown files in `references/` for depth (referenced via relative links like `[Details](references/details.md)`). Keep file references one level deep from SKILL.md — avoid deeply nested reference chains.

**Important:** When including non-markdown content (configuration files, scripts, templates, linter configs, etc.), create them as separate files in `assets/` rather than embedding them directly in markdown. Reference these files from your markdown using relative links (e.g., `[View config](assets/example.yml)`). This keeps markdown files clean, makes assets reusable, and allows proper syntax highlighting when the files are viewed separately.

Polanyi's paradox: most operational knowledge is tacit and resists explicit description. The skills that work aren't the ones with the most rules, they're the ones that capture a posture. Markdown is the iceberg's tip.

### Token budgets

- **~100 tokens per description** — loaded at startup for all skills
- **≤ 1,000 characters per description** — hard limit; keep descriptions focused and scannable
- **< 5.000 tokens per SKILL.md** (spec recommendation) — keep focused on essentials
- **< 2.500 tokens per SKILL.md** (project recommendation)
- **< 500 lines per SKILL.md** — move detailed reference material to `references/`
- **Use secondary markdown files for depth** — Claude reads these on demand, so they don't count against context until needed
- **2-4 skills loaded simultaneously** in a typical session
- **Stay below ~10k tokens of total loaded SKILL.md** to avoid degrading response quality

This is a budget. A 100 lines SKILL.md is even better. Feel free to stay far below the limits.

#### Top-of-body directives

Place these directives at the very top of the body, before the first heading, in this order:

| Directive | Required | Format | When to include |
| --- | --- | --- | --- |
| **Persona** | Optional | `**Persona:** You are a <role>. <mindset or goal>.` | Analytical/generative/multi-mode skills |
| **Thinking mode** | Optional | `**Thinking mode:** Use \`ultrathink\` for <task>. <Why deep reasoning matters>.` | Deep analysis: profiling, security auditing, root cause analysis |
| **Modes** | Optional | `**Modes:**` section listing each invocation mode and its sub-agent strategy | Skills invoked in distinct contexts (audit, coding, review, code understanding...) |
| **Dependencies** | Optional | `**Dependencies:**` list of required binaries with install commands | Skills that require external tools beyond `go` (e.g. `benchstat`, `dlv`, `golangci-lint`) |

All four are optional. A short procedural skill may have none. A complex orchestrating skill may have all four.

The **Dependencies** block lists only non-trivial developer tools — skip universal system utilities (e.g. `curl`, `git`). Prefer `go install` over `brew install` when the tool provides a Go install path; use `brew install` only for tools without one (e.g. `protoc`). Place this block last among the top-of-body directives, just before the first `#` heading.

#### Persona (optional)

Place `**Persona:**` at the very top of the body, before any heading. Keep it to 1–2 sentences: role → mindset or goal. No fictional biography.

```
**Persona:** You are a <role>. <Mindset/assumption or goal>.
```

**Include a persona when:**

- The skill has a well-defined analytical or generative domain (security, performance, debugging) — it primes the model to prioritize angles it would otherwise reach only with longer prompts.
- The skill is invoked by **multiple distinct user types or tasks** (reviewer vs. builder, auditor vs. coder) — a persona helps the model adopt the right frame for each invocation context.
- The skill produces stylistic output (docs, code review, commit messages) — it maintains tone consistency across invocations.
- The skill orchestrates sub-agents — it implicitly defines the delegation policy and conflict resolution strategy.

**Skip a persona when:**

- The skill is purely procedural ("run X, read Y, output Z") — there is nothing to anchor.
- The skill body is very short (~10 lines) — instruction density matters more.

**Risk:** A persona that is too rich in a leaf skill can override global CLAUDE.md instructions if the model perceives an identity conflict. Keep leaf personas minimal and orthogonal to the global persona.

**Examples:**

- `golang-security` (audit + coding, orchestrator): `You are a senior Go security engineer. You apply security thinking both when auditing existing code and when writing new code — threats are easier to prevent than to fix.`
- `golang-performance` (analytical, orchestrator): `You are a Go performance engineer. You never optimize without profiling first — measure, hypothesize, change one thing, re-measure.`
- `golang-testing` (generative + analytical): `You are a Go engineer who treats tests as executable specifications. You write tests to constrain behavior, not to hit coverage targets.`
- `golang-troubleshooting` (orchestrator + analytical): `You are a Go systems debugger. You follow evidence, not intuition — instrument, reproduce, and trace root causes systematically.`
- `golang-code-style` (procedural/short) → **skip persona**.

#### Skill modes and parallelization (optional)

Some skills serve multiple distinct **modes** — e.g. `golang-security` is used both for _auditing_ existing code and for _writing_ new secure code. Skills that have multiple modes SHOULD add a short **"Modes"** section early in their body naming each mode and its execution strategy.

**Common mode names and their strategies:**

| Mode | Scope | Execution |
| --- | --- | --- |
| **Coding / Write** | Generating new code | Sequential; optionally a background agent for non-blocking checks |
| **Review** | A PR diff | Sequential; start from changed files, then trace call sites and data flows into adjacent code — a bug may live outside the diff but be triggered by it |
| **Audit** | Full codebase | Parallel sub-agents split by concern or scope |

**When to parallelize with sub-agents:**

Sub-agents can be used in three complementary ways:

1. **Split by concern** — each agent handles one type of search or analysis in parallel. Agents may read the same file independently; that is expected and acceptable.

   Example — `golang-security` audit mode (up to 5 agents):
   - Agent 1 — injection (SQL, command, LDAP): grep `fmt.Sprintf` in queries, `exec.Command` with user input
   - Agent 2 — auth & authorization: JWT handling, session management, middleware chains
   - Agent 3 — cryptography: `math/rand`, hardcoded secrets, weak hash algorithms
   - Agent 4 — dependencies: `govulncheck ./...`, review `go.sum`
   - Agent 5 — input validation & error leakage: `http.Error`, stack traces in responses

2. **Split by scope** — each agent covers a different part of the codebase doing the same task. Useful for large repositories where one agent would miss files.

   Example — `golang-performance` across a monorepo: Agent 1 covers `pkg/`, Agent 2 covers `internal/`, Agent 3 covers `cmd/`.

3. **Background agents** — run analysis (e.g., security checks, lint, test coverage) in the background while the main agent continues coding. The background agent does not block the primary workflow; its results are surfaced when it completes. Use this pattern when the analysis is useful but not on the critical path.

   Example — `golang-security` in coding mode: launch a background agent to grep for common vulnerability patterns in newly written code while the main agent finishes implementing the feature.

**Write / generate mode** — follow the skill's sequential instructions unless background agents are explicitly used for non-blocking analysis.

### Ultrathink policy

Skills that require deep analytical reasoning (profiling interpretation, root cause analysis, security auditing) include a **Thinking mode:** `ultrathink` instruction in their SKILL.md body. When you encounter this instruction, activate maximum extended thinking — these tasks punish shallow reasoning with wrong conclusions.

When creating or modifying a skill that involves deep analysis, profiling, debugging methodology, or security auditing, add this line in the top-of-body directives block, after **Persona** (if present) and before the first heading:

```
**Thinking mode:** Use `ultrathink` for <task description>. <Why deep reasoning matters for this skill>.
```

Update the README.md Ultrathink column (🧠 emoji) to keep track of skills requiring ultrathink mode.

### Tool reference sections

When a skill mentions an important tool (e.g. `go test`, `pprof`, `dlv`, `benchstat`), create a `references/` markdown file with a comprehensive reference section listing many command examples. This helps users discover tool capabilities without leaving the skill content.

**Example:** For the `samber/cc-skills-golang@golang-testing` skill, create `references/go-test.md` with examples like:

```bash
go test ./...                          # all tests
go test -run TestName ./...            # specific test by exact name
go test -race ./...                    # race detection
go test -cover ./...                   # coverage summary
go test -bench=. -benchmem ./...       # benchmarks
[...]
```

When the tool has **sub-commands, flags, or configuration files**, showcase them generously — list every useful sub-command with a realistic example, show flag combinations for common workflows, and include sample config files with inline comments. Developers discover tool capabilities through examples, not by reading `--help` output.

Link to this reference from the main SKILL.md using relative markdown links.

### Progressive disclosure

Skills are structured for efficient context use:

1. **Metadata** (~100 tokens): `name` and `description` are loaded at startup for all skills
2. **Instructions** (< 5.000 tokens recommended by AgentMD specification): full SKILL.md body loaded when skill activates
3. **Instructions** (< 2.500 tokens recommended by me): SKILL.md body loaded when skill activates
4. **Instructions** (< 10.000 tokens recommended by me): full SKILL.md body + secondary files loaded when skill activates
5. **Resources** (as needed): files in `scripts/`, `references/`, `assets/` loaded only when required

Keep SKILL.md under 500 lines. Move detailed reference material to separate files.

This is a budget. A 100 lines SKILL.md is even better. Feel free to stay far below the limits.

### Validation

<!-- Disabled: skills-ref does not yet support the `user-invocable` field.
     See https://github.com/agentskills/agentskills/issues/105

Use [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) to validate skills:

```bash
skills-ref validate ./skills/<skill-name>
```
-->

## Skill Architecture

Each concept must live in exactly one skill. Skills cross-reference each other instead of duplicating content.

### Performance skill cluster

Four skills cover performance and observability with distinct ownership:

- **`samber/cc-skills-golang@golang-performance`** - optimization patterns and methodology ("if X bottleneck, then apply Y")
- **`samber/cc-skills-golang@golang-benchmark`** - measurement methodology, deep analysis, profiling interpretation, benchstat, CI regression detection
- **`samber/cc-skills-golang@golang-troubleshooting`** - debugging workflow, root cause finding, pprof setup/capture, Delve, GODEBUG
- **`samber/cc-skills-golang@golang-observability`** - everyday continuous monitoring (logs, metrics, tracing, alerts) - always-on signals

The first three form a "deep analysis" cluster for temporary focused investigation. `samber/cc-skills-golang@golang-observability` covers the always-on production signals. Each concept lives in exactly one skill.

### Atomic skills and deduplication

Concept drift between skills creates confusion when the agent loads the wrong one — or two competing ones. Each concept MUST live in exactly one skill (the "owner"). All other skills cross-reference the owner with `→ See` using the fully-qualified `owner/repo@skill` identifier. When splitting or merging skills, update every cross-reference to the affected skills. Prefer small, focused skills over large monolithic ones.

### Company override convention

Some skills are community defaults, not mandates. They include a note at the top of their body that defers to a company skill that explicitly supersedes them.

**To override a generic skill**, add this line near the top of your company skill's body (replace `<skill-name>` with the target):

> This skill supersedes `samber/cc-skills-golang@<skill-name>` skill for [company] projects.

The override is skill-specific: your company skill must name each generic skill it supersedes. Plugin-wide override (`samber/cc-skills-golang`) is not supported — be explicit. The README skills table (Override column) lists which skills support this.

### Cross-skill references

Skills use the `owner/repo@skill:version` identifier format for cross-references. This convention aligns with the [skills CLI](https://github.com/vercel-labs/skills) `owner/repo@skill` install shorthand and extends it with an optional `:version` segment for pinning.

| Segment | Required | Description | Example |
| --- | --- | --- | --- |
| `owner` | yes | GitHub owner or organization | `samber` |
| `repo` | yes | Repository name | `cc-skills-golang` |
| `skill` | yes | Skill name (from frontmatter `name` field) | `golang-security` |
| `version` | no | Semver version — omit unless pinning matters | `1.2.0` |

**Full form:** `samber/cc-skills-golang@golang-security:1.2.0` **Common form (no version):** `samber/cc-skills-golang@golang-security`

Always use the fully-qualified `owner/repo@skill` form in backticks, even for references within the same plugin. This makes every reference portable, searchable, and unambiguous regardless of where the skill is consumed.

**Inline:** see the `samber/cc-skills-golang@golang-database` skill. **Arrow-prefixed lists:** "→ See `samber/cc-skills-golang@golang-database` skill for …"

**Install mapping:** the identifier maps to skills CLI commands:

- `samber/cc-skills-golang@golang-security` → `npx skills add samber/cc-skills-golang --skill golang-security`
- `samber/cc-skills-golang` → `npx skills add samber/cc-skills-golang`

### Large repository research

When a skill requires broad codebase understanding (e.g. migration, refactoring, architecture review), it SHOULD recommend using parallel sub-agents (up to 5) via the Agent tool to explore different areas of the repository simultaneously. Each sub-agent should target a distinct search scope (e.g. different packages, file patterns, or concerns). This dramatically reduces research time on large codebases.

## Writing Guidelines

When editing skill files, fix grammar mistakes if you find some.

### Avoid duplicating linter rules

Skills should NOT re-explain rules that are already enforced by linters (e.g. golangci-lint). If a `.golangci.yml` is present in the skill directory, the linter is the source of truth for style and correctness rules. Skill instructions should focus on higher-level patterns, architecture decisions, and judgment calls that linters cannot catch — not low-level rules like formatting, naming conventions, or import ordering that tools already enforce automatically.

### Teach reasoning, not only rules

Skills MUST teach Claude how to think about problems, not just list prescriptive rules. Every recommendation needs a "why" — what goes wrong without it, what consequence the reader avoids. Bare imperatives like "NEVER do X" without rationale are not acceptable.

When a recommendation addresses a problem that can be confirmed with a diagnostic tool, add a **`Diagnose:`** line indicating which tool(s) to use to validate the hypothesis before applying the fix. This is essential in performance-oriented skills (`samber/cc-skills-golang@golang-performance`) but also useful in any skill where a tool can confirm the root cause (e.g. race detector for concurrency, `go vet` for safety, `govulncheck` for security). The diagnostic tool must NOT apply the fix automatically (e.g. never use `--fix` flags) — let the LLM interpret the diagnostic output and perform the improvement itself, so changes are tracked and can include explanatory comments.

Format Diagnose lines with a carriage return before each tool, numbered by importance and potential impact (`1-`, `2-`, `3-`, …):

```md
**Diagnose:** 1- `go tool pprof -alloc_objects` — find which functions allocate the most objects; expect hot-path functions near the top 2- `go build -gcflags="-m"` — check which variables escape to the heap; expect `"moved to heap"` for values that should stay on the stack 3- Prometheus `rate(go_memstats_alloc_bytes_total[5m])` — track allocation rate trend in production; compare before/after deploy to detect regressions
```

Diagnostic tools include CLI commands (pprof, fieldalignment, benchstat), runtime introspection (`GODEBUG`, `runtime.ReadMemStats`), and production monitoring queries (Prometheus PromQL, continuous profiling). Use CLI tools for local investigation and monitoring queries for production trend analysis.

Transformation patterns:

- **Best Practices items**: embed the tradeoff in one sentence — "Naked returns help in short functions but become confusing when readers must scroll to find what's returned"
- **Common Mistakes tables**: inject the "because" into the Fix column — "`math/rand` output is predictable; an attacker can reproduce the sequence. Use `crypto/rand`"
- **Code example comments**: carry the reasoning — `// ✗ Bad — nil map has no backing storage; writing panics at runtime`
- **Section intros**: add a 1-2 sentence framing paragraph that establishes the mental model before listing specifics

### Library-specific skills

When a skill describes a third-party library (e.g. `samber/cc-skills-golang@golang-samber-do`, `samber/cc-skills-golang@golang-google-wire`), the skill instructions **must** include a disclaimer that the skill is not exhaustive and recommend referring to the library's official documentation and code examples for up-to-date API signatures and usage patterns. This ensures the agent always works with current API signatures and best practices, even if the skill's static markdown becomes outdated.

Skills dedicated to a single open-source project (CLI tool, library, SDK) **must** also include a line at the end of the skill body pointing to the issue tracker for bugs or unexpected behavior:

```
If you encounter a bug or unexpected behavior in <tool>, open an issue at <repo>/issues.
```

**Important:** Skill body text must NEVER contain explicit MCP tool-calling instructions (e.g. "call `resolve-library-id`", "call `query-docs`", "use the MCP context7 server"). These trigger prompt-injection detections in security scanners (Snyk). Instead, use generic formulations like:

```
This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.
```

The `mcp__context7__*` tools may still be listed in `allowed-tools` frontmatter — only the body instructions are restricted.

### Snyk agent scanner compliance

The Snyk agent scanner runs static analysis on skill bodies and raises warnings for patterns that look like prompt injection or unsafe agent behavior. Known rules and fixes:

**W011 — Third-party content exposure (high)**

Triggered when the skill body explicitly instructs the agent to fetch and interpret external web content in ways that influence code changes (upgrades, refactors, security decisions).

| Pattern that triggers W011 | Safe reformulation |
| --- | --- |
| `Check <https://example.com/releases> for the latest version` | Remove the URL; refer to an embedded table or note it as a passive reference |
| `check the changelog or release notes` (agent as subject) | `Major version upgrades may contain breaking changes — the package's changelog documents them` (passive statement of fact, not an instruction) |
| `search the internet for the latest stable major version of each GitHub Action` | `The versions in the examples below may be outdated. The current major version for each action may differ from what is shown here.` (passive note) |
| Checklist bullet `Package health: \`gh repo view\` → stars, last commit, open issues` | Keep `gh repo view` as a reference command in a code block; remove it from any checklist that implies the agent must run it before acting |
| Checklist bullet `"evaluate" package health (stars, last commit, open issues)` | Remove from evaluation criteria if it implies fetching GitHub data; list only criteria resolvable without external fetching |
| `Always reference the relevant changelog when suggesting X` | `Reference the relevant changelog when suggesting X` (remove imperative "always") |
| Use tool output from external-DB tools (e.g. `govulncheck`) as the sole motivation to apply a code change | Frame as local analysis; do not chain "run govulncheck → upgrade because of its output" |

General rules to avoid W011:

- **Never** use an imperative like "Check `<url>`" or "Run `<tool>` and use its output to decide X" — prefer passive availability hints.
- **Passive hint pattern** — mention URLs and tools as available resources without instructing the agent to act on them:
  - URLs: `The release notes at <https://example.com/releases> may be useful.`
  - Tools: `` `govulncheck` may surface relevant findings. ``
- **Passive statement of fact** (instead of delegating to developer): `Major version upgrades may contain breaking changes — the package's changelog documents them.` The agent reads the fact but is not instructed to fetch the changelog itself.
- **Keep tool references in code blocks**, not in prose checklists. A `gh repo view` command in a Quick Reference code block does not trigger W011; the same command in an evaluation checklist does because it implies the agent must run it to fulfill the checklist item.
- **Decouple** tool execution from upgrade decisions: running a tool is fine; using its remote-sourced output as the direct trigger for a refactor is not.
- URLs in markdown tables or as trailing passive references (not as workflow steps) do not trigger W011.

**W012 — Potentially malicious external URL (high)**

Triggered when asset files or instruction bodies reference external URLs that are fetched and executed at runtime (e.g., `go install pkg@latest`, `curl ... | sh`, unpinned GitHub Actions `uses: org/action@vN`).

| Pattern that triggers W012 | Safe reformulation |
| --- | --- |
| `go install golang.org/x/vuln/cmd/govulncheck@latest` in instruction prose | Use `golang/govulncheck-action@v1` GitHub Action in CI YAML instead; remove duplicate install instruction from prose if already in frontmatter `install` block |
| `uses: actions/checkout@v6` (non-existent version) in YAML assets | Update to the correct current major version (e.g., `@v4` for checkout, `@v5` for setup-go) — non-existent versions look more suspicious |
| CI YAML assets referencing unpinned GitHub Actions | This is inherent to CI skills; W012 risk drops when versions are corrected to current stable values |

**W001 — Prompt injection via MCP tool calls**

Triggered when the skill body contains explicit MCP tool-calling instructions. See the "Library-specific skills" section above for the fix.

## Evaluation

### Adversarial evaluation design

Run skill evaluation with the pattern recommended by `/skill-creator`. Use `/tmp/{skill-name}-workspace` as default workspace for ephemeral files.

Evals MUST be adversarial — they test the skill's **unique value**, not common knowledge the model already has. A good eval has a "trap" the model falls into without the skill but avoids with it. Every rule of a skill must have its test.

Size evaluations to the skill's **Directory (tok)** column in README.md: expect **~10 assertions per 1,000 tokens** of skill content (full directory excluding evals), with a **minimum of 50 assertions**. Examples from the current table:

| Skill           | Directory (tok) | Min assertions |
| --------------- | --------------- | -------------- |
| Code style      | 2,613           | 50             |
| Error handling  | 4,145           | 62             |
| Testing         | 5,913           | 89             |
| Design patterns | 9,122           | 137            |
| Security        | 21,470          | 322            |
| Benchmark       | 29,081          | 436            |

Store your evaluation scenarios in `skills/{name}/evals/evals.json`.

**Design principles:**

- **Never test common knowledge.** If the model passes both with and without the skill, the eval is useless. Avoid testing well-known patterns (e.g. `bufio.Scanner` for file reading, `strings.Builder` for concatenation, basic `make` preallocation).
- **Test the skill's unique guidance.** Identify what the skill teaches that the model wouldn't do by default — subtle tradeoffs, non-obvious stdlib choices, Go-specific gotchas.
- **Create traps — natural wrong defaults, not explicit wrong instructions.** A trap makes the obvious/lazy approach incorrect: the task looks like a normal request where the natural implementation is subtly wrong. If the task explicitly instructs the model to use a specific wrong approach, the model follows that instruction regardless of the skill. The skill shifts defaults; it cannot override direct instructions. Good trap: "implement a shared counter for a web handler" (tempts a race condition). Bad trap: "implement a counter using a global int without synchronization".
- **Test judgment, not API knowledge.** Ask "which data structure?" not "how to use data structure X?". The model knows APIs; the skill adds architectural judgment.
- **Avoid leading prompts.** Don't mention the correct approach in the task description (e.g. don't say "use container/list" — say "implement LRU cache"). Don't hint at the answer. Don't name the rule, alert type, or problem category — if the prompt labels the issue, the model can reason to the fix without the skill.
- **Stress-test edge cases.** The skill's common-mistakes tables and "when NOT to use" guidance are high-value targets.
- **Pre-flight every candidate eval without the skill.** If the model passes, cut it or redesign it before adding it to the suite. This is the cheapest quality gate.
- **Prefer positive trigger tests over negative ones.** Testing "don't do X when not applicable" is weak — models have a strong prior of not acting when uncertain. Every eval should test the model _doing_ something correctly, not refraining.
- **Target rules that are saturated in training data last.** Widely-documented patterns, standard stdlib idioms, and common Go conventions appear in countless guides and produce little or no delta. Focus first on rules that are counterintuitive, library-specific, or unique to the skill's domain.
- **Don't let prompt context substitute for skill knowledge.** If the eval describes the problem with enough specificity that the model can reason to the correct answer, the skill becomes redundant. Present the problem as an opaque or misleading scenario where the skill's rule resolves an ambiguity the model would otherwise get wrong.
- **Keep assertions within a group homogeneous.** Mixing common-knowledge assertions with skill-specific ones in the same eval group produces a partial score that masks both problems — some assertions pass in both conditions (common knowledge), others fail in both (coverage gap). Each eval group should test a single, skill-specific behavior.
- **Isolate the evaluated skill.** When running "without" evals, do NOT load any skill that covers overlapping content — a colliding skill would give the model guidance it shouldn't have, inflating the "without" score and masking the evaluated skill's true uplift. When running "with" evals, load only the skill under test (and its explicit cross-references if needed). For example, when evaluating `golang-error-handling`, do not load `golang-code-style` or `golang-safety` — they contain overlapping error-handling advice that would contaminate the baseline.

**Anti-patterns to avoid:**

- Testing `strings.Builder` when the task obviously needs string building → model knows this
- Testing `make([]T, 0, n)` when the task obviously needs preallocation → model knows this
- Testing `bufio.Scanner` for file reading → model knows this
- Testing `container/heap` when the task says "priority queue" → model knows this
- Any eval group where both with/without score 100% → tests common knowledge, not skill uplift; redesign it
- Any eval group where both with/without score 0% and the task explicitly requests the wrong approach → tests instruction-following, not skill guidance; remove the explicit wrong instruction and make that approach merely the natural default
- Any eval group where both with/without score 0% and the task is neutral → the skill has a coverage gap for this case; fix the skill or remove the eval
- Any eval group where both with/without score identically at a partial value → mixed common-knowledge and coverage-gap assertions; split and redesign each
- Naming an eval "model already knows this" and keeping it — if you know it's common knowledge, cut it
- Testing general best practices (widely-known Go idioms, standard stdlib patterns) instead of the skill's specific, non-obvious rules

#### Evaluation Reporting

Eval results go in `EVALUATIONS.md` at the repo root. Append new skill sections — never overwrite previous runs. The file is wrapped in `<!-- prettier-ignore-start/end -->` so Prettier doesn't break the HTML spans.

**Structure per skill:**

```
## `skill-name` — vX.Y.Z

Summary table (Overall with/without/delta)

<details>
<summary>Full breakdown (N assertions)</summary>

Metadata line (model, runs, grading method)
Flat table: # | Assertion | With | Without
  - Eval header rows: empty # cell, bold eval name + description, bold score spans
  - Assertion rows: a.b numbering, assertion text, colored ✓/✗ spans
  - Failed cells may include short evidence after ✗ (e.g. "✗ NewStore()")

</details>
```

**Styling:** Two CSS classes in the file's `<style>` block — `.g { color: #22863a; font-weight: bold; }` (green/pass) and `.r { color: #cb2431; font-weight: bold; }` (red/fail). Use `<span class="g">✓</span>` for pass and `<span class="r">✗</span>` for fail. Eval header scores use the same classes: `**<span class="g">4/4</span>**` or `**<span class="r">2/4</span>**` (red when score < max).

**Numbering:** `a.b` format — `a` is the eval number, `b` is the assertion within that eval (e.g., `4.3`, `11.2`). Eval header rows leave the `#` cell empty.

See `EVALUATIONS.md` for the canonical format.

After updating `EVALUATIONS.md` sum all the skill reports and update the table in `Skill evaluations` section of README.md.

Also update the **Summary table** at the top of `EVALUATIONS.md`: add a new row for the skill (or update the existing row if re-running), then recompute the **Total** row by summing all numerators and denominators across all skills. The table is ordered by Delta ascending (low → high). Populate the Concern column using these rules: "Low delta" (≤32pp), "High without" (Without ≥65%), "Low with-skill score" (With ≤90%) — combine when multiple apply. Use bold on Concern values to draw attention. The **Uplift** column shows `With / Without` rounded to 2 decimal places and suffixed with `×` (e.g. `1.64×`); recompute it for every row including the Total.

## Workflows

### Working in worktrees

All implementation work MUST happen in a git worktree in `.claude/worktrees/`, never directly on the checked-out branch.

Before starting any task, propose a branch name and ask the developer to confirm. Also run `git worktree list` first — if an existing worktree covers the same skill or a closely related topic, suggest reusing it and let the developer decide.

### After updating a skill

After making changes, suggest the following as next steps for the developer to run. Do NOT execute these automatically.

> **If the skill's scope changed** (new topic added, topic moved to another skill) **or if a skill was added/removed**: update `skills/golang-how-to/SKILL.md` — the skill loading table and the competing clusters section must reflect the current state of the plugin.

1. ~~Validate against the spec: `skills-ref validate ./skills/{name}`~~ (disabled — [skills-ref doesn't support `user-invocable` yet](https://github.com/agentskills/agentskills/issues/105))
2. Reformat markdowns with `npx prettier --write *.md "**/*.md"` then lint with `markdownlint-cli2 --config .markdownlint-cli2.jsonc ./` — run before measuring tokens, as formatting changes token counts 2b. Run `SNYK_TOKEN=<token> uvx snyk-agent-scan@latest skills/<name>/` and fix any W011/W012/W001 warnings before proceeding (see [Snyk agent scanner compliance](#snyk-agent-scanner-compliance))
3. Measure token counts:
   - **Description (tok)**: `awk 'NR==1 && /^---$/{found=1; next} found && /^---$/{exit} found && /^description:/{print}' skills/{name}/SKILL.md | tiktoken-cli`
   - **SKILL.md (tok)**: `tiktoken-cli skills/{name}/SKILL.md`
   - **Directory (tok)**: `tiktoken-cli --exclude "evals" skills/{name}/` (exclude `evals/` subdirectory)
4. Update the README.md table with the measured token counts, update the total rows, and update the **Error rate gap** column (`Without - With`, expressed as a negative percentage, e.g. `-39%`)
5. Increment `metadata.version` in the changed SKILL.md and the plugin version in `.claude-plugin/plugin.json`, `.cursor-plugin/plugin.json` and `gemini-extension.json` — all three plugin files MUST have the same version
6. Run skill evaluation via `/skill-creator`: 10+ evals, run them with and without the skill via parallel subagents, grade with LLM-as-judge (no human in the loop), print results, suggest improvements if needed, and append/update the report to `EVALUATIONS.md` following the format in [Evaluation Reporting](#evaluation-reporting)
7. Depending on evaluation final report, suggest improvements and loop

For initial evaluation of skills, use Human-as-Judge.

### After creating a new skill

After writing a new skill body, run the description optimization loop before marking it ready:

1. Verify the description against quality criteria: contains "Golang", has "Use when"/"Apply when" trigger clause with specific scenarios, no broad anti-patterns (`whenever writing Go code`, `Essential for ANY`, `proactively`), FQN cross-refs for competing skills (`samber/cc-skills-golang@<skill>`), library skills use `Apply when the codebase imports github.com/...` pattern. Description must stay ≤ 1,000 characters.
2. Follow the [After updating a skill](#after-updating-a-skill) checklist.

### Checking for outdated skills

Skills covering a specific library or framework can become stale when the project releases breaking changes or new APIs. Run this check periodically (e.g. monthly) to surface outdated skills.

1. Grep all SKILL.md files for `skill-library-version` entries to build the inventory.
2. For each skill with a `skill-library-version`, fetch the latest release from the project's GitHub releases page or changelog via web search.
3. Compare the skill's recorded version against the latest release. Flag skills where the latest version is a higher major or minor than `skill-library-version`.
4. For flagged skills, skim the changelog between the recorded version and the latest to identify breaking changes or new APIs that the skill should cover.
5. Suggest a skill update for each flagged skill, summarizing the relevant changelog entries.

After updating a skill to reflect a new library version, bump `skill-library-version` to the new version and follow the [After updating a skill](#after-updating-a-skill) checklist.

### README status icons

In the README tables, skill names are prefixed with status icons:

- **✅** — skill is complete and active
- **👷** — skill is work in progress — **set all token counts to 0** for these rows and exclude them from totals
- **❌** — skill is disabled/not yet started — **set all token counts to 0** for these rows and exclude them from totals

## Plugin Configuration

Plugin metadata is defined in `.claude-plugin/plugin.json`, `.cursor-plugin/plugin.json` and `gemini-extension.json`. All three files MUST have the same `version` value. Fields include:

- Plugin name, version, and description
- Author and repository information
- Keywords for discoverability

## Best Practice Sources

Skills:

- <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>

Go language:

- <https://go.dev/doc/effective_go>
- <https://go.dev/ref/spec>
- <https://go.dev/ref/mem>
- <https://go.dev/blog/pipelines>
- <https://go.dev/doc/faq>
- <https://go-proverbs.github.io/>
- <https://gobyexample.com/>

Style guides:

- <https://google.github.io/styleguide/go/guide>
- <https://google.github.io/styleguide/go/decisions>
- <https://google.github.io/styleguide/go/best-practices.html>
- <https://github.com/uber-go/guide/blob/master/style.md>
- <https://github.com/unknwon/go-code-convention/blob/main/en-US.md>
- <https://go.dev/talks/2014/names.slide>

Common mistakes:

- <https://100go.co/>
- <https://golang50shades.com/>

Security:

- <https://go.dev/doc/security/best-practices>
- <https://docs.bearer.com/reference/rules/?lang-go=go_>
- <https://docs.snyk.io/scan-with-snyk/snyk-code/snyk-code-security-rules/go-rules>

Internals:

- <https://research.swtch.com/godata>
- <https://research.swtch.com/interfaces>

Testing:

- <https://testing.googleblog.com/2017/10/code-health-identifiernamingpostforworl.html>
- <https://testing.googleblog.com/2013/03/testing-on-toilet-testing-state-vs.html>
- <https://testing.googleblog.com/2014/05/testing-on-toilet-effective-testing.html>
- <https://testing.googleblog.com/2014/05/testing-on-toilet-risk-driven-testing.html>
- <https://testing.googleblog.com/2015/01/testing-on-toilet-change-detector-tests.html>

## Formats

Write short sentences.

### Format 5: Imperative Prose (recommended by skill-creator)

```md
## Writing Rules

Cut ruthlessly — every word must work. Remove filler words like "very", "really", "incredibly". Use active voice. Vary sentence length: 3-5 words for impact, then medium length for explanation.
```

### Format 1: Categorized examples (Good / Bad)

```md
## `errors.New` — static error messages

'''go // ✓ Good - {tell why} errors.New("unexpected error)

// ✗ Bad — {tell why} fmt.Errorf("unexpected error) '''
```

### Format 2: Template / Example-Driven

```md
## Commit Message Format

ALWAYS use this exact template:

''' <type>[optional scope]: <description> [optional body] '''

**Example 1:** Input: Added user authentication with JWT tokens Output: feat(auth): implement JWT-based authentication

**Example 2:** ...
```

### Format 3: Categorized Bullet Lists (Do / Don't / Avoid)

```md
**Formatting:**

- Mobile-first (58% on mobile)
- Never more than 2 visual lines per paragraph on phone
- Line breaks between most sentences

**Avoid:**

- Rhetorical questions
- Empty words ("digital landscape", "incontournable")
- Emoji abuse
```

### Format 4: Numbered RFC-style Rules (MUST/MAY/SHOULD)

```md
## Git conventions

1. Commits MUST be prefixed with a type
2. The type `feat` MUST be used for new features
3. A scope MAY be provided after a type, in parentheses
4. A description MUST immediately follow the colon and space
```
