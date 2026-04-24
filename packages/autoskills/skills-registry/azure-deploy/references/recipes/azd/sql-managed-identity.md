# SQL Managed Identity Access

Grant Azure managed identities database permissions on Azure SQL with Entra authentication.

## Prerequisites

- Azure SQL Server with Entra ID admin configured
- App Service/Container App with system-assigned managed identity
- Your account is Entra ID admin on SQL Server
- Azure CLI: `az login`
- Azure CLI `rdbms-connect` extension: `az extension add --name rdbms-connect --yes`

## Quick Grant

```bash
eval $(azd env get-values)
APP_NAME=$(echo "$SERVICE_API_NAME")  # or SERVICE_WEB_NAME

az sql db query \
  --server "$SQL_SERVER" \
  --database "$SQL_DATABASE" \
  --resource-group "$AZURE_RESOURCE_GROUP" \
  --auth-mode ActiveDirectoryDefault \
  --queries "
    CREATE USER [$APP_NAME] FROM EXTERNAL PROVIDER;
    ALTER ROLE db_datareader ADD MEMBER [$APP_NAME];
    ALTER ROLE db_datawriter ADD MEMBER [$APP_NAME];
    ALTER ROLE db_ddladmin ADD MEMBER [$APP_NAME];
  "
```

**PowerShell:**
```powershell
azd env get-values | ForEach-Object {
    $name, $value = $_.Split('=', 2)
    Set-Item "env:$name" $value
}
$AppName = $env:SERVICE_API_NAME  # or SERVICE_WEB_NAME

$SqlQuery = @"
CREATE USER [$AppName] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [$AppName];
ALTER ROLE db_datawriter ADD MEMBER [$AppName];
ALTER ROLE db_ddladmin ADD MEMBER [$AppName];
"@

az sql db query `
  --server $env:SQL_SERVER `
  --database $env:SQL_DATABASE `
  --resource-group $env:AZURE_RESOURCE_GROUP `
  --auth-mode ActiveDirectoryDefault `
  --queries $SqlQuery
```

## Database Roles

| Role | Permissions | Use For |
|------|------------|---------|
| `db_datareader` | SELECT | Read-only queries |
| `db_datawriter` | INSERT, UPDATE, DELETE | CRUD operations |
| `db_ddladmin` | CREATE, ALTER, DROP schema | EF migrations |
| `db_owner` | Full control | Admin (use sparingly) |

**Standard app (read/write/migrations):** All three roles above.  
**Read-only app:** Only `db_datareader`.

## Automate with azd Hook

Add `postprovision` hook to `azure.yaml`:

```yaml
hooks:
  postprovision:
    shell: sh
    run: ./scripts/grant-sql-access.sh
```

**scripts/grant-sql-access.sh:**

```bash
#!/bin/bash
set -e
eval $(azd env get-values)

az sql db query \
  --server "$SQL_SERVER" \
  --database "$SQL_DATABASE" \
  --resource-group "$AZURE_RESOURCE_GROUP" \
  --auth-mode ActiveDirectoryDefault \
  --queries "
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '$SERVICE_API_NAME')
      CREATE USER [$SERVICE_API_NAME] FROM EXTERNAL PROVIDER;
    
    IF NOT EXISTS (
      SELECT 1 FROM sys.database_role_members drm
      JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
      JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
      WHERE r.name = 'db_datareader' AND m.name = '$SERVICE_API_NAME'
    )
      ALTER ROLE db_datareader ADD MEMBER [$SERVICE_API_NAME];
    
    IF NOT EXISTS (
      SELECT 1 FROM sys.database_role_members drm
      JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
      JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
      WHERE r.name = 'db_datawriter' AND m.name = '$SERVICE_API_NAME'
    )
      ALTER ROLE db_datawriter ADD MEMBER [$SERVICE_API_NAME];
    
    IF NOT EXISTS (
      SELECT 1 FROM sys.database_role_members drm
      JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
      JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
      WHERE r.name = 'db_ddladmin' AND m.name = '$SERVICE_API_NAME'
    )
      ALTER ROLE db_ddladmin ADD MEMBER [$SERVICE_API_NAME];
  "
