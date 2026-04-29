# Databases on Deno Deploy

## Overview

Deno Deploy provides built-in database support with automatic environment isolation. You don't need to manage connection strings or worry about mixing production and development data.

## Available Database Engines

| Engine | Description |
|--------|-------------|
| **Deno KV** | Fast, globally distributed key-value store hosted by Deno |
| **PostgreSQL** | Connect your own PostgreSQL or provision managed Postgres via Prisma |

## Key Concept: Timelines

Deno Deploy automatically creates **isolated databases for each environment**:

- **Production:** `{app-id}-production`
- **Git branches:** `{app-id}--{branch-name}`
- **Preview deployments:** `{app-id}-preview`

This means your preview deployments won't accidentally modify production data.

## Database CLI Commands

Use `deno deploy database` to manage databases from the command line.

### List Databases

```bash
# List all databases in your organization
deno deploy database list

# Search for databases by name
deno deploy database list my-prefix
```

### Provision a Database

Create a new managed database:

```bash
# Provision a new Deno KV database
deno deploy database provision my-database --kind denokv

# Provision a new Prisma PostgreSQL database (requires --region)
deno deploy database provision my-database --kind prisma --region us-east-1
```

### Link an External Database

Link an existing external postgres database by providing a connection string:

```bash
deno deploy database link my-database "postgres://user:pass@host:5432/db"
```

### Assign / Detach

Connect or disconnect a database from an app:

```bash
# Assign a database to an app
deno deploy database assign my-database --app my-app

# Detach a database from an app
deno deploy database detach my-database --app my-app
```

Deno Deploy creates separate databases for each timeline automatically.

### Query a Database

Run queries directly from the CLI:

```bash
deno deploy database query my-database production "SELECT * FROM users LIMIT 10"
```

The second argument is the timeline name (e.g., `production`, `preview`, or a branch name), 
which can be found in the output of `deno deploy database list`.

### Delete a Database

```bash
deno deploy database delete my-database
```

## Connecting in Code

### Deno KV

No configuration needed - just call `Deno.openKv()`:

```typescript
const kv = await Deno.openKv();

// Deno Deploy automatically connects to the right database
// based on your current environment (production, preview, etc.)
```

### PostgreSQL

Deno Deploy injects standard environment variables that most PostgreSQL libraries detect automatically:

- `DATABASE_URL` - Full connection string
- `PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD` - Individual components

```typescript
// Recommended: npm:pg (best PostgreSQL driver for Deno Deploy)
import pg from "npm:pg";
const pool = new pg.Pool(); // Reads DATABASE_URL from environment automatically
const { rows } = await pool.query("SELECT * FROM users");
```

## Local Development

### With Tunnel

Use `--tunnel` to connect your local dev server to your hosted development database:

```bash
deno task --tunnel dev
```

This gives you access to the same database environment variables locally.

### Without Tunnel

- **Deno KV:** Data stays in memory during local development
- **PostgreSQL:** Point to a local PostgreSQL instance or use the tunnel

## Migrations

Deno Deploy supports pre-deploy commands that run before each deployment. Use these for database migrations:

```json
{
  "deploy": {
    "preDeploy": ["deno task db:migrate"]
  }
}
```

## Sharing Databases

Multiple apps can share the same database instance. Each app gets its own isolated databases per timeline, even when sharing.

## Documentation

- Databases overview: https://docs.deno.com/deploy/reference/databases/
- Deno KV reference: https://docs.deno.com/deploy/reference/deno_kv/
