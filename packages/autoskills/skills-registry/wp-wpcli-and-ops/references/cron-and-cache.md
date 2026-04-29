# Cron, caches, and rewrites

Use this file when debugging background jobs or “changes not visible”.

## Cron

- List scheduled events:
  - `wp cron event list`
- Run a specific event now:
  - `wp cron event run <hook>`

## Cache + rewrite

- Flush object cache:
  - `wp cache flush`
- Flush rewrite rules:
  - `wp rewrite flush`

## Guardrails

- Don’t “run all cron events” on production without understanding impact.
- Cache flush can cause load spikes; coordinate if needed.

