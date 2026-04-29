# API Monitoring Reference

Complete guide for monitoring Terraform Stack deployments using the HCP Terraform API. Use this approach for automation, CI/CD pipelines, and non-interactive environments like AI agents.

## Table of Contents

1. [When to Use the API](#when-to-use-the-api)
2. [Authentication](#authentication)
3. [API Monitoring Workflow](#api-monitoring-workflow)
4. [Detailed Endpoint Reference](#detailed-endpoint-reference)
5. [Notes for AI Agents and Automation](#notes-for-ai-agents-and-automation)

## When to Use the API

Use the HCP Terraform API instead of CLI commands when:
- Running in non-interactive environments (CI/CD, automation scripts)
- Building tools or integrations that need programmatic access
- Monitoring multiple Stacks simultaneously
- Implementing custom retry logic or error handling
- Working in environments where streaming CLI commands don't work

**CLI commands that don't work in automation:**
- `terraform stacks deployment-run watch` - Streams output, blocks indefinitely
- `terraform stacks deployment-group watch` - Streams output, blocks indefinitely
- `terraform stacks configuration watch` - Streams output, blocks indefinitely

## Authentication

### Extract API Token from Credentials File

```bash
TOKEN=$(jq -r '.credentials["app.terraform.io"].token' ~/.terraform.d/credentials.tfrc.json)
```

### Alternative: Use Environment Variable

```bash
export TFC_TOKEN="your-token-here"
TOKEN=$TFC_TOKEN
```

### API Request Headers

All API requests require these headers:

```bash
-H "Authorization: Bearer $TOKEN"
-H "Content-Type: application/vnd.api+json"
```

## API Monitoring Workflow

After uploading a configuration with `terraform stacks configuration upload`, follow this sequence to monitor deployment progress:

### Step 1: Get Configuration Status

**Endpoint:** `GET /api/v2/stack-configurations/{configuration-id}`

**Purpose:** Verify configuration upload completed successfully and get the configuration details.

**Request:**

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/vnd.api+json" \
  "https://app.terraform.io/api/v2/stack-configurations/{configuration-id}" | jq '.'
```

**Response Fields:**
- `attributes.status` - Configuration processing status (pending/completed)
- `attributes.sequence-number` - Version number of this configuration
- `attributes.components-detected` - Number of components found
- `attributes.deployments-detected` - Number of deployments found

**Example Response:**

```json
{
  "data": {
    "id": "stc-ABC123",
    "type": "stack-configurations",
    "attributes": {
      "status": "completed",
      "sequence-number": 5,
      "components-detected": 3,
      "deployments-detected": 2,
      "created-at": "2024-01-15T10:30:00.000Z",
      "updated-at": "2024-01-15T10:30:45.000Z"
    }
  }
}
```

### Step 2: Get Deployment Group Summaries

**Endpoint:** `GET /api/v2/stack-configurations/{configuration-id}/stack-deployment-group-summaries`

**Purpose:** Get list of deployment groups, their IDs, and current status summary.

**Request:**

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/vnd.api+json" \
  "https://app.terraform.io/api/v2/stack-configurations/{configuration-id}/stack-deployment-group-summaries" | jq '.'
```

**Response Fields:**
- `id` - Deployment group ID (needed for next step)
- `attributes.name` - Deployment group name (e.g., `dev_default`)
- `attributes.status` - Overall status (running/succeeded/failed)
- `attributes.status-counts` - Breakdown of deployment statuses

**Example Response:**

```json
{
  "data": [
    {
      "id": "sdg-XYZ789",
      "type": "stack-deployment-group-summaries",
      "attributes": {
        "name": "dev_default",
        "status": "running",
        "status-counts": {
          "pending": 0,
          "running": 1,
          "succeeded": 1,
          "failed": 0
        }
      }
    }
  ]
}
```

### Step 3: Get Deployment Runs

**Endpoint:** `GET /api/v2/stack-deployment-groups/{group-id}/stack-deployment-runs`

**Purpose:** Get list of deployment runs for a specific group with their current status.

**Request:**

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/vnd.api+json" \
  "https://app.terraform.io/api/v2/stack-deployment-groups/{group-id}/stack-deployment-runs" | jq '.'
```

**Response Fields:**
- `id` - Deployment run ID (needed for next step)
- `attributes.status` - Current status (planning/planned/applying/applied/failed)
- `attributes.created-at` - Run start time
- `attributes.updated-at` - Last update time

**Example Response:**

```json
{
  "data": [
    {
      "id": "sdr-123ABC",
      "type": "stack-deployment-runs",
      "attributes": {
        "status": "planning",
        "created-at": "2024-01-15T10:31:00.000Z",
        "updated-at": "2024-01-15T10:31:15.000Z"
      }
    }
  ]
}
```

### Step 4: Get Deployment Steps

**Endpoint:** `GET /api/v2/stack-deployment-runs/{run-id}/stack-deployment-steps`

**Purpose:** Get detailed information about individual plan and apply steps.

**Request:**

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/vnd.api+json" \
  "https://app.terraform.io/api/v2/stack-deployment-runs/{run-id}/stack-deployment-steps" | jq '.'
```

**Response Fields:**
- `id` - Step ID (needed for diagnostics and outputs)
- `attributes.operation-type` - Type of operation (plan/apply)
- `attributes.status` - Step status (running/completed/failed)
- `attributes.component-name` - Which component is being processed

**Example Response:**

```json
{
  "data": [
    {
      "id": "sds-PlanStep123",
      "type": "stack-deployment-steps",
      "attributes": {
        "operation-type": "plan",
        "status": "completed",
        "component-name": "vpc",
        "created-at": "2024-01-15T10:31:05.000Z",
        "completed-at": "2024-01-15T10:31:30.000Z"
      }
    },
    {
      "id": "sds-ApplyStep456",
      "type": "stack-deployment-steps",
      "attributes": {
        "operation-type": "apply",
        "status": "running",
        "component-name": "vpc",
        "created-at": "2024-01-15T10:32:00.000Z"
      }
    }
  ]
}
```

### Step 5: Get Error Diagnostics (When Deployment Fails)

**Endpoint:** `GET /api/v2/stack-deployment-steps/{step-id}/stack-diagnostics`

**Purpose:** Retrieve detailed error messages when a deployment step fails.

**Critical:** The `stack_deployment_step_id` query parameter is **required**. Without it, the API returns empty results.

**Request:**

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/vnd.api+json" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/stack-diagnostics?stack_deployment_step_id={step-id}" | jq '.'
```

**Response Fields:**
- `attributes.severity` - Diagnostic level (error/warning)
- `attributes.summary` - Brief error description
- `attributes.detail` - Detailed error message
- `attributes.diags` - Array of diagnostic objects with file locations and code snippets

**Example Response (Error with Details):**

```json
{
  "data": [
    {
      "id": "stf-ErrorExampleId",
      "type": "stack-diagnostics",
      "attributes": {
        "severity": "error",
        "summary": "Diagnostics reported",
        "detail": "2 errors",
        "diags": [
          {
            "summary": "Unsupported attribute",
            "detail": "This object does not have an attribute named \"target_id\".",
            "range": {
              "filename": "main.tf",
              "start": {
                "line": 634,
                "column": 33
              },
              "end": {
                "line": 634,
                "column": 43
              },
              "source": "registry.terraform.io/terraform-aws-modules/alb/aws@9.17.0//main.tf"
            },
            "snippet": {
              "code": "  target_id         = each.value.target_id",
              "context": "resource \"aws_lb_target_group_attachment\" \"this\""
            }
          },
          {
            "summary": "Invalid reference",
            "detail": "A reference to a resource type must be followed by at least one attribute access.",
            "range": {
              "filename": "main.tf",
              "start": {
                "line": 142,
                "column": 15
              },
              "end": {
                "line": 142,
                "column": 28
              },
              "source": "local-module//main.tf"
            },
            "snippet": {
              "code": "  vpc_id = aws_vpc.main",
              "context": "resource \"aws_subnet\" \"private\""
            }
          }
        ],
        "acknowledged": false,
        "created-at": "2024-01-15T10:32:15.000Z"
      }
    }
  ]
}
```

**Parsing Diagnostics:**

Extract error information with jq:

```bash
# Get error summaries
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/stack-diagnostics?stack_deployment_step_id={step-id}" | \
  jq -r '.data[].attributes.diags[]? | "\(.summary): \(.detail)"'

# Get file locations
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{step-id}/stack-diagnostics?stack_deployment_step_id={step-id}" | \
  jq -r '.data[].attributes.diags[]? | "\(.range.filename):\(.range.start.line)"'
```

### Step 6: Get Stack Outputs (After Successful Deployment)

**Endpoint:** `GET /api/v2/stack-deployment-steps/{final-apply-step-id}/artifacts?name=apply-description`

**Purpose:** Retrieve Stack outputs after a successful deployment completes.

**Important Notes:**
- This endpoint returns HTTP 307 redirect - use `curl -L` to follow redirects automatically
- This is currently the **only way** to retrieve Stack outputs programmatically
- This endpoint is **not documented** in public API documentation
- You need the final apply step ID from Step 4

**Request:**

```bash
curl -L -s -H "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{final-apply-step-id}/artifacts?name=apply-description"
```

**Response Structure:**

The artifact response includes an `.outputs` object where each output contains a `change.after` property with the actual output value:

```json
{
  "outputs": {
    "alb_url": {
      "change": {
        "actions": ["no-op"],
        "before": "http://my-alb-123456789.us-west-2.elb.amazonaws.com",
        "after": "http://my-alb-123456789.us-west-2.elb.amazonaws.com",
        "after_unknown": false,
        "before_sensitive": false,
        "after_sensitive": false
      },
      "type": "string"
    },
    "ecr_repository_url": {
      "change": {
        "actions": ["no-op"],
        "before": "123456789.dkr.ecr.us-west-2.amazonaws.com/my-repo",
        "after": "123456789.dkr.ecr.us-west-2.amazonaws.com/my-repo",
        "after_unknown": false,
        "before_sensitive": false,
        "after_sensitive": false
      },
      "type": "string"
    }
  }
}
```

**Extract Only Output Values:**

```bash
curl -L -s --header "Authorization: Bearer $TOKEN" \
  "https://app.terraform.io/api/v2/stack-deployment-steps/{final-apply-step-id}/artifacts?name=apply-description" | \
  jq -r '.outputs | to_entries | .[] | "\(.key): \(.value.change.after)"'
```

**Example Output:**

```
alb_url: http://my-alb-123456789.us-west-2.elb.amazonaws.com
ecr_repository_url: 123456789.dkr.ecr.us-west-2.amazonaws.com/my-repo
```

## Detailed Endpoint Reference

### Available Artifact Types

The artifacts endpoint accepts these `name` parameter values:

- `plan-description` - Terraform plan output in JSON format
- `plan-debug-log` - Detailed debug logs from plan operation
- `apply-description` - Terraform apply output including outputs (JSON format)
- `apply-debug-log` - Detailed debug logs from apply operation

### Polling Best Practices

**Recommended polling intervals:**
- Configuration status: Check every 5 seconds until status is "completed"
- Deployment runs: Check every 10 seconds during active deployment
- Deployment steps: Check every 10 seconds for individual step status

**Implement exponential backoff:**

```bash
# Example polling script with backoff
RETRY_COUNT=0
MAX_RETRIES=30
BACKOFF=5

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  STATUS=$(curl -s -H "Authorization: Bearer $TOKEN" \
    "https://app.terraform.io/api/v2/stack-deployment-runs/{run-id}" | \
    jq -r '.data.attributes.status')

  if [ "$STATUS" = "applied" ] || [ "$STATUS" = "failed" ]; then
    echo "Deployment finished with status: $STATUS"
    break
  fi

  echo "Current status: $STATUS. Waiting ${BACKOFF}s..."
  sleep $BACKOFF
  RETRY_COUNT=$((RETRY_COUNT + 1))
done
```

## Notes for AI Agents and Automation

### CLI Command Limitations

**These CLI commands DO NOT work in automation:**
- `terraform stacks deployment-run watch` - Streams output, blocks indefinitely
- `terraform stacks deployment-group watch` - Streams output, blocks indefinitely
- `terraform stacks configuration watch` - Streams output, blocks indefinitely

**Solution:** Use API polling instead of watch commands.

### No Direct Output Command

There is currently no CLI command to retrieve Stack outputs. You must:
1. Use API to get deployment steps
2. Find the final apply step ID
3. Request the `apply-description` artifact
4. Parse JSON to extract outputs

### Handling Redirects

The artifacts endpoint returns HTTP 307 redirect to the actual artifact location. Ensure your HTTP client follows redirects:

**curl:** Use `-L` flag
**Python requests:** Set `allow_redirects=True` (default)
**Node.js fetch:** Set `redirect: 'follow'` (default)

### Error Handling

**Common API errors:**

- **401 Unauthorized:** Invalid or expired token - refresh credentials
- **404 Not Found:** Invalid ID or resource doesn't exist yet - retry with backoff
- **429 Too Many Requests:** Rate limited - implement exponential backoff
- **Empty diagnostics:** Missing required `stack_deployment_step_id` query parameter

### Complete Monitoring Script Example

```bash
#!/bin/bash

# Configuration
TOKEN=$(jq -r '.credentials["app.terraform.io"].token' ~/.terraform.d/credentials.tfrc.json)
CONFIG_ID="stc-ABC123"
BASE_URL="https://app.terraform.io/api/v2"

# Helper function
api_get() {
  curl -s -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/vnd.api+json" \
    "$1"
}

# 1. Wait for configuration to complete
echo "Checking configuration status..."
while true; do
  STATUS=$(api_get "$BASE_URL/stack-configurations/$CONFIG_ID" | jq -r '.data.attributes.status')
  [ "$STATUS" = "completed" ] && break
  echo "Configuration status: $STATUS. Waiting..."
  sleep 5
done

# 2. Get deployment groups
echo "Getting deployment groups..."
GROUP_ID=$(api_get "$BASE_URL/stack-configurations/$CONFIG_ID/stack-deployment-group-summaries" | \
  jq -r '.data[0].id')

# 3. Get deployment run
echo "Getting deployment run..."
RUN_ID=$(api_get "$BASE_URL/stack-deployment-groups/$GROUP_ID/stack-deployment-runs" | \
  jq -r '.data[0].id')

# 4. Monitor deployment run
echo "Monitoring deployment run: $RUN_ID"
while true; do
  STATUS=$(api_get "$BASE_URL/stack-deployment-runs/$RUN_ID" | jq -r '.data.attributes.status')
  echo "Deployment status: $STATUS"

  if [ "$STATUS" = "applied" ]; then
    echo "Deployment succeeded!"

    # 5. Get outputs from final apply step
    APPLY_STEP=$(api_get "$BASE_URL/stack-deployment-runs/$RUN_ID/stack-deployment-steps" | \
      jq -r '.data[] | select(.attributes["operation-type"] == "apply") | .id' | tail -1)

    echo "Retrieving outputs from step: $APPLY_STEP"
    curl -L -s -H "Authorization: Bearer $TOKEN" \
      "$BASE_URL/stack-deployment-steps/$APPLY_STEP/artifacts?name=apply-description" | \
      jq -r '.outputs | to_entries | .[] | "\(.key): \(.value.change.after)"'
    break
  fi

  if [ "$STATUS" = "failed" ]; then
    echo "Deployment failed!"

    # Get error diagnostics
    FAILED_STEP=$(api_get "$BASE_URL/stack-deployment-runs/$RUN_ID/stack-deployment-steps" | \
      jq -r '.data[] | select(.attributes.status == "failed") | .id' | head -1)

    echo "Error diagnostics from step: $FAILED_STEP"
    api_get "$BASE_URL/stack-deployment-steps/$FAILED_STEP/stack-diagnostics?stack_deployment_step_id=$FAILED_STEP" | \
      jq -r '.data[].attributes.diags[]? | "\(.summary): \(.detail)"'
    exit 1
  fi

  sleep 10
done
```

This script demonstrates a complete monitoring workflow from configuration upload to output retrieval with error handling.
