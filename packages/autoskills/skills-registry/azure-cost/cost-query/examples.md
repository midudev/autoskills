# Cost Management Query Examples

Common query patterns with request bodies. Use the [SKILL.md workflow](../SKILL.md) to construct and execute the `az rest` command.

## 1. Monthly Cost by Service

```json
{
  "type": "ActualCost",
  "timeframe": "MonthToDate",
  "dataset": {
    "granularity": "None",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "grouping": [
      { "type": "Dimension", "name": "ServiceName" }
    ],
    "sorting": [
      { "direction": "Descending", "name": "Cost" }
    ]
  }
}
```

---

## 2. Daily Cost Trend (Last 30 Days)

```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "2024-01-01T00:00:00Z",
    "to": "2024-01-31T23:59:59Z"
  },
  "dataset": {
    "granularity": "Daily",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    }
  }
}
```

> ⚠️ **Warning:** Daily granularity supports a maximum of 31 days.

---

## 3. Cost by Resource Group with Tag Filter

```json
{
  "type": "ActualCost",
  "timeframe": "MonthToDate",
  "dataset": {
    "granularity": "None",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "grouping": [
      { "type": "Dimension", "name": "ResourceGroupName" }
    ],
    "filter": {
      "tags": {
        "name": "Environment",
        "operator": "In",
        "values": ["production", "staging"]
      }
    },
    "sorting": [
      { "direction": "Descending", "name": "Cost" }
    ]
  }
}
```

---

## 4. Amortized Cost for Reservation Analysis

```json
{
  "type": "AmortizedCost",
  "timeframe": "TheLastMonth",
  "dataset": {
    "granularity": "None",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "grouping": [
      { "type": "Dimension", "name": "BenefitName" }
    ],
    "sorting": [
      { "direction": "Descending", "name": "Cost" }
    ]
  }
}
```

> 💡 **Tip:** `AmortizedCost` spreads reservation purchases across the term for accurate daily/monthly effective cost.

---

## 5. Top 10 Most Expensive Resources

```json
{
  "type": "ActualCost",
  "timeframe": "MonthToDate",
  "dataset": {
    "granularity": "None",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "grouping": [
      { "type": "Dimension", "name": "ResourceId" }
    ],
    "sorting": [
      { "direction": "Descending", "name": "Cost" }
    ]
  }
}
```

> 💡 **Tip:** Append `&$top=10` to the URL to limit results: `...query?api-version=2023-11-01&$top=10`
