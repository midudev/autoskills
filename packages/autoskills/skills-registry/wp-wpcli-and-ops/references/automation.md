# Automation with WP-CLI

Use this file when turning an ops sequence into a repeatable script or CI job.

## `wp-cli.yml`

If the repo uses `wp-cli.yml`, use it to standardize:

- `path:` (WordPress root)
- `url:` (default site)
- PHP settings (memory limits)

## Shell scripting

Guardrails for scripts:

- `set -euo pipefail`
- print commands before running them
- make destructive operations require an explicit flag (e.g. `--apply`)

## CI jobs

Prefer CI jobs that are read-only by default:

- `wp core version`
- `wp plugin list`
- `wp theme list`

Only enable write operations in dedicated deploy/maintenance workflows.

