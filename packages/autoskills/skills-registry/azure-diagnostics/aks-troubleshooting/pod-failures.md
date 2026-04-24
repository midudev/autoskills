# Pod Failures & Application Issues

## Common Pod Diagnostic Commands

```bash
# List unhealthy pods across all namespaces
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded

# All pods wide view
kubectl get pods -A -o wide

# Detailed pod status - events section is critical
kubectl describe pod <pod-name> -n <namespace>

# Pod logs (current and previous crash)
kubectl logs <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace> --previous
```

---

## CrashLoopBackOff

Pod starts, crashes, restarts with exponential backoff (10s, 20s, 40s... up to 5m).

**Diagnostics:**

```bash
kubectl describe pod <pod-name> -n <namespace>
# Check: Exit Code, Reason, Last State, Events

kubectl logs <pod-name> -n <namespace> --previous
# Shows stdout/stderr from the last crashed container
```

**Decision tree:**

| Exit Code | Meaning                                               | Fix Path                                                      |
| --------- | ----------------------------------------------------- | ------------------------------------------------------------- |
| `0`       | App exited successfully (unexpected for long-running) | Check if entrypoint/command is correct; app may be a one-shot |
| `1`       | Application error                                     | Read logs - unhandled exception, missing config, bad startup  |
| `137`     | OOMKilled (SIGKILL)                                   | Increase `resources.limits.memory`; check for memory leaks    |
| `139`     | Segfault (SIGSEGV)                                    | Binary compatibility issue or native code bug                 |
| `143`     | SIGTERM - graceful shutdown                           | Pod was terminated; check if liveness probe killed it         |

**OOMKilled specifically:**

```bash
kubectl describe pod <pod-name> -n <namespace> | grep -A2 "Last State"
# Reason: OOMKilled -> container exceeded memory limit
```

Fix: increase `resources.limits.memory` or optimize application memory usage. Check `kubectl top pod <pod-name> -n <namespace>` for actual usage.

---

## ImagePullBackOff

Pod can't pull the container image.

**Diagnostics:**

```bash
kubectl describe pod <pod-name> -n <namespace>
# Events section shows the exact pull error
```

| Error Message                           | Cause                        | Fix                                                            |
| --------------------------------------- | ---------------------------- | -------------------------------------------------------------- |
| `ErrImagePull` / `ImagePullBackOff`     | Image name or tag is wrong   | Verify image name and tag exist in the registry                |
| `unauthorized: authentication required` | Missing or wrong pull secret | Create/update `imagePullSecrets` on the pod or service account |
| `manifest unknown`                      | Tag doesn't exist            | Check available tags in the registry                           |
| `context deadline exceeded`             | Registry unreachable         | Check network/firewall; for ACR, verify AKS -> ACR integration |

**ACR integration check:**

```bash
# Verify AKS is attached to ACR
az aks check-acr -g <rg> -n <cluster> --acr <acr-name>.azurecr.io
```

---

## Pending Pods

Pod stays in `Pending` - scheduler can't place it.

**Diagnostics:**

```bash
kubectl describe pod <pod-name> -n <namespace>
# Events section shows why scheduling failed
```

| Event Message                                                          | Cause                               | Fix                                                             |
| ---------------------------------------------------------------------- | ----------------------------------- | --------------------------------------------------------------- |
| `Insufficient cpu` / `Insufficient memory`                             | No node has enough resources        | Scale node pool; reduce resource requests; check for overcommit |
| `node(s) had taint ... that the pod didn't tolerate`                   | Taint/toleration mismatch           | Add matching toleration or use a different node pool            |
| `node(s) didn't match Pod's node affinity/selector`                    | Affinity rule unsatisfiable         | Check `nodeSelector` or `nodeAffinity` rules                    |
| `persistentvolumeclaim ... not found` / `unbound`                      | PVC not ready                       | Check PVC status; verify storage class exists                   |
| `0/N nodes are available: N node(s) had volume node affinity conflict` | Zonal disk vs pod in different zone | Use ZRS storage class or ensure same zone                       |

---

## Readiness & Liveness Probe Failures

**Readiness probe failure** -> pod removed from Service endpoints (no traffic). **Liveness probe failure** -> pod killed and restarted.

**Diagnostics:**

```bash
kubectl describe pod <pod-name> -n <namespace>
# Look for: "Readiness probe failed" or "Liveness probe failed" in Events

# Check the pod's READY column - must show n/n
kubectl get pod <pod-name> -n <namespace>
```

| Symptom                              | Cause                   | Fix                                                        |
| ------------------------------------ | ----------------------- | ---------------------------------------------------------- |
| READY shows `0/1` but pod is Running | Readiness probe failing | Check probe path, port, and app health endpoint            |
| Pod restarts repeatedly              | Liveness probe failing  | Increase `initialDelaySeconds`; check if app starts slowly |
| Probe timeout errors                 | App responds too slowly | Increase `timeoutSeconds`; check app performance           |

> 💡 **Tip:** Set `initialDelaySeconds` on liveness probes to be longer than your app's startup time. A common mistake is killing pods before they finish initializing.

---

## Resource Constraints (CPU/Memory)

**Check actual usage vs limits:**

```bash
kubectl top pod <pod-name> -n <namespace>
kubectl top pod -n <namespace> --sort-by=memory

# Compare with requests/limits
kubectl get pod <pod-name> -n <namespace> -o jsonpath='{.spec.containers[*].resources}'
```

| Symptom                          | Cause                                   | Fix                                                 |
| -------------------------------- | --------------------------------------- | --------------------------------------------------- |
| OOMKilled (exit code 137)        | Container exceeded memory limit         | Increase `limits.memory` or fix memory leak         |
| CPU throttling (slow responses)  | Container hitting CPU limit             | Increase `limits.cpu` or remove CPU limits          |
| Pending - insufficient resources | Requests exceed available node capacity | Lower requests, scale nodes, or use larger VM sizes |

> ⚠️ **Warning:** Setting CPU limits can cause unnecessary throttling even when the node has spare capacity. Many teams set CPU requests but not limits. Memory limits should always be set.
