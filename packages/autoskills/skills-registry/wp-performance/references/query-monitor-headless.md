# Query Monitor (headless / backend-only)

Query Monitor is UI-first, but it can expose useful data to backend-only tooling.

## What it can show

Query Monitor can help debug:

- DB queries (slow/dupes/errors), hooks/actions, HTTP API calls, PHP errors

Plugin page:

- https://wordpress.org/plugins/query-monitor/

Configuration constants:

- https://querymonitor.com/help/configuration-constants/

## REST API requests (no browser needed)

Query Monitor can add performance/error info to authenticated REST responses.

Docs:

- https://querymonitor.com/wordpress-debugging/rest-api-requests/

High-level approach:

1. Authenticate (nonce or Application Password).
2. Make a REST request and inspect response headers like `x-qm-overview-*`.
3. If you request an enveloped response (`?_envelope`), you can get a `qm` property with:
   - DB queries details, cache stats, HTTP API request details, etc.

## Guardrails

- Query Monitor adds some overhead; don’t enable it in production without approval.
- If it’s already installed by your platform (e.g. VIP), you may need to grant `view_query_monitor`.

