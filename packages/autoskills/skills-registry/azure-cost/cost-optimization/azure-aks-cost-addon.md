# AKS Cost Analysis Add-on

Enable namespace-level cost visibility using the built-in AKS cost monitoring add-on.

## Check Status

```bash
# Check if add-on is enabled
az aks show \
  --name "<cluster-name>" --resource-group "<resource-group>" \
  --query "addonProfiles.costAnalysis" -o json

# Check cluster tier (add-on requires Standard or Premium)
az aks show \
  --name "<cluster-name>" --resource-group "<resource-group>" \
  --query "{tier:sku.tier, name:name}" -o table
```

## Enable Add-on

```bash
# Requires Standard or Premium tier
az aks update \
  --name "<cluster-name>" --resource-group "<resource-group>" \
  --enable-cost-analysis
```

## If Cluster is Free Tier

Warn user that upgrading from Free to Standard introduces an ongoing cluster management fee. Use the official AKS pricing page or this skill’s pricing validation step to confirm the current cost with the user and obtain explicit approval before proceeding. After user approval:

```bash
az aks update \
  --name "<cluster-name>" --resource-group "<resource-group>" \
  --tier standard

az aks update \
  --name "<cluster-name>" --resource-group "<resource-group>" \
  --enable-cost-analysis
```

## After Enabling

Namespace-level cost data is available in:
- Azure Portal: AKS cluster -> Cost Analysis blade
- Azure Cost Management: filter by cluster resource ID + `kubernetes namespace` dimension

> Risk: Low for enabling the add-on. Upgrading tier (Free -> Standard) has a cost — always confirm with user first.
