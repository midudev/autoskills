#!/bin/bash
# Grant Azure SQL data-plane access to the managed identity AND apply EF Core migrations.
#
# USAGE: Copy this file to scripts/grant-and-migrate.sh in your project root and add
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

# Determine app identity name (App Service uses SERVICE_WEB_NAME, APIs use SERVICE_API_NAME)
APP_NAME=${SERVICE_WEB_NAME:-$SERVICE_API_NAME}

if [ -z "$APP_NAME" ]; then
  echo "ERROR: Neither SERVICE_WEB_NAME nor SERVICE_API_NAME is set in azd environment." >&2
  exit 1
fi

# ─── Step 1: Grant SQL data-plane access ────────────────────────────────────
echo "Granting SQL data-plane access to managed identity: $APP_NAME"

# Ensure the rdbms-connect extension is installed (provides 'az sql db query')
if ! az extension show --name rdbms-connect >/dev/null 2>&1; then
  echo "Installing Azure CLI extension: rdbms-connect"
  if ! az extension add --name rdbms-connect --yes; then
    echo "ERROR: Failed to install required Azure CLI extension 'rdbms-connect'. Cannot continue with 'az sql db query'." >&2
    exit 1
  fi
fi

az sql db query \
  --server "$SQL_SERVER" \
  --database "$SQL_DATABASE" \
  --resource-group "$AZURE_RESOURCE_GROUP" \
  --auth-mode ActiveDirectoryDefault \
  --queries "
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '$APP_NAME')
      CREATE USER [$APP_NAME] FROM EXTERNAL PROVIDER;

    IF NOT EXISTS (
      SELECT 1 FROM sys.database_role_members drm
      JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
      JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
      WHERE r.name = 'db_datareader' AND m.name = '$APP_NAME'
    )
      ALTER ROLE db_datareader ADD MEMBER [$APP_NAME];

    IF NOT EXISTS (
      SELECT 1 FROM sys.database_role_members drm
      JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
      JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
      WHERE r.name = 'db_datawriter' AND m.name = '$APP_NAME'
    )
      ALTER ROLE db_datawriter ADD MEMBER [$APP_NAME];

    IF NOT EXISTS (
      SELECT 1 FROM sys.database_role_members drm
      JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
      JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
      WHERE r.name = 'db_ddladmin' AND m.name = '$APP_NAME'
    )
      ALTER ROLE db_ddladmin ADD MEMBER [$APP_NAME];
  "

echo "SQL access granted successfully."

# ─── Step 2: Apply EF Core migrations ───────────────────────────────────────
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
