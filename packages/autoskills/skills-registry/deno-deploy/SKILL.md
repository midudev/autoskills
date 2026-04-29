---
name: deno-deploy
description: Use when deploying Deno apps to production, asking about Deno Deploy, or working with `deno deploy` CLI commands. Covers deployment workflows, environment variables, KV database access, custom domains, the --tunnel flag for local development, and the `deno deploy` command reference.
license: MIT
metadata:
  author: denoland
  version: "1.5"
---

# Deno Deploy

This skill provides guidance for deploying applications to Deno Deploy.

## Scope Boundaries

This skill applies **only** to Deno Deploy questions. Follow these rules:

- If the user asks about **AWS Lambda, Vercel, Netlify, Google Cloud Run, Docker, Kubernetes, or any other deployment platform**, answer using that platform directly. Do not mention Deno Deploy at all — not as an alternative, not as a comparison, not as a suggestion.
- If the user asks about **running a local Deno script** (not deploying), answer the local question directly. Do not mention Deno Deploy, deployment, or the `--tunnel` flag.
- Do not include `deno deploy` commands, Deno KV, or Deno Deploy environment variable configuration in responses about other platforms or local-only scripts.
- Only discuss Deno Deploy when the user explicitly asks about Deno Deploy or deploying a Deno application to production.

## Important: Use `deno deploy`, NOT `deployctl`

**Always use the `deno deploy` command.** Do NOT use `deployctl`.

- `deployctl` is for Deno Deploy Classic (deprecated)
- `deno deploy` is the modern, integrated command built into the Deno CLI
- **Requires Deno >= 2.4.2** - the `deno deploy` subcommand was introduced in Deno 2.4

## When Unsure About CLI Flags

**Always run `--help` before guessing at flags.** The `deno deploy` subcommand has many flags, and they change between versions. When you're unsure what a command accepts:

```bash
# See all subcommands
deno deploy --help

# See flags for a specific subcommand
deno deploy create --help
deno deploy env --help
deno deploy database --help
```

This takes seconds and prevents repeated trial-and-error failures. Never assume a flag exists — check first.

## Deployment Workflow

**Always show the core deploy command first** — then explain diagnostic steps. When a user asks "how do I deploy?", lead with the actual command (`deno deploy --prod`) before covering pre-flight checks and configuration.

### Step 1: Locate the App Directory

Before running any deploy commands, find where the Deno app is located:

```bash
# Check if deno.json exists in current directory
if [ -f "deno.json" ] || [ -f "deno.jsonc" ]; then
  echo "APP_DIR: $(pwd)"
else
  # Look for deno.json in immediate subdirectories
  find . -maxdepth 2 -name "deno.json" -o -name "deno.jsonc" 2>/dev/null | head -5
fi
```

All deploy commands must run from the app directory.

### Step 2: Pre-Flight Checks

Check Deno version and existing configuration:

```bash
# Check Deno version (must be >= 2.4.2)
deno --version | head -1

# Check for existing deploy config
grep -E '"org"|"app"' deno.json deno.jsonc 2>/dev/null || echo "NO_DEPLOY_CONFIG"
```

### Step 3: Check for Startup Dependencies

Before deploying, check if the app connects to a database or external service at startup (e.g., top-level `await initDb()` in `main.ts`). If it does, the deploy will fail during warmup because the database doesn't exist yet.

**If the app has startup database dependencies, follow this order:**

1. **Create the app with `--no-wait`** so a warmup failure doesn't block you:
   ```bash
   deno deploy create \
     --org <ORG_NAME> --app <APP_NAME> \
     --source local --runtime-mode dynamic --entrypoint main.ts \
     --build-timeout 5 --build-memory-limit 1024 --region us \
     --no-wait
   ```

2. **Provision and assign the database:**
   ```bash
   deno deploy database provision my-db --kind prisma --region us-east-1
   deno deploy database assign my-db --app <APP_NAME>
   ```

3. **Redeploy** (now the database exists, warmup will succeed):
   ```bash
   deno deploy --prod
   ```

If the app has no startup dependencies, skip this step and deploy normally below.

### Step 4: Deploy Based on Configuration

**If `deploy.org` AND `deploy.app` exist in deno.json:**
```bash
# Build if needed (Fresh, Astro, etc.)
deno task build

# Deploy to production
deno deploy --prod
```

**If NO deploy config exists:**

**Apps must be created before they can be deployed to.** You cannot run `deno deploy --prod` until an app exists.

**IMPORTANT: Ask the user first** - Do they have an existing app on Deno Deploy, or do they need to create a new one?

**If they have an existing app**, add the config directly to deno.json:
```json
{
  "deploy": {
    "org": "<ORG_NAME>",
    "app": "<APP_NAME>"
  }
}
```
The org name is in the Deno Deploy console URL (e.g., `console.deno.com/your-org-name`). Once this config is in place, subsequent deploys just need `deno deploy --prod`.

