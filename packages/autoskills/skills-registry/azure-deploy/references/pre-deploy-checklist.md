# Pre-Deployment Checklist

> **CRITICAL**: Before running ANY provisioning commands, you MUST complete this checklist IN ORDER.
>
> ⛔ **DO NOT** run `azd up` until ALL steps are complete. Trial-and-error wastes time and creates orphan resources.

## Step 1: Check Current Subscription

Use the Azure MCP tool to get current subscription:

```
mcp_azure_mcp_subscription_list
```

**CLI fallback:**
```bash
az account show --query "{name:name, id:id}" -o json
```

## Step 2: Prompt User for Subscription

**You MUST use `ask_user`** to confirm the subscription. Find the default subscription (marked `isDefault: true`) from Step 1 results and present it as the recommended choice.

✅ **Correct — show actual name and ID as a choice:**
```
ask_user(
  question: "Which Azure subscription would you like to deploy to?",
  choices: [
    "Use current: <subscription-name> (<subscription-id>) (Recommended)",
    "Let me specify a different subscription"
  ]
)
```

❌ **Wrong — never use freeform input for subscription:**
```
ask_user(
  question: "Which Azure subscription should I deploy to? I'll need the subscription name or ID."
)
```

## Step 3: Create AZD Environment FIRST

> ⚠️ **MANDATORY** — Create the environment BEFORE setting any variables or running `azd up`.
>
> ⛔ **DO NOT** manually create `.azure/` folder with `mkdir` or `New-Item`. Let `azd` create it.

**For new projects (no azure.yaml):**
```bash
azd init -e <environment-name> --no-prompt
```

**For existing projects (azure.yaml exists):**
```bash
azd env new <environment-name> --no-prompt
```

Both commands create:
- `.azure/<env-name>/` folder with config files
- Set the environment as default

The environment name becomes part of the resource group name (`rg-<env-name>`).

## Step 4: Check if Resource Group Already Exists

> ⛔ **CRITICAL** — Skip this and you'll hit "Invalid resource group location" errors.

Use the Azure MCP tool to list resource groups:

```
mcp_azure_mcp_group_list
  subscription: <subscription-id>
```

Then check if `rg-<env-name>` exists in the results.

**CLI fallback:**
```bash
az group show --name rg-<env-name> --query "{location:location}" -o json 2>&1
```

**If RG exists:**
- Use `ask_user` to offer choices:
  1. Use existing RG location (show the location)
  2. Choose a different environment name
  3. Delete the existing RG and start fresh

**If RG doesn't exist:** Proceed to location selection.

## Step 5: Check for Tag Conflicts (AZD only)

> ⚠️ AZD uses `azd-service-name` tags to find deployment targets **within the target resource group**. Multiple resources with the same tag in the same RG cause failures. Tags in other RGs are fine.

```bash
az resource list --resource-group rg-<env-name> --tag azd-service-name=<service-name> --query "[].name" -o table
```

Check for each service in `azure.yaml`. If duplicates exist **in the target RG**:

1. **Preferred — Fresh environment**: Run `azd env new <new-name> --no-prompt` and restart from Step 4. Non-destructive, no user confirmation needed, avoids orphan risks.
2. **Alternative — Delete conflicts**: Use `ask_user` to confirm deletion of old resources (required by global rules).

## Step 5a: Check for Existing Container Apps Environments (Container Apps only)

> ⛔ **MANDATORY for Container Apps deployments** — Skip this and `azd up` may silently create a new Container Apps environment with an unexpected name (e.g. `"deployment-prod"`), causing a much longer deployment and environment drift.

**Only run this step if the resource group `rg-<env-name>` already exists (confirmed in Step 4).** If the resource group does not exist yet, skip to Step 6.

If `azure.yaml` includes a Container Apps service and the resource group exists, check for existing Container Apps environments **before** running `azd up`:

```bash
az containerapp env list \
  --resource-group rg-<env-name> \
  --query "[].{name:name, location:location, provisioningState:properties.provisioningState}" \
  -o table
```

**PowerShell:**
```powershell
az containerapp env list `
  --resource-group rg-<env-name> `
  --query "[].{name:name, location:location, provisioningState:properties.provisioningState}" `
  -o table
