# Load Balancer And Ingress Troubleshooting

Use this guide when AKS networking symptoms point at Azure load balancer provisioning, ingress controller behavior, or backend routing.

## Load Balancer Stuck In Pending

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