**If they need to create a new app:**

The CLI needs an organization name. Find it at https://console.deno.com - the org is in the URL path (e.g., `console.deno.com/your-org-name`).

**Interactive creation** (opens a browser — only works when a human is at the keyboard):
```bash
deno deploy create --org <ORG_NAME>
# A browser window opens - complete the app creation there
```

**Non-interactive creation** (use when an AI agent is performing the deploy, or in CI/CD):
```bash
deno deploy create \
  --org <ORG_NAME> \
  --app <APP_NAME> \
  --source local \
  --runtime-mode dynamic \
  --entrypoint main.ts \
  --build-timeout 5 \
  --build-memory-limit 1024 \
  --region us
```

The create command also does the initial deploy. After it completes, `deno.json` is updated with `deploy.org` and `deploy.app` automatically. From that point on, subsequent deploys only need:
```bash
deno deploy --prod
```

After completion, verify the config was saved:
```bash
grep -E '"org"|"app"' deno.json
```

**When an AI agent is performing the deployment**, always use the non-interactive flow with explicit flags. The interactive flow requires browser windows and terminal prompts that agents cannot navigate.

## Core Commands

### Production Deployment

```bash
deno deploy --prod
```

### Preview Deployment

```bash
deno deploy
```

Preview deployments create a unique URL for testing without affecting production.

### Targeting Specific Apps

```bash
deno deploy --org my-org --app my-app --prod
```

### Configuring an Entrypoint

Set the entrypoint in your `deno.json` (this is used by `deno deploy create` during app creation):

```json
{
  "deploy": {
    "entrypoint": "main.ts"
  }
}
```

Note: `--entrypoint` is a flag on `deno deploy create`, not on `deno deploy` itself.

### Additional Flags

These flags are available on `deno deploy create` (and apply during the initial deploy):

| Flag | Purpose |
|------|---------|
| `--allow-node-modules` | Include node_modules directory in upload |
| `--no-wait` | Skip waiting for the build to complete |

## Creating Apps (Non-Interactive Reference)

When any flag beyond `--org` is provided, `deno deploy create` runs in non-interactive mode — all required flags must be specified. This is the recommended approach for AI agents and CI/CD pipelines.

### Required Flags

| Flag | Description |
|------|-------------|
| `--org <name>` | Organization name |
| `--app <name>` | Application name (becomes your URL: `<app>.deno.dev`) |
| `--source <local\|github>` | Deploy from local files or a GitHub repo |
| `--build-timeout <minutes>` | Build timeout: 5, 10, 15, 20, 25, or 30 |
| `--build-memory-limit <MB>` | Memory limit: 1024, 2048, 3072, or 4096 |
| `--region <region>` | Deployment region: us, eu, or global |

### GitHub Source Flags

When using `--source github`, you also need:

| Flag | Description |
|------|-------------|
| `--owner <name>` | GitHub repository owner |
| `--repo <name>` | GitHub repository name |

### Build Configuration Flags

| Flag | Description |
|------|-------------|
| `--app-directory <path>` | Path to app directory (for monorepos) |
| `--framework-preset <preset>` | Framework preset (see [Frameworks](references/FRAMEWORKS.md)) |
| `--install-command <cmd>` | Custom install command |
| `--build-command <cmd>` | Custom build command |
| `--pre-deploy-command <cmd>` | Command to run before deploy |
| `--do-not-use-detected-build-config` | Skip auto-detection of framework config |

The CLI auto-detects your framework and build configuration. If a framework is detected, you can skip `--install-command`, `--build-command`, `--pre-deploy-command`, and `--runtime-mode` — they'll be inferred from the preset. Use `--do-not-use-detected-build-config` to override detection. **When using this flag, all three build commands (`--install-command`, `--build-command`, `--pre-deploy-command`) plus `--runtime-mode` become required** — omitting any of them causes exit code 2.

### Runtime Mode Flags

You must pick a runtime mode with `--runtime-mode <dynamic|static>` (unless a framework preset handles it).

**Dynamic mode** (for apps with a server):

| Flag | Description |
|------|-------------|
| `--entrypoint <path>` | Entry file (required for dynamic mode) |
| `--arguments <args>` | Arguments passed to entrypoint (repeatable) |
| `--working-directory <cwd>` | Working directory for the process |

**Static mode** (for static sites):

| Flag | Description |
|------|-------------|
| `--static-dir <dir>` | Directory to serve static files from (required) |
| `--single-page-app` | Serve index.html for routes that don't match a file |

### Other Flags

| Flag | Description |
|------|-------------|
| `--dry-run` | Validate everything without actually creating the app |
| `--no-wait` | Don't wait for the build to complete |
| `--allow-node-modules` | Include node_modules in the upload |