```

**If no existing environments are found:** No action needed — proceed to Step 6.

**If existing environments are found:** Check the `provisioningState` column in the output. Environments with a state of `Failed` or `Deleting` are not usable — treat them the same as no conflict (proceed to Step 6), or use option 3 below to delete the stuck environment first.

For environments with a `provisioningState` of `Succeeded`, use `ask_user` to present the conflict and offer choices:

```
ask_user(
  question: "I found existing Container Apps environment(s) in rg-<env-name>:
    <environment-list>
  Proceeding without resolving this conflict may cause azd to create an additional environment.
  How would you like to proceed?",
  choices: [
    "Use the existing environment — select the matching AZD environment (Recommended)",
    "Choose a different AZD environment name to deploy to a new resource group",
    "Delete the existing Container Apps environment and start fresh (DESTRUCTIVE)"
  ]
)
```

**Resolution per choice:**

1. **Use existing environment** — First check if the matching AZD environment exists locally:
   ```bash
   azd env list
   ```
   - **If the environment exists locally**, select it:
     ```bash
     azd env select <matching-env-name>
     ```
   - **If the environment does NOT exist locally** (e.g., it was provisioned on a different machine or has been cleaned up), create it and configure it to target the existing resource group:
     ```bash
     azd env new <matching-env-name> --no-prompt
     azd env set AZURE_SUBSCRIPTION_ID <subscription-id>
     azd env set AZURE_LOCATION <location-of-existing-rg>
     ```

2. **Choose a different name** — Create a new AZD environment:
   ```bash
   azd env new <new-unique-env-name> --no-prompt
   azd env set AZURE_SUBSCRIPTION_ID <subscription-id>
   # Then restart from Step 4 with the new environment name
   ```

3. **Delete and start fresh** — Delete the conflicting environment (requires `ask_user` confirmation per global-rules):
   ```bash
   az containerapp env delete \
     --name <environment-name> \
     --resource-group rg-<env-name> \
     --yes
   ```

   **PowerShell:**
   ```powershell
   az containerapp env delete `
     --name <environment-name> `
     --resource-group rg-<env-name> `
     --yes
   ```

## Step 6: Prompt User for Location

**You MUST use `ask_user`** with regions that support ALL services in the architecture.

See [Region Availability](region-availability.md) for service-specific limitations.

## Step 7: Set Environment Variables

> ⚠️ **Set ALL variables BEFORE running `azd up`** — not during error recovery.

Environment should already be configured during **azure-validate**. Run `azd env get-values` to confirm.

Verify settings:
```bash
azd env get-values
```

## Step 8: Only NOW Run Deployment

```bash
azd up --no-prompt
```

---

## Step 9: Verify Terraform Variable Resolution (AZD+Terraform Only)

> ⚠️ **MANDATORY for azd+Terraform projects.** Skip this step for Bicep or pure Terraform deployments.

Before running `azd up`, verify no Go-style template variables exist in Terraform files:

```bash
# Fail if Go-style template variables found in Terraform files
if grep -rn '{{ *\.Env\.' infra/ --include='*.tf' --include='*.tfvars.json'; then
  echo "ERROR: Unresolved Go-style template variables found"
  exit 1
fi

# Check main.tfvars.json uses correct ${VAR} syntax (not Go-style templates)
if test -f infra/main.tfvars.json; then
  if grep -q '{{ *\.Env\.' infra/main.tfvars.json; then
    echo "ERROR: main.tfvars.json uses Go-style templates. Use \${VAR} syntax instead."
    exit 1
  fi
fi
```

**If either check fails:**
1. Fix `main.tfvars.json` syntax: replace `{{ .Env.VAR }}` with `${VAR}` (e.g., `${AZURE_ENV_NAME}`)
2. For variables not in `main.tfvars.json`, use `TF_VAR_*` environment variables
3. Re-run `azure-validate` before proceeding

---

## Quick Reference: Correct AZD Sequence

```bash
# 1. Create environment FIRST
azd env new myapp-dev --no-prompt

# 2. Set subscription
azd env set AZURE_SUBSCRIPTION_ID 25fd0362-...

# 3. Set location (after checking RG doesn't conflict)
azd env set AZURE_LOCATION westus2

# 4. Verify
azd env get-values

# 5. Deploy
azd up --no-prompt
```

