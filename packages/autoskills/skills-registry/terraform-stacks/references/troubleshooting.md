# Troubleshooting Reference

Common issues and solutions when working with Terraform Stacks.

## Table of Contents

1. [Configuration Issues](#configuration-issues)
2. [Deployment Issues](#deployment-issues)
3. [Provider and Authentication Issues](#provider-and-authentication-issues)
4. [Module Compatibility Issues](#module-compatibility-issues)
5. [State and Dependency Issues](#state-and-dependency-issues)
6. [API and CLI Issues](#api-and-cli-issues)

## Configuration Issues

### Circular Dependencies

**Issue:** Component A references Component B, and Component B references Component A.

**Error Message:**
```
Error: Cycle detected in component dependencies
```

**Solutions:**

1. **Break the circular reference** by refactoring components:

```hcl
# Before (circular dependency)
component "vpc" {
  source = "./modules/vpc"
  inputs = {
    security_group_id = component.app.security_group_id  # References app
  }
}

component "app" {
  source = "./modules/app"
  inputs = {
    vpc_id = component.vpc.vpc_id  # References vpc
  }
}

# After (broken circular reference)
component "vpc" {
  source = "./modules/vpc"
  inputs = {
    # Remove reference to app
  }
}

component "security_group" {
  source = "./modules/security-group"
  inputs = {
    vpc_id = component.vpc.vpc_id
  }
}

component "app" {
  source = "./modules/app"
  inputs = {
    vpc_id             = component.vpc.vpc_id
    security_group_id  = component.security_group.id
  }
}
```

2. **Use intermediate components** to break the dependency chain
3. **Refactor modules** to remove the circular dependency at the module level

### Validation Errors on Variables

**Issue:** Variable block validation errors during `terraform stacks validate`.

**Error Message:**
```
Error: Unsupported argument
  on variables.tfcomponent.hcl line 5:
  5:   validation {

Validation blocks are not supported in Stack configurations
```

**Solution:** Remove `validation` blocks from variable declarations. Stacks do not support validation blocks:

```hcl
# Incorrect
variable "instance_count" {
  type = number
  validation {
    condition     = var.instance_count > 0
    error_message = "Instance count must be positive"
  }
}

# Correct
variable "instance_count" {
  type        = number
  description = "Number of instances (must be positive)"
}
```

Move validation logic into the underlying modules if needed.

### Missing Type in Variable Declarations

**Issue:** Variables fail validation when `type` is not specified.

**Error Message:**
```
Error: Missing required argument
  on variables.tfcomponent.hcl line 3:
  3: variable "region" {

The argument "type" is required in Stack variable declarations
```

**Solution:** Always specify `type` for variables - it's required in Stacks (unlike traditional Terraform):

```hcl
# Incorrect
variable "region" {
  default = "us-west-1"
}

# Correct
variable "region" {
  type    = string
  default = "us-west-1"
}
```

### Provider Configuration in Modules

**Issue:** Modules with embedded provider blocks cause errors.

**Error Message:**
```
Error: Provider configuration not allowed in module

Modules used with Terraform Stacks cannot contain provider blocks
```

**Solution:**

1. **Remove provider blocks from modules** - configure providers in Stack configuration instead
2. **Use modules that don't contain provider blocks** (most public registry modules are compatible)
3. **Fork and modify modules** if necessary to remove provider blocks

## Deployment Issues

### Cannot Destroy Deployment from UI

**Issue:** The HCP Terraform UI doesn't provide an option to destroy Stack deployments.

**Why:** Stack deployment destruction is only available through configuration, not the UI.

**Solution:** Set `destroy = true` in the deployment block and upload the configuration:

```hcl
deployment "old_environment" {
  inputs = {
    aws_region     = "us-west-1"
    instance_count = 2
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }

  destroy = true  # Marks deployment for destruction
}
```

**Workflow:**

1. Add `destroy = true` to the deployment block
2. Run `terraform stacks configuration upload`
3. HCP Terraform creates a destroy run automatically
4. Approve the destroy run (if auto-approve is not configured)
5. After destruction completes, remove the deployment block entirely
6. Upload configuration again to clean up the deployment definition

**Important:** You cannot destroy deployments from the UI. This is by design to prevent accidental destruction.

### Deployment Stuck in "Planning" State

**Issue:** Deployment remains in "planning" state indefinitely.

**Possible Causes:**

1. **Provider authentication failed** - Check OIDC configuration and IAM roles
2. **Module download failed** - Verify module sources are accessible
3. **Provider version conflict** - Check `.terraform.lock.hcl` matches required providers

**Diagnosis:**

```bash
# Get deployment step diagnostics
terraform stacks deployment-run list
# Note the run ID, then:
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-runs/{run-id}/stack-deployment-steps" | \
  jq '.data[] | {id, status: .attributes.status, component: .attributes["component-name"]}'
```

**Solutions:**

1. Check diagnostics for the stuck step
2. Verify provider authentication is configured correctly
3. Ensure all module sources are accessible
4. Check provider lock file matches required providers

### Deployment Requires Approval But No Approval Prompt

**Issue:** Deployment is waiting for approval but CLI doesn't show approval prompt.

**Why:** CLI monitoring commands are non-blocking and don't automatically prompt for approval.

**Solution:**

**Option 1: Approve via CLI**
```bash
# Approve all pending plans in a deployment run
terraform stacks deployment-run approve-all-plans -deployment-run-id=sdr-ABC123

# Or approve all plans in a deployment group
terraform stacks deployment-group approve-all-plans -deployment-group=canary
```

**Option 2: Configure auto-approve** (Premium feature)
```hcl
deployment_auto_approve "safe_changes" {
  deployment_group = deployment_group.canary

  check {
    condition = context.plan.applyable
    reason    = "Plan must be successful"
  }
}
```

## Provider and Authentication Issues

### OIDC Authentication Failing

**Issue:** Provider authentication fails with OIDC/workload identity.

**Error Messages:**
```
Error: Error assuming role with web identity
Error: Failed to retrieve credentials
Error: Invalid identity token
```

**Diagnosis Steps:**

1. **Verify identity token configuration:**

```hcl
# Check identity_token block exists
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

# Check deployment references the token
deployment "production" {
  inputs = {
    identity_token = identity_token.aws.jwt
  }
}
```

2. **Verify provider configuration:**

```hcl
provider "aws" "this" {
  config {
    region = var.aws_region
    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }
  }
}
```

3. **Check IAM role trust policy:**

**AWS - Verify trust policy includes HCP Terraform:**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<account-id>:oidc-provider/app.terraform.io"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "app.terraform.io:aud": "aws.workload.identity"
        },
        "StringLike": {
          "app.terraform.io:sub": "organization:<org-name>:project:<project-name>:stack:<stack-name>:deployment:<deployment-name>"
        }
      }
    }
  ]
}
```

**Azure - Verify federated credential:**
- Application ID matches the one in provider configuration
- Subject matches: `organization:<org>:project:<project>:stack:<stack>:deployment:<deployment>`
- Issuer is `https://app.terraform.io`

**GCP - Verify workload identity pool:**
- Provider configuration includes correct workload identity provider
- Service account has necessary IAM permissions
- Attribute mapping includes `google.subject` from token claims

**Solutions:**

1. Fix IAM role trust policy to include correct HCP Terraform OIDC provider
2. Ensure audience matches between identity_token block and IAM trust policy
3. Verify subject pattern matches your organization/project/stack/deployment names
4. Check that the role_arn is correct in provider configuration

### Provider Version Lock File Issues

**Issue:** Provider version conflicts or "could not retrieve provider" errors.

**Error Messages:**
```
Error: Failed to install provider
Error: Provider version not found
Error: Checksum mismatch for provider
```

**Solutions:**

1. **Regenerate provider lock file:**

```bash
terraform stacks providers-lock
```

2. **Add additional platforms** (if deploying from different OS):

```bash
terraform stacks providers-lock \
  -platform=linux_amd64 \
  -platform=darwin_amd64 \
  -platform=darwin_arm64
```

3. **Verify required_providers block:**

```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"  # Ensure version constraint is valid
  }
}
```

4. **Commit `.terraform.lock.hcl`** to version control

## Module Compatibility Issues

### Public Registry Module Errors

**Issue:** Modules from the Terraform public registry cause errors during plan or apply.

**Common Errors:**
```
Error: Unsupported attribute
Error: Invalid reference
Error: Missing required argument
```

**Known Problematic Modules:**
- `terraform-aws-modules/alb/aws` - Some versions have compatibility issues
- `terraform-aws-modules/ecs-service/aws` - May have issues with certain configurations

**Solutions:**

1. **Test modules in dev deployment first** before using in production

2. **Check module compatibility** by reviewing recent issues on the module repository

3. **Use specific module versions** rather than latest:

```hcl
component "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"  # Use specific version known to work
  # ...
}
```

4. **Consider using raw resources** for critical infrastructure:

```hcl
# Instead of using a module that has issues
component "alb" {
  source = "./modules/alb"  # Create local module with raw resources
  # ...
}
```

5. **Fork and fix modules** if you have the resources to maintain them

6. **Report compatibility issues** to module maintainers

### Local Module Not Found

**Issue:** Stack can't find local module sources.

**Error Message:**
```
Error: Module not found
  Could not load module ./modules/vpc
```

**Solutions:**

1. **Verify module path is relative** to Stack root:

```hcl
# Correct
component "vpc" {
  source = "./modules/vpc"
}

# Incorrect (absolute paths don't work)
component "vpc" {
  source = "/Users/username/project/modules/vpc"
}
```

2. **Ensure module directory exists** with proper structure:

```
my-stack/
├── components.tfcomponent.hcl
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

3. **Check file permissions** on module directories

## State and Dependency Issues

### Component Output Not Available

**Issue:** Component output is not available to referencing component.

**Error Message:**
```
Error: Reference to unknown component
  Component "vpc" has not been defined
```

**Solutions:**

1. **Verify component exists** in configuration:

```hcl
component "vpc" {
  source = "./modules/vpc"
  # Must define component before referencing it
}

component "app" {
  source = "./modules/app"
  inputs = {
    vpc_id = component.vpc.vpc_id  # Now valid
  }
}
```

2. **Check output is defined in module:**

```hcl
# In modules/vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}
```

3. **For components with for_each**, reference specific instance:

```hcl
component "regional" {
  for_each = var.regions
  # ...
}

component "app" {
  inputs = {
    # Correct - reference specific instance
    vpc_id = component.regional["us-west-1"].vpc_id

    # Incorrect - can't reference for_each component directly
    # vpc_id = component.regional.vpc_id
  }
}
```

### Deferred Changes Not Converging

**Issue:** Deployment with deferred changes doesn't complete after multiple iterations.

**Error Message:**
```
Error: Maximum deferred change iterations reached
```

**Cause:** Dependency cycle or values that never stabilize.

**Solutions:**

1. **Review component dependencies** for logical cycles
2. **Check for computed values that change on every run**
3. **Refactor to break dependency chain**
4. **Consider multi-stage deployments** if resources truly can't be created together

## API and CLI Issues

### Empty Diagnostics Response

**Issue:** API request for diagnostics returns empty results.

**Request:**
```bash
curl "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/stack-diagnostics"
```

**Response:**
```json
{
  "data": []
}
```

**Solution:** Add required `stack_deployment_step_id` query parameter:

```bash
curl "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/stack-diagnostics?stack_deployment_step_id={step-id}"
```

### Cannot Retrieve Stack Outputs

**Issue:** No CLI command to retrieve Stack outputs after deployment.

**Why:** Currently no direct CLI command for outputs retrieval.

**Solution:** Use the artifacts API endpoint:

```bash
# Get final apply step ID first
APPLY_STEP=$(terraform stacks deployment-run list --json | \
  jq -r '.[0].deployment_steps[] | select(.operation_type == "apply") | .id' | tail -1)

# Get outputs
curl -L -s -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/$APPLY_STEP/artifacts?name=apply-description" | \
  jq -r '.outputs | to_entries | .[] | "\(.key): \(.value.change.after)"'
```

### CLI Watch Commands Hang in CI/CD

**Issue:** Commands like `terraform stacks deployment-run watch` never return in CI/CD pipelines.

**Why:** Watch commands stream output indefinitely and are designed for interactive use.

**Solution:** Use API polling instead of watch commands. See `api-monitoring.md` for complete workflow.

### Artifacts Endpoint Returns 404

**Issue:** Request to artifacts endpoint returns 404 Not Found.

**Possible Causes:**

1. **Step hasn't completed yet** - wait for step status to be "completed"
2. **Wrong artifact name** - use one of: plan-description, plan-debug-log, apply-description, apply-debug-log
3. **Invalid step ID** - verify step ID from deployment-steps endpoint

**Solution:**

```bash
# Check step status first
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}" | \
  jq '.data.attributes.status'

