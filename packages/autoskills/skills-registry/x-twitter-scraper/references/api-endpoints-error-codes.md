# Xquik REST API endpoints: error codes

Default v1 responses put a legacy string code in `error`. Send
`xquik-api-contract: 2026-04-29` to receive an object with `message`, `type`,
and `code`. OpenAPI enumerates 112 codes, including `closed`, `expired`,
`missing_url`, and `user_not_found`. This table highlights common codes.
`closed` and `expired` map to 410. `missing_url` maps to 502.

| Status | Code | Meaning |
|--------|------|---------|
| 400 | `invalid_input` | Request body failed validation |
| 400 | `invalid_id` | Path parameter is not a valid ID |
| 400 | `invalid_json` | Invalid JSON in request body |
| 400 | `invalid_tweet_url` | Tweet URL format is invalid |
| 400 | `invalid_tweet_id` | Tweet ID is empty or invalid |
| 400 | `invalid_username` | X username is empty or invalid |
| 400 | `invalid_tool_type` | Extraction tool type not recognized |
| 400 | `invalid_format` | Export format not `csv`, `json`, `md`, `md-document`, `pdf`, `txt`, or `xlsx` |
| 400 | `invalid_params` | Export query parameters are missing or invalid |
| 400 | `invalid_coverage_cursor` | Automatic coverage cursor is malformed. Restart without it |
| 400 | `missing_query` | Required query parameter is missing |
| 400 | `missing_params` | Required query parameters are missing |
| 400 | `no_media` | Tweet has no downloadable media |
| 400 | `webhook_inactive` | Webhook is disabled; applies only to webhook tests |
| 401 | `unauthenticated` | Missing or invalid API key |
| 403 | `account_needs_reauth` | X account session expired; use dashboard re-auth flow |
| 402 | `no_subscription` | No active plan |
| 402 | `subscription_inactive` | Plan is not active |
| 402 | `no_credits` | No credit balance record exists |
| 402 | `insufficient_credits` | Credit balance is too low |
| 403 | `api_key_limit_reached` | API key limit reached; maximum 100 |
| 404 | `not_found` | Resource does not exist |
| 404 | `user_not_found` | X user not found |
| 404 | `tweet_not_found` | Tweet not found |
| 404 | `style_not_found` | No cached style found |
| 404 | `draft_not_found` | Draft not found |
| 409 | `monitor_already_exists` | Duplicate monitor for same username |
| 409 | `coverage_cursor_unavailable` | Wait the exact `Retry-After` seconds, then retry the same cursor once |
| 410 | `coverage_cursor_gone` | No `Retry-After`. Restart without a cursor and deduplicate by ID |
| 422 | `login_failed` | Account connection failed; use dashboard re-auth flow |
| 424 | `x_api_unavailable` | With `xquik-api-contract: 2026-04-29`, an upstream dependency failed. Apply the endpoint's documented fallback |
| 429 | - | Rate limited. Honor `Retry-After` when present. Otherwise retry only `GET` with bounded backoff |
| 429 | `x_api_rate_limited` | X data source rate limited. Honor `Retry-After` when present. Otherwise retry only `GET` with bounded backoff |
| 500 | `internal_error` | Server error. Retry only safe reads |
| 502 | `x_api_unavailable` | X data source temporarily unavailable. Retry only safe reads |
| 502 | `x_api_unauthorized` | Stop. Do not retry automatically. Review X source authentication |

Outside the cursor rules below, retry safe reads after connection failures,
`408`, `429`, or `5xx`. Retry `424` only when `safeToRetry` is `true`. Never
retry `POST`, `PATCH`, or `DELETE` automatically. For a write, preserve its
`Idempotency-Key` and inspect `statusUrl`. Start another attempt only when
`safeToRetry` is `true` and the user approves.

## Cursor recovery examples

`409 coverage_cursor_unavailable` requires an integer `Retry-After` response
header. Wait that many seconds, then retry the same cursor once.

The following example uses the default v1 string error contract:

```json
{
  "error": "coverage_cursor_unavailable",
  "message": "Cursor busy. Retry after the indicated delay."
}
```

`410 coverage_cursor_gone` has no `Retry-After` header. Restart without a
cursor and deduplicate by ID.

The following example also uses the default v1 string error contract:

```json
{
  "error": "coverage_cursor_gone",
  "message": "Cursor finished, expired, or superseded. Restart pagination without cursor."
}
```
