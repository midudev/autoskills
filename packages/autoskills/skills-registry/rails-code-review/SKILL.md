---
name: rails-code-review
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

Work through the diff in this sequence. See [REVIEW_CHECKLIST.md](./REVIEW_CHECKLIST.md) for the full per-area check criteria.

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

**Additional Critical patterns:**

- **Business logic in controller action** (multi-step domain workflow) — flag as Critical; extract to a service object. A controller action doing more than coordinate (call one service, handle response) is a Critical finding.
- **Missing authorization check on sensitive action** — flag as Critical.

## Severity Levels

Use these levels when reporting findings:

| Level | Meaning | Action |
|-------|---------|--------|
| **Critical** | Security risk, data loss, or crash | Block merge — must fix before approval; mandatory re-review after fix |
| **Suggestion** | Convention violation or performance concern | Fix in this PR; create a tracked follow-up ticket only if the fix requires significant redesign |
| **Nice to have** | Style improvement, minor optimization | Optional — author's discretion; no follow-up required |

## Re-Review Loop

When critical or significant findings were addressed, re-review before merging:

```
Review → Categorize findings (Critical / Suggestion / Nice to have)
       → Developer addresses findings
       → Critical findings fixed? → Re-review the diff
       → Suggestion items resolved or ticketed?
       → All green → Approve PR
```

**Re-review triggers:**
- Any Critical finding was present → mandatory re-review after fixes
- More than 3 Suggestion items addressed → re-review recommended
- Logic or architecture changed during feedback → re-review required

**Skip re-review only when:** All findings were Nice to have or single-line fixes with zero logic change.

## Pitfalls

| Pitfall | What to do |
|---------|------------|
| "Skinny controller" means move to model | Move to services — avoid fat models |
| Skipping N+1 check because "it's just one query" | One query per record in a collection is N+1 |
| `permit!` for convenience | Privilege escalation risk — always whitelist attributes |
| Index added in same migration as column | On large tables, separate migration with `algorithm: :concurrent` |
| Callbacks for business logic | Callbacks are for persistence-level concerns, not orchestration |
| Approving after Critical fix without re-reviewing | A fix can introduce new issues — re-review is mandatory |
| Controller action > ~15 lines | Extract to service — controllers orchestrate, not implement |
| Model with > 3 callbacks | Extract to service or observer |
| `html_safe`/`raw` on user-provided content | XSS risk — escape or sanitize first |
| Migration combining schema change and data backfill | Split: schema migration first, then data migration |

## Integration

| Skill | When to chain |
|-------|---------------|
| **rails-review-response** | When the developer receives feedback and must decide what to implement |
| **rails-architecture-review** | When review reveals structural problems |
| **rails-security-review** | When review reveals security concerns |
| **rails-migration-safety** | When reviewing migrations on large tables |
| **refactor-safely** | When review suggests refactoring |