## Common Mistakes to Avoid

| ❌ Wrong | ✅ Correct |
|----------|-----------|
| `azd up --location eastus2` | `azd env set AZURE_LOCATION eastus2` then `azd up` |
| Running `azd up` without environment | `azd env new <name> --no-prompt` first |
| Assuming location without checking RG | Check `az group show` before choosing |
| Ignoring tag conflicts in target RG | Check `az resource list --resource-group rg-<env-name>` before deploy |
| Skipping Container Apps environment check | Run `az containerapp env list --resource-group rg-<env-name>` before deploy (Step 5a) |

---

## Service-Specific Checks

### Container Apps + ACR — Pre-Deploy RBAC Health Check

> **⛔ MANDATORY**: If the plan includes Container Apps that pull images from ACR using a managed identity, you **MUST** use this two-phase flow: `azd provision` → RBAC health check → `azd deploy`. **Do not use `azd up` for this scenario**, because `azd up` combines provisioning and deployment and can skip the required propagation gate. You must confirm the `AcrPull` role assignment has propagated **before** running `azd deploy`. Skipping this check causes the Container App revision to time out (~900 seconds) waiting for image pull permission — a known Azure RBAC propagation delay.

This check is **required** when ALL of the following are true:
- `azure.yaml` includes a Container App service
- The Bicep template assigns an `AcrPull` role for the Container App's managed identity on ACR using the two-phase deployment pattern
- Infrastructure was just provisioned with `azd provision` and application deployment has not yet started

> 💡 **Two-phase Bicep pattern:** With the recommended two-phase deployment pattern, `azd provision` succeeds immediately because the Container App is provisioned with a public placeholder image (not an ACR image). The AcrPull role assignment is deployed in a separate module with no circular dependency. `azd deploy` then configures the registry/identity link (the equivalent CLI step is `az containerapp registry set --name <app-name> --resource-group rg-<environment-name> --server <acr-login-server> --identity system`) and pushes the real image via the Azure API — but the AcrPull role still needs time to propagate before this succeeds.

**Required flow for this scenario:**
1. Run `azd provision`
2. Complete the RBAC health check in this section
3. Run `azd deploy`
**Step A — Get the Container App's managed identity principal ID:**

```bash
PRINCIPAL_ID=$(az containerapp identity show \
  --name <app-name> \
  --resource-group rg-<env-name> \
  --query principalId -o tsv)
```

**PowerShell:**
```powershell
$PrincipalId = az containerapp identity show `
  --name <app-name> `
  --resource-group rg-<env-name> `
  --query principalId -o tsv
```

**Step B — Get the ACR resource ID:**

```bash
ACR_ID=$(az acr show \
  --name <acr-name> \
  --resource-group rg-<env-name> \
  --query id -o tsv)
```

**PowerShell:**
```powershell
$AcrId = az acr show `
  --name <acr-name> `
  --resource-group rg-<env-name> `
  --query id -o tsv
```

**Step C — Poll until the `AcrPull` role is visible (up to 5 minutes):**

```bash
for attempt in 1 2 3 4 5; do
  ROLE=$(az role assignment list \
    --scope "$ACR_ID" \
    --assignee-object-id "$PRINCIPAL_ID" \
    --query "[?roleDefinitionName=='AcrPull'].roleDefinitionName" \
    -o tsv 2>/dev/null)

  if printf '%s\n' "$ROLE" | grep -qx 'AcrPull'; then
    echo "AcrPull role confirmed. Proceeding with azd deploy."
    break
  fi

  if [ "$attempt" -eq 5 ]; then
    echo "AcrPull role not found after 5 minutes. Assign it manually before retrying."
    exit 1
  fi

  echo "Waiting for AcrPull RBAC propagation (attempt $attempt/5, waiting 60s)..."
  sleep 60
done
```

