---
name: clerk-orgs
description: Clerk Organizations for B2B SaaS - create multi-tenant apps with org
  switching, role-based access, verified domains, and enterprise SSO. Use for team
  workspaces, RBAC, org-based routing, member management.
allowed-tools: WebFetch
license: MIT
metadata:
  author: clerk
  version: 2.1.0
  inputs:
  - name: NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
    description: Clerk publishable key from dashboard
    required: true
  - name: CLERK_SECRET_KEY
    description: Clerk secret key for server-side operations
    required: true
---

# Organizations (B2B SaaS)

> **Prerequisite**: Enable Organizations in Clerk Dashboard first.
>
> **Version**: Check `package.json` for the SDK version — see `clerk` skill for the version table. Core 2 differences are noted inline with `> **Core 2 ONLY (skip if current SDK):**` callouts.

## Quick Start

1. **Create an organization via dashboard** or through Clerk API
2. **Use OrganizationSwitcher** to let users switch between orgs
3. **Protect routes** using orgSlug from URL and role checks

## Documentation Reference

| Task | Link |
|------|------|
| Overview | https://clerk.com/docs/guides/organizations/overview |
| Org slugs in URLs | https://clerk.com/docs/guides/organizations/org-slugs-in-urls |
| Roles & permissions | https://clerk.com/docs/guides/organizations/control-access/roles-and-permissions |
| Check access | https://clerk.com/docs/guides/organizations/control-access/check-access |
| Invitations | https://clerk.com/docs/guides/organizations/add-members/invitations |
| OrganizationSwitcher | https://clerk.com/docs/reference/components/organization/organization-switcher |
| Verified domains | https://clerk.com/docs/guides/organizations/verified-domains |
| Enterprise SSO | https://clerk.com/docs/guides/organizations/add-members/sso |

## Key Patterns

### 1. Get Organization from Auth

Server-side access to organization:

```typescript
import { auth } from '@clerk/nextjs/server'

const { orgId, orgSlug } = await auth()
console.log(`Current org: ${orgSlug}`)
```

### 2. Dynamic Routes with Org Slug

Create routes that accept org slug:

```
app/orgs/[slug]/page.tsx
app/orgs/[slug]/settings/page.tsx
```

Access the slug:

```typescript
export default function DashboardPage({ params }: { params: { slug: string } }) {
  return <div>Organization: {params.slug}</div>
}
```

### 3. Check Organization Membership

Verify user has access to specific org:

```typescript
import { auth } from '@clerk/nextjs/server'

export default async function ProtectedPage() {
  const { orgId, orgSlug } = await auth()

  if (!orgId) {
    return <div>Not in an organization</div>
  }

  return <div>Welcome to {orgSlug}</div>
}
```

### 4. Role-Based Access Control

Check if user has specific role:

```typescript
const { has } = await auth()

if (!has({ role: 'org:admin' })) {
  return <div>Admin access required</div>
}
```

#### Custom Permissions

Create custom roles and permissions in Dashboard → Organizations → Roles. Permission format: `org:resource:action`.

```typescript
// Server component — check a custom billing permission
import { auth } from '@clerk/nextjs/server'
import { redirect } from 'next/navigation'

export default async function BillingPage() {
  const { has } = await auth()

  if (!has({ permission: 'org:billing:manage' })) {
    redirect('/unauthorized')
  }

  return <BillingDashboard />
}
```

```typescript
// Middleware — protect an entire route segment
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server'

const isBillingRoute = createRouteMatcher(['/orgs/:slug/billing(.*)'])

export default clerkMiddleware(async (auth, req) => {
  if (isBillingRoute(req)) {
    await auth.protect({ permission: 'org:billing:manage' })
  }
})
```

```tsx
// Client component — conditional rendering
import { Show } from '@clerk/nextjs'

<Show when={{ permission: 'org:billing:manage' }}>
  <BillingSettings />
</Show>
```

Permission naming convention: `org:resource:action` (e.g., `org:billing:manage`, `org:reports:view`, `org:api_keys:create`). Always prefix with `org:` for organization-scoped permissions.

### 5. OrganizationSwitcher Component

Let users switch between organizations:

