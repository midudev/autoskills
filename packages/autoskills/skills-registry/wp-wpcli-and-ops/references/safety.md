# Safety rules (WP-CLI)

Use this file before running any write operations.

## Golden rules

- Assume production is **unsafe** unless explicitly confirmed.
- Always confirm targeting:
  - `--path` (WordPress root)
  - `--url` (multisite / specific site targeting)
- Prefer a backup (`wp db export`) before risky operations.
- Prefer `--dry-run` where available (especially `search-replace`).

## High-risk commands (require explicit confirmation)

- `wp db reset`
- `wp db import` (overwrites data)
- `wp search-replace` (can affect serialized data and URLs)
- bulk deletes (`wp post delete --force --all`, `wp user delete --reassign`, etc.)
- plugin/theme mass updates on production

## Logging

For ops scripts, log:

- date/time
- environment (dev/staging/prod)
- exact WP-CLI commands
- exit codes