**PowerShell:**
```powershell
for ($attempt = 1; $attempt -le 5; $attempt++) {
    $Role = az role assignment list `
      --scope $AcrId `
      --assignee-object-id $PrincipalId `
      --query "[?roleDefinitionName=='AcrPull'].roleDefinitionName" `
      -o tsv 2>$null

    if ($Role -eq "AcrPull") {
        Write-Output "AcrPull role confirmed. Proceeding with azd deploy."
        break
    }

    if ($attempt -eq 5) {
        Write-Output "AcrPull role not found after 5 minutes. Assign it manually before retrying."
        exit 1
    }

    Write-Output "Waiting for AcrPull RBAC propagation (attempt $attempt/5, waiting 60s)..."
    Start-Sleep -Seconds 60
}
```

Only after this check confirms `AcrPull` has propagated should you run `azd deploy --no-prompt`.

> 💡 **Tip:** If `AcrPull` is missing entirely, assign it manually using the steps in [Container App Revision Timeout](recipes/azd/errors.md#container-app-revision-timeout), then re-run the poll loop above.

---

### AZD/Bicep — Non-User Principal RBAC Fix

> **⛔ MANDATORY**: If the deploying identity is NOT an interactive user (e.g., service principal in CI/CD), you **MUST** check and patch Bicep templates that hardcode user-type RBAC role assignments. Skipping this causes `PrincipalType` mismatch errors during provisioning, leading to costly retry loops and potential test timeouts.

This check is **required** when ALL of the following are true:
- The deployment uses AZD with Bicep infrastructure
- The deploying identity is not an interactive user (service principal, managed identity, etc.)
- The Bicep templates contain `allowUserIdentityPrincipal` set to `true` or role assignments with `principalType: 'User'`

> ⚠️ **Known affected templates:** `functions-quickstart-python-http-azd` and other AZD quickstart templates that include optional user-identity RBAC. See [Principal Type Mismatch](recipes/azd/errors.md#principal-type-mismatch) for details.

**Step A — Detect the deploying identity type:**

```bash
AUTH_TYPE=$(az account show --query user.type -o tsv)
echo "Auth type: $AUTH_TYPE"
```

**PowerShell:**
```powershell
$AuthType = az account show --query user.type -o tsv
Write-Output "Auth type: $AuthType"
```

If `AUTH_TYPE` is `user`, skip to the next section — no fix needed.

**Step B — Search for user-type RBAC in Bicep templates:**

```bash
grep -rn "allowUserIdentityPrincipal" infra/ --include='*.bicep'
```

**PowerShell:**
```powershell
Select-String -Path infra\*.bicep -Pattern 'allowUserIdentityPrincipal' -Recurse
```

If no matches are found, skip to the next section.

**Step C — Patch `allowUserIdentityPrincipal` to `false`:**

For each match where `allowUserIdentityPrincipal` is set to `true`, change it to `false`:

```bicep
// Before (fails with service principal deployments):
allowUserIdentityPrincipal: true

// After (CI/CD compatible):
allowUserIdentityPrincipal: false
```

> ⚠️ **This is a CI/CD compatibility patch.** Setting this to `false` disables optional interactive-user RBAC role assignments. The application's managed identity roles are unaffected. If the user later needs local interactive access, they can re-enable this flag or assign roles manually.

> ⚠️ **Do NOT** attempt to fix this by clearing `AZURE_PRINCIPAL_ID`. The `azd` CLI repopulates this value from the current auth context on every run.

---

### Durable Functions — Verify DTS Backend

> **⛔ MANDATORY**: If the plan includes Durable Functions, verify infrastructure uses **Durable Task Scheduler** (DTS), NOT Azure Storage.

Check that `infra/` Bicep files contain:
- `Microsoft.DurableTask/schedulers` resource
- `Microsoft.DurableTask/schedulers/taskHubs` child resource
- `Durable Task Data Contributor` RBAC role assignment
- `DURABLE_TASK_SCHEDULER_CONNECTION_STRING` app setting

If any are missing, **STOP** and invoke **azure-prepare** to regenerate with the durable recipe.

---

## Non-AZD Deployments

**For Azure CLI / Bicep:**
```bash
az account set --subscription <subscription-id-or-name>
# Pass location as parameter: --location <location>
```

**For Terraform:**
```bash
az account set --subscription <subscription-id-or-name>
# Set in terraform.tfvars or -var="location=<location>"
```
