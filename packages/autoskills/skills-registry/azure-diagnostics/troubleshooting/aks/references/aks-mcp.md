# AKS MCP Reference

Use this reference when AKS-aware MCP tools are available in the client.

## Preference Order

1. `mcp_azure_mcp_aks`
2. The AKS-MCP tools that surface after discovery in the client
3. Supporting Azure tools such as `mcp_azure_mcp_applens`, `mcp_azure_mcp_monitor`, and `mcp_azure_mcp_resourcehealth`
4. Raw `az aks` and `kubectl` only when required functionality is missing from MCP

## Happy Path

After selecting `mcp_azure_mcp_aks`, let the client enumerate the exact AKS-MCP tools it exposes and choose the smallest tool that fits the task.

Favor the obvious read paths first:

- cluster and Azure-side inspection
- detector or diagnostic workflows
- monitoring, metrics, or control-plane-log checks
- kubectl-style read operations

## Authentication And Access

AKS-MCP is Azure CLI-backed. Expect service principal, workload identity, managed identity, or existing `az login` auth, usually keyed by `AZURE_CLIENT_ID`. If `AZURE_SUBSCRIPTION_ID` is set, expect the server to select that subscription after login.

Default to `readonly`. Only suggest `readwrite` or `admin` when the current diagnostic step truly requires it.

## Detector Notes

For detector-style workflows, use the cluster resource ID, keep the time window within the last 30 days, cap each run to 24 hours, and stay within the supported AKS detector categories.

## Fallback Rule

If the client does not expose the AKS-MCP surface needed for a check, then fall back to:

- `az aks` for Azure-side AKS operations
- raw `kubectl` for Kubernetes-side inspection
