# General AKS Investigation & Diagnostics

## "What happened in my cluster?"

When a user asks a broad question like "what happened in my AKS cluster?" or "check my AKS status", follow this systematic flow:

```bash
# 1. Cluster health
az aks show -g <rg> -n <cluster> --query "provisioningState"

# 2. Recent events
kubectl get events -A --sort-by='.lastTimestamp' | head -40

# 3. Node status
kubectl get nodes -o wide

# 4. Unhealthy pods
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded

# 5. All pods overview
kubectl get pods -A -o wide

# 6. System pods health
kubectl get pods -n kube-system -o wide

# 7. Activity log
az monitor activity-log list -g <rg> --max-events 20 -o table
```

---

## AKS CLI Tools

```bash
# Get cluster credentials (required before kubectl commands)
az aks get-credentials -g <rg> -n <cluster>

# View node pools
az aks nodepool list -g <rg> --cluster-name <cluster> -o table
```

### AppLens (MCP) for AKS

For AI-powered diagnostics:

```text
mcp_azure_mcp_applens
  intent: "diagnose AKS cluster issues"
  command: "diagnose"
  parameters:
    resourceId: "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.ContainerService/managedClusters/<cluster>"
```

> 💡 **Tip:** AppLens automatically detects common issues and provides remediation recommendations using the cluster resource ID.

---

## Best Practices

1. **Start with kubectl get/describe** - Always check basic status first
2. **Check events** - `kubectl get events -A` reveals recent issues
3. **Use systematic isolation** - Pod -> Node -> Cluster -> Network
4. **Document changes** - Note what you tried and what worked
5. **Escalate when needed** - For control plane issues, contact Azure support
