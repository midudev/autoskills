# AZD Verification

Verify deployment success and application health.

## Step 1: Verify Resources

```bash
azd show
```

Expected output:
```text
Showing deployed resources:
  Resource Group: rg-myapp-dev
  Services:
    api - Endpoint: https://api-xxxx.azurecontainerapps.io
```

## Step 2: Health Check

```bash
# Get endpoint
ENDPOINT=$(azd env get-values | grep -E "SERVICE_.*_URI|.*_ENDPOINT" | head -1 | cut -d'=' -f2)

# Test endpoint
curl -f "$ENDPOINT/health" || curl -f "$ENDPOINT"
```

**PowerShell:**
```powershell
# Get endpoint
$Endpoint = azd env get-values | Select-String -Pattern 'SERVICE_.*_URI|.*_ENDPOINT' |
    Select-Object -First 1 | ForEach-Object { ($_ -split '=', 2)[1] }

# Test endpoint
try { Invoke-WebRequest "$Endpoint/health" } catch { Invoke-WebRequest $Endpoint }
```

Expected: HTTP 200 response.

## Step 3: Report Results to User

> ⛔ **MANDATORY** — You **MUST** present the deployed endpoint URLs to the user in your response. A deployment is not considered complete until the user has received the URLs.

> ⛔ **ALWAYS run `azd show`** after deployment to extract endpoint URLs. Do NOT rely on the `azd deploy` output alone — it is frequently truncated before endpoint URLs appear.

```bash
azd show
```

Parse the `Endpoint:` lines from the `azd show` output to collect all deployed service URLs.

**Present a summary to the user that includes:**

| Item | Source |
|------|--------|
| Deployed service endpoint(s) | `Endpoint:` lines from `azd show` |
| Aspire Dashboard URL (if applicable) | `Aspire Dashboard:` line from `azd show` |
| Azure Portal deployment link (if available) | Portal URL from provisioning output |

Example response format:

```text
✅ Deployment succeeded!

| Service | Endpoint |
|---------|----------|
| apiservice | https://apiservice.xxx.azurecontainerapps.io |

Aspire Dashboard: https://aspire-dashboard.xxx.azurecontainerapps.io
```

> ⚠️ **Always use fully-qualified URLs with the `https://` scheme.** If a command returns a bare hostname (e.g. `myapp.azurestaticapps.net`), prepend `https://` before presenting it to the user.

## Step 4: Post-Deployment Verification (if applicable)

For deployments with Azure SQL Database and managed identity:

### Verify SQL Access

> ⚠️ **Warning:** `az sql db query` requires the `rdbms-connect` extension: `az extension add --name rdbms-connect --yes`

```bash
# Load environment variables
eval $(azd env get-values)

# Check managed identity user exists in database
az sql db query \
  --server "$SQL_SERVER" \
  --database "$SQL_DATABASE" \
  --resource-group "$AZURE_RESOURCE_GROUP" \
  --auth-mode ActiveDirectoryDefault \
  --queries "SELECT name, type_desc FROM sys.database_principals WHERE type = 'E'"
```

**PowerShell:**
```powershell
# Load environment variables
azd env get-values | ForEach-Object {
    $name, $value = $_.Split('=', 2)
    Set-Item "env:$name" $value
}

# Check managed identity user exists in database
az sql db query `
  --server $env:SQL_SERVER `
  --database $env:SQL_DATABASE `
  --resource-group $env:AZURE_RESOURCE_GROUP `
  --auth-mode ActiveDirectoryDefault `
  --queries "SELECT name, type_desc FROM sys.database_principals WHERE type = 'E'"
```

**Expected:** Should list the App Service or Container App managed identity.

### Verify Database Schema

For EF Core applications:

```bash
# Check tables exist
az sql db query \
  --server "$SQL_SERVER" \
  --database "$SQL_DATABASE" \
  --resource-group "$AZURE_RESOURCE_GROUP" \
  --auth-mode ActiveDirectoryDefault \
  --queries "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'"
```

**PowerShell:**
```powershell
az sql db query `
  --server $env:SQL_SERVER `
  --database $env:SQL_DATABASE `
  --resource-group $env:AZURE_RESOURCE_GROUP `
  --auth-mode ActiveDirectoryDefault `
  --queries "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'"
```

**Expected:** Should list application tables (not just `__EFMigrationsHistory`).

### Check Application Logs

```bash
# For App Service
az webapp log tail --name <app-name> --resource-group <resource-group>

# For Container Apps
az containerapp logs show --name <app-name> --resource-group <resource-group> --follow
```

**Look for:**
- ✅ No SQL authentication errors
- ✅ Successful database connection
- ✅ Application started successfully

## Common Issues

| Symptom | Cause | Fix |
|---------|-------|-----|
| HTTP 500 on startup | SQL authentication failure | See [sql-managed-identity.md](sql-managed-identity.md) |
| "Invalid object name" errors | Migrations not applied | See [ef-migrations.md](ef-migrations.md) |
| Endpoint not accessible | Service still starting | Wait 1-2 minutes, retry |
| Health check fails | Application error | Check logs with `az webapp log tail` |

## References

- [Post-Deployment Steps](post-deployment.md)
- [SQL Managed Identity Access](sql-managed-identity.md)
- [EF Core Migrations](ef-migrations.md)
