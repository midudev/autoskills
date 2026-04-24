# Terraform Errors

| Error | Resolution |
|-------|------------|
| State lock error | Wait or `terraform force-unlock <lock-id>` |
| Resource exists | `terraform import <resource>` |
| Backend denied | Check storage permissions |
| Provider error | `terraform init -upgrade` |
| Literal `{{ .Env.* }}` in variable values | Fix syntax in `main.tfvars.json`: use `${VAR}` (e.g., `${AZURE_ENV_NAME}`), not Go-style `{{ .Env.* }}`. See [AZD Errors](../azd/errors.md#unresolved-terraform-template-variables) |
| State cleared on each `azd provision` | azd copies Terraform config to `.azure/<env>/infra/` on each run. Use a remote state backend to persist state across runs |

## Cleanup (DESTRUCTIVE)

```bash
terraform destroy -auto-approve
```

Selective:
```bash
terraform destroy -target=azurerm_container_app.api
```

⚠️ Permanently deletes resources.
