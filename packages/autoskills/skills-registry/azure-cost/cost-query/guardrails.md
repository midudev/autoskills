# Cost Query Guardrails

Detailed validation rules and guardrails for the Cost Management Query API. The system applies these automatically, but understanding them helps avoid unexpected query modifications or errors.

## Time Period Validation

### Default Behavior

| Scenario | System Behavior |
|----------|----------------|
| No time period specified | Defaults to current month start → today. |
| `from` is after `to` | System silently swaps `from` and `to`. |

### Future Date Handling

| Scenario | System Behavior |
|----------|----------------|
| Both `from` and `to` are in the future | Entire period shifted to the equivalent period last year. |
| Only `to` is in the future | `to` is adjusted to today's date. |

> ⚠️ **Warning:** Future date shifting happens silently. The response data will cover the adjusted period, not the originally requested dates.

### Granularity-Based Range Limits

| Granularity | Maximum Range | Truncation Behavior |
|-------------|---------------|---------------------|
| `Daily` | 31 days | `from` truncated to `to - 1 month + 1 day`. |
| `Monthly` | 12 months | `from` truncated to `to - 12 months + 1 day`. |
| `None` | 12 months | `from` truncated to `to - 12 months + 1 day`. |

> ⚠️ **Warning:** The absolute API limit is **37 months**. Requests exceeding 37 months return HTTP 400 regardless of granularity.

### Minimum Start Date

| Constraint | Value |
|------------|-------|
| Earliest allowed `from` date | May 1, 2014 |

### GroupBy Interaction with Time Period

| Combination | System Behavior |
|-------------|----------------|
| GroupBy + Daily granularity | Time period adjusted to the last day of the requested range. |
| GroupBy + Monthly granularity | Time period adjusted to the last month of the requested range. |

> 💡 **Tip:** When using GroupBy with Daily granularity over a multi-day range, the system may return data only for the last day. For full daily breakdown with grouping, ensure the range is within the 31-day limit.

## ResourceId Scope Restriction

> ⚠️ **Warning:** Grouping by `ResourceId` is **only supported at subscription scope and below** (subscription, resource group). It is NOT supported at higher scopes.

| Scope | ResourceId GroupBy |
|-------|--------------------|
| Subscription | ✅ Supported |
| Resource Group | ✅ Supported |
| Billing Account | ❌ Not supported |
| Management Group | ❌ Not supported |
| Billing Profile | ❌ Not supported |
| Department (EA) | ❌ Not supported |
| Enrollment Account (EA) | ❌ Not supported |
| Invoice Section (MCA) | ❌ Not supported |
| Customer (Partner) | ❌ Not supported |

When the user requests a cost breakdown by resource at a billing account or management group scope, use `ServiceName`, `SubscriptionName`, or another supported dimension instead. If per-resource detail is needed, narrow the scope to a specific subscription first.

## Dataset Validation

### GroupBy Constraints

| Rule | Limit | Error Behavior |
|------|-------|----------------|
| Maximum GroupBy dimensions | 2 | Validation error if more than 2 specified. |
| Duplicate columns in GroupBy | Not allowed | Validation error on duplicate column names. |
| Same column in Aggregation and GroupBy | Not allowed | Validation error if a column appears in both. |

### Aggregation Constraints

| Rule | Details |
|------|---------|
| Standard queries aggregation function | Only `Sum` is allowed. |
| `Date` in aggregation with granularity | Not allowed. Cannot aggregate on `Date` when granularity is `Daily` or `Monthly`. |

### Filter Constraints

| Rule | Details |
|------|---------|
| `and` operator | Must have 2 or more child expressions. |
| `or` operator | Must have 2 or more child expressions. |
| `not` operator | Must have exactly 1 child expression. |

> ⚠️ **Warning:** A filter with a single child in `and` or `or` will fail validation. Wrap single-condition filters directly without a logical operator, or use `not` for negation.

## Scope & Dimension Compatibility

Dimensions must be valid for the intersection of the agreement type **and** scope type.

| Agreement Type | Unique Dimensions | Reference |
|----------------|-------------------|-----------|
| EA | `DepartmentName`, `EnrollmentAccountName`, `BillingPeriod` | See [dimensions-by-scope.md](dimensions-by-scope.md) |
| MCA | `InvoiceSectionName` | See [dimensions-by-scope.md](dimensions-by-scope.md) |
| MOSP | _(common dimensions only)_ | See [dimensions-by-scope.md](dimensions-by-scope.md) |

| Validation | Error Behavior |
|------------|----------------|
| Dimension not valid for agreement type | `BillingSubscriptionNotFound` or dimension validation error. |
| Dimension not valid for scope type | `BadRequest` with invalid dimension message. |

> ⚠️ **Warning:** Using an EA-only dimension (e.g., `DepartmentName`) on a MOSP subscription will return a validation error. Always verify the agreement type before selecting dimensions.

## EA + Management Group Special Case

| Scenario | Result |
|----------|--------|
| Filter by `SubscriptionName` without `SubscriptionId` at Management Group scope | Error returned. |
| Error message | _"To view cost data, the subscription ID is needed. Select Subscriptions to find the ID for your subscription, and then ask your question again."_ |

**Remediation:** When filtering by subscription name at Management Group scope under EA, always include a `SubscriptionId` filter alongside the `SubscriptionName` filter.

```json
{
  "and": [
    {
      "dimensions": {
        "name": "SubscriptionId",
        "operator": "In",
        "values": ["<subscription-id>"]
      }
    },
    {
      "dimensions": {
        "name": "SubscriptionName",
        "operator": "In",
        "values": ["My Subscription"]
      }
    }
  ]
}
```

## Rate Limiting

### Rate Limit Thresholds

| Limit | Value |
|-------|-------|
| Per User | 20 requests per minute |
| Per Scope | 4 requests per minute |
| Per Tenant | 12 requests per 10 seconds, 60 requests per minute, 600 requests per hour |
| Per Client Type | 2,000 requests per minute |

> ⚠️ **Warning:** The **per-scope limit (4 requests/minute)** is the most restrictive. Sequential queries to the same subscription, resource group, or billing account share this limit.

### QPU-Based Throttling

| Tier | Description |
|------|-------------|
| Premium | Higher QPU allocation (EA, MCA enterprise). |
| Non-premium | Lower QPU allocation (MOSP, trial). |

### Rate Limit Headers

| Header | Description |
|--------|-------------|
| `x-ms-ratelimit-microsoft.costmanagement-qpu-retry-after` | Seconds to wait before retrying (QPU limit). |
| `x-ms-ratelimit-microsoft.costmanagement-entity-retry-after` | Seconds to wait before retrying (entity/scope limit). |
| `x-ms-ratelimit-microsoft.costmanagement-tenant-retry-after` | Seconds to wait before retrying (tenant limit). |

### Handling 429 Responses

On a 429 response, check **all** retry-after headers present in the response. Multiple headers may be returned simultaneously. Take the **maximum** value and **do NOT send any further requests to the same scope until that duration has fully elapsed.**

> ⚠️ **Warning:** Do not retry before the retry-after duration has elapsed. Premature retries will be rejected and may extend the throttling period.

### Pagination

| Parameter | Default | Maximum |
|-----------|---------|---------|
| Page size | 1,000 rows | 5,000 rows |
| Pagination | Use `nextLink` from response to fetch subsequent pages. | — |

> 💡 **Tip:** For large result sets, always check the `nextLink` field in the response. If present, make additional requests to retrieve all pages.
