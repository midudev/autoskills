# AZD Errors

## Deployment Runtime Errors

These errors occur **during** `azd up` execution:

| Error | Cause | Resolution |
|-------|-------|------------|
| `unknown flag: --location` | `azd up` doesn't accept `--location` | Use `azd env set AZURE_LOCATION <region>` before `azd up` |
| Provision failed | Bicep template errors | Check detailed error in output |
| Deploy failed | Build or Docker errors | Check build logs |
| Package failed | Missing Dockerfile or deps | Verify Dockerfile exists and dependencies |
| Quota exceeded | Subscription limits | Request increase or change region |
| `PrincipalId '...' has type 'ServicePrincipal', which is different from specified PrincipalType 'User'` | Base template RBAC assigns roles with `principalType: 'User'` but deploying identity is a service principal (CI/CD) | Set `allowUserIdentityPrincipal: false` in the `storageEndpointConfig` variable in `infra/main.bicep`. Do NOT try clearing `AZURE_PRINCIPAL_ID` — azd repopulates it. See [Principal Type Mismatch](#principal-type-mismatch). |
| `ImagePullBackOff` or `azd up` hangs during provision for Container Apps | Container App references an image that doesn't exist in ACR yet | See [Container Apps Bootstrap Problem](#container-apps-bootstrap-problem) |
| `unauthorized: authentication required` on `docker push` to ACR | ACR auth token expired or scoped incorrectly | See [ACR Authentication Failures](#acr-authentication-failures) |
| `could not determine container registry endpoint` | Missing `AZURE_CONTAINER_REGISTRY_ENDPOINT` | See [Missing Container Registry Variables](#missing-container-registry-variables) |
| `map has no entry for key "AZURE_CONTAINER_REGISTRY_MANAGED_IDENTITY_ID"` | Missing managed identity env vars | See [Missing Container Registry Variables](#missing-container-registry-variables) |
| `map has no entry for key "MANAGED_IDENTITY_CLIENT_ID"` | Missing managed identity client ID | See [Missing Container Registry Variables](#missing-container-registry-variables) |
| `Operation expired` / revision creation timeout (900s) | RBAC propagation delay — Container App's managed identity doesn't have `AcrPull` on ACR yet | See [Container App Revision Timeout](#container-app-revision-timeout) |
| `found '2' resources tagged with 'azd-service-name: <name>'` | Previous deployment left duplicate-tagged resources in same RG | **Preferred**: Create fresh env with `azd env new <new-name> --no-prompt`, set subscription/location, redeploy. **Alternative**: Delete conflicting resources (requires `ask_user`). |
| Literal `{{ .Env.* }}` in Terraform errors | azd does not interpolate template variables in `.tfvars.json` | See [Unresolved Terraform Template Variables](#unresolved-terraform-template-variables) |

> ℹ️ **Pre-flight validation**: Run `azure-validate` before deployment to catch configuration errors early. See [Pre-Deploy Checklist](../../pre-deploy-checklist.md).

## Container App Revision Timeout

**Symptom:** `azd up` provisions infrastructure successfully but the Container App revision creation times out after ~900 seconds. The Container App enters a `Failed` provisioning state with no active revision. The `azd` output shows `Operation expired` or `The operation did not complete within the permitted time`.

**Cause:** Azure RBAC propagation delay. When `azd up` runs both `azd provision` and `azd deploy` in a single step:
1. Bicep creates the Container App with a system-assigned managed identity and a public placeholder image
2. Bicep creates an `AcrPull` role assignment for that identity on ACR in a separate module using the two-phase deployment pattern
3. `azd deploy` immediately pushes the real image and creates a new Container App revision
4. The revision tries to pull the image from ACR, but the `AcrPull` role assignment hasn't propagated yet (can take 1–5 minutes)
5. The image pull fails repeatedly until the 900-second timeout is reached

**Solution:**

1. **Verify the Container App state:**
```bash
az containerapp show --name <app-name> --resource-group <resource-group> \
  --query "{provisioningState:properties.provisioningState, latestRevision:properties.latestRevisionName}" -o json
```

2. **Confirm the AcrPull role exists (it may have propagated by now):**
```bash
PRINCIPAL_ID=$(az containerapp identity show --name <app-name> --resource-group <resource-group> --query principalId -o tsv)
az role assignment list --scope $(az acr show --name <acr-name> --resource-group <resource-group> --query id -o tsv) \
  --assignee-object-id "$PRINCIPAL_ID" --query "[].roleDefinitionName" -o tsv
```

**PowerShell:**
```powershell
$PrincipalId = az containerapp identity show --name <app-name> --resource-group <resource-group> --query principalId -o tsv
$AcrScope = az acr show --name <acr-name> --resource-group <resource-group> --query id -o tsv
az role assignment list --scope $AcrScope --assignee-object-id $PrincipalId --query "[].roleDefinitionName" -o tsv
```

3. **If AcrPull is missing, assign it:**
```bash
az role assignment create \
  --assignee-object-id "$PRINCIPAL_ID" \
  --assignee-principal-type ServicePrincipal \
  --role AcrPull \
  --scope $(az acr show --name <acr-name> --resource-group <resource-group> --query id -o tsv)
```

**PowerShell:**
```powershell
$AcrScope = az acr show --name <acr-name> --resource-group <resource-group> --query id -o tsv
az role assignment create `
  --assignee-object-id $PrincipalId `
  --assignee-principal-type ServicePrincipal `
  --role AcrPull `
  --scope $AcrScope
```

4. **Wait for propagation, then redeploy:**
```bash
azd env set AZURE_CONTAINER_REGISTRY_ENDPOINT $(az acr show --name <acr-name> --resource-group <resource-group> --query loginServer -o tsv)

for attempt in 1 2 3 4 5; do
  echo "Waiting for RBAC propagation (attempt $attempt/5)..."
  sleep 60

  if azd deploy --no-prompt; then
    echo "Deployment succeeded after RBAC propagation."
    break
  fi

  if [ "$attempt" -eq 5 ]; then
    echo "Deployment still failing after 5 minutes. Re-check AcrPull assignment and Container App revision status."
    exit 1
  fi
done
```

**PowerShell:**
```powershell
azd env set AZURE_CONTAINER_REGISTRY_ENDPOINT (az acr show --name <acr-name> --resource-group <resource-group> --query loginServer -o tsv)

for ($attempt = 1; $attempt -le 5; $attempt++) {
    Write-Output "Waiting for RBAC propagation (attempt $attempt/5)..."
    Start-Sleep -Seconds 60

    azd deploy --no-prompt
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Deployment succeeded after RBAC propagation."
        break
    }

    if ($attempt -eq 5) {
        Write-Output "Deployment still failing after 5 minutes. Re-check AcrPull assignment and Container App revision status."
        exit 1
    }
}
```

> 💡 **Prevention:** To avoid this in future deployments, ensure the Bicep template includes the `AcrPull` role assignment with `principalType: 'ServicePrincipal'`, and consider using `azd provision` + `azd deploy` as separate steps instead of `azd up` to allow RBAC propagation time between infrastructure creation and app deployment.

## Container Apps Bootstrap Problem

**Symptom:** `azd up` hangs or fails during provisioning with `ImagePullBackOff`, or the Container App cannot start because the referenced image doesn't exist in ACR yet.

**Cause:** The Bicep template creates the Container App referencing an ACR image, but that image doesn't exist until `azd deploy` builds and pushes it. This chicken-and-egg problem blocks provisioning.

**Solution — use two-phase deployment:**

```bash
# Phase 1: Provision infrastructure (Container App uses placeholder image)
azd provision --no-prompt

# Phase 2: Build, push, and update Container App with real image
azd deploy --no-prompt
```

> ⚠️ This requires the Bicep template to use a placeholder image parameter (e.g., `mcr.microsoft.com/azuredocs/containerapps-helloworld:latest`) so provisioning succeeds without the app image. If the Bicep hardcodes the ACR image reference, update it to accept a `containerImageName` parameter with a placeholder default before provisioning.

> ⚠️ Do **NOT** repeatedly poll a hanging `azd up` — if there is no provisioning progress or you continue to see `ImagePullBackOff` events for several minutes during a Container Apps deployment, stop it and switch to the two-phase approach above.

## ACR Authentication Failures

**Symptom:** `docker push` fails with `unauthorized: authentication required` even after `az acr login` succeeds.

**Solution — try these methods in order:**

```bash
# Method 1: AAD-based login (preferred)
az acr login --name <acr-name>
docker push <acr-name>.azurecr.io/<image>:<tag>

# Method 2: Admin credentials (fallback)
ACR_USER=$(az acr credential show --name <acr-name> --query username -o tsv)
ACR_PASS=$(az acr credential show --name <acr-name> --query "passwords[0].value" -o tsv)
docker login <acr-name>.azurecr.io -u "$ACR_USER" -p "$ACR_PASS"
docker push <acr-name>.azurecr.io/<image>:<tag>
```

**PowerShell (Method 2):**
```powershell
$AcrUser = az acr credential show --name <acr-name> --query username -o tsv
$AcrPass = az acr credential show --name <acr-name> --query "passwords[0].value" -o tsv
docker login <acr-name>.azurecr.io -u $AcrUser -p $AcrPass
docker push <acr-name>.azurecr.io/<image>:<tag>
```

> 💡 **Tip:** Prefer `azd deploy` over manual `docker push` — azd handles ACR authentication automatically.

## Missing Container Registry Variables

**Symptom:** Errors during `azd deploy` about missing container registry or managed identity environment variables:

```
ERROR: could not determine container registry endpoint, ensure 'registry' has been set in the docker options or 'AZURE_CONTAINER_REGISTRY_ENDPOINT' environment variable has been set
```

Or:

```
ERROR: failed executing template file: template: manifest template:6:14: executing "manifest template" at <.Env.AZURE_CONTAINER_REGISTRY_MANAGED_IDENTITY_ID>: map has no entry for key "AZURE_CONTAINER_REGISTRY_MANAGED_IDENTITY_ID"
```

Or:

```
ERROR: failed executing template file: template: manifest template:39:26: executing "manifest template" at <.Env.MANAGED_IDENTITY_CLIENT_ID>: map has no entry for key "MANAGED_IDENTITY_CLIENT_ID"
```

**Cause:** This typically occurs with .NET Aspire projects using azd "limited mode" (in-memory infrastructure generation without explicit `infra/` folder). The `azd provision` command creates the Azure Container Registry and Managed Identity resources but doesn't automatically populate the environment variables that `azd deploy` needs to reference them.

> ⚠️ **Prevention is Better:** For .NET Aspire projects, this issue should be addressed PROACTIVELY before deployment by setting up environment variables after `azd init` but before `azd up`. This avoids deployment failures entirely.

**Solution:**

After `azd provision` succeeds, manually set the missing environment variables by querying the provisioned resources:

```bash
# Get the resource group name (typically rg-{environment-name})
azd env get-values

# Set container registry endpoint
azd env set AZURE_CONTAINER_REGISTRY_ENDPOINT $(az acr list --resource-group <resource-group-name> --query "[0].loginServer" -o tsv)

# Set managed identity resource ID
azd env set AZURE_CONTAINER_REGISTRY_MANAGED_IDENTITY_ID $(az identity list --resource-group <resource-group-name> --query "[0].id" -o tsv)

# Set managed identity client ID
azd env set MANAGED_IDENTITY_CLIENT_ID $(az identity list --resource-group <resource-group-name> --query "[0].clientId" -o tsv)
```

**PowerShell:**
```powershell
# Set container registry endpoint
azd env set AZURE_CONTAINER_REGISTRY_ENDPOINT (az acr list --resource-group <resource-group-name> --query "[0].loginServer" -o tsv)

# Set managed identity resource ID
azd env set AZURE_CONTAINER_REGISTRY_MANAGED_IDENTITY_ID (az identity list --resource-group <resource-group-name> --query "[0].id" -o tsv)

# Set managed identity client ID
azd env set MANAGED_IDENTITY_CLIENT_ID (az identity list --resource-group <resource-group-name> --query "[0].clientId" -o tsv)
```

After setting these variables, retry the deployment:
```bash
azd deploy --no-prompt
```

> 💡 **Tip:** This issue is specific to Aspire limited mode. Manually setting these environment variables after `azd provision` is the recommended workaround.

## Unresolved Terraform Template Variables

**Symptom:** Terraform receives literal Go-style template strings instead of resolved values during `azd provision`:

```
Error: Invalid value for variable "environment_name"
  The value "{{ .Env.AZURE_ENV_NAME }}" is not valid.
```

Or Terraform silently uses the literal string, causing resource naming failures, state conflicts, and cascading errors that lead to deployment timeouts.

**Cause:** azd reads `infra/main.tfvars.json`, substitutes `${VAR}` references using its built-in envsubst, and passes the resolved file to Terraform via `-var-file=`. Go-style `{{ .Env.* }}` variables are only processed in `azure.yaml` and service manifests — they are **NOT** interpolated in `.tfvars.json` or any Terraform variable files. If `azure-prepare` generated a `main.tfvars.json` with Go-style template expressions, those literal strings are passed to Terraform.

**Solution:**

1. **Fix the syntax** in `infra/main.tfvars.json` — replace Go-style `{{ .Env.* }}` with `${VAR}`:
   ```json
   {
       "environment_name": "${AZURE_ENV_NAME}",
       "location": "${AZURE_LOCATION}",
       "subscription_id": "${AZURE_SUBSCRIPTION_ID}"
   }
   ```

2. **Or use `TF_VAR_*` environment variables** if you don't have `main.tfvars.json`:
   ```bash
   azd env set TF_VAR_environment_name "$(azd env get-value AZURE_ENV_NAME)"
   azd env set TF_VAR_location "$(azd env get-value AZURE_LOCATION)"
   azd env set TF_VAR_subscription_id "$(azd env get-value AZURE_SUBSCRIPTION_ID)"
   ```

3. **Ensure `variables.tf`** declares all required variables:
   ```hcl
   variable "environment_name" { type = string }
   variable "location" { type = string }
   ```

4. **Re-run deployment:**
   ```bash
   azd up --no-prompt
   ```

> ⚠️ **Prevention:** This issue should be caught by `azure-validate` Step 10 (Template Variable Resolution Check) before deployment. If you encounter it, re-run validation after fixing.

## Retry

After fixing the issue:
```bash
azd up --no-prompt
```

## Principal Type Mismatch

**Symptom:** `azd up` fails during provisioning with:

```
PrincipalId '...' has type 'ServicePrincipal', which is different from specified PrincipalType 'User'
```

**Cause:** Many AZD templates (e.g., `functions-quickstart-python-http-azd`) include RBAC role assignments for the deploying user with hardcoded `principalType: 'User'`. This is controlled by an `allowUserIdentityPrincipal` flag in `main.bicep`'s `storageEndpointConfig` variable. When deploying from CI/CD with a service principal, `azd` sets `AZURE_PRINCIPAL_ID` to that service principal's object ID, but the Bicep still tries to create a role assignment with `principalType: 'User'`, causing ARM to reject it.

**Solution:**

In `infra/main.bicep`, find the `storageEndpointConfig` variable and set `allowUserIdentityPrincipal` to `false`:

```bicep
var storageEndpointConfig = {
  enableBlob: true
  enableQueue: false
  enableTable: false
  enableFiles: false
  allowUserIdentityPrincipal: false  // Set to false for service principal deployments
}
```

> ⚠️ **Do NOT** try to fix this by running `azd env set AZURE_PRINCIPAL_ID ""`. The `azd` CLI repopulates this value from the current auth context, so clearing it has no effect.

## Cleanup (DESTRUCTIVE)

```bash
azd down --force --purge
```

⚠️ Permanently deletes ALL resources including databases and Key Vaults.
