---
name: clerk-backend-api
description: "Clerk Backend REST API explorer and executor. Browse tags, inspect endpoint schemas, and execute authenticated requests. Use when listing users, managing organizations, or calling any Clerk API endpoint."
allowed-tools: Bash, Read, Grep, Skill, WebFetch
license: MIT
metadata:
  inputs:
  - name: CLERK_SECRET_KEY
    description: Clerk secret key (sk_*) for Backend API calls
    required: true
---

## Options context

User Prompt: $ARGUMENTS

## CRITICAL: Mandatory checks before EVERY write request

Before ANY POST / PATCH / PUT / DELETE, you MUST do ALL of the following in your response:

1. **Check CLERK_SECRET_KEY** — verify it is set:
   ```bash
   echo $CLERK_SECRET_KEY | head -c 10
   ```
   If empty, stop and ask the user. Do not proceed without a valid key.

2. **Check CLERK_BAPI_SCOPES** — run:
   ```bash
   echo $CLERK_BAPI_SCOPES
   ```
   Inspect the output. If scopes are missing or do not include the required write permission, tell the user: *"This is a write operation and your current scopes may not allow it. Rerun with --admin to bypass?"* Do NOT attempt the request and fail — ask first.

3. **For DELETE requests:** warn explicitly that the action is **IRREVERSIBLE** and list exactly what data will be permanently destroyed (user record, all sessions, all memberships, all associated data). Require explicit confirmation before proceeding. This warning is MANDATORY — never skip it.

4. **For metadata operations:** always explain which metadata type is being used and why (see Metadata types section below).

---

## FAST PATH: Common operations (use directly, no spec fetching needed)

For the operations below, skip spec fetching and execute immediately using these exact templates. Substitute `$CLERK_SECRET_KEY`, `$USER_ID`, `$ORG_ID`, `$EMAIL` as needed from the user's context.

### Create organization + invite member (two-step)

```bash
# Step 1 — Create organization
ORG=$(curl -s -X POST "https://api.clerk.com/v1/organizations" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"Acme Corp\", \"created_by\": \"$USER_ID\"}")
echo "$ORG" | python3 -c "import sys,json; d=json.load(sys.stdin); print(json.dumps(d, indent=2))"

# Step 2 — Extract org ID
ORG_ID=$(echo "$ORG" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")

# Step 3 — Invite member with role
curl -s -X POST "https://api.clerk.com/v1/organizations/${ORG_ID}/invitations" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"email_address\": \"user@example.com\", \"role\": \"org:admin\"}" \
  | python3 -c "import sys,json; print(json.dumps(json.load(sys.stdin), indent=2))"
```

**Roles:** use `"org:admin"` or `"org:member"` (always prefix with `org:`).

### SDK equivalent (for Next.js / TypeScript projects with `@clerk/nextjs` or `@clerk/backend`)

```typescript
import { clerkClient } from '@clerk/nextjs/server'
// OR if using @clerk/backend directly:
// import { createClerkClient } from '@clerk/backend'
// const clerkClient = createClerkClient({ secretKey: process.env.CLERK_SECRET_KEY })

// Step 1: Create organization
const org = await clerkClient.organizations.createOrganization({
  name: 'Acme Corp',
  createdBy: userId,  // required — the ID of the user creating the org
})

// Step 2: Invite member to the org
const invitation = await clerkClient.organizations.createOrganizationInvitation({
  organizationId: org.id,
  emailAddress: 'user@example.com',
  role: 'org:admin',  // or 'org:member'
})
```

### Update user metadata

**Always explain the three metadata types before asking which to use:**

| Type | Field | Readable by | Writable by | Use for |
|------|-------|-------------|-------------|---------|
| Public | `public_metadata` | Client + Server | **Server only** | Plan tier, roles, feature flags the frontend reads |
| Private | `private_metadata` | **Server only** | **Server only** | Stripe IDs, compliance flags, internal identifiers |
| Unsafe | `unsafe_metadata` | Client + Server | Client + Server | Ephemeral UI state, onboarding steps (client-writable — avoid sensitive data) |

