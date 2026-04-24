# Deno Deploy Troubleshooting

## First Step: Use `--help`

Before debugging a failed command, run `--help` to confirm the flags you're using actually exist and are spelled correctly:

```bash
deno deploy create --help
deno deploy env --help
deno deploy database --help
```

Exit code 2 almost always means a flag is missing or invalid — `--help` will show you exactly what's required.

## Common Errors

### "No organization was selected"

This error occurs because the CLI needs an organization context. Unfortunately, commands like `deno deploy orgs` also fail without this context.

**Solution:**

1. **Find your org name manually:** Visit https://console.deno.com - your org is in the URL path (e.g., `console.deno.com/donjo` means org is `donjo`)

2. **Specify org explicitly:**
   ```bash
   deno deploy --org your-org-name --prod
   ```

3. **Or create an app with org:**
   ```bash
   deno deploy create --org your-org-name
   # Complete the browser flow when prompted
   ```

If you see this error, the user needs to provide their organization name from the console URL.

### "No entrypoint found"

Specify your entry file:

```bash
deno deploy --entrypoint main.ts --prod
```

Or add to `deno.json`:

```json
{
  "deploy": {
    "entrypoint": "main.ts"
  }
}
```

### "authorization required"

Token expired or missing. Options:
- Re-authenticate interactively (browser flow)
- Set up a CI/CD token via `DENO_DEPLOY_TOKEN` environment variable
- Create a new token at https://console.deno.com/account/access-tokens

### "Minimum Deno version required"

User needs to upgrade Deno:
```bash
deno upgrade
```

The `deno deploy` command requires Deno >= 2.4.2.

### Fresh "Build required" Error

Fresh 2.0 requires building before deployment:

```bash
deno task build
deno deploy --prod
```

### Environment Variable Errors

Check what's currently set:

```bash
deno deploy env list
```

Add missing variables:

```bash
deno deploy env add MISSING_VAR "value"
```

### Warmup Failure After Deploy

The build succeeds but the deploy fails with a warmup error or exit code 1. This usually means the app crashes on startup.

**Most common cause:** The app connects to a database at startup (e.g., `await initDb()` in `main.ts`), but no database has been provisioned or assigned yet.

**Solution:**

1. Provision and assign the database:
   ```bash
   deno deploy database provision my-db --kind prisma --region us-east-1
   deno deploy database assign my-db --app <APP_NAME>
   ```

2. Redeploy:
   ```bash
   deno deploy --prod
   ```

For a complete walkthrough, see the [Fresh + PostgreSQL recipe](FRAMEWORKS.md#fresh--postgresql).

### Fresh Auto-Detection / Preset Fails

When the CLI auto-detects Fresh or you use `--framework-preset fresh`, the deploy may fail with an API error. This is a known issue.

**Workaround:** Use `--do-not-use-detected-build-config` and specify all build commands manually:

```bash
deno deploy create \
  --org <ORG_NAME> --app <APP_NAME> \
  --source local \
  --do-not-use-detected-build-config \
  --install-command "deno install" \
  --build-command "deno task build" \
  --pre-deploy-command "echo ready" \
  --runtime-mode dynamic --entrypoint main.ts \
  --build-timeout 5 --build-memory-limit 1024 --region us
```

## Error Response Table

| Error | Cause | Solution |
|-------|-------|----------|
| "No organization was selected" | No org in config | Get org name from console URL, use `--org` flag |
| "No entrypoint found" | Can't find main file | Use `--entrypoint` flag or set in deno.json |
| "authorization required" | Token expired/missing | Re-authenticate or set `DENO_DEPLOY_TOKEN` |
| "Minimum Deno version required" | Deno too old | Run `deno upgrade` |
| Exit code 2 (usage error) | Missing or invalid flags | Run `deno deploy create --help` to see required flags |
| Warmup failure (exit code 1) | App crashes on startup | Check for missing database or env vars — see [Warmup Failure](#warmup-failure-after-deploy) |
| Fresh preset API error | Auto-detection bug | Use `--do-not-use-detected-build-config` — see [Fresh workaround](#fresh-auto-detection--preset-fails) |

## Verifying Deployment Success

The CLI output can be verbose. Look for these indicators of success:
- A URL containing `.deno.dev` or `.deno.net` - this is your live deployment
- A console URL like `https://console.deno.com/<org>/<app>/builds/<id>`
- The command exits with code 0 (no error)

After deployment, confirm success by extracting the production URL from the output. The format is typically:
`https://<app-name>.<org>.deno.net` or `https://<app-name>.deno.dev`

## Commands That Require Org Context

These commands will error if no org is configured - do not try them to "discover" orgs:
- `deno deploy` (without --org flag)
- `deno deploy orgs`
- `deno deploy switch`
- `deno deploy env list`
- `deno deploy logs`

## Environment Variable Contexts

Variables can apply to different environments:

```bash
# Set which contexts a variable applies to
deno deploy env update-contexts API_KEY Production Preview
```

Available contexts: `Production`, `Preview`, `Local`, `Build`
