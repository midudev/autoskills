# Forecast API Request Body Schema

## Complete JSON Schema

```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "2024-01-01T00:00:00Z",
    "to": "2024-03-31T00:00:00Z"
  },
  "dataset": {
    "granularity": "Daily",
    "aggregation": {
      "totalCost": {
        "name": "Cost",
        "function": "Sum"
      }
    },
    "sorting": [
      {
        "direction": "Ascending",
        "name": "UsageDate"
      }
    ],
    "filter": {
      "dimensions": {
        "name": "ResourceGroupName",
        "operator": "In",
        "values": ["my-resource-group"]
      }
    }
  },
  "includeActualCost": true,
  "includeFreshPartialCost": true
}
```

## Field Reference

| Field | Type | Required | Values | Description |
|---|---|---|---|---|
| `type` | string | ✅ | `ActualCost`, `AmortizedCost`, `Usage` | Cost type for the forecast |
| `timeframe` | string | ✅ | `Custom` | Must be `Custom` for forecast requests |
| `timePeriod` | object | ✅ | — | Start and end dates for the forecast window |
| `timePeriod.from` | string | ✅ | ISO 8601 datetime | Start date; can be in the past to include actuals |
| `timePeriod.to` | string | ✅ | ISO 8601 datetime | End date; **must be in the future** for forecast |
| `dataset` | object | ✅ | — | Dataset configuration for the forecast |
| `dataset.granularity` | string | ✅ | `Daily`, `Monthly` | Time granularity of forecast results |
| `dataset.aggregation` | object | ✅ | — | Aggregation functions to apply |
| `dataset.aggregation.totalCost.name` | string | ✅ | `Cost` | Column name to aggregate |
| `dataset.aggregation.totalCost.function` | string | ✅ | `Sum` | Aggregation function |
| `dataset.sorting` | array | Optional | — | Sort order for results |
| `dataset.sorting[].direction` | string | Optional | `Ascending`, `Descending` | Sort direction |
| `dataset.sorting[].name` | string | Optional | `UsageDate` | Column to sort by |
| `dataset.filter` | object | Optional | — | Filter expression (dimensions/tags) |
| `includeActualCost` | boolean | Optional | `true`, `false` | Include historical actual costs alongside forecast. Default: `true` |
| `includeFreshPartialCost` | boolean | Optional | `true`, `false` | Include partial cost data for recent days. Default: `true`. **Requires `includeActualCost=true`** |

## Forecast-Specific Fields

### `includeActualCost`

- **Type:** boolean
- **Default:** `true`
- When `true`, the response includes historical actual cost rows from the `from` date up to today, alongside projected forecast rows from today to the `to` date.
- When `false`, only forecast (projected) rows are returned.

### `includeFreshPartialCost`

- **Type:** boolean
- **Default:** `true`
- When `true`, includes partial (incomplete) cost data for the most recent days where billing data is still arriving.
- ⚠️ **Requires `includeActualCost=true`.** Setting `includeFreshPartialCost=true` without `includeActualCost=true` produces a validation error (`DontContainIncludeActualCostWhileIncludeFreshPartialCost`).

## Response Structure

### Response Columns

| Column | Type | Description |
|---|---|---|
| `Cost` | Number | The cost amount (actual or forecasted) |
| `UsageDate` / `BillingMonth` | Datetime | The date for the cost row |
| `CostStatus` | String | Indicates whether the row is historical or projected |
| `Currency` | String | Currency code (e.g., `USD`, `EUR`) |

### CostStatus Values

| Value | Meaning |
|---|---|
| `Actual` | Historical cost data (already incurred) |
| `Forecast` | Projected future cost (model prediction) |

### Granularity and Date Column Mapping

| Granularity | Date Column |
|---|---|
| `Daily` | `UsageDate` |
| `Monthly` | `BillingMonth` |

## Key Differences from Query API Request Body

| Aspect | Forecast API | Query API |
|---|---|---|
| Grouping | ❌ Not supported | ✅ Supported via `grouping` field |
| `timeframe` | Typically `Custom` only | Supports `Custom`, `MonthToDate`, `BillingMonthToDate`, etc. |
| `includeActualCost` | ✅ Forecast-specific field | ❌ Not applicable |
| `includeFreshPartialCost` | ✅ Forecast-specific field | ❌ Not applicable |
| Response `CostStatus` column | ✅ Distinguishes `Actual` vs `Forecast` rows | ❌ Not present |
| `to` date | Must be in the future | Can be any valid past/present date |