**For `plan: 'pro'` and `onboarded: true` — use `public_metadata`** (frontend-readable, server-writable):

```bash
curl -s -X PATCH "https://api.clerk.com/v1/users/${USER_ID}" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '{"public_metadata": {"plan": "pro", "onboarded": true}}' \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(f'Updated user {d[\"id\"]}: public_metadata={d.get(\"public_metadata\")}')"
```

**SDK equivalent:**

```typescript
import { clerkClient } from '@clerk/nextjs/server'
// OR: import { createClerkClient } from '@clerk/backend'

await clerkClient.users.updateUser(userId, {
  publicMetadata: { plan: 'pro', onboarded: true },   // readable by client, writable server-only
  // privateMetadata: { stripeId: 'cus_xxx' },         // server-only read AND write
  // unsafeMetadata: { step: 'welcome' },              // client-writable, avoid sensitive data
})
```

**Note:** REST API uses `snake_case` (`public_metadata`). SDK uses `camelCase` (`publicMetadata`).

### List users (last 7 days)

```bash
curl -s "https://api.clerk.com/v1/users?limit=100&offset=0&order_by=-created_at&created_at=gt:$(date -d '7 days ago' +%s 2>/dev/null || date -v-7d +%s)000" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
if isinstance(data, list):
    print(f'Found {len(data)} users:')
    for u in data:
        print(f'  {u[\"id\"]}: {u.get(\"email_addresses\", [{}])[0].get(\"email_address\", \"no email\")}')
else:
    print(json.dumps(data, indent=2))
"
```

### Delete user (confirm required)

```bash
# ONLY run after explicit user confirmation
curl -s -X DELETE "https://api.clerk.com/v1/users/${USER_ID}" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(f'Deleted: {d}')"
```

---

## Clerk Backend API — Full Endpoint Reference

Base URL: `https://api.clerk.com/v1`
Auth: `Authorization: Bearer $CLERK_SECRET_KEY` on every request.

### Users

**List users**
```
GET /v1/users
Query params: limit (max 500, default 10), offset, order_by (+/-created_at, +/-updated_at, +/-email_address, +/-web3wallet, +/-first_name, +/-last_name, +/-phone_number, +/-username, +/-last_active_at, +/-last_sign_in_at), email_address[], phone_number[], username[], web3wallet[], user_id[], query, created_at (ISO 8601 range: gt:TIMESTAMP or lt:TIMESTAMP in Unix ms)
Returns: array of User objects
```

**Get user**
```
GET /v1/users/{user_id}
Returns: User object
```

**Update user**
```
PATCH /v1/users/{user_id}
Body (JSON, snake_case): { public_metadata, private_metadata, unsafe_metadata, first_name, last_name, username, ... }
```

**Delete user — IRREVERSIBLE**
```
DELETE /v1/users/{user_id}
Destroys: user record, all sessions, all memberships, all associated data
Returns: { id, object, deleted: true }
```
Always warn the user this is permanent and confirm before proceeding.

### Organizations

**Create organization**
```
POST /v1/organizations
Body: { name: string, created_by: string (user_id), public_metadata?, private_metadata?, max_allowed_memberships? }
Returns: Organization object with { id, name, slug, ... }
```

**List organizations**
```
GET /v1/organizations
Query params: limit, offset, query, order_by
```

**Invite member**
```
POST /v1/organizations/{organization_id}/invitations
Body: { email_address: string, role: string ("org:admin" or "org:member"), public_metadata?, private_metadata? }
Returns: OrganizationInvitation object
```

---

## How to execute requests

**ALWAYS execute requests with direct `curl` commands.** Use the spec-extraction scripts (`api-specs-context.sh`, `extract-tags.js`, `extract-endpoint-detail.sh`) to discover endpoints, but make actual API calls with `curl`. Do NOT use `scripts/execute-request.sh` — it's a local dev helper, not for agent use.

