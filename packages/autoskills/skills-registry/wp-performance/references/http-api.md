# HTTP API (remote requests)

Use this file when profiling shows slow external requests (`wp_remote_get`, etc.).

Fix patterns:

- Add timeouts and fail-fast behavior.
- Cache responses where appropriate (transients/object cache).
- Batch requests and avoid calling remote APIs on every page load.
- Move heavy remote work to async (cron/queue) where possible.

Tooling:

- Query Monitor can report HTTP API calls (including timing) via REST envelope info.

