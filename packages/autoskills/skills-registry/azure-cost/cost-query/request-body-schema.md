# Cost Management Query API — Request Body Schema

Schema for the [Cost Management Query API](https://learn.microsoft.com/en-us/rest/api/cost-management/query/usage).

## Request Body Structure

```json
{
  "type": "<report-type>",
  "timeframe": "<timeframe>",
  "timePeriod": { "from": "2024-01-01T00:00:00Z", "to": "2024-01-31T23:59:59Z" },
  "dataset": {
    "granularity": "<granularity>",
    "aggregation": { "<alias>": { "name": "<column>", "function": "<function>" } },
    "grouping": [{ "type": "<column-type>", "name": "<column-name>" }],
    "filter": { "<filter-expression>" },
    "sorting": [{ "direction": "<direction>", "name": "<column>" }]
  }
}
```

## Top-Level Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | string | Yes | `ActualCost`, `AmortizedCost`, or `Usage` |
| `timeframe` | string | Yes | Predefined or `Custom` time window |
| `timePeriod` | object | Conditional | Required when `timeframe` is `Custom`. Contains `from`/`to` ISO 8601 dates. |
| `dataset` | object | Yes | Defines granularity, aggregation, grouping, filtering, sorting |

### Timeframe Values

`WeekToDate` · `MonthToDate` · `BillingMonthToDate` · `YearToDate` · `TheLastWeek` · `TheLastMonth` · `TheLastBillingMonth` · `TheLastYear` · `TheLast7Days` · `TheLast3Months` · `Custom`

## Dataset Fields

### Granularity

| Value | Max Range | Description |
|-------|-----------|-------------|
| `None` | 12 months | Aggregated total, no date breakdown |
| `Daily` | 31 days | Day-by-day breakdown |
| `Monthly` | 12 months | Month-by-month breakdown |

### Aggregation

```json
"aggregation": { "totalCost": { "name": "Cost", "function": "Sum" } }
```

| Field | Required | Description |
|-------|----------|-------------|
| `<alias>` (key) | Yes | Output column alias (e.g., `totalCost`) |
| `name` | Yes | Source column: `Cost`, `PreTaxCost`, or `UsageQuantity` |
| `function` | Yes | `Sum` (only supported function for cost queries) |

### Grouping

```json
"grouping": [
  { "type": "Dimension", "name": "ServiceName" },
  { "type": "TagKey", "name": "Environment" }
]
```

- `type`: `Dimension` (built-in) or `TagKey` (resource tag)
- Maximum **2** GroupBy dimensions per query. No duplicates.

### Filter

Filter expressions restrict which cost records are included. Filters support logical operators (`and`, `or`, `not`) and comparison operators on dimensions or tags.

#### Filter Expression Structure

```json
"filter": {
  "and": [
    {
      "dimensions": {
        "name": "ResourceGroupName",
        "operator": "In",
        "values": ["rg-prod", "rg-staging"]
      }
    },
    {
      "not": {
        "tags": {
          "name": "Environment",
          "operator": "Equal",
          "values": ["dev"]
        }
      }
    }
  ]
}
```

#### Logical Operators

| Operator | Description | Children |
|----------|-------------|----------|
| `and` | All child expressions must match. | 2 or more expressions. |
| `or` | Any child expression must match. | 2 or more expressions. |
| `not` | Negates a single child expression. | Exactly 1 expression. |

> ⚠️ **Warning:** `and` and `or` must contain at least 2 child expressions. `not` must contain exactly 1.

#### Comparison Operators (ComparisonOperator Enum)

| Operator | Description | Example |
|----------|-------------|---------|
| `In` | Value is in the provided list. Supports multiple values. | `"values": ["vm", "storage"]` |
| `Equal` | Exact match against a single value. | `"values": ["production"]` |
| `Contains` | String contains the specified substring. | `"values": ["prod"]` |
| `LessThan` | Numeric less-than comparison. | `"values": ["100"]` |
| `GreaterThan` | Numeric greater-than comparison. | `"values": ["0"]` |
| `NotEqual` | Value does not match the specified value. | `"values": ["dev"]` |

#### Filter Target Types

| Target | Description |
|--------|-------------|
| `dimensions` | Filter on built-in dimensions (e.g., `ResourceGroupName`, `ServiceName`). |
| `tags` | Filter on Azure resource tags (e.g., `Environment`, `CostCenter`). |

### Sorting

```json
"sorting": [
  { "direction": "Descending", "name": "Cost" }
]
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `direction` | string | Yes | `Ascending` or `Descending`. |
| `name` | string | Yes | Column name to sort by (must be present in aggregation or grouping). |

## Response Structure

```json
{
  "id": "<query-id>",
  "name": "<query-name>",
  "type": "Microsoft.CostManagement/query",
  "properties": {
    "nextLink": "<url-for-next-page-or-null>",
    "columns": [
      { "name": "Cost", "type": "Number" },
      { "name": "ServiceName", "type": "String" },
      { "name": "UsageDate", "type": "Number" },
      { "name": "Currency", "type": "String" }
    ],
    "rows": [
      [123.45, "Virtual Machines", 20240115, "USD"],
      [67.89, "Storage", 20240115, "USD"]
    ]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| `columns` | array | Array of column definitions with `name` and `type`. |
| `columns[].name` | string | Column name. |
| `columns[].type` | string | Data type: `Number` or `String`. |
| `rows` | array | Array of row arrays. Values ordered to match `columns`. |
| `nextLink` | string | URL for next page of results, or `null` if no more pages. |

> 💡 **Tip:** `UsageDate` is returned as a number in `YYYYMMDD` format (e.g., `20240115`) when granularity is `Daily` or `Monthly`.
