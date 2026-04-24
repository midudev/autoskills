# Bicep Verification

```bash
az resource list --resource-group <rg-name> --output table
```

## Get Deployment Outputs

```bash
az deployment sub show \
  --name main \
  --query properties.outputs
```

## Health Check

```bash
curl -s https://<endpoint>/health | jq .
```

## Report Results to User

> ⛔ **MANDATORY** — You **MUST** present the deployed endpoint URLs to the user in your response.

Extract endpoints from deployment outputs:

```bash
az deployment sub show --name main --query properties.outputs
```

Present a summary including all service URLs as fully-qualified `https://` links. If a deployment output returns a bare hostname (e.g. `myapp.azurewebsites.net`), always prepend `https://`. Do NOT end your response without including them.
