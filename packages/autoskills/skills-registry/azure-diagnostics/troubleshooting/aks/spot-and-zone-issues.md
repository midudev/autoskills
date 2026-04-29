# Spot And Zone Issues

Use this guide when workload placement, evictions, or zonal behavior is causing node-pool instability.

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
```

Add this preferred node affinity when you want the workload to bias toward spot nodes:

```yaml
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
