# Live Role Verification

Query Azure to confirm that provisioned RBAC role assignments are correct and sufficient for the application to function. This complements the static role check in azure-validate by validating **live Azure state**.

## How It Differs from azure-validate's Role Check

| Check | Skill | What It Verifies |
|-------|-------|-----------------|
| **Static** | azure-validate | Generated Bicep/Terraform has correct role assignments in code |
| **Live** | azure-deploy (this) | Provisioned Azure resources actually have the right roles assigned |

Both checks are needed because:
- Bicep may be correct but provisioning could fail silently for roles
- Manual changes or policy enforcement may alter role assignments
- Previous deployments may have stale or conflicting roles

## When to Run

After deployment verification (step 7). Resources are now provisioned, so live role assignments can be queried.

## Verification Steps

### 1. Identify App Identities

Read `.azure/deployment-plan.md` to find all services with managed identities. Then query Azure for their principal IDs:

```bash
# App Service
az webapp identity show --name <app-name> -g <resource-group> --query principalId -o tsv

# Container App
az containerapp identity show --name <app-name> -g <resource-group> --query principalId -o tsv

# Function App
az functionapp identity show --name <app-name> -g <resource-group> --query principalId -o tsv
```

### 2. Query Live Role Assignments

Use MCP tools to list role assignments for each resource **and identity** (using the `principalId` from step 1):

```
azure__role(
  command: "role_assignment_list",
  scope: "<resourceId>",
  assignee_object_id: "<principalId>"
)
```

Or via CLI:

```bash
az role assignment list --scope <resourceId> --assignee-object-id <principalId> --output table
```

### 3. Cross-Check Against Requirements

For each identity, verify the assigned roles match what the app needs:

| App Operation | Expected Role | Scope |
|---------------|---------------|-------|
| Read/write blobs | Storage Blob Data Contributor | Storage account |
| Generate user delegation SAS | Storage Blob Delegator | Storage account |
| Read secrets | Key Vault Secrets User | Key Vault |
| Send messages | Azure Service Bus Data Sender | Service Bus namespace |
| Read/write documents | Cosmos DB Built-in Data Contributor | Cosmos DB account |

### 4. Check for Common Issues

| Issue | How to Detect | Fix |
|-------|---------------|-----|
| Role assigned at wrong scope | Role on resource group but needed on specific resource | Reassign at resource scope |
| Generic role instead of data role | `Contributor` assigned but no data-plane access | Replace with data-plane role (e.g., `Storage Blob Data Contributor`) |
| Missing role entirely | No assignment found for identity on target resource | Add role assignment to Bicep and redeploy |
| Stale role from previous deployment | Old principal ID with roles, new identity without | Clean up old assignments, add new ones |

## Decision Tree

```
Resources provisioned?
├── No → Skip live check (nothing to query yet)
└── Yes → For each app identity:
    ├── Query role assignments on target resources
    ├── Compare against expected roles from plan
    │   ├── All roles present and correct → ✅ Pass
    │   ├── Missing roles → ❌ Fail — add to Bicep, redeploy
    │   └── Wrong scope or generic roles → ⚠️ Warning — fix and redeploy
    └── Record results in deployment verification
```

## Record in Deployment Verification

Add live role verification results to the deployment log in `.azure/deployment-plan.md`:

```markdown
### Live Role Verification
- Command: `az role assignment list --scope <resourceId> --assignee-object-id <principalId>`
- Results:
  - <identity> → <role> on <resource> ✅
  - <identity> → missing <expected-role> on <resource> ❌
- Status: Pass / Fail
```
