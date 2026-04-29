# Linked Stacks Reference

Complete reference for linking Terraform Stacks together using published outputs and upstream inputs.

## Publish Output Block

Exports outputs from a Stack for consumption by other Stacks (linked Stacks).

###Syntax

```hcl
publish_output "<output_name>" {
  type  = <type>
  value = <expression>
}
```

### Arguments

- **output_name** (label, required): Unique identifier for this published output
- **type** (required): Data type of the output
- **value** (required): Expression to export

### Accessing Deployment Outputs

Reference deployment outputs using: `deployment.<deployment_name>.<output_name>`

### Important Notes

- Must apply the Stack's deployment configuration before downstream Stacks can reference outputs
- Published outputs create a snapshot that other Stacks can read
- Changes to published outputs automatically trigger runs in downstream Stacks

### Examples

**Basic Published Output:**

```hcl
publish_output "vpc_id" {
  type  = string
  value = deployment.network.vpc_id
}

publish_output "subnet_ids" {
  type  = list(string)
  value = deployment.network.private_subnet_ids
}
```

**Multiple Deployment Outputs:**

```hcl
publish_output "regional_vpc_ids" {
  type = map(string)
  value = {
    us_east = deployment.us_east.vpc_id
    us_west = deployment.us_west.vpc_id
    eu_west = deployment.eu_west.vpc_id
  }
}
```

**Complex Output:**

```hcl
publish_output "database_config" {
  type = object({
    endpoint = string
    port     = number
    name     = string
  })
  value = {
    endpoint = deployment.production.db_endpoint
    port     = deployment.production.db_port
    name     = deployment.production.db_name
  }
}
```

**Regional Endpoints:**

```hcl
publish_output "api_endpoints" {
  type = map(object({
    url    = string
    region = string
  }))
  value = {
    for env in ["dev", "staging", "prod"] : env => {
      url    = deployment[env].api_url
      region = deployment[env].region
    }
  }
}
```

## Upstream Input Block

References published outputs from another Stack (linked Stacks).

### Syntax

```hcl
upstream_input "<input_name>" {
  type   = "stack"
  source = "<stack_address>"
}
```

### Arguments

- **input_name** (label, required): Local name for this upstream input
- **type** (required): Must be "stack"
- **source** (required): Full Stack address in format: `app.terraform.io/<org>/<project>/<stack-name>`

### Accessing Upstream Outputs

Reference upstream outputs using: `upstream_input.<input_name>.<output_name>`

### Important Notes

- Creates a dependency on the upstream Stack
- Upstream Stack must have applied its deployment configuration
- Changes in upstream Stack automatically trigger downstream Stack runs
- Only works with Stacks in the same HCP Terraform project

### Examples

**Basic Upstream Reference:**

```hcl
upstream_input "network" {
  type   = "stack"
  source = "app.terraform.io/my-org/my-project/networking-stack"
}

deployment "application" {
  inputs = {
    vpc_id     = upstream_input.network.vpc_id
    subnet_ids = upstream_input.network.subnet_ids
  }
}
```

**Multiple Upstream Stacks:**

```hcl
upstream_input "network" {
  type   = "stack"
  source = "app.terraform.io/my-org/my-project/network-stack"
}

upstream_input "database" {
  type   = "stack"
  source = "app.terraform.io/my-org/my-project/database-stack"
}

deployment "application" {
  inputs = {
    vpc_id              = upstream_input.network.vpc_id
    subnet_ids          = upstream_input.network.private_subnet_ids
    database_endpoint   = upstream_input.database.endpoint
    database_credentials = upstream_input.database.credentials
  }
}
```

**Regional Upstream Dependencies:**

```hcl
upstream_input "regional_network" {
  type   = "stack"
  source = "app.terraform.io/my-org/my-project/regional-networks"
}

deployment "us_east_app" {
  inputs = {
    region     = "us-east-1"
    vpc_id     = upstream_input.regional_network.regional_vpc_ids["us_east"]
    subnet_ids = upstream_input.regional_network.regional_subnet_ids["us_east"]
  }
}
```

## Complete Working Example

For a complete example showing full Stack configurations with all files (variables, providers, components, outputs, deployments) for both upstream and downstream Stacks, see the "Linked Stacks (Cross-Stack Dependencies)" section in `examples.md`.
