---
name: azure-cost
description: "Unified Azure cost management: query historical costs, forecast future spending, and optimize to reduce waste. WHEN: \"Azure costs\", \"Azure spending\", \"Azure bill\", \"cost breakdown\", \"cost by service\", \"cost by resource\", \"how much am I spending\", \"show my bill\", \"monthly cost summary\", \"cost trends\", \"top cost drivers\", \"actual cost\", \"amortized cost\", \"forecast spending\", \"projected costs\", \"estimate bill\", \"future costs\", \"budget forecast\", \"end of month costs\", \"how much will I spend\", \"optimize costs\", \"reduce spending\", \"find cost savings\", \"orphaned resources\", \"rightsize VMs\", \"cost analysis\", \"reduce waste\", \"unused resources\", \"optimize Redis costs\", \"cost by tag\", \"cost by resource group\", \"AKS cost analysis add-on\", \"namespace cost\", \"cost spike\", \"anomaly\", \"budget alert\", \"AKS cost visibility\". DO NOT USE FOR: deploying resources, provisioning infrastructure, diagnostics, security audits, or estimating costs for new resources not yet deployed."
license: MIT
metadata:
  author: Microsoft
  version: "0.0.0-placeholder"
---

# Azure Cost Management Skill

Unified skill for all Azure cost management tasks: querying historical costs, forecasting future spending, and optimizing to reduce waste.

## When to Use This Skill

Activate this skill when user wants to:
- Query or analyze Azure costs (how much am I spending, show my bill, cost breakdown)
- Break down costs by service, resource, location, or tag
- Analyze cost trends over time
- Forecast future Azure spending or project end-of-month costs
- Optimize Azure costs, reduce spending, or find savings
- Find orphaned or unused resources
- Rightsize Azure VMs, containers, or services
- Generate cost optimization reports

## Quick Reference

| Property | Value |
|----------|-------|
| **Query API Endpoint** | `POST {scope}/providers/Microsoft.CostManagement/query?api-version=2023-11-01` |
| **Forecast API Endpoint** | `POST {scope}/providers/Microsoft.CostManagement/forecast?api-version=2023-11-01` |
| **MCP Tools** | `azure__documentation`, `azure__extension_cli_generate`, `azure__get_azure_bestpractices` |
| **CLI** | `az rest`, `az monitor metrics list`, `az resource list` |
| **Required Role** | Cost Management Reader + Monitoring Reader + Reader on scope |

## MCP Tools

| Tool | Description | Parameters | When to Use |
|------|-------------|------------|-------------|
| `azure__documentation` | Search Azure documentation | `query` (Required): search terms | Research Cost Management API parameters and options |
| `azure__extension_cli_generate` | Generate Azure CLI commands | `intent` (Required): task description, `cli-type` (Required): `"az"` | Construct `az rest` commands for cost queries |
| `azure__get_azure_bestpractices` | Get Azure best practices | `intent` (Required): optimization context | Inform query design with cost management best practices |
| `azure__extension_azqr` | Run Azure Quick Review compliance scan | `subscription` (Required): subscription ID, `resource-group` (Optional): resource group name | Find orphaned resources and cost optimization opportunities |
| `azure__aks` | Azure Kubernetes Service operations | varies by sub-command | AKS cost analysis: list clusters, get node pools, inspect configuration |

> 💡 **Tip:** Prefer MCP tools over direct CLI commands. Use `az rest` only when MCP tools don't cover the specific operation.

---

## Routing

Read the user's request and follow the appropriate workflow below.

| User Intent | Workflow | Example Prompts |
|-------------|----------|-----------------|
| Understand current costs | [Cost Query Workflow](cost-query/workflow.md) | "how much am I spending", "cost by service", "show my bill" |
| Reduce costs / find waste | [Cost Optimization Workflow](cost-optimization/workflow.md) | "optimize costs", "find orphaned resources", "reduce spending" |
| Project future costs | [Cost Forecast Workflow](cost-forecast/workflow.md) | "forecast costs", "end of month estimate", "how much will I spend" |
| Full cost picture | All three workflows combined | "give me the full picture of my Azure costs" |

> **Important:** When optimizing costs, always present the total bill and cost breakdown alongside optimization recommendations.

---

## Scope Reference (Shared Across All Workflows)

| Scope | URL Pattern |
|-------|-------------|
| Subscription | `/subscriptions/<subscription-id>` |
| Resource Group | `/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>` |
| Management Group | `/providers/Microsoft.Management/managementGroups/<management-group-id>` |
| Billing Account | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>` |
| Billing Profile | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>/billingProfiles/<billing-profile-id>` |

> 💡 **Tip:** These are scope paths only — not complete URLs. Combine with the API endpoint and version.

---

## Part 1: Cost Query Workflow

For the full cost query workflow (scope selection, report types, timeframes, dataset configuration, API calls, pagination, guardrails, examples, and error handling), see:

📄 **[Cost Query Workflow](cost-query/workflow.md)**

---

## Part 2: Cost Optimization Workflow

For the full cost optimization workflow (prerequisites, best practices, Redis/AKS-specific analysis, Azure Quick Review, resource discovery, cost queries, pricing validation, utilization metrics, and report generation), see:

📄 **[Cost Optimization Workflow](cost-optimization/workflow.md)**

---

## Part 3: Cost Forecast Workflow

For the full cost forecast workflow (scope selection, time period rules, dataset configuration, forecast-specific options, API calls, response interpretation, guardrails, and error handling), see:

📄 **[Cost Forecast Workflow](cost-forecast/workflow.md)**

---

## Data Classification

- **ACTUAL DATA** = Retrieved from Azure Cost Management API
- **ACTUAL METRICS** = Retrieved from Azure Monitor
- **VALIDATED PRICING** = Retrieved from official Azure pricing pages
- **ESTIMATED SAVINGS** = Calculated based on actual data and validated pricing

## Best Practices

- Always query actual costs first — never estimate or assume
- Always present the total bill alongside optimization recommendations
- Validate pricing from official sources — account for free tiers
- Use REST API for cost queries (more reliable than `az costmanagement query`)
- Always include the `ClientType: GitHubCopilotForAzure` header on all Cost Management API requests (`--headers "ClientType=GitHubCopilotForAzure"` in `az rest`)
- Save audit trail — include all queries and responses
- Include Azure Portal links for all resources
- For costs < $10/month, emphasize operational improvements over financial savings
- Never execute destructive operations without explicit approval
- On 429 responses, check all `x-ms-ratelimit-microsoft.costmanagement-*-retry-after` headers (`qpu-retry-after`, `entity-retry-after`, `tenant-retry-after`), wait for the longest value, and do not retry until that duration has elapsed. The per-scope limit (4 requests/minute) is the most restrictive.

## Common Pitfalls

- **Assuming costs**: Always query actual data from Cost Management API
- **Ignoring free tiers**: Many services have generous allowances
- **Using wrong date ranges**: 30 days for costs, 14 days for utilization
- **Not showing the bill**: Always present cost breakdown alongside optimization recommendations
- **Cost query failures**: Use `az rest` with JSON body, not `az costmanagement query`

## Safety Requirements

- Get approval before deleting resources
- Test changes in non-production first
- Provide dry-run commands for validation
- Include rollback procedures

## SDK Quick References

- **Redis Management**: [.NET](cost-optimization/sdk/azure-resource-manager-redis-dotnet.md)
