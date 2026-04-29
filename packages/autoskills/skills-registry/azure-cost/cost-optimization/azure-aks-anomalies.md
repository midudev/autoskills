# AKS Cost Anomaly Investigation

Investigate user-reported cost or utilization spikes by correlating Azure Monitor metrics, scaling events, and Cost Management data.

## Step 1 - Confirm Timeframe

Ask the user: "When did you notice the spike? (e.g., 'last Tuesday', 'between 2 AM and 4 AM yesterday')"

## Step 2 - Pull Cost Data

```bash
az rest --method post \
  --url "https://management.azure.com/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.CostManagement/query?api-version=2023-11-01" \
  --headers "ClientType=GitHubCopilotForAzure" \
  --body '{
    "type": "ActualCost",
    "timeframe": "Custom",
    "timePeriod": { "from": "<start-date>", "to": "<end-date>" },
    "dataset": {
      "granularity": "Daily",
      "aggregation": { "totalCost": { "name": "Cost", "function": "Sum" } },
      "grouping": [{ "type": "Dimension", "name": "ResourceId" }]
    }
  }'
```

## Step 3 - Pull Node Count and Scaling Events

```bash
# First, verify available metrics on your AKS resource
az monitor metrics list-definitions \
  --resource "<aks-resource-id>" \
  --output table

# Node count over the anomaly window (use metric name from list-definitions output)
az monitor metrics list \
  --resource "<aks-resource-id>" \
  --metrics "<verified-node-count-metric>" \
  --interval PT5M --aggregation Count \
  --start-time "<start-date>" --end-time "<end-date>"

# HPA scaling events
kubectl get events --all-namespaces \
  --field-selector reason=SuccessfulRescale \
  --sort-by='.lastTimestamp'
```

## Step 4 - Top Consumers

```bash
kubectl top nodes
kubectl top pods --all-namespaces --sort-by=cpu
```

## Common Causes

| Symptom | Likely Cause | Action |
|---------|-------------|--------|
| Node count surged off-peak | HPA/VPA misconfiguration | Review HPA min replicas |
| Single pod consuming all CPU | Memory leak or runaway process | Check logs, add resource limits |
| Cost spike on specific day | Batch job ran unexpectedly | Review CronJob schedule |
| Persistent high node count | CAS scale-down blocked | Check PodDisruptionBudgets, system pods |
| Sudden namespace cost jump | New deployment with no resource limits | Add requests/limits |

## Set Up Budget Alert

```bash
az consumption budget create \
  --budget-name "aks-monthly-budget" \
  --amount <budget-amount> \
  --time-grain Monthly \
  --start-date "<YYYY-MM-01>" \
  --end-date "<YYYY-MM-01>" \
  --resource-group "<resource-group>" \
  --threshold 80 \
  --contact-emails "<contact-email>"
```

