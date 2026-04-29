#!/bin/bash
# Apply EF Core database migrations to Azure SQL using Managed Identity authentication.
#
# USAGE: Copy this file to scripts/apply-migrations.sh in your project root and add
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
#   Set APP_PROJECT_PATH below to the path of your application project (.csproj directory)

set -e

APP_PROJECT_PATH="src/api"  # Adjust to your project directory

# Safely load azd environment variables without eval
while IFS= read -r line; do
  [ -n "$line" ] || continue
  key=${line%%=*}
  value=${line#*=}
  case "$value" in
    \"*\") value=${value#\"}; value=${value%\"} ;;
    \'*\') value=${value#\'}; value=${value%\'} ;;
  esac
  export "$key=$value"
done < <(azd env get-values)

# Install dotnet-ef only when it is not already installed (no-op when already present)
if ! dotnet tool list --global 2>/dev/null | grep -q '^\s*dotnet-ef\s'; then
  dotnet tool install --global dotnet-ef
fi
export PATH="$PATH:$HOME/.dotnet/tools"

CONNECTION_STRING="Server=tcp:${SQL_SERVER}.database.windows.net,1433;Database=${SQL_DATABASE};Authentication=Active Directory Default;Encrypt=True;"

echo "Applying EF Core migrations..."
cd "$APP_PROJECT_PATH"
dotnet ef database update --connection "$CONNECTION_STRING"
echo "Migrations applied successfully."