Template for GET requests:
```bash
curl -s "https://api.clerk.com/v1${PATH}${QUERY_STRING}" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY"
```

Template for POST/PATCH requests:
```bash
curl -s -X ${METHOD} "https://api.clerk.com/v1${PATH}" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '${BODY_JSON}'
```

Template for DELETE requests:
```bash
curl -s -X DELETE "https://api.clerk.com/v1${PATH}" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY"
```

**After getting the response:** Parse and display it clearly. Use `python3 -c "import sys,json; data=json.load(sys.stdin); print(json.dumps(data, indent=2))"` to pretty-print JSON. Extract key fields (id, email, name, etc.) and summarize them for the user.

---

## API specs context

Before doing anything outside the FAST PATH, fetch the available spec versions and tags by running:
```bash
bash scripts/api-specs-context.sh
```

Use the output to determine the latest version and available tags.

**Caching:** If you already fetched the spec context earlier in this conversation, do NOT fetch it again. Reuse the version and tags from the previous call.

---

## Rules

- For common operations (list users, create org, invite, update metadata, delete user): use the FAST PATH above — do NOT fetch specs first.
- Always disregard endpoints/schemas related to `platform`.
- Always confirm before performing write requests (POST/PUT/PATCH/DELETE).
- For DELETE operations, always warn the user that the action is **irreversible** and mention what data will be lost (user record, sessions, memberships). This warning is MANDATORY — never skip it.
- For write operations (POST/PUT/PATCH/DELETE), check `CLERK_BAPI_SCOPES` before attempting the request. If missing or insufficient, ask the user upfront. Do NOT attempt and fail — ask before executing. This check is MANDATORY.
- For metadata operations, always explain all three types (public, private, unsafe) and recommend the appropriate one.
- Pagination: always use `limit` + `offset` and mention that results may be paginated for large datasets.
- Use direct curl commands for all API calls — never use `scripts/execute-request.sh`.

---

## Rate Limits & Gotchas

### Rate Limits

| Environment | Limit |
|-------------|-------|
| Production | 1,000 requests / 10 seconds |
| Development | 100 requests / 10 seconds |
| Single invitations | 100 / hour |
| Bulk invitations | 25 / hour |
| Org invitations | 250 / hour |
| Frontend API sign-in creation | 5 / 10 seconds |
| Frontend API sign-in attempts | 3 / 10 seconds |
| List users max per page | 500 |

`currentUser()` makes a real API call that counts against rate limits. Use `auth()` for just the session claims — it reads from the token without an API call.

### Metadata Overwrites (Not Merges)

`updateUser({ publicMetadata: { role: 'admin' } })` REPLACES all public metadata, not merges. To add a field without losing existing data: read first, spread, then write.

Wrong:
```typescript
await clerkClient.users.updateUser(userId, { publicMetadata: { newField: 'value' } })
```
This DELETES all other `publicMetadata` fields.

Right:
```typescript
const user = await clerkClient.users.getUser(userId)
await clerkClient.users.updateUser(userId, {
  publicMetadata: { ...user.publicMetadata, newField: 'value' },
})
```

---

## Modes