### Examples

**Simple Deno server:**
```bash
deno deploy create \
  --org my-org --app my-api \
  --source local \
  --runtime-mode dynamic --entrypoint main.ts \
  --build-timeout 5 --build-memory-limit 1024 --region us
```

**Fresh app (framework auto-detected):**
```bash
deno deploy create \
  --org my-org --app my-fresh-app \
  --source local \
  --build-timeout 5 --build-memory-limit 1024 --region us
```

**Next.js from GitHub:**
```bash
deno deploy create \
  --org my-org --app my-next-app \
  --source github --owner my-github-user --repo my-next-repo \
  --framework-preset Next \
  --build-timeout 15 --build-memory-limit 2048 --region us \
  --allow-node-modules
```

**Static site:**
```bash
deno deploy create \
  --org my-org --app my-static-site \
  --source local \
  --runtime-mode static --static-dir dist --single-page-app \
  --build-command "deno task build" \
  --build-timeout 5 --build-memory-limit 1024 --region us
```

## Environment Variables

### Contexts

Deno Deploy has three "contexts" - logical environments where your code runs, each with its own set of variables:

| Context | Purpose |
|---------|---------|
| **Production** | Live traffic on your production URL |
| **Development** | Preview deployments and branch URLs |
| **Build** | Only available during the build process |

You can set different values for the same variable in each context. For example, you might use a test database URL in Development and the real one in Production.

### Predefined Variables

These are automatically available in your code:

| Variable | Description |
|----------|-------------|
| `DENO_DEPLOY` | Always `1` when running on Deno Deploy |
| `DENO_DEPLOYMENT_ID` | Unique ID for the current deployment |
| `DENO_DEPLOY_ORG_ID` | Your organization's ID |
| `DENO_DEPLOY_APP_ID` | Your application's ID |
| `CI` | Set to `1` during builds only |

### Accessing Variables in Code

```typescript
const dbUrl = Deno.env.get("DATABASE_URL");
const isDenoDeploy = Deno.env.get("DENO_DEPLOY") === "1";
```

### Managing Variables via CLI

```bash
# Add a plain text variable
deno deploy env add DATABASE_URL "postgres://..."

# Add a secret variable (hidden after creation, only readable in code)
deno deploy env add API_KEY "sk-..." --secret

# List all variables
deno deploy env list

# Update just the value (keeps contexts and secret status)
deno deploy env update-value DATABASE_URL "postgres://new-url..."

# Update which contexts a variable applies to
deno deploy env update-contexts DATABASE_URL production development

# Delete a variable
deno deploy env delete DATABASE_URL

# Load from .env file (all values treated as secrets by default)
deno deploy env load .env.production

# Load from .env file, marking specific keys as non-secrets
deno deploy env load .env.production --non-secrets PUBLIC_URL APP_NAME
```

### Variable Types

- **Plain text** - Visible in the dashboard, good for feature flags and non-sensitive config
- **Secrets** - Hidden after creation, only readable in your code, use for API keys and credentials

### Limits

- Key names: max 128 bytes
- Values: max 16 KB
- Keys cannot start with `DENO_`, `LD_`, or `OTEL_`

## Viewing Logs

```bash
# Stream live logs
deno deploy logs

# Filter by date range
deno deploy logs --start 2026-01-15 --end 2026-01-16
```

## Databases & Storage

Deno Deploy provides built-in database support with **automatic environment isolation**. Each environment (production, preview, branch) gets its own isolated database automatically.

### Available Options

| Engine | Use Case |
|--------|----------|
| **Deno KV** | Key-value storage, simple data, counters, sessions |
| **PostgreSQL** | Relational data, complex queries, existing Postgres apps |

### Deno KV Quick Start

No configuration needed - just use the built-in API:

```typescript
const kv = await Deno.openKv();

// Store data
await kv.set(["users", "alice"], { name: "Alice", role: "admin" });

// Retrieve data
const user = await kv.get(["users", "alice"]);
console.log(user.value); // { name: "Alice", role: "admin" }

// List by prefix
for await (const entry of kv.list({ prefix: ["users"] })) {
  console.log(entry.key, entry.value);
}
```

Deno Deploy automatically connects to the correct database based on your environment.

### PostgreSQL

For PostgreSQL, Deno Deploy injects environment variables (`DATABASE_URL`, `PGHOST`, etc.) that most libraries detect automatically:

```typescript
// Recommended: npm:pg (best PostgreSQL driver for Deno Deploy)
import pg from "npm:pg";
const pool = new pg.Pool(); // Reads DATABASE_URL from environment automatically
```

### Provisioning

Use the `deno deploy database` command to provision and manage databases:

```bash
# Provision a Deno KV database
deno deploy database provision my-database --kind denokv

# Provision a Prisma PostgreSQL database
deno deploy database provision my-database --kind prisma --region us-east-1

# Assign to your app
deno deploy database assign my-database --app my-app
```

