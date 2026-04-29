# AZD Deploy Recipe

Deploy to Azure using Azure Developer CLI (azd).

> 💡 **Note:** azd supports both Bicep and Terraform as IaC providers. The deployment workflow is identical regardless of which you use.

## Prerequisites

- `azd` CLI installed → Run `mcp_azure_mcp_extension_cli_install` with `cli-type: azd` if needed
- `.azure/deployment-plan.md` exists with status `Validated`
- `azure.yaml` exists and validated
- Infrastructure files exist (Bicep: `infra/main.bicep`, Terraform: `infra/*.tf`)
- **AZD environment configured** → Done in azure-validate
- **Subscription and location confirmed** → See [Pre-deploy Checklist](../../pre-deploy-checklist.md)

## Workflow

| Step | Task | Command |
|------|------|---------|
| 1 | **Verify environment** | `azd env get-values` — Confirm AZURE_SUBSCRIPTION_ID and AZURE_LOCATION set |
| 2 | **Provision infrastructure** | `azd provision --no-prompt` |
| 3 | **RBAC health check** *(Container Apps + ACR only)* | After provisioning, verify `AcrPull` role has propagated before deploying — see [Pre-Deploy Checklist](../../pre-deploy-checklist.md#container-apps--acr--pre-deploy-rbac-health-check) |
| 4 | **Deploy application** | `azd deploy --no-prompt` |
| 5 | **Post-Deploy** | [Post-Deployment Steps](post-deployment.md) — If using SQL + managed identity |
| 6 | **Verify** | See [Verification](verify.md) |
| 7 | **Report** | Present deployed endpoint URLs to the user — see [Verification](verify.md) Step 3 |

> ⚠️ **Important:** For Container Apps that use a managed identity to pull from ACR, always run `azd provision` and `azd deploy` as **separate steps** (not `azd up`) and complete the RBAC health check between them. This ensures the managed identity `AcrPull` role assignment has propagated before the Container App revision attempts to pull the image.

> ⚠️ **Important:** For .NET Aspire projects or projects using azd "limited mode" (no explicit `infra/` folder), verify that `azd provision` populated all required environment variables. If `azd deploy` fails with errors about missing `AZURE_CONTAINER_REGISTRY_ENDPOINT`, `AZURE_CONTAINER_REGISTRY_MANAGED_IDENTITY_ID`, or `MANAGED_IDENTITY_CLIENT_ID`, see [Error Handling](errors.md#missing-container-registry-variables) for the resolution.

## Common Mistakes

| ❌ Wrong | Why It Fails |
|----------|-------------|
| `azd up --location eastus2` | `--location` is not a valid flag for `azd up` |
| `azd up` without `azd env new` | Prompts for input, fails with `--no-prompt` |
| `mkdir .azure` then `azd env new --no-prompt` | Creates env folder structure incorrectly |
| Setting AZURE_LOCATION without checking RG | "Invalid resource group location" if RG exists elsewhere |
| Ignoring `azd-service-name` tag conflicts in same RG | "found '2' resources tagged with..." error |
| `language: html` or `language: static` | Not valid - use `language: js` with `dist: .` for static sites |

## Deployment Commands

> ⚠️ `azd up` takes 5-15 min. Run with output **streamed visibly to the user** — do NOT run silently or suppress output. The user must see provisioning progress in real time.

### Full Deployment

Provisions infrastructure AND deploys application:

```bash
azd up --no-prompt
```

### Infrastructure Only

```bash
azd provision --no-prompt
```

### Application Only

Deploy code to existing infrastructure:

```bash
azd deploy --no-prompt
```

### Single Service

```bash
azd deploy api --no-prompt
```

## References

- [Pre-deploy Checklist](../../pre-deploy-checklist.md) — **REQUIRED**
- [Post-Deployment Steps](post-deployment.md) — SQL + managed identity setup
- [Azure Functions Deployment](functions-deploy.md)
- [Verification](verify.md)
- [Error Handling](errors.md)