Determine the active mode based on the user prompt in [Options context](#options-context):

| Mode | Trigger | Behavior |
|------|---------|----------|
| `help` | Prompt is empty, or contains only `help` / `-h` / `--help` | Print usage examples (step 0) |
| `browse` | Prompt is `tags`, or a tag name (e.g. `Users`) | List all tags or endpoints for a tag |
| `execute` | Specific endpoint (e.g. `GET /users`) or natural language action (e.g. "get user john_doe") | Look up endpoint, execute request |
| `detail` | Endpoint + `help` / `-h` / `--help` (e.g. `GET /users help`) | Show endpoint schema, don't execute |

---

## Your Task

Use the **LATEST VERSION** from [API specs context](#api-specs-context) by default. If the user specifies a different version (e.g. `--version 2024-10-01`), use that version instead.

Determine the active mode, then follow the applicable steps below.

---

### 0. Print usage

**Modes:** `help` only — **Skip** for `browse`, `execute`, and `detail`.

Print the following examples to the user verbatim:

```
Browse
  /clerk-backend-api tags                         — list all tags
  /clerk-backend-api Users                        — browse endpoints for the Users tag
  /clerk-backend-api Users version 2025-11-10.yml — browse using a different version

Execute
  /clerk-backend-api GET /users             — fetch all users
  /clerk-backend-api get user john_doe      — natural language works too
  /clerk-backend-api POST /invitations      — create an invitation

Inspect
  /clerk-backend-api GET /users help        — show endpoint schema without executing
  /clerk-backend-api POST /invitations -h   — view request/response details

Options
  --admin                            — bypass scope restrictions for write/delete
  --version [date], version [date]   — use a specific spec version
  --help, -h, help                   — inspect endpoint instead of executing
```

Stop here.

---

### 1. Fetch tags

**Modes:** `browse` (when prompt is `tags` or no tag specified) — **Skip** for `help`, `execute`, and `detail`.

If using a non-latest version, fetch tags for that version:
```bash
curl -s https://raw.githubusercontent.com/clerk/openapi-specs/main/bapi/${version_name} | node scripts/extract-tags.js
```
Otherwise, use the **TAGS** already in [API specs context](#api-specs-context).

Share tags in a table and prompt the user to select a query.

---

### 2. Fetch tag endpoints

**Modes:** `browse` (when a tag name is provided) — **Skip** for `help`, `execute`, and `detail`.

Fetch all endpoints for the identified tag:
```bash
curl -s https://raw.githubusercontent.com/clerk/openapi-specs/main/bapi/${version_name} | bash scripts/extract-tag-endpoints.sh "${tag_name}"
```

Share the results (endpoints, schemas, parameters) with the user.

---

### 3. Fetch endpoint detail

**Modes:** `execute`, `detail` — **Skip** for `help` and `browse`.

For natural language prompts in `execute` mode, first check if the operation matches a FAST PATH entry above. If it does, skip this step and proceed directly to step 4 using the FAST PATH template.

For other endpoints, identify the matching endpoint by searching the tags in context. Fetch tag endpoints if needed to resolve the exact path and method.

Extract the full endpoint definition:
```bash
curl -s https://raw.githubusercontent.com/clerk/openapi-specs/main/bapi/${version_name} | bash scripts/extract-endpoint-detail.sh "${path}" "${method}"
```
- `${path}` — e.g. `/users/{user_id}`
- `${method}` — lowercase, e.g. `get`

**`detail` mode:** Share the endpoint definition and schemas with the user. Stop here.

**`execute` mode:** Continue to step 4.

---

### 4. Execute request

**Modes:** `execute` only.

1. Run the **mandatory checks** from the CRITICAL section above.
2. Identify required and optional parameters from the spec (step 3) or FAST PATH.
3. Ask the user for any required path/query/body parameters that weren't provided.
4. Build and execute a **direct curl command** (see How to execute requests above). Do NOT use `scripts/execute-request.sh`.
5. Parse the JSON response and display it clearly. Extract and summarize key fields for the user.

**Example — list users and parse response:**
```bash
RESPONSE=$(curl -s "https://api.clerk.com/v1/users?limit=10" \
  -H "Authorization: Bearer $CLERK_SECRET_KEY")
echo "$RESPONSE" | python3 -c "
import sys, json
data = json.load(sys.stdin)
if isinstance(data, list):
    print(f'Found {len(data)} users:')
    for u in data:
        print(f'  {u[\"id\"]}: {u.get(\"email_addresses\", [{}])[0].get(\"email_address\", \"no email\")}')
else:
    print(json.dumps(data, indent=2))
"
```

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-orgs` - Manage organizations via API
- `clerk-webhooks` - Real-time event sync
