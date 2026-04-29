# EF Core Migrations Deployment

Apply Entity Framework Core migrations to Azure SQL Database after deployment.

## Detection

EF Core projects contain `Migrations/` folder or `Microsoft.EntityFrameworkCore` package reference in `.csproj`.

```bash
find . -type d -name "Migrations" 2>/dev/null
find . -name "*.csproj" -exec grep -l "Microsoft.EntityFrameworkCore" {} \;
```

**PowerShell:**
```powershell
Get-ChildItem -Recurse -Directory -Filter "Migrations" -ErrorAction SilentlyContinue
Get-ChildItem -Recurse -Filter "*.csproj" | Select-String -List "Microsoft.EntityFrameworkCore" | Select-Object -ExpandProperty Path
```

## Deployment Methods

### Method 1: azd Hook (Recommended)

Automate via `postprovision` hook in `azure.yaml`:

```yaml
hooks:
  postprovision:
    posix:
      shell: sh
      run: ./scripts/apply-migrations.sh
    windows:
      shell: pwsh
      run: ./scripts/apply-migrations.ps1
```

**Copy the pre-built scripts** — Read [scripts/apply-migrations.sh](scripts/apply-migrations.sh) and [scripts/apply-migrations.ps1](scripts/apply-migrations.ps1) and write them verbatim to the project's `scripts/` folder. Adjust `APP_PROJECT_PATH` / `$AppProjectPath` in the script to the location of the `.csproj` directory.

Key behaviours of the scripts:
- Loads `azd env get-values` safely (no `eval`)
- Installs `dotnet-ef` automatically when not present; no-op when already installed
- Fails on genuine install errors (network failure, missing SDK)
- Adds `~/.dotnet/tools` to `PATH` so the tool is immediately available

> 💡 Make executable: `chmod +x scripts/*.sh`.

### Method 2: SQL Script (Production)

Generate idempotent script for review before applying:

> ⚠️ **Warning:** `az sql db query` requires the `rdbms-connect` extension: `az extension add --name rdbms-connect --yes`

```bash
dotnet ef migrations script --idempotent --output migrations.sql
az sql db query --server "$SQL_SERVER" --database "$SQL_DATABASE" \
  --auth-mode ActiveDirectoryDefault --queries "$(cat migrations.sql)"
```

**PowerShell:**
```powershell
dotnet ef migrations script --idempotent --output migrations.sql
$MigrationsSql = Get-Content migrations.sql -Raw
az sql db query --server $env:SQL_SERVER --database $env:SQL_DATABASE `
  --auth-mode ActiveDirectoryDefault --queries $MigrationsSql
```

### Method 3: Application Startup (Dev Only)

⚠️ **Development only** — production should use explicit migration steps.

```csharp
// Program.cs
if (app.Environment.IsDevelopment()) {
    using var scope = app.Services.CreateScope();
    scope.ServiceProvider.GetRequiredService<ApplicationDbContext>().Database.Migrate();
}
```

## Combined Hook: SQL Access + Migrations

Combine both steps in a single `postprovision` hook using the pre-built combined scripts:

```yaml
hooks:
  postprovision:
    posix:
      shell: sh
      run: ./scripts/grant-and-migrate.sh
    windows:
      shell: pwsh
      run: ./scripts/grant-and-migrate.ps1
```

**Copy the pre-built scripts** — Read [scripts/grant-and-migrate.sh](scripts/grant-and-migrate.sh) and [scripts/grant-and-migrate.ps1](scripts/grant-and-migrate.ps1) and write them verbatim to the project's `scripts/` folder. Adjust `APP_PROJECT_PATH` / `$AppProjectPath` in the script to the location of the `.csproj` directory.

> 💡 Make executable: `chmod +x scripts/*.sh`

## Prerequisites

Install EF Core tools:

```bash
dotnet tool install --global dotnet-ef
dotnet ef --version  # Verify installation
```

## Connection String

```
Server=tcp:{server}.database.windows.net,1433;Database={database};Authentication=Active Directory Default;Encrypt=True;
```

## Troubleshooting

| Error | Solution |
|-------|----------|
| Cannot open database | Check firewall rules: `az sql server firewall-rule list` |
| Login failed | Grant SQL access per [sql-managed-identity.md](sql-managed-identity.md) |
| Unable to create DbContext | Add `IDesignTimeDbContextFactory` implementation |
| Hook fails but deployment continues | Remove `|| true` to make migrations block deployment |

**DbContext Factory Example:**

```csharp
public class ApplicationDbContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext> {
    public ApplicationDbContext CreateDbContext(string[] args) {
        var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
        var connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING") 
            ?? args.FirstOrDefault() ?? "Server=(localdb)\\mssqllocaldb;Database=MyDb;Trusted_Connection=True;";
        optionsBuilder.UseSqlServer(connectionString);
        return new ApplicationDbContext(optionsBuilder.Options);
    }
}
```

## Best Practices

- Use `--idempotent` flag for production scripts
- Version control Migrations/ folder
- Test locally before deploying
- Backup production databases before applying
- Keep migrations small and focused

## References

- [SQL Managed Identity Access](sql-managed-identity.md)
- [Post-Deployment Guide](post-deployment.md)
- [EF Core Migrations](https://learn.microsoft.com/ef/core/managing-schemas/migrations/)
