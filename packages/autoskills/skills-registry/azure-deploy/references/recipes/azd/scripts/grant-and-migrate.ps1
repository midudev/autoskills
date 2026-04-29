# Grant Azure SQL data-plane access to the managed identity AND apply EF Core migrations.
#
# USAGE: Copy this file to scripts/grant-and-migrate.ps1 in your project root and add
#        a postprovision hook in azure.yaml:
#
#   hooks:
#     postprovision:
#       posix:
#         shell: sh
#         run: ./scripts/grant-and-migrate.sh
#       windows:
#         shell: pwsh
#         run: ./scripts/grant-and-migrate.ps1
#
# ENVIRONMENT VARIABLES (sourced from azd env):
#   SQL_SERVER           - SQL server name (without .database.windows.net)
#   SQL_DATABASE         - Database name
#   AZURE_RESOURCE_GROUP - Resource group name
#   SERVICE_WEB_NAME     - App Service name (used when set, takes priority)
#   SERVICE_API_NAME     - API service name (fallback when SERVICE_WEB_NAME is not set)
#
# CONFIGURATION:
#   Set $AppProjectPath below to the path of your application project (.csproj directory)

$ErrorActionPreference = 'Stop'

$AppProjectPath = "src/api"  # Adjust to your project directory

# Load azd environment variables
azd env get-values | ForEach-Object {
    $name, $value = $_.Split('=', 2)
    Set-Item "env:$name" $value.Trim('"')
}

# Determine app identity name (App Service uses SERVICE_WEB_NAME, APIs use SERVICE_API_NAME)
$AppName = if ($env:SERVICE_WEB_NAME) { $env:SERVICE_WEB_NAME } else { $env:SERVICE_API_NAME }

if (-not $AppName) {
    throw "ERROR: Neither SERVICE_WEB_NAME nor SERVICE_API_NAME is set in azd environment."
}

# ─── Step 1: Grant SQL data-plane access ────────────────────────────────────
Write-Host "Granting SQL data-plane access to managed identity: $AppName"

$SqlQuery = @"
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '$AppName')
  CREATE USER [$AppName] FROM EXTERNAL PROVIDER;

IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_datareader' AND m.name = '$AppName'
)
  ALTER ROLE db_datareader ADD MEMBER [$AppName];

IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_datawriter' AND m.name = '$AppName'
)
  ALTER ROLE db_datawriter ADD MEMBER [$AppName];

IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_ddladmin' AND m.name = '$AppName'
)
  ALTER ROLE db_ddladmin ADD MEMBER [$AppName];
"@

# Ensure the rdbms-connect extension is installed (provides 'az sql db query')
az extension show --name rdbms-connect 1>$null 2>$null
if ($LASTEXITCODE -ne 0) {
    az extension add --name rdbms-connect --yes
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install Azure CLI extension 'rdbms-connect', which is required for 'az sql db query'."
    }
}

az sql db query `
  --server $env:SQL_SERVER `
  --database $env:SQL_DATABASE `
  --resource-group $env:AZURE_RESOURCE_GROUP `
  --auth-mode ActiveDirectoryDefault `
  --queries $SqlQuery

Write-Host "SQL access granted successfully."

# ─── Step 2: Apply EF Core migrations ───────────────────────────────────────
# Install dotnet-ef only when it is not already installed
$globalTools = dotnet tool list --global 2>$null
if ($LASTEXITCODE -ne 0) {
    throw "Failed to list globally installed .NET tools."
}
if (-not ($globalTools | Select-String -Pattern '^\s*dotnet-ef\s')) {
    dotnet tool install --global dotnet-ef
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install dotnet-ef."
    }
}
$env:PATH += ";$env:USERPROFILE\.dotnet\tools"

$ConnectionString = "Server=tcp:$($env:SQL_SERVER).database.windows.net,1433;Database=$($env:SQL_DATABASE);Authentication=Active Directory Default;Encrypt=True;"

Write-Host "Applying EF Core migrations..."
Set-Location $AppProjectPath
dotnet ef database update --connection $ConnectionString
Write-Host "Migrations applied successfully."
