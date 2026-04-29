---
name: refactor-module
description: Transform monolithic Terraform configurations into reusable, maintainable modules following HashiCorp's module design principles and community best practices.
metadata:
  copyright: Copyright IBM Corp. 2026
  version: "0.0.1"
---

# Skill: Refactor Module

## Overview
This skill guides AI agents in transforming monolithic Terraform configurations into reusable, maintainable modules following HashiCorp's module design principles and community best practices.

## Capability Statement
The agent will analyze existing Terraform code and systematically refactor it into well-structured modules with:
- Clear interface contracts (variables and outputs)
- Proper encapsulation and abstraction
- Versioning and documentation
- Testing frameworks
- Migration path for existing state

## Prerequisites
- Existing Terraform configuration to refactor
- Understanding of resource dependencies
- Access to current state file (for migration planning)
- Knowledge of module registry patterns

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `source_directory` | string | Yes | Path to existing Terraform configuration |
| `module_name` | string | Yes | Name for the new module |
| `abstraction_level` | string | No | "simple", "intermediate", "advanced" (default: intermediate) |
| `preserve_state` | boolean | Yes | Whether to maintain state compatibility |
| `target_registry` | string | No | Target module registry (local, private, public) |

## Execution Steps

### 1. Analysis Phase
```markdown
**Identify Refactoring Candidates**
- Group resources by logical function
- Identify repeated patterns
- Map resource dependencies
- Detect configuration coupling
- Analyze variable usage patterns

**Complexity Assessment**
- Count resource relationships
- Measure variable propagation depth
- Identify cross-resource references
- Evaluate state migration complexity
```

### 2. Module Design

#### Interface Design
```hcl
# Define clear input contract
variable "network_config" {
  description = "Network configuration parameters"
  type = object({
    cidr_block         = string
    availability_zones = list(string)
    enable_nat         = bool
  })
  
  validation {
    condition     = can(cidrhost(var.network_config.cidr_block, 0))
    error_message = "CIDR block must be valid IPv4 CIDR."
  }
}

# Define output contract
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = { for k, v in aws_subnet.private : k => v.id }
}
```

#### Encapsulation Strategy
```markdown
**What to Include in Module:**
- Tightly coupled resources (VPC + subnets)
- Resources with shared lifecycle
- Configuration with clear boundaries

**What to Keep Separate:**
- Cross-cutting concerns (monitoring, tagging)
- Resources with different lifecycles
- Provider-specific configurations
```

### 3. Code Transformation

#### Before: Monolithic Configuration
```hcl
# main.tf (monolithic)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  
  tags = {
    Name = "production-vpc"
    Environment = "prod"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "public-subnet-1"
    Type = "public"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "public-subnet-2"
    Type = "public"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "production-igw"
  }
}

# ... more repetitive subnet and routing resources
```

#### After: Modular Structure
```hcl
# modules/vpc/main.tf
locals {
  subnet_count = length(var.availability_zones)
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  
  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_subnet" "public" {
  for_each = var.create_public_subnets ? toset(var.availability_zones) : []
  
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, index(var.availability_zones, each.value))
  availability_zone       = each.value
  map_public_ip_on_launch = true
  
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-${each.value}"
      Type = "public"
    }
  )
}

resource "aws_internet_gateway" "main" {
  count  = var.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-igw"
    }
  )
}

# modules/vpc/variables.tf
variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  
  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "Must be a valid IPv4 CIDR block."
  }
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "create_public_subnets" {
  description = "Whether to create public subnets"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# modules/vpc/outputs.tf
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "Map of availability zones to public subnet IDs"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = try(aws_internet_gateway.main[0].id, null)
}

# Root configuration using module
module "vpc" {
  source = "./modules/vpc"
  
  name               = "production"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  
  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

### 4. State Migration

#### Generate Migration Plan
```hcl
# migration.tf
# Use moved blocks for state refactoring (Terraform 1.1+)

moved {
  from = aws_vpc.main
  to   = module.vpc.aws_vpc.main
}

moved {
  from = aws_subnet.public_1
  to   = module.vpc.aws_subnet.public["us-east-1a"]
}

moved {
  from = aws_subnet.public_2
  to   = module.vpc.aws_subnet.public["us-east-1b"]
}

moved {
  from = aws_internet_gateway.main
  to   = module.vpc.aws_internet_gateway.main[0]
}
```

#### Manual State Migration (Pre-1.1)
```bash
# Generate state migration commands
terraform state mv aws_vpc.main module.vpc.aws_vpc.main
terraform state mv aws_subnet.public_1 'module.vpc.aws_subnet.public["us-east-1a"]'
terraform state mv aws_subnet.public_2 'module.vpc.aws_subnet.public["us-east-1b"]'
terraform state mv aws_internet_gateway.main 'module.vpc.aws_internet_gateway.main[0]'
```

### 5. Module Documentation

```markdown
# VPC Module

## Overview
Creates a VPC with configurable public and private subnets across multiple availability zones.

