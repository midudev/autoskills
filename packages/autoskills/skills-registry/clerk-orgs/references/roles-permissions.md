# Roles and Permissions

Clerk Organizations use Role-Based Access Control (RBAC). Every member has one Role per org; Roles carry Permissions (a mix of Clerk-provided System Permissions and your own custom Permissions).

## Default Roles

| Role | Default meaning |
|------|-----------------|
| `org:admin` | Full access — holds all System Permissions, can manage the Organization and its memberships |
| `org:member` | Read-only members. By default has only `org:sys_memberships:read` and `org:sys_billing:read` |

Both slugs are automatically created when Organizations are enabled. You cannot delete a default Role if it's set as the org's **Creator** or **Default** Role — reassign to another Role first.

## System Permissions (canonical catalog)

These are the only built-in Permissions. Use them verbatim; do NOT invent shorter forms like `org:manage_members` or `org:create`.

| Slug | Purpose |
|------|---------|
| `org:sys_profile:manage` | Edit Organization profile (name, slug, logo) |
| `org:sys_profile:delete` | Delete the Organization |
| `org:sys_memberships:read` | View the member list |
| `org:sys_memberships:manage` | Invite, remove, and change roles of members |
| `org:sys_domains:read` | View Verified Domains |
| `org:sys_domains:manage` | Add / verify / remove Verified Domains |
| `org:sys_billing:read` | View billing info (subscription, invoices) |
| `org:sys_billing:manage` | Manage billing (change plan, payment method) |

**Creator Role requirement.** The Role that Clerk assigns to a user who creates a new Organization MUST carry at minimum:

- `org:sys_memberships:manage`
- `org:sys_memberships:read`
- `org:sys_profile:delete`

If you reassign the Creator Role, ensure the replacement Role has these three at minimum.

## Custom Roles

Up to 10 custom Roles per instance. Create in Dashboard → Roles & Permissions → **Add role**. The key follows `org:<role>` format. Examples:

- `org:billing` — carries `org:sys_billing:manage`
- `org:reports_viewer` — carries your custom `org:reports:view`

## Custom Permissions

Naming convention: `org:<resource>:<action>`. Examples: `org:reports:view`, `org:api_keys:create`, `org:posts:edit`.

Create in Dashboard → Roles & Permissions → **Permissions** tab → **Add permission**. Permissions are attached to Roles inside a Role Set.

## Role Sets

Roles are surfaced to Organizations through **Role Sets** — this controls which Roles can be assigned within a given Organization. Each Organization is assigned exactly one Role Set.

Default behavior: all orgs share the default Role Set. If you need per-org role variations (e.g. one customer org has its own `org:support` role), create a second Role Set and assign it.

## Billing Gates Permissions

When Clerk Billing is enabled, a custom Permission `org:<feature>:<action>` only returns `true` from `has()` if the `<feature>` part matches a Feature included in the organization's active Plan.

Example: user has role `org:admin` with Permission `org:posts:edit`. `has({ permission: 'org:posts:edit' })` returns:

- `false` — if the active Plan does not include the `posts` Feature
- `true` — if the active Plan includes the `posts` Feature

This applies regardless of role assignment. See `clerk-billing` skill for the full feature-vs-plan model.

## Change a User's Role

Via Backend API:

```typescript
import { clerkClient } from '@clerk/nextjs/server'

const clerk = await clerkClient()
await clerk.organizations.updateOrganizationMembership({
  organizationId: 'org_123',
  userId: 'user_123',
  role: 'org:admin',
})
```

Via Dashboard: Users → select member → change role dropdown.

Via UI: the `<OrganizationProfile />` component's Members tab includes a role-change dropdown for admins.

## Checking Roles and Permissions

Three surfaces, same semantics:

```typescript
// Server (Next.js)
import { auth } from '@clerk/nextjs/server'
const { has } = await auth()
has({ role: 'org:admin' })
has({ permission: 'org:sys_memberships:manage' })
```

```tsx
// Client (any React-based SDK)
import { useAuth } from '@clerk/nextjs'
const { has, isLoaded } = useAuth()
if (!isLoaded) return null
has?.({ role: 'org:admin' })
```

```tsx
// JSX conditional
import { Show } from '@clerk/nextjs'
<Show when={{ role: 'org:admin' }}>
  <AdminPanel />
</Show>
```

## Key Rules

- **Never invent permission slugs.** If you don't see it in the System Permissions catalog above or you haven't created it as a custom Permission in Dashboard, it doesn't exist.
- **`org:` prefix is mandatory** for all org-scoped permissions.
- **Always check `isLoaded` before trusting `has` on the client.** On first render `has` can be `undefined` — use optional chaining (`has?.()`) or guard on `isLoaded`.
- **Case-sensitive.** `org:Admin` is not `org:admin`.
- **Role changes require session refresh.** If you change a user's role and `has()` still returns the old value, the session token is stale. `await clerk.session?.reload()` on the client, or navigate to force a new session.
