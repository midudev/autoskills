# Node & Cluster Troubleshooting

## Node NotReady

**Diagnostics:**

```bash
kubectl get nodes -o wide
kubectl describe node <node-name>
# Look for: Conditions, Taints, Events, resource usage, kubelet status
```

**Condition decision tree:**

| Condition            | Value   | Meaning                           | Fix Path                                                      |
| -------------------- | ------- | --------------------------------- | ------------------------------------------------------------- |
| `Ready`              | `False` | kubelet stopped reporting         | SSH to node; if unrecoverable, consider cordon/drain/delete\* |
| `MemoryPressure`     | `True`  | Node running out of memory        | Evict pods; scale out pool; reduce pod density                |
| `DiskPressure`       | `True`  | OS disk or ephemeral storage full | Check logs and images; clean up or increase disk              |
| `PIDPressure`        | `True`  | Too many processes                | App spawning excessive threads/processes                      |
| `NetworkUnavailable` | `True`  | CNI plugin issue                  | Check CNI pods in kube-system; node network config            |

\*Only after explicit user request for remediation and confirmation of workload impact.

**AKS-specific - SSH to a node:**

> ⚠️ **Warning:** `kubectl debug node/...` creates a privileged debug pod on the node and is not a read-only diagnostic step. Default to read-only evidence gathering first. Only suggest or run this after the user explicitly asks for remediation or approves a privileged diagnostic action and understands the change-control impact.

```bash
# Create a privileged debug pod on the node
kubectl debug node/<node-name> -it --image=mcr.microsoft.com/cbl-mariner/base/core:2.0

# Check kubelet status inside the node
chroot /host systemctl status kubelet
chroot /host journalctl -u kubelet -n 50
```

**Optional remediation if kubelet can't recover (after confirmation):** cordon -> drain -> delete. AKS auto-replaces via node pool VMSS.

> ⚠️ **Warning:** These commands are disruptive. By default, stay in read-only diagnostic mode. Only suggest or run them if the user has explicitly requested remediation and confirmed they understand the workload and PodDisruptionBudget impact.

```bash
kubectl cordon <node-name>
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
kubectl delete node <node-name>
```

---

## Node Pool Not Scaling

### Cluster Autoscaler Not Triggering

**Diagnostics:**

```bash
# Autoscaler logs
kubectl logs -n kube-system -l app=cluster-autoscaler --tail=100

# Autoscaler status
kubectl get configmap cluster-autoscaler-status -n kube-system -o yaml

# Verify autoscaler is enabled on the node pool
az aks nodepool show -g <rg> --cluster-name <cluster> -n <nodepool> \
  --query "{autoscaleEnabled:enableAutoScaling, min:minCount, max:maxCount}"
```

**Autoscaler won't scale up - common reasons:**

- Node pool already at `maxCount`
- VM quota exhausted: `az vm list-usage -l <region> -o table | grep -i "DSv3\|quota"`
- Pod `nodeAffinity` is unsatisfiable on any new node template
- 10-minute cooldown period still active after last scale event

**Autoscaler won't scale down - common reasons:**

- Pods with `emptyDir` local storage (configure `--skip-nodes-with-local-storage=false` if safe)
- Standalone pods with no controller (not in a ReplicaSet)
- `cluster-autoscaler.kubernetes.io/safe-to-evict: "false"` annotation on a pod

### Manual Scaling

```bash
az aks nodepool scale -g <rg> --cluster-name <cluster> -n <nodepool> --node-count <n>
```

---

## Resource Pressure & Capacity Planning

**Check actual vs allocatable:**

```bash
kubectl describe node <node> | grep -A6 "Allocated resources:"
```

See [AKS resource reservations](https://learn.microsoft.com/azure/aks/concepts-clusters-workloads#resource-reservations) for allocatable math.

**Ephemeral storage pressure:**

```bash
# Check what's consuming ephemeral storage on a node
kubectl debug node/<node> -it --image=mcr.microsoft.com/cbl-mariner/base/core:2.0
```

Common culprit: high-volume container logs accumulating in `/var/log/containers`.

---

## Detailed Node And Cluster Guides

- [Upgrade Operations](upgrade-operations.md) for node images, Kubernetes version upgrades, surge settings, and PDB-related drain blockers.
- [Spot And Zone Issues](spot-and-zone-issues.md) for spot evictions, tolerations, zone skew, and zonal storage or service behavior.
