# WP-Cron performance

Use this file when cron causes spikes or request-time slowness.

Backend-only tools:

- `wp cron test` (spawning health)
- `wp cron event list`
- `wp cron event run --due-now`

Reference:

- WP-CLI cron command package: https://github.com/wp-cli/cron-command

Fix patterns:

- De-duplicate scheduled events and reduce frequency where possible.
- Ensure tasks are idempotent and short.
- Move heavy work off-request; cron that runs on page load can hurt TTFB.

