# Terraform Stacks Complete Examples

Complete, working examples for common Terraform Stacks scenarios.

## Table of Contents

1. [Simple Single-Region Stack](#simple-single-region-stack)
2. [Stack with Private Registry Modules](#stack-with-private-registry-modules)
3. [Multi-Environment Stack](#multi-environment-stack)
4. [Multi-Region Stack](#multi-region-stack)
5. [Linked Stacks (Cross-Stack Dependencies)](#linked-stacks-cross-stack-dependencies)
6. [Multi-Cloud Stack](#multi-cloud-stack)
7. [Complete AWS Production Stack](#complete-aws-production-stack)
8. [Destroying Deployments](#destroying-deployments)

## Simple Single-Region Stack

Basic Stack with a single environment deployment.

### File Structure
```
simple-stack/
├── variables.tfcomponent.hcl
├── providers.tfcomponent.hcl
├── components.tfcomponent.hcl
├── deployments.tfdeploy.hcl
└── modules/
    └── webapp/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### variables.tfcomponent.hcl
```hcl
variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}

variable "app_name" {
  type = string
}
```

### providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
}

provider "aws" "main" {
  config {
    region = var.aws_region
    
    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }
  }
}
```

### components.tfcomponent.hcl
```hcl
component "webapp" {
  source = "./modules/webapp"
  
  inputs = {
    app_name = var.app_name
    region   = var.aws_region
  }
  
  providers = {
    aws = provider.aws.main
  }
}
```

### deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "production" {
  inputs = {
    aws_region     = "us-west-1"
    app_name       = "my-webapp"
    role_arn       = "arn:aws:iam::123456789012:role/terraform-stacks"
    identity_token = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "production" {
  deployments = [deployment.production]
}
```

## Stack with Private Registry Modules

Example Stack using modules from a private HCP Terraform registry, combining both private and public registry sources.

### File Structure
```
private-registry-stack/
├── variables.tfcomponent.hcl
├── providers.tfcomponent.hcl
├── components.tfcomponent.hcl
├── outputs.tfcomponent.hcl
└── deployments.tfdeploy.hcl
```

### variables.tfcomponent.hcl
```hcl
variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "environment" {
  type = string
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "app_name" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
```

### providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.0"
  }
}

provider "aws" "main" {
  config {
    region = var.aws_region

    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }

    default_tags {
      tags = {
        Environment = var.environment
        ManagedBy   = "Terraform Stacks"
        Application = var.app_name
      }
    }
  }
}

provider "random" "main" {
  config {}
}
```

### components.tfcomponent.hcl
```hcl
locals {
  name_prefix = "${var.app_name}-${var.environment}"
  common_tags = {
    Project     = var.app_name
    Environment = var.environment
  }
}

# Using a private registry module for VPC
component "vpc" {
  source  = "app.terraform.io/my-org/vpc/aws"
  version = "2.1.0"

  inputs = {
    name_prefix         = local.name_prefix
    cidr_block          = var.vpc_cidr
    availability_zones  = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
    enable_nat_gateway  = true
    single_nat_gateway  = var.environment != "prod"
    tags                = local.common_tags
  }

  providers = {
    aws = provider.aws.main
  }
}

# Using a private registry module for security groups
component "security_groups" {
  source  = "app.terraform.io/my-org/security-groups/aws"
  version = "1.5.2"

  inputs = {
    vpc_id      = component.vpc.vpc_id
    name_prefix = local.name_prefix
    environment = var.environment
  }

  providers = {
    aws = provider.aws.main
  }
}

# Using a public registry module for RDS
component "database" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  inputs = {
    identifier           = "${local.name_prefix}-db"
    engine               = "postgres"
    engine_version       = "15.3"
    family               = "postgres15"
    major_engine_version = "15"
    instance_class       = var.environment == "prod" ? "db.t3.large" : "db.t3.micro"

    allocated_storage     = var.environment == "prod" ? 100 : 20
    db_name               = replace(var.app_name, "-", "_")
    username              = "dbadmin"
    password              = var.db_password
    port                  = 5432

    db_subnet_group_name   = component.vpc.database_subnet_group_name
    vpc_security_group_ids = [component.security_groups.database_sg_id]

    backup_retention_period = var.environment == "prod" ? 30 : 7
    skip_final_snapshot     = var.environment != "prod"
    deletion_protection     = var.environment == "prod"

    tags = local.common_tags
  }

  providers = {
    aws = provider.aws.main
  }
}

# Using a private registry module for application infrastructure
component "application" {
  source  = "app.terraform.io/my-org/ecs-application/aws"
  version = "3.2.1"

  inputs = {
    name_prefix           = local.name_prefix
    vpc_id                = component.vpc.vpc_id
    private_subnet_ids    = component.vpc.private_subnet_ids
    public_subnet_ids     = component.vpc.public_subnet_ids
    app_security_group_id = component.security_groups.app_sg_id

    container_image       = "my-org/my-app:latest"
    container_port        = 8080
    desired_count         = var.environment == "prod" ? 3 : 1

    environment_variables = {
      ENVIRONMENT    = var.environment
      DATABASE_HOST  = component.database.db_instance_endpoint
      DATABASE_NAME  = component.database.db_instance_name
    }

    tags = local.common_tags
  }

  providers = {
    aws = provider.aws.main
  }
}
```

### outputs.tfcomponent.hcl
```hcl
output "vpc_id" {
  type        = string
  description = "VPC ID"
  value       = component.vpc.vpc_id
}

output "application_url" {
  type        = string
  description = "Application load balancer URL"
  value       = component.application.load_balancer_dns
}

output "database_endpoint" {
  type        = string
  description = "Database endpoint"
  value       = component.database.db_instance_endpoint
  sensitive   = true
}
```

### deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn = "arn:aws:iam::123456789012:role/terraform-stacks"
}

deployment "development" {
  inputs = {
    aws_region     = "us-west-2"
    environment    = "dev"
    app_name       = "myapp"
    vpc_cidr       = "10.0.0.0/16"
    db_password    = "dev-password-change-me"
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

deployment "production" {
  inputs = {
    aws_region     = "us-east-1"
    environment    = "prod"
    app_name       = "myapp"
    vpc_cidr       = "10.1.0.0/16"
    db_password    = "prod-password-use-secrets-manager"
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "development" {
  deployments = [deployment.development]
}

deployment_group "production" {
  deployments = [deployment.production]
}
```

### Key Points

- **Private registry modules** use the format `app.terraform.io/<org>/<module>/<provider>`
- **Version constraints** ensure consistent module versions across environments
- **Mixed sources**: Combining private registry modules (VPC, security groups, application) with public registry modules (RDS)
- **Authentication**: HCP Terraform workspaces automatically authenticate to private registries; CLI users need credentials configured
- **Terraform Enterprise**: Replace `app.terraform.io` with your instance hostname

## Multi-Environment Stack

Stack with development, staging, and production deployments.

### variables.tfcomponent.hcl
```hcl
variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}
```

### providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
}

provider "aws" "this" {
  config {
    region = var.aws_region
    
    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }
    
    default_tags {
      tags = {
        Environment = var.environment
        ManagedBy   = "Terraform Stacks"
      }
    }
  }
}
```

### components.tfcomponent.hcl
```hcl
locals {
  name_prefix = "myapp-${var.environment}"
}

component "vpc" {
  source = "./modules/vpc"
  
  inputs = {
    name_prefix = local.name_prefix
    cidr_block  = "10.0.0.0/16"
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "compute" {
  source = "./modules/compute"
  
  inputs = {
    name_prefix    = local.name_prefix
    vpc_id         = component.vpc.vpc_id
    subnet_ids     = component.vpc.private_subnet_ids
    instance_count = var.instance_count
    instance_type  = var.instance_type
  }
  
  providers = {
    aws = provider.aws.this
  }
}
```

### outputs.tfcomponent.hcl
```hcl
output "vpc_id" {
  type  = string
  value = component.vpc.vpc_id
}

output "load_balancer_url" {
  type  = string
  value = component.compute.load_balancer_url
}
```

### deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn = "arn:aws:iam::123456789012:role/terraform-stacks"
  
  environments = {
    dev = {
      region         = "us-east-1"
      instance_count = 1
      instance_type  = "t3.micro"
    }
    staging = {
      region         = "us-west-1"
      instance_count = 2
      instance_type  = "t3.small"
    }
    prod = {
      region         = "us-west-1"
      instance_count = 5
      instance_type  = "t3.large"
    }
  }
}

deployment "development" {
  inputs = {
    aws_region     = local.environments.dev.region
    environment    = "dev"
    instance_count = local.environments.dev.instance_count
    instance_type  = local.environments.dev.instance_type
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

deployment "staging" {
  inputs = {
    aws_region     = local.environments.staging.region
    environment    = "staging"
    instance_count = local.environments.staging.instance_count
    instance_type  = local.environments.staging.instance_type
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

deployment "production" {
  inputs = {
    aws_region     = local.environments.prod.region
    environment    = "prod"
    instance_count = local.environments.prod.instance_count
    instance_type  = local.environments.prod.instance_type
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "development" {
  deployments = [deployment.development]
}

deployment_group "non_production" {
  deployments = [deployment.staging]
}

deployment_group "production" {
  deployments = [deployment.production]
}

# Auto-approve dev deployments
deployment_auto_approve "dev_auto" {
  deployment_group = deployment_group.development

  check {
    condition = context.plan.applyable
    reason    = "Development plans must be applyable"
  }
}
```

## Multi-Region Stack

Stack that deploys identical infrastructure across multiple AWS regions.

### variables.tfcomponent.hcl
```hcl
variable "regions" {
  type = set(string)
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}

variable "app_name" {
  type = string
}
```

### providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
}

provider "aws" "regional" {
  for_each = var.regions
  
  config {
    region = each.value
    
    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }
    
    default_tags {
      tags = {
        Region    = each.value
        ManagedBy = "Terraform Stacks"
        AppName   = var.app_name
      }
    }
  }
}
```

### components.tfcomponent.hcl
```hcl
component "regional_infrastructure" {
  for_each = var.regions
  
  source = "./modules/regional-infra"
  
  inputs = {
    region      = each.value
    app_name    = var.app_name
    name_suffix = each.value
  }
  
  providers = {
    aws = provider.aws.regional[each.value]
  }
}

component "global_route53" {
  source = "./modules/route53"
  
  inputs = {
    app_name     = var.app_name
    domain_name  = "example.com"
    regional_lbs = {
      for region, comp in component.regional_infrastructure :
      region => comp.load_balancer_dns
    }
  }
  
  # Use one region's provider for global resources
  providers = {
    aws = provider.aws.regional["us-west-1"]
  }
}
```

### outputs.tfcomponent.hcl
```hcl
output "regional_endpoints" {
  type = map(string)
  value = {
    for region, comp in component.regional_infrastructure :
    region => comp.load_balancer_url
  }
}

output "global_domain" {
  type  = string
  value = component.global_route53.domain_name
}
```

### deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  regions = ["us-west-1", "us-east-1", "eu-west-1"]
}

deployment "multi_region_prod" {
  inputs = {
    regions        = toset(local.regions)
    app_name       = "my-global-app"
    role_arn       = "arn:aws:iam::123456789012:role/terraform-stacks"
    identity_token = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "production" {
  deployments = [deployment.multi_region_prod]
}
```

## Linked Stacks (Cross-Stack Dependencies)

Two Stacks where the application Stack depends on the network Stack.

### Network Stack

#### network-stack/variables.tfcomponent.hcl
```hcl
variable "vpc_cidr" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}
```

#### network-stack/providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
}

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

#### network-stack/components.tfcomponent.hcl
```hcl
component "vpc" {
  source = "./modules/vpc"
  
  inputs = {
    cidr_block  = var.vpc_cidr
    environment = var.environment
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "security_groups" {
  source = "./modules/security-groups"
  
  inputs = {
    vpc_id      = component.vpc.vpc_id
    environment = var.environment
  }
  
  providers = {
    aws = provider.aws.this
  }
}
```

#### network-stack/outputs.tfcomponent.hcl
```hcl
output "vpc_id" {
  type  = string
  value = component.vpc.vpc_id
}

output "private_subnet_ids" {
  type  = list(string)
  value = component.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  type  = list(string)
  value = component.vpc.public_subnet_ids
}

output "app_security_group_id" {
  type  = string
  value = component.security_groups.app_sg_id
}
```

#### network-stack/deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn = "arn:aws:iam::123456789012:role/terraform-stacks"
}

deployment "network" {
  inputs = {
    aws_region     = "us-west-1"
    environment    = "production"
    vpc_cidr       = "10.0.0.0/16"
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

# Publish outputs for other stacks
publish_output "vpc_id_network" {
  type  = string
  value = deployment.network.vpc_id
}

publish_output "private_subnet_ids" {
  type  = list(string)
  value = deployment.network.private_subnet_ids
}

publish_output "public_subnet_ids" {
  type  = list(string)
  value = deployment.network.public_subnet_ids
}

publish_output "app_security_group_id" {
  type  = string
  value = deployment.network.app_security_group_id
}

# Deployment groups
deployment_group "network" {
  deployments = [deployment.network]
}
```

### Application Stack

#### application-stack/variables.tfcomponent.hcl
```hcl
variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "aws_region" {
  type = string
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}
```

#### application-stack/providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
}

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

#### application-stack/components.tfcomponent.hcl
```hcl
component "application" {
  source = "./modules/app"
  
  inputs = {
    vpc_id            = var.vpc_id
    subnet_ids        = var.subnet_ids
    security_group_id = var.security_group_id
    instance_count    = var.instance_count
  }
  
  providers = {
    aws = provider.aws.this
  }
}
```

#### application-stack/deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

# Reference the network stack
upstream_input "network" {
  type   = "stack"
  source = "app.terraform.io/my-org/my-project/network-stack"
}

deployment "application" {
  inputs = {
    aws_region        = "us-west-1"
    vpc_id            = upstream_input.network.vpc_id_network
    subnet_ids        = upstream_input.network.private_subnet_ids
    security_group_id = upstream_input.network.app_security_group_id
    instance_count    = 3
    role_arn          = "arn:aws:iam::123456789012:role/terraform-stacks"
    identity_token    = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "application" {
  deployments = [deployment.application]
}
```

## Multi-Cloud Stack

Stack that deploys to both AWS and Azure.

### variables.tfcomponent.hcl
```hcl
variable "aws_region" {
  type = string
}

variable "azure_location" {
  type = string
}

variable "aws_identity_token" {
  type      = string
  ephemeral = true
}

variable "aws_role_arn" {
  type = string
}

variable "azure_identity_token" {
  type      = string
  ephemeral = true
}

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_client_id" {
  type = string
}

variable "app_name" {
  type = string
}
```

### providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~> 3.0"
  }
}

provider "aws" "this" {
  config {
    region = var.aws_region
    
    assume_role_with_web_identity {
      role_arn           = var.aws_role_arn
      web_identity_token = var.aws_identity_token
    }
  }
}

provider "azurerm" "this" {
  config {
    features {}
    
    subscription_id = var.azure_subscription_id
    tenant_id       = var.azure_tenant_id
    client_id       = var.azure_client_id
    
    use_oidc = true
    oidc_token = var.azure_identity_token
  }
}
```

### components.tfcomponent.hcl
```hcl
component "aws_infrastructure" {
  source = "./modules/aws-infra"
  
  inputs = {
    region   = var.aws_region
    app_name = var.app_name
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "azure_infrastructure" {
  source = "./modules/azure-infra"
  
  inputs = {
    location = var.azure_location
    app_name = var.app_name
  }
  
  providers = {
    azurerm = provider.azurerm.this
  }
}
```

### deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

identity_token "azure" {
  audience = ["api://AzureADTokenExchange"]
}

deployment "multi_cloud" {
  inputs = {
    aws_region             = "us-west-1"
    azure_location         = "westus2"
    app_name               = "my-multi-cloud-app"
    aws_role_arn           = "arn:aws:iam::123456789012:role/terraform-stacks"
    aws_identity_token     = identity_token.aws.jwt
    azure_subscription_id  = "12345678-1234-1234-1234-123456789012"
    azure_tenant_id        = "87654321-4321-4321-4321-210987654321"
    azure_client_id        = "11111111-1111-1111-1111-111111111111"
    azure_identity_token   = identity_token.azure.jwt
  }
}

# Deployment groups
deployment_group "multi_cloud" {
  deployments = [deployment.multi_cloud]
}
```

## Complete AWS Production Stack

Full production-grade Stack with VPC, RDS, ECS, and monitoring.

### variables.tfcomponent.hcl
```hcl
variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "ecs_desired_count" {
  type        = number
  description = "Desired ECS task count"
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}
```

### providers.tfcomponent.hcl
```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.0"
  }
}

provider "aws" "this" {
  config {
    region = var.aws_region
    
    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }
    
    default_tags {
      tags = {
        Environment = var.environment
        Application = var.app_name
        ManagedBy   = "Terraform Stacks"
      }
    }
  }
}

provider "random" "this" {
  config {}
}
```

### components.tfcomponent.hcl
```hcl
locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

component "vpc" {
  source = "./modules/vpc"
  
  inputs = {
    name_prefix = local.name_prefix
    cidr_block  = var.vpc_cidr
    azs_count   = 3
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "security_groups" {
  source = "./modules/security-groups"
  
  inputs = {
    name_prefix = local.name_prefix
    vpc_id      = component.vpc.vpc_id
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "rds" {
  source = "./modules/rds"
  
  inputs = {
    name_prefix        = local.name_prefix
    instance_class     = var.db_instance_class
    subnet_ids         = component.vpc.private_subnet_ids
    security_group_ids = [component.security_groups.database_sg_id]
  }
  
  providers = {
    aws    = provider.aws.this
    random = provider.random.this
  }
}

component "ecs_cluster" {
  source = "./modules/ecs-cluster"
  
  inputs = {
    name_prefix = local.name_prefix
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "ecs_service" {
  source = "./modules/ecs-service"
  
  inputs = {
    name_prefix      = local.name_prefix
    cluster_id       = component.ecs_cluster.cluster_id
    desired_count    = var.ecs_desired_count
    subnet_ids       = component.vpc.private_subnet_ids
    security_group_id = component.security_groups.app_sg_id
    database_endpoint = component.rds.endpoint
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "alb" {
  source = "./modules/alb"
  
  inputs = {
    name_prefix       = local.name_prefix
    vpc_id            = component.vpc.vpc_id
    subnet_ids        = component.vpc.public_subnet_ids
    security_group_id = component.security_groups.alb_sg_id
    target_group_arn  = component.ecs_service.target_group_arn
  }
  
  providers = {
    aws = provider.aws.this
  }
}

component "cloudwatch" {
  source = "./modules/cloudwatch"
  
  inputs = {
    name_prefix  = local.name_prefix
    cluster_name = component.ecs_cluster.cluster_name
    service_name = component.ecs_service.service_name
  }
  
  providers = {
    aws = provider.aws.this
  }
}
```

### outputs.tfcomponent.hcl
```hcl
output "load_balancer_url" {
  type        = string
  description = "Application load balancer URL"
  value       = component.alb.dns_name
}

output "database_endpoint" {
  type        = string
  description = "RDS endpoint"
  value       = component.rds.endpoint
  sensitive   = true
}

output "vpc_id" {
  type  = string
  value = component.vpc.vpc_id
}

output "ecs_cluster_name" {
  type  = string
  value = component.ecs_cluster.cluster_name
}
```

### deployments.tfdeploy.hcl
```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn = "arn:aws:iam::123456789012:role/terraform-stacks"
}

deployment "staging" {
  inputs = {
    aws_region        = "us-west-1"
    environment       = "staging"
    app_name          = "myapp"
    vpc_cidr          = "10.1.0.0/16"
    db_instance_class = "db.t3.small"
    ecs_desired_count = 2
    role_arn          = local.role_arn
    identity_token    = identity_token.aws.jwt
  }
}

deployment "production" {
  inputs = {
    aws_region        = "us-west-1"
    environment       = "production"
    app_name          = "myapp"
    vpc_cidr          = "10.0.0.0/16"
    db_instance_class = "db.r5.large"
    ecs_desired_count = 5
    role_arn          = local.role_arn
    identity_token    = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "staging" {
  deployments = [deployment.staging]
}

deployment_group "production" {
  deployments = [deployment.production]
}

# Auto-approve staging with safety checks
deployment_auto_approve "staging_safe" {
  deployment_group = deployment_group.staging

  check {
    condition = context.plan.changes.remove == 0
    reason    = "Cannot auto-approve deletions in staging"
  }

  check {
    condition = context.plan.applyable
    reason    = "Plan must be applyable"
  }
}
```

## Testing Configurations

### Validate Stack Configuration
```bash
terraform stacks providers lock
terraform stacks validate
```

### Plan Specific Deployment
```bash
terraform stacks plan --deployment=development
terraform stacks plan --deployment=production
```

### Apply Deployment
```bash
terraform stacks apply --deployment=staging
```

## Destroying Deployments

Example of safely removing a deployment from your Stack.

### Scenario

You want to decommission the "development" deployment while keeping staging and production active.

### Step 1: Mark Deployment for Destruction

Update your `deployments.tfdeploy.hcl` file to set `destroy = true`:

```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn = "arn:aws:iam::123456789012:role/terraform-stacks"
}

# Mark this deployment for destruction
deployment "development" {
  inputs = {
    aws_region     = "us-east-1"
    environment    = "dev"
    instance_count = 1
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
  destroy = true  # This tells HCP Terraform to destroy all resources
}

# Keep these deployments active
deployment "staging" {
  inputs = {
    aws_region     = "us-west-1"
    environment    = "staging"
    instance_count = 2
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

deployment "production" {
  inputs = {
    aws_region     = "us-west-1"
    environment    = "prod"
    instance_count = 5
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "staging" {
  deployments = [deployment.staging]
}

deployment_group "production" {
  deployments = [deployment.production]
}
```

### Step 2: Plan and Apply

```bash
# Review the destruction plan
terraform stacks plan --deployment=development

# Apply the destruction
terraform stacks apply --deployment=development
```

HCP Terraform will destroy all resources in the development deployment.

### Step 3: Remove the Deployment Block

After the deployment is successfully destroyed, remove the entire deployment block from your configuration:

```hcl
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

locals {
  role_arn = "arn:aws:iam::123456789012:role/terraform-stacks"
}

# deployment "development" block has been removed

deployment "staging" {
  inputs = {
    aws_region     = "us-west-1"
    environment    = "staging"
    instance_count = 2
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

deployment "production" {
  inputs = {
    aws_region     = "us-west-1"
    environment    = "prod"
    instance_count = 5
    role_arn       = local.role_arn
    identity_token = identity_token.aws.jwt
  }
}

# Deployment groups
deployment_group "staging" {
  deployments = [deployment.staging]
}

deployment_group "production" {
  deployments = [deployment.production]
}
```

### Important Notes

- **Provider Authentication**: The `destroy` argument ensures your configuration retains the provider authentication needed to destroy resources
- **Do Not Remove Immediately**: Don't remove the deployment block until after the destruction is complete
- **Verify Before Removing**: Check HCP Terraform UI to confirm all resources are destroyed before removing the block
- **Alternative**: You could manually destroy resources through HCP Terraform UI, but using `destroy = true` is the recommended approach for maintaining infrastructure-as-code practices