```typescript
import { OrganizationSwitcher } from '@clerk/nextjs'

export default function Nav() {
  return (
    <header>
      <h1>Dashboard</h1>
      <OrganizationSwitcher />
    </header>
  )
}
```

## Default Roles

All new members get assigned a role:

| Role | Permissions |
|------|-------------|
| `org:admin` | Full access, manage members, settings |
| `org:member` | Limited access, read-only |

Custom roles can be created in the dashboard.

## Default Permissions

| Permission | Role |
|-----------|------|
| `org:create` | Can create new organizations |
| `org:manage_members` | Can invite/remove members (default: admin) |
| `org:manage_roles` | Can change member roles (default: admin) |
| `org:update_metadata` | Can update org metadata (default: admin) |

## Authorization Pattern

Complete example protecting a route:

```typescript
import { auth } from '@clerk/nextjs/server'
import { redirect } from 'next/navigation'

export default async function AdminPage({ params }: { params: { slug: string } }) {
  const { orgSlug, has } = await auth()

  // Verify user is in the org
  if (orgSlug !== params.slug) {
    redirect('/dashboard')
  }

  // Check if admin
  if (!has({ role: 'org:admin' })) {
    redirect(`/orgs/${orgSlug}`)
  }

  return <div>Admin settings for {orgSlug}</div>
}
```

## Conditional Rendering with `<Show>`

Use `<Show>` for role-based conditional rendering in client components:

```tsx
import { Show } from '@clerk/nextjs'

<Show when={{ role: 'org:admin' }}>
  <AdminPanel />
</Show>

<Show when={{ permission: 'org:billing:manage' }}>
  <BillingSettings />
</Show>
```

> **Core 2 ONLY (skip if current SDK):** Use `<Protect role="org:admin">` and `<Protect permission="org:billing:manage">` instead of `<Show>`.

## Billing Checks

The `has()` method supports billing plan and feature checks for gating access:

```typescript
const { has } = await auth()

has({ plan: 'gold' })        // Check subscription plan
has({ feature: 'widgets' })  // Check feature entitlement
```

> **Core 2 ONLY (skip if current SDK):** `has()` only supports `role` and `permission` parameters. Billing checks are not available.

## Session Tasks

When personal accounts are disabled, users must choose an organization after sign-in. This is handled by the `choose-organization` session task:

```tsx
import { TaskChooseOrganization } from '@clerk/nextjs'

// Renders when user must select an org
<TaskChooseOrganization redirectUrlComplete="/dashboard" />
```

> **Core 2 ONLY (skip if current SDK):** Session tasks are not available. Use `<OrganizationSwitcher>` for org selection.

## Enterprise SSO

Organizations can use Enterprise SSO (SAML/OIDC) for member authentication:

```typescript
// Strategy name for Enterprise SSO
strategy: 'enterprise_sso'

// Access enterprise accounts on user object
user.enterpriseAccounts
```

> **Core 2 ONLY (skip if current SDK):** Uses `strategy: 'saml'` instead of `strategy: 'enterprise_sso'`, and `user.samlAccounts` instead of `user.enterpriseAccounts`.

### Configuring Enterprise SSO per Organization

Enterprise SSO is configured **per organization** in the Clerk Dashboard under Organizations > SSO Connections. Steps:

1. Go to Dashboard → Organizations → select the org → SSO Connections
2. Add a SAML or OIDC connection with the customer's IdP metadata
3. Set the **verified domain** for the org — Clerk verifies ownership via DNS TXT record
4. Once verified, users signing in with that email domain are automatically routed to the SSO flow and joined to the org

```typescript
// Check if the active user authenticated via enterprise SSO
import { currentUser } from '@clerk/nextjs/server'

const user = await currentUser()
const ssoAccount = user?.enterpriseAccounts?.[0]

if (ssoAccount) {
  console.log(`SSO provider: ${ssoAccount.provider}`)
  console.log(`SSO domain: ${ssoAccount.emailAddress}`)
}
```

Key facts:
- Strategy name: `enterprise_sso` (used in `signIn.supportedFirstFactors`)
- Domain verification required: org claims a domain, Clerk verifies via DNS TXT record
- Users with a verified email domain auto-join the org on first SSO sign-in
- Each org can have multiple SSO connections (e.g., SAML + OIDC)