## Features
- Multi-AZ subnet deployment
- Optional NAT gateway configuration
- VPC Flow Logs integration
- Customizable CIDR allocation

## Usage

\`\`\`hcl
module "vpc" {
  source = "./modules/vpc"
  
  name               = "my-vpc"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  
  create_public_subnets  = true
  create_private_subnets = true
  enable_nat_gateway     = true
  
  tags = {
    Environment = "production"
  }
}
\`\`\`

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name prefix for resources | `string` | n/a | yes |
| cidr_block | VPC CIDR block | `string` | n/a | yes |
| availability_zones | List of AZs | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC identifier |
| public_subnet_ids | Map of public subnet IDs |
| private_subnet_ids | Map of private subnet IDs |

## Examples

See [examples/](./examples/) directory for complete usage examples.
```

### 6. Testing

Use skill terraform-test

**Test File**: A `.tftest.hcl` or `.tftest.json` file containing test configuration and run blocks that validate your Terraform configuration.

**Test Block**: Optional configuration block that defines test-wide settings (available since Terraform 1.6.0).

**Run Block**: Defines a single test scenario with optional variables, provider configurations, and assertions. Each test file requires at least one run block.

**Assert Block**: Contains conditions that must evaluate to true for the test to pass. Failed assertions cause the test to fail.

**Mock Provider**: Simulates provider behavior without creating real infrastructure (available since Terraform 1.7.0).

**Test Modes**: Tests run in apply mode (default, creates real infrastructure) or plan mode (validates logic without creating resources).

#### File Structure

Terraform test files use the `.tftest.hcl` or `.tftest.json` extension and are typically organized in a `tests/` directory. Use clear naming conventions to distinguish between unit tests (plan mode) and integration tests (apply mode):

```
my-module/
├── main.tf
├── variables.tf
├── outputs.tf
└── tests/
    ├── unit_test.tftest.hcl      # Unit test (plan mode)
    └── integration_test.tftest.hcl  # Integration test (apply mode - creates real resources)
```

## Refactoring Patterns

### Pattern 1: Resource Grouping
Extract related resources into cohesive modules:
- Networking (VPC, Subnets, Route Tables)
- Compute (ASG, Launch Templates, Load Balancers)
- Data (RDS, ElastiCache, S3)

### Pattern 2: Configuration Layering
```hcl
# Base module with defaults
module "vpc_base" {
  source = "./modules/vpc-base"
  # Minimal required inputs
}

# Environment-specific wrapper
module "vpc_prod" {
  source = "./modules/vpc-production"
  # Inherits from base, adds prod-specific config
}
```

### Pattern 3: Composition
```hcl
# Small, focused modules
module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "application" {
  source     = "./modules/application"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  sg_ids     = module.security_groups.app_sg_ids
}
```

## Common Pitfalls

### 1. Over-Abstraction
```hcl
# ❌ Don't create overly generic modules
variable "resources" {
  type = map(map(any))  # Too flexible, hard to validate
}

# ✅ Do use specific, typed interfaces
variable "database_config" {
  type = object({
    engine         = string
    instance_class = string
  })
}
```

### 2. Tight Coupling
```hcl
# ❌ Don't couple modules through direct references
# module A
output "instance_id" { value = aws_instance.app.id }

# module B (in same config)
resource "aws_eip" "app" {
  instance = module.a.instance_id  # Tight coupling
}

# ✅ Do pass dependencies through root module
module "compute" {
  source = "./modules/compute"
}

resource "aws_eip" "app" {
  instance = module.compute.instance_id
}
```

### 3. State Migration Errors
Always test migration in non-production first:
```bash
# Create plan to verify no changes after migration
terraform plan -out=migration.tfplan

# Review carefully
terraform show migration.tfplan

# Apply only if plan shows no changes
terraform apply migration.tfplan
```

## Version Control Strategy

```hcl
# Use semantic versioning for modules
module "vpc" {
  source  = "git::https://github.com/org/terraform-modules.git//vpc?ref=v1.2.0"
  version = "~> 1.2"
}

# Pin to specific versions in production
# Use version ranges in development
```

## Success Criteria

- [ ] Module has single, well-defined responsibility
- [ ] All variables have descriptions and types
- [ ] Validation rules prevent invalid configurations
- [ ] Outputs provide sufficient information for consumers
- [ ] Documentation includes usage examples
- [ ] Tests verify module behavior
- [ ] State migration completed without resource recreation
- [ ] No plan differences after refactoring

## Related Skills
- [Terraform code generation](https://raw.githubusercontent.com/hashicorp/agent-skills/refs/heads/main/terraform/code-generation/skills/terraform-style-guide/SKILL.md) - Style guide for the new Terraform Module
- [Azure Verified Modules](https://raw.githubusercontent.com/hashicorp/agent-skills/refs/heads/main/terraform/code-generation/skills/azure-verified-modules/SKILL.md) - Recommended module specifications for Azure

## Resources
- [Terraform Module Development](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Module Best Practices](https://developer.hashicorp.com/terraform/cloud-docs/registry/design)

## Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-11-07 | Initial skill definition |
