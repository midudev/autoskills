---
name: rails-code-review
license: MIT
description: >
  Reviews Rails pull requests, focusing on controller/model conventions,
  migration safety, query performance, and Rails Way compliance. Covers
  routing, ActiveRecord, security, caching, and background jobs. Use when
  reviewing existing Rails code for quality, conducting a PR review, or
  doing a code review on Ruby on Rails (RoR) code.
---

# Rails Code Review (The Rails Way)

When **reviewing** Rails code, analyze it against the following areas. When **writing** new code, follow **rails-code-conventions** (principles, logging, path rules) and **rails-stack-conventions** (stack-specific UI and Rails patterns).

**Core principle:** Review early, review often. Self-review before PR. Re-review after significant changes.

## HARD-GATE: After implementation (before PR)

```
After green tests + linters pass + YARD + doc updates:
1. Self-review the full branch diff using the Review Order below.
2. Fix Critical items; resolve or ticket Suggestion items.
3. Only then open the PR.
generate-tasks must include a "Code review before merge" task.
```

## Quick Reference

| Area | Key Checks |
|------|------------|
| Routing | RESTful, shallow nesting, named routes, constraints |
| Controllers | Skinny, strong params, `before_action` scoping |
| Models | Structure order, `inverse_of`, enum values, scopes over callbacks |
| Queries | N+1 prevention, `exists?` over `present?`, `find_each` for batches |
| Migrations | Reversible, indexed, foreign keys, concurrent indexes |
| Security | Strong params, parameterized queries, no `html_safe` abuse |
| Caching | Fragment caching, nested caching, ETags |
| Jobs | Idempotent, retriable, appropriate backend |

## Review Order

Work through the diff in this sequence. Deep criteria: [REVIEW_CHECKLIST.md](./REVIEW_CHECKLIST.md). One-page PR baseline: [assets/checklist.md](./assets/checklist.md). Finding examples (JSON + comment shape): [assets/examples.md](./assets/examples.md).

Configuration → Routing → Controllers → Views → Models → Associations → Queries → Migrations → Validations → I18n → Sessions → Security → Caching → Jobs → Tests

**Critical checks to spot immediately:**

```ruby
# N+1 — one query per record in a collection
posts.each { |post| post.author.name }       # Bad
posts.includes(:author).each { |post| post.author.name }  # Good

# Privilege escalation via permit!
params.require(:user).permit!                # Bad — never in production
params.require(:user).permit(:name, :email)  # Good
```

**Always Critical (flag every occurrence as `Critical`):**

- `params.require(...).permit!` — mass-assignment / privilege escalation
- `html_safe` or `raw` applied to user-supplied content — XSS
- Missing authorization check on a sensitive action
- **Business logic inside a controller action** — pricing, tax, discount, multi-step workflow, or any domain calculation inline. A controller action that does more than coordinate (call one service, render response) is `Critical`, not a Suggestion.
- Unparameterized / string-interpolated SQL — injection
- Destructive migration without a safe path on large tables

## Severity levels

Use **only** these labels (no High/Low, P0–P2, etc.): **`Critical`** | **`Suggestion`** | **`Nice to have`**.

- **Critical** — security, data loss, crash, or any **Always Critical** rule → block merge; re-diff after fix.
- **Suggestion** — conventions / performance → fix in PR, or ticket if redesign is large.
- **Nice to have** — small style or micro-optimization → optional for the author.

## Output style

Group findings under `### Critical` / `### Suggestion` / `### Nice to have` (omit empty sections). Do not use a single flat list mixed by severity.

```text
## Review — <PR title or area>

### Critical
- [path/to/file.rb:LINE] (Area) One-line risk. **Mitigation:** concrete next step.

### Suggestion
- [path/to/file.rb:LINE] (Area) … **Mitigation:** …

### Nice to have
- …

**Actions required:** <one line per severity level that appeared — e.g. Critical → block merge + re-review; Suggestion → …>
```

**Template rules:** each bullet is `[file:line] (Area)` + risk + **`Mitigation:`** (required). Tag **(Area)** from: Controllers, Routing, Views, Models, Queries, Migrations, Validations, Security, Caching, Jobs, Tests — across the whole review, cover **≥4** distinct areas when the diff touches that many surfaces.

## Re-review before merge

Re-diff the branch after **any** Critical fix (mandatory), after **>3** Suggestion fixes or any logic/architecture change during feedback (recommended), or whenever the fix could alter queries, auth, or migrations. Skip only for **Nice to have**-only feedback or trivial one-line edits with **no** behavior change.

## Review anti-patterns (adds to checklist, does not replace it)

- **Thin controller → fat model:** extract orchestration to **services** (PORO / `*.call`), not giant model methods.
- **N+1 in dev:** small seeds hide N+1 — if associations run inside a loop, count queries (request spec, rack-mini-profiler, logs) instead of assuming “it’s fast here.”
- **Hot-table migrations:** add concurrent indexes and heavy backfills in **separate** deploy steps from reversible schema changes (chain **rails-migration-safety** when unsure).
- **Callbacks vs jobs:** persistence hooks only; external I/O and multi-step workflows belong in services/jobs with clear idempotency.

## Integration

| Skill | When to chain |
|-------|---------------|
| **rails-review-response** | When the developer receives feedback and must decide what to implement |
| **rails-architecture-review** | When review reveals structural problems |
| **rails-security-review** | When review reveals security concerns |
| **rails-migration-safety** | When reviewing migrations on large tables |
| **refactor-safely** | When review suggests refactoring |