## Gotchas

### Capping Org Seats with `maxAllowedMemberships`

Pass `maxAllowedMemberships` when creating an org to cap the number of seats. Attempts to add members beyond the cap will return an error.

```typescript
const clerk = await clerkClient()
const org = await clerk.organizations.createOrganization({
  name: 'Acme Corp',
  createdBy: userId,
  maxAllowedMemberships: 10,
})
```

You can also update the cap after creation:

```typescript
await clerk.organizations.updateOrganization(orgId, {
  maxAllowedMemberships: 25,
})
```

### Billing Gates Permissions

When Clerk Billing is enabled, `has({ permission: 'org:posts:edit' })` returns `false` if the Feature associated with that permission is not included in the organization's active Plan — even if the user has the permission assigned via their role. Billing gates permissions at the feature level. Ensure the required Feature is attached to the active Plan in Dashboard → Billing → Plans → Features before debugging role assignments.

### Metadata Overwrites (Not Merges)

`updateOrganization({ publicMetadata: { tier: 'enterprise' } })` REPLACES all public metadata, not merges it. Read first, spread, then write.

Wrong:
```typescript
await clerk.organizations.updateOrganization(orgId, {
  publicMetadata: { newField: 'value' },
})
```

Right:
```typescript
const org = await clerk.organizations.getOrganization(orgId)
await clerk.organizations.updateOrganization(orgId, {
  publicMetadata: { ...org.publicMetadata, newField: 'value' },
})
```

The same rule applies to `privateMetadata` and to user metadata via `clerkClient.users.updateUser`.

## Common Pitfalls

| Symptom | Cause | Solution |
|---------|-------|----------|
| `orgSlug` is undefined | Not calling `await auth()` | Use `const { orgSlug } = await auth()` |
| Role check always fails | Not awaiting `auth()` | Add `await` before `auth()` |
| Users can access other orgs | Not checking orgSlug matches URL | Verify `orgSlug === params.slug` |
| Org not appearing in switcher | Organizations not enabled | Enable in Clerk Dashboard → Organizations |
| Invitations not working | Wrong role configuration | Ensure members have invite role permissions |

## Invitation API

### Send an Invitation (Server Action / Route Handler)

```typescript
import { clerkClient } from '@clerk/nextjs/server'
import { auth } from '@clerk/nextjs/server'

export async function inviteMember(organizationId: string, emailAddress: string, role: string) {
  const { has } = await auth()

  if (!has({ permission: 'org:sys_memberships:manage' })) {
    throw new Error('Not authorized to invite members')
  }

  const clerk = await clerkClient()
  const invitation = await clerk.organizations.createOrganizationInvitation({
    organizationId,
    emailAddress,
    role, // e.g. 'org:member' or 'org:admin'
    redirectUrl: 'https://yourapp.com/accept-invite',
  })

  return invitation
}
```

### List Pending Invitations

```typescript
const clerk = await clerkClient()
const { data: invitations } = await clerk.organizations.getOrganizationInvitationList({
  organizationId,
  status: ['pending'], // 'pending' | 'accepted' | 'revoked'
})
```

### Revoke an Invitation

```typescript
await clerk.organizations.revokeOrganizationInvitation({
  organizationId,
  invitationId,
  requestingUserId: userId,
})
```

### Built-in Invite UI

`<OrganizationSwitcher />` includes a built-in member invitation UI when personal accounts are hidden:

```tsx
<OrganizationSwitcher
  hidePersonal
  afterCreateOrganizationUrl="/orgs/:slug/dashboard"
  afterSelectOrganizationUrl="/orgs/:slug/dashboard"
/>
```

The `<OrganizationProfile />` component also provides a full members management tab with invitation and role management.

## Workflow

1. **Setup** - Enable Organizations in Clerk Dashboard
2. **Create org** - Users create org or admin creates via API
3. **Add members** - Send invitations or add directly
4. **Assign roles** - Default member role, promote to admin as needed
5. **Build protected routes** - Use auth() to check orgSlug and roles
6. **Use OrganizationSwitcher** - Let users switch between orgs

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-webhooks` - Sync org events to your database
- `clerk-backend-api` - Manage members programmatically