For detailed CLI commands, see [Databases](references/DATABASES.md).

### Local Development

Use `--tunnel` to connect to your hosted development database locally:

```bash
deno task --tunnel dev
```

See [Databases](references/DATABASES.md) and [Deno KV](references/DENO_KV.md) for detailed documentation.

## Local Development Tunnel

The tunnel feature lets you expose your local development server to the internet. This is useful for:

- **Testing webhooks** - Receive webhook callbacks from external services
- **Sharing with teammates** - Let others preview your local work
- **Mobile testing** - Access your local server from other devices

### Basic Usage

Add the `--tunnel` flag when running your app:

```bash
deno run --tunnel -A main.ts
```

The first time you run this, it will:
1. Ask you to authenticate with Deno Deploy (opens a browser)
2. Ask you to select which app to connect the tunnel to
3. Generate a public URL that forwards requests to your local server

### Using with Tasks

You can use `--tunnel` with your existing tasks in `deno.json`:

```bash
deno task --tunnel dev
```

This runs your `dev` task with the tunnel enabled.

### What the Tunnel Provides

Beyond just forwarding requests, the tunnel also:

- **Syncs environment variables** - Variables set in your Deno Deploy app's "Local" context become available to your local process
- **Sends logs and metrics** - OpenTelemetry data goes to the Deno Deploy dashboard (filter with `context:local`)
- **Connects to databases** - Automatically connects to your assigned local development databases

### Managing Tunnels

- View active tunnels in the Deno Deploy dashboard under the "Tunnels" tab
- Stop a tunnel by terminating the Deno process (Ctrl+C)

## Command Reference

| Command | Purpose |
|---------|---------|
| `deno deploy --prod` | Deploy to production (app must exist first) |
| `deno deploy` | Preview deployment |
| `deno deploy create --org <name>` | Create new app (interactive) |
| `deno deploy create --org <name> --app <name> ...` | Create new app (non-interactive, see full flags above) |
| `deno deploy create ... --no-wait` | Create app without waiting for build to complete |
| `deno deploy create ... --allow-node-modules` | Create app including node_modules |
| `deno deploy env add <var> <value>` | Add plain text environment variable |
| `deno deploy env add <var> <value> --secret` | Add secret environment variable |
| `deno deploy env list` | List environment variables |
| `deno deploy env update-value <var> <value>` | Update variable value (keeps contexts/secret status) |
| `deno deploy env update-contexts <var> <contexts...>` | Update which contexts a variable applies to |
| `deno deploy env delete <var>` | Delete environment variable |
| `deno deploy env load <file>` | Load variables from .env file (defaults to secret) |
| `deno deploy env load <file> --non-secrets <keys...>` | Load .env file, marking specific keys as non-secrets |
| `deno deploy database provision <name> --kind <type>` | Provision a new database |
| `deno deploy database assign <name> --app <app>` | Assign database to an app |
| `deno deploy logs` | View deployment logs |
| `deno run --tunnel -A <file>` | Start local tunnel |
| `deno task --tunnel <task>` | Run task with tunnel |

## Edge Runtime Notes

Deno Deploy runs in one or many regions (globally distributed). Keep in mind:

- **Environment variables** - Must be set via `deno deploy env`, not .env files at runtime
- **Global distribution** - Code runs at the region closest to users
- **Cold starts** - First request after idle may be slightly slower

## Additional References

- [Authentication](references/AUTHENTICATION.md) - Interactive and CI/CD authentication
- [Databases](references/DATABASES.md) - Database provisioning and connections
- [Deno KV](references/DENO_KV.md) - Key-value storage API and examples
- [Domains](references/DOMAINS.md) - Custom domains and SSL certificates
- [Frameworks](references/FRAMEWORKS.md) - Framework-specific deployment guides
- [Organizations](references/ORGANIZATIONS.md) - Managing orgs and members
- [Runtime](references/RUNTIME.md) - Lifecycle, cold starts, and limitations
- [Troubleshooting](references/TROUBLESHOOTING.md) - Common issues and solutions

## Documentation

- Official docs: https://docs.deno.com/deploy/
- CLI reference: https://docs.deno.com/runtime/reference/cli/deploy/
- Databases: https://docs.deno.com/deploy/reference/databases/
- Deno KV: https://docs.deno.com/deploy/reference/deno_kv/
- Domains: https://docs.deno.com/deploy/reference/domains/
- Environment variables & contexts: https://docs.deno.com/deploy/reference/env_vars_and_contexts/
- Organizations: https://docs.deno.com/deploy/reference/organizations/
- Runtime: https://docs.deno.com/deploy/reference/runtime/
- Tunnel: https://docs.deno.com/deploy/reference/tunnel/
