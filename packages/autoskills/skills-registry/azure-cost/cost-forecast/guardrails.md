# Forecast API Guardrails

Detailed guardrails derived from CCM-LUX getForecastData and CCM-UX-MIDDLEWARE Forecaster.

## Time Period Validation

| Rule | Detail |
|---|---|
| `to` date must be in the future | `numberOfDaysToForecast` must be > 0. Entirely past date ranges return a `CantForecastOnThePast` error. |
| `from` can be in the past | When `from` is in the past, the response includes actual costs from `from` to today and forecast costs from today to `to`. |
| Both dates must be valid | When `timePeriod` is present, both `from` and `to` must be valid parseable ISO 8601 datetime strings. |
| Monthly + includeActualCost | Monthly granularity with `includeActualCost=true` requires an explicit `timePeriod` with valid `from` and `to` dates. Omitting it produces `DontContainsValidTimeRangeWhileMonthlyAndIncludeCost`. |
| Maximum forecast period | 10 years maximum forecast window. |

> ⚠️ **Warning:** If both `from` and `to` are in the past, the API returns `CantForecastOnThePast`. At least the `to` date must be in the future.

## Training Data Requirements

| Requirement | Value |
|---|---|
| Minimum historical data | 4 weeks (28 days) of cost data |
| Preferred training window | Up to 3 months of history |
| Late arrival tolerance | 2 days for billing data to arrive |
| New subscriptions (< 28 days) | Forecast unavailable |

> ⚠️ **Warning:** New subscriptions with fewer than 28 days of cost history cannot generate forecasts. Suggest using **the Cost Query workflow (Part 1)** to retrieve available historical data instead.

## Grouping Restriction

| Aspect | Detail |
|---|---|
| Grouping support | ❌ **Not supported** |
| API limitation | This is a hard limitation of the Forecast API. The `grouping` field is not accepted in the request body. |
| Workaround | If the user requests a grouped forecast (e.g., forecast by resource group or service), inform them that grouping is not supported for forecasts. Suggest querying historical data with grouping using **the Cost Query workflow (Part 1)** instead. |

> ⚠️ **Warning:** Even when using **the Cost Query workflow (Part 1)** for grouped historical data, `ResourceId` grouping is only supported at subscription scope and below. It is not supported at billing account, management group, or higher scopes.

## Response Row Limit

| Constraint | Detail |
|---|---|
| Maximum rows | 40 rows per forecast response |
| Daily example | 30 actual days + 30 forecast days = 60 rows → **exceeds limit** |
| Recommendation | For daily granularity, keep forecast period to ~2–3 weeks |
| Longer periods | Use monthly granularity to stay within the row limit |

> 💡 **Tip:** If the user needs a daily forecast for more than 2–3 weeks, consider splitting the request into smaller time windows or switching to monthly granularity.

## includeActualCost / includeFreshPartialCost

| Field | Default | Dependency |
|---|---|---|
| `includeActualCost` | `true` | None |
| `includeFreshPartialCost` | `true` | **Requires `includeActualCost=true`** |

> ⚠️ **Warning:** Setting `includeFreshPartialCost=true` without `includeActualCost=true` produces validation error `DontContainIncludeActualCostWhileIncludeFreshPartialCost`. Always set both fields explicitly.

## Forecast Availability

The API returns "Forecast is unavailable for the specified time period" when:

| Condition | Detail |
|---|---|
| Null/empty response rows | Response has no data rows |
| Insufficient training data | Scope has fewer than 28 days of cost history |
| No cost history | Scope has never had any cost data |

> ⚠️ **Warning:** This is **not an error** — it is a valid response indicating the forecast model cannot generate predictions. Do not retry. Instead, suggest using **the Cost Query workflow (Part 1)** to retrieve whatever historical data is available.

## Rate Limiting

### Rate Limit Thresholds

The Forecast API shares the same rate limits as the Cost Query API:

| Limit | Value |
|-------|-------|
| Per User | 20 requests per minute |
| Per Scope | 4 requests per minute |
| Per Tenant | 12 requests per 10 seconds, 60 requests per minute, 600 requests per hour |
| Per Client Type | 2,000 requests per minute |

> ⚠️ **Warning:** The **per-scope limit (4 requests/minute)** is the most restrictive. Sequential queries to the same subscription, resource group, or billing account share this limit.

### Rate Limit Headers

| Header | Description |
|---|---|
| `x-ms-ratelimit-microsoft.costmanagement-qpu-retry-after` | Seconds to wait before retrying (QPU-based) |
| `x-ms-ratelimit-microsoft.costmanagement-entity-retry-after` | Seconds to wait for entity/scope-level throttle |
| `x-ms-ratelimit-microsoft.costmanagement-tenant-retry-after` | Seconds to wait for tenant-level throttle |

### Handling 429 Responses

On a 429 response, check **all** retry-after headers present in the response. Multiple headers may be returned simultaneously. Take the **maximum** value and **do NOT retry until that duration has fully elapsed.**

> ⚠️ **Warning:** Do not retry before the retry-after duration has elapsed. Premature retries will be rejected and may extend the throttling period.
