# Cost Forecast Workflow

Use this workflow when the user wants to **project future costs**.

> ⚠️ **Warning:** If the user wants **historical** cost data, use the [Cost Query Workflow](../cost-query/workflow.md). If they want to **reduce** costs, use the [Cost Optimization Workflow](../cost-optimization/workflow.md).

## Key Differences from Query API

| Aspect | Query API | Forecast API |
|--------|-----------|--------------|
| Purpose | Historical cost data | Projected future costs |
| Time period | Past dates only | Must include future dates |
| Grouping | Up to 2 dimensions | **Not supported** |
| `includeActualCost` | N/A | Include historical alongside forecast |
| Response columns | Cost, Date, Currency | Cost, Date, **CostStatus**, Currency |
| Max response rows | 5,000/page | 40 rows recommended |
| Timeframe | Multiple presets + Custom | Typically `Custom` only |

## Step 1: Determine Scope

Use the same scope patterns from the Scope Reference table in the main [SKILL.md](../SKILL.md#scope-reference-shared-across-all-workflows).

## Step 2: Choose Report Type

`ActualCost` is most common for forecasting. `AmortizedCost` for reservation/savings plan projections.

## Step 3: Set Time Period

> ⚠️ **Warning:** The `to` date **MUST** be in the future.

- Set `timeframe` to `Custom` and provide `timePeriod` with `from` and `to` dates
- `from` can be in the past — shows actual costs up to today, then forecast to `to`
- Minimum 28 days of historical cost data required
- Maximum forecast period: 10 years

> **Full rules:** [Forecast Guardrails](./guardrails.md)

## Step 4: Configure Dataset

- **Granularity**: `Daily` or `Monthly` recommended
- **Aggregation**: Typically `Sum` of `Cost`
- See [Forecast Request Body Schema](./request-body-schema.md) for full schema

> ⚠️ **Warning:** Grouping is **NOT supported** for forecast. Suggest using the [Cost Query Workflow](../cost-query/workflow.md) for grouped historical data instead.

## Step 5: Set Forecast-Specific Options

| Field | Default | Description |
|-------|---------|-------------|
| `includeActualCost` | `true` | Include historical actual costs alongside forecast |
| `includeFreshPartialCost` | `true` | Include partial cost data for recent days. **Requires `includeActualCost: true`** |

## Step 6: Construct and Execute

**Create `temp/cost-forecast.json`:**
```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "<first-of-month>",
    "to": "<last-of-month>"
  },
  "dataset": {
    "granularity": "Daily",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "sorting": [{ "direction": "Ascending", "name": "UsageDate" }]
  },
  "includeActualCost": true,
  "includeFreshPartialCost": true
}
```

**Execute:**
```powershell
New-Item -ItemType Directory -Path "temp" -Force

az rest --method post `
  --url "/subscriptions/<subscription-id>/providers/Microsoft.CostManagement/forecast?api-version=2023-11-01" `
  --headers "ClientType=GitHubCopilotForAzure" `
  --body '@temp/cost-forecast.json'
```

## Step 7: Interpret Response

| CostStatus | Meaning |
|------------|---------|
| `Actual` | Historical actual cost (when `includeActualCost: true`) |
| `Forecast` | Projected future cost |

> 💡 **Tip:** "Forecast is unavailable for the specified time period" is not an error — it means the scope has insufficient historical data. Suggest using the [Cost Query Workflow](../cost-query/workflow.md) for available data.

## Key Guardrails

| Rule | Constraint |
|------|-----------|
| `to` date | Must be in the future |
| Grouping | Not supported |
| Min training data | 28 days of historical cost data |
| Max forecast period | 10 years |
| Response row limit | 40 rows recommended |
| `includeFreshPartialCost` | Requires `includeActualCost: true` |
| Monthly + includeActualCost | Requires explicit `timePeriod` |

> **Full details:** [Forecast Guardrails](./guardrails.md)

## Error Handling

| Status | Error | Remediation |
|--------|-------|-------------|
| 400 | Can't forecast on the past | Ensure `to` date is in the future. |
| 400 | Missing dataset | Add required `dataset` field. |
| 400 | Invalid dependency | Set `includeActualCost: true` when using `includeFreshPartialCost`. |
| 403 | Forbidden | Needs **Cost Management Reader** role on scope. |
| 424 | Bad training data | Insufficient history; falls back to actual costs if available. |
| 429 | Rate limited | Check all `x-ms-ratelimit-microsoft.costmanagement-*-retry-after` headers (`qpu`, `entity`, `tenant`). Wait for the **longest** value. **Max 3 retries.** |
| 503 | Service unavailable | Check [Azure Status](https://status.azure.com). |

> **Full details:** [Forecast Error Handling](./error-handling.md)

For more forecast examples, see [forecast examples](./examples.md).
