---
name: rails-security-review
license: MIT
description: >
  Performs security audits and vulnerability assessments on Ruby on Rails application
  code. Use when reviewing Rails code for security risks, assessing authentication or
  authorization, auditing parameter handling, redirects, file uploads, secrets management,
  or checking for XSS, CSRF, SSRF, SQL injection, and other common vulnerabilities.
---

# Rails Security Review

Use this skill when the task is to review or harden Rails code from a security perspective.

**Core principle:** Prioritize exploitable issues over style. Assume any untrusted input can be abused.

## HARD-GATE: Authorization Findings Lead the Report

```
BEFORE returning your security review, verify:
  1. The FIRST finding section in your output is "Authentication & Authorization"
  2. SQL injection, XSS, or other findings come AFTER auth/authz — even if
     they feel more severe or were discovered first
  3. If no auth/authz issue exists, the report still opens with an explicit
     "Authentication & Authorization: no issues found" line BEFORE any other
     finding category
```

## Quick Reference

| Area | Key Checks |
|------|------------|
| Auth | Permissions on every sensitive action |
| Params | No `permit!`, whitelist only safe attributes |
| Queries | Parameterized — no string interpolation in SQL |
| Redirects | Constrained to relative paths or allowlist |
| Output | No `html_safe`/`raw` on user content |
| Secrets | Encrypted credentials, never in code or logs |
| Files | Validate filename, content type, destination |

## Review Order

1. Check authentication and authorization boundaries.
2. Check parameter handling and sensitive attribute assignment.
3. Check redirects, rendering, and output encoding.
4. Check file handling, network calls, and background job inputs.
5. Check secrets, logging, and operational exposure.
6. **Verify each finding:** Confirm it is exploitable with a concrete attack scenario before reporting. Exclude false positives (e.g., `html_safe` on a developer-defined constant, not user input).

## Severity Levels

### High

- Missing or bypassable authorization checks
- SQL, shell, YAML, or constantization injection paths
- Unsafe redirects or SSRF-capable outbound requests
- File upload handling that trusts filename, content type, or destination blindly
- Secrets or tokens stored in code, logs, or unsafe config

### Medium

- Unscoped mass assignment through weak parameter filtering
- User-controlled HTML rendered without clear sanitization
- Sensitive data logged in plaintext
- Security-relevant behavior hidden in callbacks or background jobs without guardrails
- Brittle custom auth logic where framework primitives would be safer

## Review Checklist

- Are permissions enforced on every sensitive action?
- Are untrusted inputs validated before database, filesystem, or network use?
- Are redirects and URLs constrained?
- Are secrets stored and logged safely?
- Are security assumptions explicit and testable?

## Examples

**High-severity (unscoped redirect):**

```ruby
# Bad: user-controlled redirect — open redirect / phishing risk
redirect_to params[:return_to]

# Good: relative path only
redirect_to root_path
# Good: allowlist
SAFE_PATHS = %w[/dashboard /settings].freeze
redirect_to(SAFE_PATHS.include?(params[:return_to]) ? params[:return_to] : root_path)
```

**Medium-severity (mass assignment):**

```ruby
# Bad: privilege escalation risk
params.require(:user).permit!

# Good: explicit whitelist — never include role, admin, or privilege fields
params.require(:user).permit(:name, :email)
```

## Pitfalls

See [PITFALLS.md](./PITFALLS.md) for the full list. Critical anti-patterns: `permit!` on any parameter set, `html_safe` on user content, SQL string interpolation, secrets in committed files.

## Output Style

Section order per the HARD-GATE. Every heading appears even when empty (write "No issues found.").

```
## Authentication & Authorization
## Parameter Handling & Mass Assignment
## Query Safety (SQL / NoSQL / shell injection)
## Output Encoding & Redirects
## Secrets, Logging & Operational Exposure
```

Each finding carries:
- **Severity:** **High** or **Medium** (not "Critical")
- **Attack path:** input → reach → impact
- **Affected file:** path + line, e.g. `app/controllers/documents_controller.rb:42`
- **Mitigation:** smallest credible fix

## Integration

| Skill | When to chain |
|-------|---------------|
| **rails-code-review** | For full code review including non-security concerns |
| **rails-architecture-review** | When security issues stem from architectural problems |
| **rails-migration-safety** | When reviewing migration security (data exposure, constraints) |
