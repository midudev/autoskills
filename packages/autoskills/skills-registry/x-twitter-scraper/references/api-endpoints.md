# Xquik REST API endpoints

Use this index to load only the REST API section needed for the task.

Send requests to `https://xquik.com/api/v1`.

All requests require the `x-api-key` header unless the section says session auth only. HTTPS only.

JSON endpoints return JSON. Export endpoints return files. Read `Content-Type`
before decoding the body. Use `Content-Disposition` for the suggested filename.
Call `response.json()` only for JSON exports.

Plan and credit changes are dashboard-only. This Skill may read usage state with `GET /credits`, but it must not start changes.

| Need | Reference |
|---|---|
| API keys | [api-keys.md](api-endpoints-api-keys.md) |
| Monitors | [monitors.md](api-endpoints-monitors.md) |
| Events | [events.md](api-endpoints-events.md) |
| Webhooks | [webhooks.md](api-endpoints-webhooks.md) |
| Draws | [draws.md](api-endpoints-draws.md) |
| Extractions | [extractions.md](api-endpoints-extractions.md) |
| Direct X lookups | [x-api.md](api-endpoints-x-api.md) |
| X media downloads | [x-media.md](api-endpoints-x-media.md) |
| Trends | [trends.md](api-endpoints-trends.md) |
| Radar | [radar.md](api-endpoints-radar.md) |
| Compose | [compose.md](api-endpoints-compose.md) |
| Drafts | [drafts.md](api-endpoints-drafts.md) |
| Tweet style cache | [tweet-style-cache.md](api-endpoints-tweet-style-cache.md) |
| Connected X accounts | [x-accounts.md](api-endpoints-x-accounts.md) |
| X writes | [x-write.md](api-endpoints-x-write.md) |
| Credits | [credits.md](api-endpoints-credits.md) |
| Support | [support.md](api-endpoints-support.md) |
| Error codes | [error-codes.md](api-endpoints-error-codes.md) |