```

**scripts/grant-sql-access.ps1:**

```powershell
$ErrorActionPreference = 'Stop'
azd env get-values | ForEach-Object {
    $name, $value = $_.Split('=', 2)
    Set-Item "env:$name" $value
}

$SqlQuery = @"
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '$($env:SERVICE_API_NAME)')
  CREATE USER [$($env:SERVICE_API_NAME)] FROM EXTERNAL PROVIDER;

IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_datareader' AND m.name = '$($env:SERVICE_API_NAME)'
)
  ALTER ROLE db_datareader ADD MEMBER [$($env:SERVICE_API_NAME)];

IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_datawriter' AND m.name = '$($env:SERVICE_API_NAME)'
)
  ALTER ROLE db_datawriter ADD MEMBER [$($env:SERVICE_API_NAME)];

IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_ddladmin' AND m.name = '$($env:SERVICE_API_NAME)'
)
  ALTER ROLE db_ddladmin ADD MEMBER [$($env:SERVICE_API_NAME)];
"@

az sql db query `
  --server $env:SQL_SERVER `
  --database $env:SQL_DATABASE `
  --resource-group $env:AZURE_RESOURCE_GROUP `
  --auth-mode ActiveDirectoryDefault `
  --queries $SqlQuery
```

> 💡 Make executable: `chmod +x scripts/*.sh`.

## Verification

```bash
eval $(azd env get-values)
APP_NAME=$SERVICE_API_NAME  # or SERVICE_WEB_NAME

az sql db query --server "$SQL_SERVER" --database "$SQL_DATABASE" \
  --auth-mode ActiveDirectoryDefault --queries "
    SELECT dp.name AS UserName, dr.name AS RoleName
    FROM sys.database_principals dp
    JOIN sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
    JOIN sys.database_principals dr ON drm.role_principal_id = dr.principal_id
    WHERE dp.name = '$APP_NAME'
  "
```

**PowerShell:**
```powershell
azd env get-values | ForEach-Object {
    $name, $value = $_.Split('=', 2)
    Set-Item "env:$name" $value
}
$AppName = $env:SERVICE_API_NAME  # or SERVICE_WEB_NAME

$SqlQuery = @"
SELECT dp.name AS UserName, dr.name AS RoleName
FROM sys.database_principals dp
JOIN sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
JOIN sys.database_principals dr ON drm.role_principal_id = dr.principal_id
WHERE dp.name = '$AppName'
"@

az sql db query --server $env:SQL_SERVER --database $env:SQL_DATABASE `
  --auth-mode ActiveDirectoryDefault --queries $SqlQuery
```

Expected: UserName matches `$APP_NAME`, RoleName includes `db_datareader`, `db_datawriter`, `db_ddladmin`.

## Troubleshooting

| Error | Solution |
|-------|----------|
| "Cannot find the user" | Verify identity exists: `az webapp identity show` or `az containerapp identity show` |
| "Principal does not have permission" | Check you're Entra admin: `az sql server ad-admin list` |
| "Login failed for user" | Run CREATE USER commands from this guide |

**Idempotent Script Pattern:**

```sql
-- Check if user exists before creating
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'my-app')
  CREATE USER [my-app] FROM EXTERNAL PROVIDER;

-- Check role membership before adding
IF NOT EXISTS (
  SELECT 1 FROM sys.database_role_members drm
  JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
  JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
  WHERE r.name = 'db_datareader' AND m.name = 'my-app'
)
  ALTER ROLE db_datareader ADD MEMBER [my-app];
```

## References

- [SQL Entra Authentication](sql-entra-auth.md)
- [EF Core Migrations](ef-migrations.md)
- [Post-Deployment Guide](post-deployment.md)
