# Azure CLI Verification

```bash
az resource list --resource-group <rg-name> --output table
```

## Health Check

```bash
curl -s https://<endpoint>/health | jq .
```

## Container Apps

```bash
az containerapp revision list \
  --name <app-name> \
  --resource-group <rg-name> \
  --query "[].{name:name, active:properties.active}" \
  --output table
```

## App Service

```bash
az webapp show \
  --name <app-name> \
  --resource-group <rg-name> \
  --query "{state:state, hostNames:hostNames}"
```

## Report Results to User

> ⛔ **MANDATORY** — You **MUST** present the deployed endpoint URLs to the user in your response.

Extract endpoints using the appropriate command for the service type:

```bash
# Container Apps
FQDN=$(az containerapp show --name <app-name> --resource-group <rg-name> --query "properties.configuration.ingress.fqdn" -o tsv)
echo "https://$FQDN"

# App Service
HOSTNAME=$(az webapp show --name <app-name> --resource-group <rg-name> --query "defaultHostName" -o tsv)
echo "https://$HOSTNAME"

# Static Web Apps
HOSTNAME=$(az staticwebapp show --name <app-name> --resource-group <rg-name> --query "defaultHostname" -o tsv)
echo "https://$HOSTNAME"
```

**PowerShell:**
```powershell
# Container Apps
$Fqdn = az containerapp show --name <app-name> --resource-group <rg-name> --query "properties.configuration.ingress.fqdn" -o tsv
Write-Output "https://$Fqdn"

# App Service
$Hostname = az webapp show --name <app-name> --resource-group <rg-name> --query "defaultHostName" -o tsv
Write-Output "https://$Hostname"

# Static Web Apps
$Hostname = az staticwebapp show --name <app-name> --resource-group <rg-name> --query "defaultHostname" -o tsv
Write-Output "https://$Hostname"
```

> ⚠️ **These commands return bare hostnames without a scheme.** Always prepend `https://` when presenting URLs to the user. For example, report `https://myapp.azurewebsites.net`, never `myapp.azurewebsites.net`.

Present a summary including all service URLs as fully-qualified `https://` links. Do NOT end your response without including them.
