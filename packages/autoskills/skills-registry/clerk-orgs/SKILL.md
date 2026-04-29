---
name: clerk-orgs
description: Clerk Organizations for B2B SaaS - create multi-tenant apps with org
  switching, role-based access, verified domains, and enterprise SSO. Use for team
  workspaces, RBAC, org-based routing, member management.
allowed-tools: WebFetch
license: MIT
compatibility: Requires NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY and CLERK_SECRET_KEY. Organizations must be enabled in Clerk Dashboard → Organizations. Membership mode (required vs optional) must match the B2B vs B2C + B2B coexistence story of your app.
metadata:
  author: clerk
  version: 3.0.0
---

# Organizations (B2B SaaS)

> **STOP — Dashboard-only prerequisite.** Organizations must be enabled in the Clerk Dashboard before any org-related API, hook, or component works. Open [Dashboard → Organizations settings](https://dashboard.clerk.com/last-active?path=organizations-settings) and enable Organizations. Also decide `Membership required` (B2B-only, the default since Aug 22, 2025) vs `Membership optional` (B2C + B2B coexistence). Pick wrong and `<PricingTable />`, `<OrganizationSwitcher />`, and personal-account flows break silently.
>
> **Version**: This skill targets current SDKs (`@clerk/nextjs` v7+, `@clerk/react` v6+ — Core 3). Core 2 differences are noted inline with `> **Core 2 ONLY (skip if current SDK):**` callouts — see `clerk` skill for the full version table.

## Quick Start

1. **Enable Organizations** — [Dashboard → Organizations settings](https://dashboard.clerk.com/last-active?path=organizations-settings). Pick `Membership required` (B2B-only) or `Membership optional` (B2C + B2B). Dashboard-only; no CLI path.
2. **Create an org** — via `<OrganizationSwitcher />`, `<CreateOrganization />`, or programmatically with `clerkClient().organizations.createOrganization()`.
3. **Protect routes** — read `orgId` / `orgSlug` from `auth()` and gate with `has({ role })` or `has({ permission })`.
4. **Manage members** — send invitations via Backend API or the built-in `<OrganizationProfile />` tab.
5. **Cap membership** — set `maxAllowedMemberships` at org creation or pick a seat-limited Billing Plan (see `clerk-billing` skill).

## What Do You Need?

| Task | Reference |
|------|-----------|
| System permissions catalog, custom roles, role sets | references/roles-permissions.md |
| Invitation lifecycle (create, list, revoke, built-in UI) | references/invitations.md |
| Enterprise SSO setup, provider field access, domain verification | references/enterprise-sso.md |
| Next.js adaptations for orgs (role/permission middleware, slug invariants, orgId-scoped writes) | references/nextjs-patterns.md |

## References

| Reference | Description |
|-----------|-------------|
| `references/roles-permissions.md` | Default + custom roles, System Permissions catalog, permission naming |
| `references/invitations.md` | Backend API for invitations + built-in UI |
| `references/enterprise-sso.md` | SAML/OIDC per-org, domain verification, correct field access |
| `references/nextjs-patterns.md` | Next.js adaptations specific to orgs. For generic Next.js patterns see `clerk-nextjs-patterns` skill. |

## Dashboard shortcuts

| Action | URL |
|---|---|
| Enable Organizations + Membership mode | `https://dashboard.clerk.com/last-active?path=organizations-settings` |
| Manage roles + permissions | `https://dashboard.clerk.com/last-active?path=organizations-settings/roles` |
| Create/edit an organization | `https://dashboard.clerk.com/last-active?path=organizations` |
| Webhooks for org events | `https://dashboard.clerk.com/last-active?path=webhooks` |

## Documentation

- [Overview](https://clerk.com/docs/guides/organizations/overview)
- [Configure + enable](https://clerk.com/docs/guides/organizations/configure)
- [Roles and permissions](https://clerk.com/docs/guides/organizations/control-access/roles-and-permissions)
- [Check access](https://clerk.com/docs/guides/organizations/control-access/check-access)
- [Invitations](https://clerk.com/docs/guides/organizations/add-members/invitations)
- [OrganizationSwitcher](https://clerk.com/docs/reference/components/organization/organization-switcher)
- [Verified domains](https://clerk.com/docs/guides/organizations/add-members/verified-domains)
- [Enterprise SSO](https://clerk.com/docs/guides/organizations/add-members/sso)

## Key Patterns

Examples use `@clerk/nextjs` by default. For other frameworks swap the import to `@clerk/react` (Vite/CRA), `@clerk/astro/components`, `@clerk/vue`, `@clerk/expo`, `@clerk/react-router`, or `@clerk/tanstack-react-start` — the feature-level APIs (`has()`, `orgId`, `<OrganizationSwitcher />`, `<Show>`) are identical across SDKs. Framework-specific patterns (middleware, redirects) live in `references/nextjs-patterns.md`.

### 1. Read Organization from Auth

Server-side access to active organization:

```typescript
import { auth } from '@clerk/nextjs/server'

const { orgId, orgSlug, orgRole } = await auth()
if (!orgId) {
  // user has no active org — either not in any, or viewing Personal Account
}
```

`auth()` is Next.js-specific. Equivalent server-side accessors per SDK: `auth(event)` (Nuxt via `event.context.auth()`), `context.locals.auth()` (Astro), `getAuth(req)` (Express, after `clerkMiddleware()`). Client-side: `useAuth()` (React-based SDKs) or composables (Vue/Nuxt). All return the same `orgId` / `orgSlug` / `orgRole` shape.

### 2. Dynamic Routes with Org Slug

Route-per-org pattern works in any framework supporting file-based dynamic routes. Next.js example:

```
app/orgs/[slug]/page.tsx
app/orgs/[slug]/settings/page.tsx
```

Always verify the URL slug matches the active org slug — otherwise users can hit `/orgs/other-org/...` with a stale `orgSlug` in their session:

```typescript
export default async function OrgPage({ params }: { params: { slug: string } }) {
  const { orgSlug } = await auth()
  if (orgSlug !== params.slug) {
    redirect('/dashboard')  // or whatever your "no-access" flow is
  }
  return <div>Welcome to {orgSlug}</div>
}
```

### 3. Role-Based Access Control

```typescript
const { has } = await auth()

if (!has({ role: 'org:admin' })) {
  return <div>Admin access required</div>
}
```

Permission checks use the same `has()` surface:

```typescript
if (!has({ permission: 'org:sys_memberships:manage' })) {
  redirect('/unauthorized')
}
```

**Permission naming convention.** System Permissions prefix with `org:sys_`; custom Permissions use `org:<resource>:<action>`. The full System Permissions catalog lives in `references/roles-permissions.md` — the short list is:

- `org:sys_memberships:{read, manage}`
- `org:sys_profile:{manage, delete}`
- `org:sys_domains:{read, manage}`
- `org:sys_billing:{read, manage}`

Do NOT invent names like `org:create`, `org:manage_members`, `org:update_metadata` — those are not real permission slugs. See `references/roles-permissions.md` for custom roles and the permission table.

### 4. Conditional Rendering with `<Show>`

```tsx
import { Show } from '@clerk/nextjs'

<Show when={{ role: 'org:admin' }}>
  <AdminPanel />
</Show>

<Show when={{ permission: 'org:sys_memberships:manage' }}>
  <MembersTab />
</Show>
```

> **Core 2 ONLY (skip if current SDK):** Use `<Protect role="org:admin">` / `<Protect permission="...">` instead of `<Show>`. `<Show>` replaced both `<Protect>` and `<SignedIn>`/`<SignedOut>` in Core 3.

Astro template syntax for the same component (imported from `@clerk/astro/components`):

```astro
<Show when={{ role: 'org:admin' }}>
  <AdminPanel />
</Show>
```

### 5. OrganizationSwitcher

```tsx
import { OrganizationSwitcher } from '@clerk/nextjs'

<OrganizationSwitcher
  hidePersonal
  afterCreateOrganizationUrl="/orgs/:slug/dashboard"
  afterSelectOrganizationUrl="/orgs/:slug/dashboard"
/>
```

Key props:
- `hidePersonal: boolean` — hide the Personal Account option. Defaults to `false`. Pass `true` for B2B-only apps.
- `afterCreateOrganizationUrl`, `afterSelectOrganizationUrl`, `afterLeaveOrganizationUrl`, `afterSelectPersonalUrl` — navigation hooks. `:slug` is substituted at runtime.
- `createOrganizationMode`, `organizationProfileMode` — `'modal' | 'navigation'` (default `'modal'`).

The full prop list lives in the [component reference](https://clerk.com/docs/reference/components/organization/organization-switcher).

### 6. Session Task — Choose Organization

When `Membership required` is enabled (the default), users without an org are routed through a `choose-organization` session task after sign-in. Clerk handles this automatically inside `<SignIn />`, but you can host the UI yourself:

```tsx
import { ClerkProvider } from '@clerk/nextjs'

<ClerkProvider taskUrls={{ 'choose-organization': '/session-tasks/choose-organization' }}>
  {children}
</ClerkProvider>
```

```tsx
// app/session-tasks/choose-organization/page.tsx
import { TaskChooseOrganization } from '@clerk/nextjs'

export default function Page() {
  return <TaskChooseOrganization redirectUrlComplete="/dashboard" />
}
```

`TaskChooseOrganization` ships as an imported component in the React-based SDKs (`@clerk/nextjs`, `@clerk/react`, `@clerk/react-router`, `@clerk/tanstack-react-start`). For the JS Frontend SDK (`@clerk/clerk-js`) the equivalent is `clerk.mountTaskChooseOrganization(node)` / `clerk.unmountTaskChooseOrganization(node)`.

> **Core 2 ONLY (skip if current SDK):** Session tasks aren't available. Force an org selection at sign-in by redirecting to a page that renders `<OrganizationSwitcher hidePersonal />`.

## Default Roles + System Permissions

| Role | Default meaning |
|------|-------------|
| `org:admin` | Full access — all System Permissions, can manage org + memberships |
| `org:member` | Read members + Read billing Permissions only |

You can create up to 10 custom roles per instance in Dashboard → Organizations → Roles & Permissions. Role-per-org is controlled via **Role Sets** — see `references/roles-permissions.md` for the full model (custom roles, Creator/Default role settings, role sets, and the System Permissions catalog).

## Billing Checks

`has()` also supports plan and feature checks when Clerk Billing is enabled:

```typescript
const { has } = await auth()

has({ plan: 'gold' })        // subscription plan
has({ feature: 'widgets' })  // feature entitlement
```

> **Core 2 ONLY (skip if current SDK):** `has()` only supports `role` and `permission`. Billing checks aren't available.

See `clerk-billing` for the full Billing surface and seat-limit plan model.

## Enterprise SSO

Per-org SAML/OIDC. Configured in Dashboard → Configure → Enterprise Connections (or per-org: Organizations → select org → SSO Connections). The SSO connection owns its domain directly; no separate Verified Domain is required (and the two features are mutually exclusive on the same domain). Auto-join on first SSO sign-in uses JIT Provisioning, not Verified Domains. Key fact: the `provider` field lives on `enterpriseConnection`, not on `enterpriseAccounts[0]` directly. See `references/enterprise-sso.md` for the full flow and correct field access.

```typescript
// Strategy name for Enterprise SSO (Core 3)
strategy: 'enterprise_sso'
```

> **Core 2 ONLY (skip if current SDK):** Uses `strategy: 'saml'` and `user.samlAccounts` instead of `user.enterpriseAccounts`.

## Gotchas

### `maxAllowedMemberships` caps seats

```typescript
const clerk = await clerkClient()
await clerk.organizations.createOrganization({
  name: 'Acme Corp',
  createdBy: userId,
  maxAllowedMemberships: 10,
})

// Update later:
await clerk.organizations.updateOrganization(orgId, {
  maxAllowedMemberships: 25,
})
```

For tier-based seat limits tied to a subscription, use a seat-limited Billing Plan (see `clerk-billing`).

### Billing gates Permissions at the Feature level

When Clerk Billing is enabled, `has({ permission: 'org:posts:edit' })` returns `false` if the Feature associated with that permission is not included in the organization's active Plan — even if the user has the Permission assigned via their role. Ensure the Feature is attached to the active Plan in Dashboard → Billing → Plans → Features.

### Metadata updates REPLACE, not merge

`updateOrganization({ publicMetadata })` overwrites all public metadata. Read first, spread, then write:

```typescript
const org = await clerk.organizations.getOrganization({ organizationId: orgId })
await clerk.organizations.updateOrganization(orgId, {
  publicMetadata: { ...org.publicMetadata, newField: 'value' },
})
```

Applies identically to `privateMetadata` and to user metadata via `clerkClient.users.updateUser`.

## Error Signatures (diagnose fast)

Most "org-related" failures are configuration, not code. Do not edit components before checking these:

| Error / symptom | Root cause | Fix |
|---|---|---|
| `orgId` / `orgSlug` is `undefined` for a signed-in user | Organizations not enabled for this instance, OR user has no active org (personal account) | Enable in Dashboard → Organizations; check Membership mode; surface `<OrganizationSwitcher />` |
| `has({ permission: 'org:manage_members' })` always `false` | Using an invented permission slug | Use `org:sys_memberships:manage` (see roles-permissions.md catalog) |
| `has({ role })` returns `false` but user looks like an admin | Session token stale after role change | Re-sign-in, or refresh the session: `await clerk.session?.reload()` |
| `has({ permission })` `false` even with the role assigned | Feature not attached to active Plan (Billing gates permissions) | Dashboard → Billing → Plans → attach Feature |
| `<OrganizationSwitcher />` doesn't show "Personal Account" | `Membership required` mode is on (the default since Aug 22, 2025) | Dashboard → Organizations settings → `Membership optional` |
| `TaskChooseOrganization` throws "cannot render when a user doesn't have current session tasks" | Rendered outside a `choose-organization` task context | Wrap in a `choose-organization` session-task route only; don't render unconditionally |
| `enterpriseAccounts[0].provider` is `undefined` | Accessing `provider` at the wrong nesting level | Use `user.enterpriseAccounts[0].enterpriseConnection?.provider` |

## Authorization Pattern (Complete Example)

Server component protecting a slug-scoped admin page:

```typescript
import { auth } from '@clerk/nextjs/server'
import { redirect } from 'next/navigation'

export default async function AdminPage({ params }: { params: { slug: string } }) {
  const { orgSlug, has } = await auth()

  if (orgSlug !== params.slug) redirect('/dashboard')
  if (!has({ role: 'org:admin' })) redirect(`/orgs/${orgSlug}`)

  return <div>Admin settings for {orgSlug}</div>
}
```

For middleware-level protection (Next.js) see `references/nextjs-patterns.md`.

## Invitations (short form)

Send from a server action or route handler:

```typescript
import { clerkClient, auth } from '@clerk/nextjs/server'

export async function inviteMember(organizationId: string, emailAddress: string, role: string) {
  const { userId, has } = await auth()

  if (!userId) throw new Error('Not signed in')
  if (!has({ permission: 'org:sys_memberships:manage' })) {
    throw new Error('Not authorized to invite members')
  }

  const clerk = await clerkClient()
  return clerk.organizations.createOrganizationInvitation({
    organizationId,
    inviterUserId: userId,       // required per Backend API
    emailAddress,
    role,                        // e.g. 'org:admin' or 'org:member'
    redirectUrl: 'https://yourapp.com/accept-invite',
  })
}
```

The full lifecycle (list, revoke, bulk create, built-in `<OrganizationProfile />` UI) lives in `references/invitations.md`.

## Workflow

1. **Enable** — Organizations + Membership mode in Dashboard
2. **Create org** — via UI component or Backend API
3. **Invite members** — Backend API or built-in UI, with `inviterUserId`
4. **Gate access** — `has({ role })` / `has({ permission })` with canonical `org:sys_*` names
5. **Scope routes** — `orgSlug === params.slug` on every protected page
6. **Switch orgs** — `<OrganizationSwitcher />` handles the whole flow

## See Also

- `clerk-setup` — Initial Clerk install
- `clerk-billing` — Seat-limit plans, per-plan billing, `has({ plan })` / `has({ feature })`
- `clerk-webhooks` — Sync org events to your database (`organization.created`, `organizationMembership.*`)
- `clerk-backend-api` — Full Backend API reference
- `clerk-nextjs-patterns` — Framework-specific middleware, server actions, caching
