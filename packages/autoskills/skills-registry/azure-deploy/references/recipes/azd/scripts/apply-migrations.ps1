# Apply EF Core database migrations to Azure SQL using Managed Identity authentication.
#
# USAGE: Copy this file to scripts/apply-migrations.ps1 in your project root and add
#        a postprovision hook in azure.yaml:
#
#   hooks:
#     postprovision:
#       posix:
#         shell: sh
#         run: ./scripts/apply-migrations.sh
#       windows:
#         shell: pwsh
#         run: ./scripts/apply-migrations.ps1
#
# ENVIRONMENT VARIABLES (sourced from azd env):
#   SQL_SERVER    - SQL server name (without .database.windows.net)
#   SQL_DATABASE  - Database name
#
# PREREQUISITES:
#   - dotnet-ef tool (installed automatically if missing)
#   - A valid managed identity or Entra-authenticated session
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

# Install dotnet-ef if not already installed (no-op when already present)
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