# Only request artifacts when status is "completed"
if [ "$STATUS" = "completed" ]; then
  curl -L -H "Authorization: Bearer $TOKEN" \
    "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/artifacts?name=apply-description"
fi
```

### HTTP 307 Redirect Not Followed

**Issue:** Artifacts endpoint returns redirect response instead of artifact content.

**Why:** The endpoint returns HTTP 307 redirect to the actual artifact URL.

**Solution:** Configure HTTP client to follow redirects:

```bash
# curl: Use -L flag
curl -L -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/artifacts?name=apply-description"

# Python requests: allow_redirects=True (default)
import requests
response = requests.get(url, headers=headers, allow_redirects=True)

# Node.js fetch: redirect: 'follow' (default)
const response = await fetch(url, {
  headers: headers,
  redirect: 'follow'
});
```

## Getting Additional Help

### Enable Debug Logging

For more detailed error information, enable debug logging:

```bash
# CLI commands
TF_LOG=DEBUG terraform stacks validate
TF_LOG=DEBUG terraform stacks configuration upload

# API artifacts
# Request the debug-log artifact instead of description
curl -L -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/artifacts?name=apply-debug-log"
```

### Check HCP Terraform Status

If experiencing widespread issues, check HCP Terraform status page:
- https://status.hashicorp.com

### Review Configuration Version

List recent configurations to identify when issues started:

```bash
terraform stacks configuration list
```

### Contact Support

For issues not covered here:
1. Gather relevant error messages and diagnostics
2. Note the configuration sequence number
3. Include deployment run IDs
4. Contact HashiCorp Support with details
