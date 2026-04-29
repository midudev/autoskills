# Deno Deploy Authentication

## Interactive Authentication (Default)

The first time you run `deno deploy`, it will open a browser for authentication:

```bash
deno deploy
# Opens: https://console.deno.com/auth?code=XXXX-XXXX
```

**Important - Browser Device Authorization Flow:**
- The CLI opens your browser and waits for you to complete authentication
- You must complete the authorization in your browser before the CLI can continue
- The CLI will not proceed automatically - it waits until you finish
- Credentials are stored in your system keyring after successful auth

**Note:** When running `deno deploy` commands that require authentication, the user must complete the browser authorization before the deployment can proceed.

## Non-Interactive Authentication (CI/CD & Automation)

To deploy without browser interaction (for CI/CD pipelines or automated workflows):

### 1. Create a Deploy Token

1. Visit https://console.deno.com/account/access-tokens
2. Click "New Access Token"
3. Give it a descriptive name (e.g., "GitHub Actions CI")
4. Copy the token immediately (shown only once)

### 2. Use the Token

```bash
# Option 1: Environment variable (recommended for CI/CD)
export DENO_DEPLOY_TOKEN="your-token-here"
deno deploy --prod

# Option 2: Inline flag (for one-off commands)
deno deploy --token "your-token-here" --prod
```

### 3. GitHub Actions Example

```yaml
- name: Deploy to Deno Deploy
  env:
    DENO_DEPLOY_TOKEN: ${{ secrets.DENO_DEPLOY_TOKEN }}
  run: deno deploy --prod
```

If the app doesn't exist yet, create it first in CI/CD using non-interactive flags:

```yaml
- name: Create and deploy app
  env:
    DENO_DEPLOY_TOKEN: ${{ secrets.DENO_DEPLOY_TOKEN }}
  run: |
    deno deploy create \
      --org my-org --app my-app \
      --source local \
      --runtime-mode dynamic --entrypoint main.ts \
      --build-timeout 10 --build-memory-limit 2048 --region us
```

After the app is created, subsequent deploys only need `deno deploy --prod`.

**Tip:** For fully automated deploys without browser prompts, ensure a Deno Deploy access token is set up. Create one at https://console.deno.com/account/access-tokens, then set it as the `DENO_DEPLOY_TOKEN` environment variable.

## Finding Your Organization Name

The Deno Deploy CLI requires an organization context for most operations. To find your org name:

1. Visit https://console.deno.com
2. Your org is in the URL: `console.deno.com/YOUR-ORG-NAME`

**Note:** Commands like `deno deploy orgs` and `deno deploy switch` require an existing org context to work - this is a CLI limitation. Always find your org name from the console URL first.

## Setting Up Your First App

**Before creating:** Check if an app already exists:

```bash
cat deno.json | grep -A5 '"deploy"'
```

If no deploy config exists, you need to create the app first. Apps must be created before they can be deployed to.

**Interactive creation** (opens a browser):
```bash
deno deploy create --org your-org-name
```

This opens a browser to create the app. **Important:**
- Complete the app creation in your browser
- The CLI waits until you finish - it won't proceed automatically
- The app name becomes your URL: `<app-name>.deno.dev`

**Non-interactive creation** (for AI agents and CI/CD — no browser needed):
```bash
deno deploy create \
  --org your-org-name \
  --app your-app-name \
  --source local \
  --runtime-mode dynamic \
  --entrypoint main.ts \
  --build-timeout 5 \
  --build-memory-limit 1024 \
  --region us
```

This creates the app and does the initial deploy in one step. No browser interaction required. See the main skill doc for the full list of `create` flags.

**Verifying Success:** After completion, verify by checking deno.json:

```bash
cat deno.json | grep -A5 '"deploy"'
```

You should see:
```json
"deploy": {
  "org": "your-org-name",
  "app": "your-app-name"
}
```

After this, subsequent deploys only need:
```bash
deno deploy --prod
```

## Interactive Commands

Some `deno deploy` commands are interactive and cannot be run through automated tools.

### Switching Organizations/Apps

```bash
deno deploy switch
```

This opens an interactive menu to select org and app.

**Alternative - Use Explicit Flags:**

Instead of interactive selection, specify org/app directly:

```bash
deno deploy --org your-org-name --app your-app-name --prod
```

This bypasses the interactive flow.

## Commands That Fail Without Org Context

These commands will error if no org is configured:
- `deno deploy` (without --org flag)
- `deno deploy orgs`
- `deno deploy switch`
- `deno deploy env list`
- `deno deploy logs`

Always ensure org context is set via deno.json or --org flag before running these commands.
