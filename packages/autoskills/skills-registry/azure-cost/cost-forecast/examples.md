# Forecast API Examples

Common forecast patterns with request bodies. Use the [SKILL.md workflow](../SKILL.md) to construct and execute the `az rest` command.

## 1. Forecast Rest of Current Month (Daily)

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
    "sorting": [
      { "direction": "Ascending", "name": "UsageDate" }
    ]
  },
  "includeActualCost": true,
  "includeFreshPartialCost": true
}
```

> 💡 **Tip:** Set `from` to the first of the month — the response contains `Actual` rows up to today and `Forecast` rows for remaining days.

---

## 2. Forecast Next 3 Months (Monthly)

```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "<first-of-month>",
    "to": "<3-months-out>"
  },
  "dataset": {
    "granularity": "Monthly",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "sorting": [
      { "direction": "Ascending", "name": "BillingMonth" }
    ]
  },
  "includeActualCost": true,
  "includeFreshPartialCost": true
}
```

> 💡 **Tip:** Monthly granularity uses the `BillingMonth` column in the response.

---

## 3. Forecast for Resource Group Scope

```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "<start-date>",
    "to": "<end-date>"
  },
  "dataset": {
    "granularity": "Daily",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "sorting": [
      { "direction": "Ascending", "name": "UsageDate" }
    ]
  },
  "includeActualCost": true,
  "includeFreshPartialCost": true
}
```

> 💡 **Tip:** Scope is set at the URL level. Use the resource group scope URL to limit the forecast.

---

## 4. Forecast for Billing Account Scope

```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "<start-date>",
    "to": "<end-date>"
  },
  "dataset": {
    "granularity": "Monthly",
    "aggregation": {
      "totalCost": { "name": "Cost", "function": "Sum" }
    },
    "sorting": [
      { "direction": "Ascending", "name": "BillingMonth" }
    ]
  },
  "includeActualCost": true,
  "includeFreshPartialCost": true
}
```

> 💡 **Tip:** Use URL pattern `/providers/Microsoft.Billing/billingAccounts/<id>/...`. Monthly granularity recommended for billing account forecasts.

---

## Scope URL Reference

| Scope | URL Pattern |
|---|---|
| Subscription | `/subscriptions/<subscription-id>/providers/Microsoft.CostManagement/forecast` |
| Resource Group | `/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.CostManagement/forecast` |
| Billing Account | `/providers/Microsoft.Billing/billingAccounts/<id>/providers/Microsoft.CostManagement/forecast` |

> 💡 **Tip:** These are path-only patterns — not complete URLs. Append `?api-version=2023-11-01` when constructing the full request URL.
