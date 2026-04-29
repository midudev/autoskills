# Networking Troubleshooting

For CNI-specific issues, check CNI pod health and review [AKS networking concepts](https://learn.microsoft.com/azure/aks/concepts-network).

## Service Unreachable / Connection Refused

**Diagnostics - always start here:**

```bash
# 1. Verify service exists and has endpoints (read-only)
kubectl get svc <service-name> -n <ns>
kubectl get endpoints <service-name> -n <ns>

# 2. Optional connectivity test from inside the namespace
# This creates a temporary pod. Prefer read-only checks first.
# Only use it after the user explicitly approves a mutating test.
kubectl run netdebug --image=curlimages/curl -it --rm -n <ns> -- \
  curl -sv http://<service>.<ns>.svc.cluster.local:<port>/healthz
```

**Decision tree:**

| Observation                             | Cause                              | Fix                                             |
| --------------------------------------- | ---------------------------------- | ----------------------------------------------- |
| Endpoints shows `<none>`                | Label selector mismatch            | Align selector with pod labels; check for typos |
| Endpoints has IPs but unreachable       | Port mismatch or app not listening | Confirm `targetPort` = actual container port    |
| Works from some pods, fails from others | Network policy blocking            | See Network Policy section                      |
| Works inside cluster, fails externally  | Load balancer issue                | See Load Balancer section                       |
| `ECONNREFUSED` immediately              | App not listening on that port     | Check listening ports in the pod                |

Pods that are running but not Ready are removed from Endpoints. Check `kubectl get pod <pod> -n <ns>`.

---

## DNS Resolution Failures

**Diagnostics:**

The live DNS test creates a temporary pod. Prefer `get`, `describe`, `logs`, or `exec` into an existing pod first. Only use it after the user explicitly approves creating the test pod.

```bash
# Confirm CoreDNS is running and healthy (read-only)
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
kubectl top pod -n kube-system -l k8s-app=kube-dns

# Optional live DNS test from the same namespace as the failing pod
kubectl run dnstest --image=busybox:1.28 -it --rm -n <ns> -- \
  nslookup <service-name>.<ns>.svc.cluster.local

# CoreDNS logs - errors show here first
kubectl logs -n kube-system -l k8s-app=kube-dns --tail=100
```

**DNS failure patterns:**

| Symptom                               | Cause                                        | Fix                                                                                                                        |
| ------------------------------------- | -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `NXDOMAIN` for `svc.cluster.local`    | CoreDNS down or pod network broken           | After confirming the diagnostics above, coordinate with the cluster operator to restart or redeploy CoreDNS and verify CNI |
| Internal resolves, external NXDOMAIN  | Custom DNS not forwarding to `168.63.129.16` | Fix upstream forwarder                                                                                                     |
| Intermittent SERVFAIL under load      | CoreDNS CPU throttled                        | Remove CPU limits or add replicas                                                                                          |
| Private cluster - external names fail | Custom DNS missing privatelink forwarder     | Add conditional forwarder to Azure DNS                                                                                     |
| `i/o timeout` not `NXDOMAIN`          | Port 53 blocked by NetworkPolicy or NSG      | Allow UDP/TCP 53 from pods to kube-dns ClusterIP                                                                           |

> ⚠️ **Warning:** The fixes in this table can change cluster state. Use them only after performing the read-only diagnostics above, and only with explicit confirmation from the cluster owner or operator.

```bash
kubectl get svc kube-dns -n kube-system -o jsonpath='{.spec.clusterIP}'
```

Custom VNet DNS must forward `.cluster.local` to the CoreDNS ClusterIP and other lookups to `168.63.129.16`.

---

## Detailed Networking Guides

- [Load Balancer And Ingress Troubleshooting](load-balancer-and-ingress.md) for pending services, ingress controller state, backend routing, and TLS failures.
- [Network Policy Troubleshooting](network-policy.md) for default-deny checks, Azure NPM or Calico validation, and ingress or egress rule audits.
