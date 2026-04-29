# Terraform Verification

```bash
terraform output
terraform output -json
```

## Health Check

```bash
curl -s https://$(terraform output -raw api_url)/health | jq .
```

## Resource Check

```bash
az resource list --resource-group $(terraform output -raw resource_group_name) --output table
```

## Report Results to User

> ⛔ **MANDATORY** — You **MUST** present the deployed endpoint URLs to the user in your response.

Extract endpoints from Terraform outputs:

```bash
terraform output -raw api_url
```

Present a summary including all service URLs as fully-qualified `https://` links. If a Terraform output returns a bare hostname (e.g. `myapp.azurewebsites.net`), always prepend `https://`. Do NOT end your response without including them.
