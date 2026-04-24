# Cost Optimization Workflow

Use this workflow when the user wants to **reduce their costs** — find waste, orphaned resources, rightsizing opportunities.

> **Important:** Always present the total bill and cost breakdown (from the [Cost Query Workflow](../cost-query/workflow.md)) alongside optimization recommendations.

## Step 0: Validate Prerequisites

**Required Tools:**
- Azure CLI installed and authenticated (`az login`)
- Azure CLI extensions: `costmanagement`, `resource-graph`
- Azure Quick Review (azqr) installed — See [Azure Quick Review](./azure-quick-review.md)

**Required Permissions:**
- Cost Management Reader role
- Monitoring Reader role
- Reader role on subscription/resource group

**Verification commands:**
```powershell
az --version
az account show
az extension show --name costmanagement
azqr version
```

## Step 1: Load Best Practices

```javascript
azure__get_azure_bestpractices({
  intent: "Get cost optimization best practices",
  command: "get_bestpractices",
  parameters: { resource: "cost-optimization", action: "all" }
})
```

## Step 1.5: Redis-Specific Analysis (Conditional)

**If the user specifically requests Redis cost optimization**, use the specialized Redis reference:

**Reference**: [Azure Redis Cost Optimization](./services/redis/azure-cache-for-redis.md)

**When to use:**
- User mentions "Redis", "Azure Cache for Redis", or "Azure Managed Redis"
- Focus is on Redis resource optimization, not general subscription analysis

> 💡 **Note:** For general subscription-wide optimization, continue with Step 2. For Redis-only analysis, follow the Redis reference document.

## Step 1.6: Choose Analysis Scope (for Redis-specific analysis)

**If performing Redis cost optimization**, ask the user to select:
1. **Specific Subscription ID**
2. **Subscription Name**
3. **Subscription Prefix** (e.g., "CacheTeam")
4. **All My Subscriptions**
5. **Tenant-wide**

Wait for user response before proceeding.

## Step 1.7: AKS-Specific Analysis (Conditional)

**If the user specifically requests AKS cost optimization**, use the specialized AKS reference files:

**When to use AKS-specific analysis:**
- User mentions "AKS", "Kubernetes", "cluster", "node pool", "pod", or "kubectl"
- User wants to enable the AKS cost analysis add-on or namespace cost visibility
- User reports a cost spike, unusual cluster utilization, or wants budget alerts

**Tool Selection:**
- **Prefer MCP first**: Use `azure__aks` for AKS operations (list clusters, get node pools, inspect configuration) — it provides richer metadata and is consistent with AKS skill conventions in this repo
- **Fall back to CLI**: Use `az aks` and `kubectl` only when the specific operation cannot be performed via the MCP surface

**Reference files (load only what is needed for the request):**
- [Cost Analysis Add-on](./azure-aks-cost-addon.md) — enable namespace-level cost visibility
- [Anomaly Investigation](./azure-aks-anomalies.md) — cost spikes, scaling events, budget alerts

> **Note**: For general subscription-wide cost optimization (including AKS resource groups), continue with Step 2. For AKS-focused analysis, follow the instructions in the relevant reference file above.

## Step 1.8: Choose Analysis Scope (for AKS-specific analysis)

**If performing AKS cost optimization**, ask the user to select their analysis scope:

**Prompt the user with these options:**
1. **Specific Cluster Name** - Analyze a single AKS cluster
2. **Resource Group** - Analyze all clusters in a resource group
3. **Subscription ID** - Analyze all clusters in a subscription
4. **All My Clusters** - Scan all accessible clusters across subscriptions

Wait for user response before proceeding to Step 2.

## Step 2: Run Azure Quick Review

Run azqr to find orphaned resources (immediate cost savings):

**Reference**: [Azure Quick Review](./azure-quick-review.md)

```yaml
azure__extension_azqr
  subscription: "<SUBSCRIPTION_ID>"
  resource-group: "<RESOURCE_GROUP>"  # optional
```

**What to look for:**
- Orphaned resources: unattached disks, unused NICs, idle NAT gateways
- Over-provisioned resources: excessive retention periods, oversized SKUs
- Missing cost tags

## Step 3: Discover Resources

Use Azure Resource Graph for efficient cross-subscription resource discovery. See [Azure Resource Graph Queries](./azure-resource-graph.md) for orphaned resource detection patterns.

```powershell
az account show
az resource list --subscription "<SUBSCRIPTION_ID>" --resource-group "<RESOURCE_GROUP>"
```

## Step 4: Query Actual Costs

Get actual cost data from Azure Cost Management API (last 30 days). Use the [Cost Query Workflow](../cost-query/workflow.md) with this configuration:

**Create `temp/cost-query.json`:**
```json
{
  "type": "ActualCost",
  "timeframe": "Custom",
  "timePeriod": {
    "from": "<START_DATE>",
    "to": "<END_DATE>"
  },
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
        "name": "ResourceId"
      }
    ]
  }
}
```

> **Action Required**: Calculate `<START_DATE>` (30 days ago) and `<END_DATE>` (today) in ISO 8601 format.

**Execute and save results to `output/cost-query-result<timestamp>.json`.** Always include the `--headers "ClientType=GitHubCopilotForAzure"` header in all Cost Management API requests.

> 💡 **Tip:** Also run a cost-by-service query (grouping by `ServiceName`) to present the total bill breakdown alongside optimization recommendations. See [examples.md](../cost-query/examples.md).

> ⚠️ **Warning:** Sequential queries to the same scope share the per-scope rate limit (4 requests/minute). If a 429 response is received, check all `x-ms-ratelimit-microsoft.costmanagement-*-retry-after` headers and do not send further requests until the longest retry-after duration has elapsed.

## Step 5: Validate Pricing

Fetch current pricing from official Azure pricing pages using `fetch_webpage`:

**Key services to validate:**
- Container Apps: https://azure.microsoft.com/pricing/details/container-apps/
- Virtual Machines: https://azure.microsoft.com/pricing/details/virtual-machines/
- App Service: https://azure.microsoft.com/pricing/details/app-service/
- Log Analytics: https://azure.microsoft.com/pricing/details/monitor/

> **Important**: Check for free tier allowances — many Azure services have generous free limits.

## Step 6: Collect Utilization Metrics

Query Azure Monitor for utilization data (last 14 days) to support rightsizing recommendations:

```powershell
$startTime = (Get-Date).AddDays(-14).ToString("yyyy-MM-ddTHH:mm:ssZ")
$endTime = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"

# VM CPU utilization
az monitor metrics list `
  --resource "<RESOURCE_ID>" `
  --metric "Percentage CPU" `
  --interval PT1H `
  --aggregation Average `
  --start-time $startTime `
  --end-time $endTime
```

## Step 7: Generate Optimization Report

Generate a report to `output/costoptimizereport<YYYYMMDD_HHMMSS>.md` that includes an executive summary, cost breakdown by service, free tier analysis, orphaned resources, prioritized optimization recommendations, and implementation commands. Save cost query results to `output/cost-query-result<YYYYMMDD_HHMMSS>.json` for audit trail, then clean up temporary files.

For the complete report template, see [report-template.md](./report-template.md).
