# AKS Troubleshooting Guide

Primary AKS troubleshooting guide for incidents routed from [../../SKILL.md](../../SKILL.md).

## When to Use This Guide

- lifecycle, access, node, `kube-system`, workload, ingress, DNS, or scaling issues
- `kubectl` cannot connect, nodes are `NotReady`, or pods are unhealthy

## Scenario Playbooks

| Scenario                                                      | Reference                                        |
| ------------------------------------------------------------- | ------------------------------------------------ |
| broad cluster investigation                                   | [general-diagnostics.md](general-diagnostics.md) |
| workload, crash, image pull, readiness, or pending pod issues | [pod-failures.md](pod-failures.md)               |
| node health, scaling, pressure, upgrade, or zone issues       | [node-issues.md](node-issues.md)                 |
| service, ingress, DNS, or network policy issues               | [networking.md](networking.md)                   |

## Tool Selection For Diagnostics

When gathering AKS diagnostic evidence, prefer `mcp_azure_mcp_aks`, then the smallest discovered AKS-MCP tool that fits the read, then supporting Azure tools such as `mcp_azure_mcp_applens`, `mcp_azure_mcp_monitor`, or `mcp_azure_mcp_resourcehealth`. Use raw `az aks` and `kubectl` only when the AKS-MCP surface cannot perform the needed check.

See [references/aks-mcp.md](references/aks-mcp.md), [references/structured-input-modes.md](references/structured-input-modes.md), [references/command-flows.md](references/command-flows.md)

## Required Inputs

- subscription or active Azure context
- resource group and cluster name
- symptom summary
- first observed time or recent change window
- impacted namespace, workload, service, or ingress when known

If cluster identity is missing, stop and ask for it.

## Scope Buckets

- Lifecycle: create, update, start, stop, upgrade, or provisioning failures
- API access: kubeconfig, auth, private endpoint, DNS, or reachability problems
- Nodes: missing nodes, `NotReady`, pressure, CNI, kubelet, certificate, or VMSS drift
- `kube-system`: CoreDNS, metrics-server, konnectivity, ingress, CNI, CSI, or add-on failures
- Workloads: `Pending`, `CrashLoopBackOff`, `OOMKilled`, PVC, quota, secret, readiness, or dependency issues
- Connectivity and DNS: pod -> service -> endpoints -> ingress/load balancer -> DNS -> network controls
- Scaling: node pool sizing, pending pods, autoscaler config, metrics, quota, or subnet constraints

## Evidence Order

1. Azure-side state first: cluster state, resource health, recent operations, node pool state, detector or monitoring output.
2. Kubernetes-side state second: cluster reachability, nodes, `kube-system`, events, affected namespace, pod detail, logs.
3. Use detector, warning-event, or metrics modes when the incoming data already matches them.

## Workflow

1. Get cluster context.
2. Classify the problem by scope bucket.
3. Prefer Azure-side evidence before Kubernetes-side evidence.
4. Use the matching AKS-MCP path first, then the documented CLI fallback if MCP cannot perform that read.
5. Return evidence, failure domain, confidence, next checks, remediation, and escalation.

## Error Patterns

- No cluster context: ask for subscription, resource group, and cluster name.
- MCP unavailable: fall back to safe `az aks` and `kubectl` reads.
- `kubectl` blocked: separate auth problems from network reachability.
- Logs or metrics missing: use events, node state, and resource descriptions.
- Detector noise: ignore `emergingIssues`, prefer critical findings, rank the most actionable signal first.

## Safe Fallback Checks

```bash
az aks show -g <resource-group> -n <cluster-name>
az aks nodepool list -g <resource-group> --cluster-name <cluster-name>
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -n kube-system
kubectl get events -A --sort-by=.lastTimestamp
kubectl describe pod <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace> --previous
```

Keep these read-only unless the user explicitly asks for remediation.

## Guardrails

- default to read-only diagnostics
- do not restart, delete, cordon, drain, scale, upgrade, or reconfigure resources unless the user explicitly asks for remediation
- do not conclude root cause without quoting the evidence that supports it

## Output Checklist

Return scope and impact, evidence, failure domain, root cause, confidence, next checks, remediation, and escalation.
