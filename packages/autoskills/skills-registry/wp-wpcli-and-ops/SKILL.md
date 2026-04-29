---
name: wp-wpcli-and-ops
description: "Use when working with WP-CLI (wp) for WordPress operations: safe search-replace, db export/import, plugin/theme/user/content management, cron, cache flushing, multisite, and scripting/automation with wp-cli.yml."
compatibility: "Targets WordPress 6.9+ (PHP 7.2.24+). Requires WP-CLI in the execution environment."
---

# WP-CLI and Ops

## When to use

Use this skill when the task involves WordPress operational work via WP-CLI, including:

- `wp search-replace` (URL changes, domain migrations, protocol switch)
- DB export/import, resets, and inspections (`wp db *`)
- plugin/theme install/activate/update, language packs
- cron event listing/running
- cache/rewrite flushing
- multisite operations (`wp site *`, `--url`, `--network`)
- building repeatable scripts (`wp-cli.yml`, shell scripts, CI jobs)

## Inputs required

- Where WP-CLI will run (local dev, staging, production) and whether it’s safe to run.
- How to target the correct site root:
  - `--path=<wordpress-root>` and (multisite) `--url=<site-url>`
- Whether this is multisite and whether commands should run network-wide.
- Any constraints (no downtime, no DB writes, maintenance window).

## Procedure

### 0) Guardrails: confirm environment and blast radius

WP-CLI commands can be destructive. Before running anything that writes:

1. Confirm environment (dev/staging/prod).
2. Confirm targeting (path/url) so you don’t hit the wrong site.
3. Make a backup when performing risky operations.

Read:
- `references/safety.md`

### 1) Inspect WP-CLI and site targeting (deterministic)

Run the inspector:

- `node skills/wp-wpcli-and-ops/scripts/wpcli_inspect.mjs --path=<path> [--url=<url>]`

If WP-CLI isn’t available, fall back to installing it via the project’s documented tooling (Composer, container, or system package), or ask for the expected execution environment.

### 2) Choose the right workflow

#### A) Safe URL/domain migration (`search-replace`)

Follow a safe sequence:

1. `wp db export` (backup)
2. `wp search-replace --dry-run` (review impact)
3. Run the real replace with appropriate flags
4. Flush caches/rewrite if needed

Read:
- `references/search-replace.md`

#### B) Plugin/theme operations

Use `wp plugin *` / `wp theme *` and confirm you’re acting on the intended site (and network) first.

Read:
- `references/packages-and-updates.md`

#### C) Cron and queues

Inspect cron state and run individual events for debugging rather than “run everything blindly”.

Read:
- `references/cron-and-cache.md`

#### D) Multisite operations

Multisite changes can affect many sites. Always decide whether you’re operating:

- on a single site (`--url=`), or
- network-wide (`--network` / iterating sites)

Read:
- `references/multisite.md`

### 3) Automation patterns (scripts + wp-cli.yml)

For repeatable ops, prefer:

- `wp-cli.yml` for defaults (path/url, PHP memory limits)
- shell scripts that log commands and stop on error
- CI jobs that run read-only checks by default

Read:
- `references/automation.md`

## Verification

- Re-run `wpcli_inspect` after changes that could affect targeting or config.
- Confirm intended side effects:
  - correct URLs updated
  - plugins/themes in expected state
  - cron/caches flushed where needed
- If there’s a health check endpoint or smoke test suite, run it after ops changes.

## Failure modes / debugging

- “Error: This does not seem to be a WordPress installation.”
  - wrong `--path`, wrong container, or missing `wp-config.php`
- Multisite commands affecting the wrong site
  - missing `--url` or wrong URL
- Search-replace causes unexpected serialization issues
  - wrong flags or changing serialized data unsafely

See:
- `references/debugging.md`

## Escalation

- If you cannot confirm environment safety, do not run write operations.
- If the repo uses containerized tooling (Docker/wp-env) but you can’t access it, ask for the intended command runner or CI job.
