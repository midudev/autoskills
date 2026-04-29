# AKS Command Flows

## Cluster Baseline Flow

```text
Resolve subscription -> resolve resource group -> resolve cluster -> inspect cluster state -> inspect node pools -> inspect resource health -> inspect recent operations
```

CLI fallback when AKS-MCP cannot perform the cluster baseline read:

```bash
az aks show -g <resource-group> -n <cluster-name>
az aks nodepool list -g <resource-group> --cluster-name <cluster-name>
az monitor activity-log list -g <resource-group> --max-events 20
```

## Kubernetes Baseline Flow

```text
Check API reachability -> inspect nodes -> inspect kube-system -> inspect events -> inspect affected namespace -> inspect pod details and logs
```

CLI fallback when AKS-MCP cannot perform the Kubernetes baseline read:

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -n kube-system
kubectl get events -A --sort-by=.lastTimestamp
kubectl get pods -n <namespace>
kubectl describe pod <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace> --previous
```

## Connectivity Flow

```text
pod -> service -> endpoints -> ingress or load balancer -> DNS -> network controls
```

CLI fallback when AKS-MCP cannot perform the connectivity read:

```bash
kubectl get pods -n <namespace> -o wide
kubectl get svc -n <namespace>
kubectl get endpoints -n <namespace>
kubectl get ingress -n <namespace>
kubectl describe ingress <ingress-name> -n <namespace>
```

## Detector Flow

```text
resolve cluster resource ID -> list detectors or choose category -> select a focused time window -> run the detector or category -> rank critical findings above warnings -> ignore emerging issues when choosing the primary root cause
```

## Monitoring Flow

```text
check resource health -> inspect metrics -> verify diagnostics settings -> inspect control plane logs if available -> correlate with Application Insights or namespace symptoms
```

## Scheduling Flow

```text
pod events -> node capacity -> taints and tolerations -> affinity rules -> PVC state -> quotas
```

CLI fallback when AKS-MCP cannot perform the scheduling read:

```bash
kubectl describe pod <pod-name> -n <namespace>
kubectl get nodes -o wide
kubectl describe node <node-name>
kubectl get pvc -n <namespace>
kubectl describe quota -n <namespace>
```

## Safety Boundary

Treat the following as change operations and avoid them unless the user explicitly asks for remediation:

- deleting or restarting pods
- cordon and drain operations
- scaling workloads or node pools
- cluster upgrade operations
- DNS, route, NSG, or firewall changes
