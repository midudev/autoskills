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

```bash
# Confirm CoreDNS is running and healthy (read-only)
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
kubectl top pod -n kube-system -l k8s-app=kube-dns

# Optional live DNS test from the same namespace as the failing pod
# This creates a temporary pod. Prefer get/describe/logs or exec into an existing pod first.
# Only use it after the user explicitly approves creating the test pod.
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

## Load Balancer Stuck in Pending

**Diagnostics:**

```bash
kubectl describe svc <svc> -n <ns>
# Events section reveals the actual Azure error

kubectl logs -n kube-system -l component=cloud-controller-manager --tail=100
```

**Error decision table:**

| Error in Events / CCM Logs                             | Cause                                  | Fix                                                                          |
| ------------------------------------------------------ | -------------------------------------- | ---------------------------------------------------------------------------- |
| `InsufficientFreeAddresses`                            | Subnet has no free IPs                 | Expand subnet CIDR; use Azure CNI Overlay; use NAT gateway instead           |
| `ensure(default/svc): failed... PublicIPAddress quota` | Public IP quota exhausted              | Request quota increase for Public IP Addresses in the region                 |
| `cannot find NSG`                                      | NSG name changed or detached           | Re-associate NSG to the AKS subnet; check `az aks show` for NSG name         |
| `reconciling NSG rules: failed`                        | NSG is locked or has conflicting rules | Remove resource lock; check for deny-all rules above AKS-managed rules       |
| `subnet not found`                                     | Wrong subnet name in annotation        | Verify subnet name: `az network vnet subnet list -g <rg> --vnet-name <vnet>` |
| No events, stuck Pending                               | CCM can't authenticate to Azure        | Check cluster managed identity access on the VNet resource group             |

---

## Ingress Not Routing Traffic

**Diagnostics:**

```bash
# Confirm controller is running
kubectl get pods -n <ingress-ns> -l 'app.kubernetes.io/name in (ingress-nginx,nginx-ingress)'
kubectl logs -n <ingress-ns> -l app.kubernetes.io/name=ingress-nginx --tail=100

# Check the ingress resource state
kubectl describe ingress <name> -n <ns>
kubectl get ingress <name> -n <ns>

# Check backend
kubectl get endpoints <backend-svc> -n <ns>
```

**Ingress failure patterns:**

| Symptom                          | Cause                                          | Fix                                                          |
| -------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ |
| ADDRESS empty                    | LB not provisioned or wrong `ingressClassName` | Check controller service; set correct `ingressClassName`     |
| 404 for all paths                | No matching host rule                          | Check `host` field; `pathType: Prefix` vs `Exact`            |
| 404 for some paths               | Trailing slash mismatch                        | `Prefix /api` matches `/api/foo` not `/api` - add both       |
| 502 Bad Gateway                  | Backend pods unhealthy or wrong port           | Verify Endpoints has IPs; confirm `targetPort` and readiness |
| 503 Service Unavailable          | All backend pods down                          | Check pod restarts and readiness probe                       |
| TLS handshake fail               | cert-manager not issuing                       | Check certificate status and ACME challenge                  |
| Works for host-a, 404 for host-b | DNS not pointing to ingress IP                 | Verify `nslookup <host>` resolves to the ingress address     |

---

## Network Policy Blocking Traffic

```bash
# List all policies in the namespace - check both ingress and egress
kubectl get networkpolicy -n <ns> -o yaml

# Check for a default-deny policy (blocks everything unless explicitly allowed)
kubectl get networkpolicy -n <ns> -o jsonpath='{range .items[?(@.spec.podSelector=={})]}{.metadata.name}{"\n"}{end}'
```

**AKS network policy engine check:** Azure NPM (Azure CNI): `kubectl get pods -n kube-system -l k8s-app=azure-npm`. Calico: `kubectl get pods -n calico-system`.

Policy audit: source labels, destination labels, destination ingress rules, and source egress rules must all line up. With default-deny, explicitly allow UDP/TCP 53 to kube-dns.
