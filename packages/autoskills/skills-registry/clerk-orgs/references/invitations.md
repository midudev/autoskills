# Organization Invitations

Send, list, revoke. Backend API methods live on `clerkClient().organizations.*`. All send operations require the caller to have `org:sys_memberships:manage`.

> **Framework wrappers.** Method signatures on `clerk.organizations.*` are identical across SDKs; only the wrapper that gives you the client differs:
>
> | SDK | Get the client | Get the auth context |
> |---|---|---|
> | `@clerk/nextjs/server` | `const clerk = await clerkClient()` | `const { userId, has } = await auth()` |
> | `@clerk/backend` (agnostic) | `const clerk = createClerkClient({ secretKey })` | n/a (verify the session token yourself with `verifyToken` imported from `@clerk/backend`) |
> | `@clerk/astro/server` | `const clerk = clerkClient(context)` | `const { userId } = context.locals.auth()` |
> | `@clerk/nuxt/server` | `const clerk = clerkClient(event)` | `const { userId } = event.context.auth()` |
> | `@clerk/express` | `const clerk = clerkClient` (after `clerkMiddleware()`) | `const { userId } = getAuth(req)` |
>
> Examples below use `@clerk/nextjs` as the default flavor.

## Create Invitation

```typescript
import { clerkClient, auth } from '@clerk/nextjs/server'

export async function inviteMember(organizationId: string, emailAddress: string, role: string) {
  const { userId, has } = await auth()
  if (!userId) throw new Error('Not signed in')
  if (!has({ permission: 'org:sys_memberships:manage' })) {
    throw new Error('Not authorized')
  }

  const clerk = await clerkClient()
  return clerk.organizations.createOrganizationInvitation({
    organizationId,
    inviterUserId: userId,
    emailAddress,
    role,
    redirectUrl: 'https://yourapp.com/accept-invite',
    publicMetadata: { invitedFrom: 'admin-panel' },
  })
}
```

**Params:**

| Param | Type | Notes |
|-------|------|-------|
| `organizationId` | `string` | Required |
| `inviterUserId` | `string \| null` | Required. The user sending the invite. Pass `null` only for system-originated invites (rare). |
| `emailAddress` | `string` | Required. Target email. |
| `role` | `string` | Required. `'org:admin'`, `'org:member'`, or any custom role slug. |
| `redirectUrl?` | `string` | Where the user lands after accepting. |
| `publicMetadata?` | `object` | Readable by Frontend + Backend; settable only from Backend. |

**Rate limit:** 250 requests/hour per application instance.

## Bulk Create

Takes the `organizationId` as its first positional arg and an array of per-invitation params as its second:

```typescript
await clerk.organizations.createOrganizationInvitationBulk(organizationId, [
  { inviterUserId: userId, emailAddress: 'alice@acme.com', role: 'org:admin' },
  { inviterUserId: userId, emailAddress: 'bob@acme.com', role: 'org:member' },
])
```

Each item accepts the same optional fields as a single `createOrganizationInvitation` call (`redirectUrl`, `publicMetadata`). The bulk endpoint is rate-limited separately at **50 requests/hour** per application instance (vs 250/hr for single create).

## List Invitations

```typescript
const { data, totalCount } = await clerk.organizations.getOrganizationInvitationList({
  organizationId,
  status: ['pending', 'accepted', 'revoked', 'expired'],  // any subset; defaults to ['pending']
  limit: 50,         // max 500
  offset: 0,
})
```

Returns a `PaginatedResourceResponse<OrganizationInvitation[]>` — access the array via `data` and the total via `totalCount`.

Full status enum: `'pending' | 'accepted' | 'revoked' | 'expired'`. Skipping `status` defaults to `['pending']`.

## Revoke Invitation

```typescript
await clerk.organizations.revokeOrganizationInvitation({
  organizationId,
  invitationId,
  requestingUserId: userId,  // the user doing the revoking
})
```

All three params are required strings. You cannot revoke an already-accepted invitation (use membership removal APIs for that).

## Get a Single Invitation

```typescript
const invitation = await clerk.organizations.getOrganizationInvitation({
  organizationId,
  invitationId,
})
```

## Built-in Invitation UI

Zero-code path — `<OrganizationProfile />` includes a full members tab with invite / revoke / role change:

```tsx
import { OrganizationProfile } from '@clerk/nextjs'

export default function OrgSettings() {
  return <OrganizationProfile />
}
```

`<OrganizationSwitcher />` also includes a compact invitation flow via its built-in dropdown when `hidePersonal` is set or users click **Manage Organization**:

```tsx
<OrganizationSwitcher
  hidePersonal
  afterCreateOrganizationUrl="/orgs/:slug/dashboard"
  afterSelectOrganizationUrl="/orgs/:slug/dashboard"
/>
```

## Accept Invitations (Custom Flow)

If you need to build your own accept page instead of relying on Clerk's account portal, see the custom flow doc: [Accept Organization Invitations](https://clerk.com/docs/guides/development/custom-flows/organizations/accept-organization-invitations). Common pattern:

1. User clicks link → lands on your `/accept-invite` page with `?__clerk_ticket=...` query param
2. Your page calls `signIn.create({ strategy: 'ticket', ticket })` OR `signUp.create({ strategy: 'ticket', ticket })` depending on whether the user exists
3. Clerk sets the active org on the session

## Webhook Events

Listen for invitation lifecycle:

- `organizationInvitation.created`
- `organizationInvitation.accepted`
- `organizationInvitation.revoked`

See `clerk-webhooks` skill for webhook setup + signature verification.

## Key Rules

- `inviterUserId` is NOT optional in a human-initiated flow. Don't omit it — track who sent each invite.
- Invitations with `status: 'expired'` need to be recreated; they can't be re-sent.
- The caller needs `org:sys_memberships:manage`. Default `org:admin` has this; `org:member` does not.
- Revoke by `invitationId`, not by email. Email alone is ambiguous when you've had multiple invites to the same address.
- Rate limits differ by endpoint: single `createOrganizationInvitation` is 250/hr, `createOrganizationInvitationBulk` is 50/hr. Batch wisely.
