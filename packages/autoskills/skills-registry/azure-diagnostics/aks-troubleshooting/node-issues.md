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

## Node Image / OS Upgrade Issues

```bash
# Check current node image versions
az aks nodepool show -g <rg> --cluster-name <cluster> -n <nodepool> \
  --query "{nodeImageVersion:nodeImageVersion, osType:osType}"

# Check available upgrades
az aks nodepool get-upgrades -g <rg> --cluster-name <cluster> --nodepool-name <nodepool>

# Upgrade node image (non-disruptive with surge)
az aks nodepool upgrade -g <rg> --cluster-name <cluster> -n <nodepool> --node-image-only
```

---

## Kubernetes Version Upgrade Failures

**Pre-upgrade check:**

```bash
# Check for deprecated API usage before upgrading
kubectl get --raw /metrics | grep apiserver_requested_deprecated_apis

# Verify available upgrade paths (can only skip one minor version)
az aks get-upgrades -g <rg> -n <cluster> -o table
```

**Upgrade stuck or failed:**

```bash
# Check control plane provisioning state
az aks show -g <rg> -n <cluster> --query "provisioningState"

# If stuck: check AKS diagnostics blade in portal
# Azure Portal -> AKS cluster -> Diagnose and solve problems -> Upgrade
```

Common causes: PDB blocking drain (`kubectl get pdb -A`), deprecated APIs in use, custom admission webhooks failing (`kubectl get validatingwebhookconfiguration`).

---

## Spot Node Pool Evictions

AKS spot nodes use Azure Spot VMs - they can be evicted with 30 seconds notice when Azure needs capacity.

**Diagnose spot eviction:**

```bash
# Spot nodes carry this taint automatically
kubectl describe node <node> | grep "Taint"
# kubernetes.azure.com/scalesetpriority=spot:NoSchedule

# Check eviction events
kubectl get events -A --field-selector reason=SpotEviction
kubectl get events -A | grep -i "evict\|spot\|preempt"
```

**Spot workload pattern:** pods must tolerate the spot taint. Prefer PDBs and avoid stateful PVC workloads on spot.

```yaml
tolerations:
  - key: "kubernetes.azure.com/scalesetpriority"
    operator: Equal
    value: spot
    effect: NoSchedule
affinity:
  nodeAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
            - key: kubernetes.azure.com/scalesetpriority
              operator: In
              values: ["spot"]
```

---

## Multi-AZ Node Pool & Zone-Related Failures

**Check zone distribution:**

```bash
kubectl get nodes -L topology.kubernetes.io/zone
```

**Zone-related failure patterns:**

| Symptom                                          | Cause                                                | Fix                                                          |
| ------------------------------------------------ | ---------------------------------------------------- | ------------------------------------------------------------ |
| Pods stack on one zone after node failures       | Scheduling imbalance after zone failure              | `kubectl rollout restart deployment/<n>` to rebalance        |
| PVC pending with `volume node affinity conflict` | Azure Disk is zonal; pod scheduled in different zone | Use ZRS storage class or ensure PVC and pod are in same zone |
| Service endpoints unreachable from one zone      | Topology-aware routing misconfigured                 | Check `service.spec.trafficDistribution` or TopologyKeys     |
| Upgrade causing zone imbalance                   | Surge nodes in one zone                              | Configure `maxSurge` in node pool upgrade settings           |

Use `Premium_ZRS` or `StandardSSD_ZRS` in custom StorageClasses to reduce zonal PVC conflicts. See [AKS storage best practices](https://learn.microsoft.com/azure/aks/operator-best-practices-storage).

---

## Zero-Downtime Node Pool Upgrades

`maxSurge` controls how many extra nodes are provisioned during upgrade.

```bash
# Check current maxSurge
az aks nodepool show -g <rg> --cluster-name <cluster> -n <nodepool> \
  --query "upgradeSettings.maxSurge"

az aks nodepool update -g <rg> --cluster-name <cluster> -n <nodepool> \
  --max-surge 33%
```

**Upgrade stuck / nodes not draining:**

```bash
kubectl get pdb -A
kubectl describe pdb <pdb-name> -n <ns>
```

If `DisruptionsAllowed: 0`, scale up the workload or temporarily relax `minAvailable`.
