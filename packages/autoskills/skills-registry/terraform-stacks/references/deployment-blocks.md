# Deployment Configuration Block Reference

Complete reference for all blocks available in Terraform Stack deployment configuration files (`.tfdeploy.hcl`).

## Table of Contents

1. [Identity Token Block](#identity-token-block)
2. [Locals Block](#locals-block)
3. [Deployment Block](#deployment-block)
4. [Deployment Group Block](#deployment-group-block)
5. [Deployment Auto-Approve Block](#deployment-auto-approve-block)

**Note**: For Publish Output and Upstream Input blocks (linked Stacks), see `linked-stacks.md`.

## Identity Token Block

Generates JWT tokens for OIDC authentication with cloud providers.

### Syntax

```hcl
identity_token "<token_name>" {
  audience = [<audience_strings>]
}
```

### Arguments

- **token_name** (label, required): Unique identifier for this token
- **audience** (required): List of audience strings for the JWT

### Accessing Token

Reference the JWT using: `identity_token.<n>.jwt`

### Cloud Provider Audiences

**AWS:**
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}
```

**Azure:**
```hcl
identity_token "azure" {
  audience = ["api://AzureADTokenExchange"]
}
```

**Google Cloud:**
```hcl
identity_token "gcp" {
  audience = ["//iam.googleapis.com/projects/<PROJECT_NUMBER>/locations/global/workloadIdentityPools/<POOL_ID>/providers/<PROVIDER_ID>"]
}
```

**Setup Documentation:** For detailed instructions on configuring OIDC/workload identity for each cloud provider (including IAM roles, trust policies, and federated credentials), see: https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials

### Examples

**Single Token:**

```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "production" {
  inputs = {
    identity_token = identity_token.aws.jwt
    role_arn       = var.role_arn
  }
}
```

For complete working examples including multi-region identity token usage, see `examples.md`.

## Locals Block

Defines local values for reuse within deployment configuration.

### Syntax

```hcl
locals {
  <n> = <expression>
}
```

### Example

```hcl
locals {
  aws_regions = ["us-west-1", "us-east-1", "eu-west-1"]
  role_arn    = "arn:aws:iam::123456789012:role/hcp-terraform-stacks"

  common_inputs = {
    project_name = "my-app"
    environment  = "production"
  }
}
```

## Deployment Block

Defines deployment instances of the Stack.

### Syntax

```hcl
deployment "<deployment_name>" {
  inputs = {
    <input_name> = <value>
  }
}
```

### Arguments

- **deployment_name** (label, required): Unique identifier for this deployment
- **inputs** (required): Map of input variable values
- **destroy** (optional, default: false): Boolean flag to destroy this deployment

### Constraints

- Minimum 1 deployment per Stack
- Maximum 20 deployments per Stack
- No meta-arguments supported (no `for_each`, `count`)

### Destroying a Deployment

To safely remove a deployment from your Stack:

1. Set `destroy = true` in the deployment block
2. Apply the plan through HCP Terraform
3. After successful destruction, remove the deployment block from your configuration

**Important**: Using the `destroy` argument ensures your configuration has the provider authentication necessary to properly destroy the deployment's resources.

**Example:**
```hcl
deployment "old_environment" {
  inputs = {
    aws_region     = "us-west-1"
    instance_count = 2
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
  destroy = true  # Mark for destruction
}
```

After applying this plan and the deployment is destroyed, remove the entire `deployment "old_environment"` block from your configuration.

### Examples

**Single Deployment:**

```hcl
deployment "production" {
  inputs = {
    aws_region     = "us-west-1"
    instance_count = 5
    instance_type  = "t3.large"
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}
```

**Using Locals for Multiple Deployments:**

```hcl
locals {
  common_inputs = {
    role_arn       = "arn:aws:iam::123456789012:role/terraform"
    identity_token = identity_token.aws.jwt
    project_name   = "my-app"
  }
}

deployment "dev" {
  inputs = merge(local.common_inputs, {
    aws_region     = "us-east-1"
    instance_count = 1
    environment    = "dev"
  })
}

deployment "prod" {
  inputs = merge(local.common_inputs, {
    aws_region     = "us-west-1"
    instance_count = 5
    environment    = "prod"
  })
}
```

For complete multi-environment and multi-region deployment examples, see `examples.md`.

## Deployment Group Block

Groups deployments together to configure shared settings and auto-approval rules (HCP Terraform Premium tier feature).

### Syntax

```hcl
deployment_group "<group_name>" {
  deployments = [<deployment_references>]
}
```

### Arguments

- **group_name** (label, required): Unique identifier for this deployment group
- **deployments** (required): List of deployment references to include in this group

### Purpose

Deployment groups allow you to:
- Organize deployments logically (by environment, team, region, etc.)
- Configure shared auto-approval rules for multiple deployments
- Manage deployments more effectively at scale
- Establish consistent configuration patterns across all Stacks

### Examples

**Single Deployment Group (Best Practice):**

```hcl
deployment "production" {
  inputs = {
    aws_region     = "us-west-1"
    instance_count = 5
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

deployment_group "production" {
  deployments = [deployment.production]
}
```

**Multiple Deployment Groups:**

```hcl
deployment_group "non_production" {
  deployments = [
    deployment.development,
    deployment.staging
  ]
}

deployment_group "production" {
  deployments = [
    deployment.prod_us_east,
    deployment.prod_us_west,
    deployment.prod_eu_west
  ]
}
```

## Deployment Auto-Approve Block

Defines rules that automatically approve deployment plans based on specific conditions (HCP Terraform Premium feature).

### Syntax

```hcl
deployment_auto_approve "<rule_name>" {
  deployment_group = deployment_group.<group_name>
  
  check {
    condition = <boolean_expression>
    reason    = "<failure_message>"
  }
}
```

### Arguments

- **rule_name** (label, required): Unique identifier for this auto-approve rule
- **deployment_group** (required): Reference to the deployment group this rule applies to
- **check** (required, one or more): Condition that must be met for auto-approval

### Context Variables

Access plan information through `context` object:

- `context.plan.applyable` - Boolean: plan succeeded without errors
- `context.plan.changes.add` - Number: resources to add
- `context.plan.changes.change` - Number: resources to change
- `context.plan.changes.remove` - Number: resources to remove
- `context.plan.changes.import` - Number: resources to import

### Important Notes

- All checks must pass for auto-approval to occur
- If any check fails, manual approval is required
- HCP Terraform displays the failure reason from failed checks
- Auto-approve rules only apply to deployments in the specified deployment group

### Examples

**Auto-approve Successful Plans:**

```hcl
deployment_group "canary" {
  deployments = [
    deployment.dev,
    deployment.staging
  ]
}

deployment_auto_approve "applyable_plans" {
  deployment_group = deployment_group.canary
  
  check {
    condition = context.plan.applyable
    reason    = "Plan must be applyable without errors"
  }
}
```

**Auto-approve Non-Destructive Changes:**

```hcl
deployment_group "production" {
  deployments = [
    deployment.prod_primary,
    deployment.prod_secondary
  ]
}

deployment_auto_approve "safe_production_changes" {
  deployment_group = deployment_group.production
  
  check {
    condition = context.plan.changes.remove == 0
    reason    = "Production deletions require manual approval"
  }
  
  check {
    condition = context.plan.applyable
    reason    = "Plan must be successful"
  }
}
```

**Graduated Rollout Pattern:**

```hcl
deployment_group "canary" {
  deployments = [deployment.canary]
}

deployment_group "production" {
  deployments = [
    deployment.prod_us,
    deployment.prod_eu,
    deployment.prod_asia
  ]
}

# Canary auto-approves with strict checks
deployment_auto_approve "canary_strict" {
  deployment_group = deployment_group.canary
  
  check {
    condition = context.plan.changes.remove == 0
    reason    = "Canary cannot delete resources"
  }
  
  check {
    condition = context.plan.changes.change <= 5
    reason    = "Canary limited to 5 resource changes"
  }
  
  check {
    condition = context.plan.applyable
    reason    = "Plan must be applyable"
  }
}

# Production requires manual approval after canary validation
```

For complete deployment configuration examples with all blocks, see `examples.md`.
