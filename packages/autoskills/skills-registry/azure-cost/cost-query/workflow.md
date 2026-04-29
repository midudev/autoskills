# Cost Query Workflow

Use this workflow when the user wants to **understand their costs** — breakdowns, trends, totals, top spenders.

## Step 1: Determine Scope

Identify the Azure scope for the cost query from the Scope Reference table in the main [SKILL.md](../SKILL.md#scope-reference-shared-across-all-workflows).

## Step 2: Choose Report Type

| Type | Description |
|------|-------------|
| `ActualCost` | Actual billed costs including purchases |
| `AmortizedCost` | Reservation/savings plan costs spread across usage period |
| `Usage` | Usage-based cost data |

## Step 3: Set Timeframe

Use a preset timeframe (e.g., `MonthToDate`, `TheLastMonth`, `TheLastYear`) or `Custom` with a `timePeriod` object.

> ⚠️ **Warning:** Key time period guardrails:
> - **Daily granularity**: max **31 days**
> - **Monthly/None granularity**: max **12 months**
> - `Custom` timeframe **requires** a `timePeriod` object with `from` and `to` dates
> - Future dates in historical queries are silently adjusted (see guardrails for details)
>
> See [guardrails.md](./guardrails.md) for the complete set of validation rules.

## Step 4: Configure Dataset

Define granularity, aggregation, grouping, filtering, and sorting in the `dataset` object.

- **Granularity**: `None`, `Daily`, or `Monthly`
- **Aggregation**: Use `Sum` on `Cost` or `PreTaxCost` for total cost
- **Grouping**: Up to **2** `GroupBy` dimensions (e.g., `ServiceName`, `ResourceGroupName`)
- **Filtering**: Use `dimensions` or `tags` filters with `name`, `operator` (`In`, `Equal`, `Contains`), and `values` fields
- **Sorting**: Order results by cost or dimension columns

> 💡 **Tip:** Not all dimensions are available at every scope. See [dimensions-by-scope.md](./dimensions-by-scope.md) for the availability matrix.

For the full request body schema, see [request-body-schema.md](./request-body-schema.md).

## Step 5: Construct and Execute the API Call

Use `az rest` to call the Cost Management Query API.

**Create cost query file:**

Create `temp/cost-query.json` with:
```json
{
  "type": "ActualCost",
  "timeframe": "MonthToDate",
  "dataset": {
    "granularity": "None",
    "aggregation": {
      "totalCost": {
        "name": "Cost",
        "function": "Sum"
      }
    },
    "grouping": [
      {
        "type": "Dimension",
        "name": "ServiceName"
      }
    ]
  }
}
```

**Execute cost query:**
```powershell
# Create temp folder
New-Item -ItemType Directory -Path "temp" -Force

# Query using REST API (more reliable than az costmanagement query)
az rest --method post `
  --url "<scope>/providers/Microsoft.CostManagement/query?api-version=2023-11-01" `
  --headers "ClientType=GitHubCopilotForAzure" `
  --body '@temp/cost-query.json'
```

## Step 6: Handle Pagination and Errors

- The API returns a maximum of **5,000 rows** per page (default: 1,000).
- If `nextLink` is present in the response, follow it to retrieve additional pages.
- Handle rate limiting (HTTP 429) by checking all `x-ms-ratelimit-microsoft.costmanagement-*-retry-after` headers in the response. Wait for the longest value before retrying. Do not send further requests to the same scope until the retry-after duration has elapsed.

See [error-handling.md](./error-handling.md) for the full error reference.

## Key Guardrails

| Rule | Constraint |
|------|-----------|
| Daily granularity max range | 31 days |
| Monthly/None granularity max range | 12 months |
| Absolute API max range | 37 months |
| Max GroupBy dimensions | 2 |
| ResourceId grouping scope | Subscription and resource group only — not supported at billing account, management group, or higher scopes |
| Max rows per page | 5,000 |
| Custom timeframe | Requires `timePeriod` with `from`/`to` |
| Filter and/or | Must have at least 2 expressions |

## Examples

**Cost by service for the current month:**

```powershell
az rest --method post `
  --url "/subscriptions/<subscription-id>/providers/Microsoft.CostManagement/query?api-version=2023-11-01" `
  --headers "ClientType=GitHubCopilotForAzure" `
  --body '{
    "type": "ActualCost",
    "timeframe": "MonthToDate",
    "dataset": {
      "granularity": "None",
      "aggregation": {
        "totalCost": { "name": "Cost", "function": "Sum" }
      },
      "grouping": [
        { "type": "Dimension", "name": "ServiceName" }
      ]
    }
  }'
```

For more examples including daily trends, tag-based filtering, and multi-dimension queries, see [examples.md](./examples.md).

## Error Handling

| HTTP Status | Error | Remediation |
|-------------|-------|-------------|
| 400 | Invalid request body | Check schema, date ranges, and dimension compatibility. |
| 401 | Unauthorized | Verify authentication (`az login`). |
| 403 | Forbidden | Ensure Cost Management Reader role on scope. |
| 404 | Scope not found | Verify scope URL and resource IDs. |
| 429 | Too many requests | Check all `x-ms-ratelimit-microsoft.costmanagement-*-retry-after` headers (`qpu`, `entity`, `tenant`). Wait for the **longest** value. **Max 3 retries.** |
| 503 | Service unavailable | Check [Azure Status](https://status.azure.com). |

See [error-handling.md](./error-handling.md) for detailed error handling including rate limit headers and retry strategies.
