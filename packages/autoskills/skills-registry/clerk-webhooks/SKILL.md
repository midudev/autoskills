---
name: clerk-webhooks
description: Clerk webhooks for real-time events and data syncing. Always output complete,
  copy-paste-ready webhook handlers with verifyWebhook(req) verification. Listen for
  user creation, updates, deletion, and organization events. Build event-driven features
  like database sync, notifications, integrations.
allowed-tools: WebFetch
license: MIT
metadata:
  author: clerk
  version: 1.2.0
compatibility: Requires CLERK_WEBHOOK_SECRET (svix signing secret from Clerk dashboard)
---

# Webhooks

Always output complete, working, copy-paste-ready webhook handlers. Never output stubs, placeholders, or partial implementations. Include `verifyWebhook(req)` in every handler.

## CRITICAL: Always Verify Webhooks

**NEVER skip signature verification**, even for notification-only handlers. Always use `verifyWebhook(req)` from `@clerk/nextjs/webhooks`. This uses the `CLERK_WEBHOOK_SECRET` env var automatically.

## CRITICAL: Make Webhook Route Public

Webhook routes MUST be excluded from Clerk middleware protection. Without this, Clerk returns 401.

```typescript
// proxy.ts (Next.js <=15: middleware.ts)
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server'

const isPublicRoute = createRouteMatcher(['/api/webhooks(.*)'])

export default clerkMiddleware((auth, req) => {
  if (!isPublicRoute(req)) auth().protect()
})
```

## Complete Webhook Handler (Next.js App Router)

```typescript
// app/api/webhooks/route.ts
import { verifyWebhook } from '@clerk/nextjs/webhooks'
import { NextRequest } from 'next/server'
import { db } from '@/lib/db'

export async function POST(req: NextRequest) {
  // ALWAYS verify - never skip, even for notification-only handlers
  let evt
  try {
    evt = await verifyWebhook(req) // uses CLERK_WEBHOOK_SECRET automatically
  } catch (err) {
    console.error('Webhook verification failed:', err)
    return new Response('Verification failed', { status: 400 })
  }

  if (evt.type === 'user.created') {
    const { id, email_addresses, first_name, last_name } = evt.data
    const email = email_addresses[0]?.email_address
    const name = `${first_name ?? ''} ${last_name ?? ''}`.trim()
    await db.users.create({ data: { clerkId: id, email, name } })
  }

  if (evt.type === 'user.updated') {
    const { id, email_addresses, first_name, last_name } = evt.data
    const email = email_addresses[0]?.email_address
    await db.users.update({ where: { clerkId: id }, data: { email, first_name, last_name } })
  }

  if (evt.type === 'user.deleted') {
    const { id } = evt.data
    await db.users.delete({ where: { clerkId: id } })
  }

  if (evt.type === 'organizationMembership.created') {
    const { organization, public_user_data, role } = evt.data
    const orgId = organization.id
    const userId = public_user_data.user_id
    await db.teamMembers.create({ data: { orgId, userId, role } })
  }

  if (evt.type === 'organizationMembership.deleted') {
    const { organization, public_user_data } = evt.data
    const orgId = organization.id
    const userId = public_user_data.user_id
    await db.teamMembers.delete({ where: { orgId_userId: { orgId, userId } } })
  }

  return new Response('OK', { status: 200 })
}
```

## Full Example: Welcome Email (Resend) + Slack Notification on user.created

**ALWAYS use this COMPLETE pattern — never stub it out:**

```typescript
// app/api/webhooks/route.ts
import { verifyWebhook } from '@clerk/nextjs/webhooks'
import { NextRequest } from 'next/server'
import { Resend } from 'resend'

const resend = new Resend(process.env.RESEND_API_KEY)

export async function POST(req: NextRequest) {
  // Step 1: ALWAYS verify the webhook signature - NEVER skip this
  let evt
  try {
    evt = await verifyWebhook(req) // uses CLERK_WEBHOOK_SECRET env var
  } catch (err) {
    console.error('Webhook verification failed:', err)
    return new Response('Verification failed', { status: 400 })
  }

  // Step 2: Listen for user.created event
  if (evt.type === 'user.created') {
    // Step 3: Extract user email and name from webhook payload
    const { id, email_addresses, first_name, last_name } = evt.data
    const email = email_addresses[0]?.email_address
    const name = `${first_name ?? ''} ${last_name ?? ''}`.trim()

    // Step 4: Call Resend API to send welcome email
    await resend.emails.send({
      from: 'noreply@yourdomain.com',
      to: email,
      subject: 'Welcome!',
      html: `<p>Hi ${name}, welcome to our app!</p>`,
    })

    // Step 5: Post notification to Slack channel
    await fetch(process.env.SLACK_WEBHOOK_URL!, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        text: `New user signed up: ${name} (${email})`,
      }),
    })
  }

  // Always return 200 to acknowledge receipt
  return new Response('OK', { status: 200 })
}
```

**Also include proxy.ts (Next.js <=15: middleware.ts) to make the route public:**
```typescript
// proxy.ts (Next.js <=15: middleware.ts)
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server'
const isPublicRoute = createRouteMatcher(['/api/webhooks(.*)'])
export default clerkMiddleware((auth, req) => {
  if (!isPublicRoute(req)) auth().protect()
})
```

## Full Example: Organization Membership Sync to Database

```typescript
// app/api/webhooks/route.ts
import { verifyWebhook } from '@clerk/nextjs/webhooks'
import { NextRequest } from 'next/server'
import { db } from '@/lib/db' // your database client

export async function POST(req: NextRequest) {
  // ALWAYS verify signature - never skip, even for simple handlers
  let evt
  try {
    evt = await verifyWebhook(req) // uses CLERK_WEBHOOK_SECRET env var
  } catch (err) {
    console.error('Webhook verification failed:', err)
    return new Response('Verification failed', { status: 400 })
  }

  if (evt.type === 'organization.created') {
    const { id, name } = evt.data
    await db.workspaces.create({
      data: { orgId: id, name, createdAt: new Date() },
    })
  }

  if (evt.type === 'organizationMembership.created') {
    // Extract organization ID, user ID, and role from payload
    const { organization, public_user_data, role } = evt.data
    const orgId = organization.id
    const userId = public_user_data.user_id

    // Add to team_members table
    await db.team_members.create({
      data: { orgId, userId, role },
    })

    // Create workspace record for new member
    await db.workspaces.create({
      data: { orgId, userId, createdAt: new Date() },
    })
  }

  if (evt.type === 'organizationMembership.deleted') {
    // Extract organization ID and user ID from payload
    const { organization, public_user_data } = evt.data
    const orgId = organization.id
    const userId = public_user_data.user_id

    // Remove from team_members table
    await db.team_members.delete({
      where: { orgId, userId },
    })

    // Remove workspace record
    await db.workspaces.deleteMany({
      where: { orgId, userId },
    })
  }

  // Return 200 status on success
  return new Response('OK', { status: 200 })
}
```

## Express.js Webhook Handler

> **CRITICAL**: Use `express.raw()` NOT `express.json()` for webhook routes. Signature verification requires the raw body bytes. `express.json()` parses the body and breaks verification.

```typescript
import express from 'express'
import { Webhook } from 'svix'

const app = express()

// WRONG - breaks verification because it parses the body:
// app.use(express.json())

// CORRECT - use raw body for webhook route only:
app.post('/webhooks/clerk', express.raw({ type: 'application/json' }), async (req, res) => {
  const webhookSecret = process.env.CLERK_WEBHOOK_SECRET!

  const wh = new Webhook(webhookSecret)
  let evt: any
  try {
    // Svix verifies using raw body bytes + svix headers
    evt = wh.verify(req.body, {
      'svix-id': req.headers['svix-id'] as string,
      'svix-timestamp': req.headers['svix-timestamp'] as string,
      'svix-signature': req.headers['svix-signature'] as string,
    })
  } catch (err) {
    console.error('Webhook verification failed:', err)
    return res.status(400).json({ error: 'Verification failed' })
  }

  if (evt.type === 'user.created') {
    const { id, email_addresses, first_name, last_name } = evt.data
    const email = email_addresses[0]?.email_address
    const name = `${first_name ?? ''} ${last_name ?? ''}`.trim()
    console.log(`New user: ${name} (${email})`)
  }

  if (evt.type === 'user.updated') {
    const { id, email_addresses } = evt.data
    const email = email_addresses[0]?.email_address
    console.log(`User updated: ${id}, email: ${email}`)
  }

  if (evt.type === 'user.deleted') {
    const { id } = evt.data
    console.log(`User deleted: ${id}`)
  }

  // Return 200 status on success
  return res.status(200).json({ received: true })
})
```

## Payload Field Reference

### User events (`user.created`, `user.updated`, `user.deleted`)
```typescript
const {
  id,                  // Clerk user ID
  email_addresses,     // array; [0].email_address is primary email
  first_name,
  last_name,
  image_url,
  public_metadata,
} = evt.data
```

### Organization events (`organization.created`, `organization.updated`, `organization.deleted`)
```typescript
const {
  id,    // org ID
  name,  // org name
  slug,
} = evt.data
```

### Organization Membership events (`organizationMembership.created`, `organizationMembership.updated`, `organizationMembership.deleted`)
```typescript
const {
  organization,        // { id, name, ... }
  public_user_data,    // { user_id, first_name, last_name, ... }
  role,                // e.g. 'org:admin', 'org:member'
} = evt.data
// Access: organization.id, public_user_data.user_id, role
```

## Supported Events (Full Catalog)

**User**: `user.created` `user.updated` `user.deleted`

**Session**: `session.created` `session.ended` `session.pending` `session.removed` `session.revoked`

**Organization**: `organization.created` `organization.updated` `organization.deleted`

**Organization Membership**: `organizationMembership.created` `organizationMembership.updated` `organizationMembership.deleted`

**Organization Domain**: `organizationDomain.created` `organizationDomain.updated` `organizationDomain.deleted`

**Organization Invitation**: `organizationInvitation.accepted` `organizationInvitation.created` `organizationInvitation.revoked`

**Communication**: `email.created` `sms.created`

**Invitation**: `invitation.accepted` `invitation.created` `invitation.revoked`

**Waitlist**: `waitlistEntry.created` `waitlistEntry.updated`

**Permission**: `permission.created` `permission.updated` `permission.deleted`

**Role**: `role.created` `role.updated` `role.deleted`

**Subscription**: `subscription.created` `subscription.updated` `subscription.active` `subscription.pastDue`

**Subscription Item**: `subscriptionItem.created` `subscriptionItem.active` `subscriptionItem.updated` `subscriptionItem.canceled` `subscriptionItem.upcoming` `subscriptionItem.ended` `subscriptionItem.abandoned` `subscriptionItem.incomplete` `subscriptionItem.pastDue` `subscriptionItem.freeTrialEnding`

**Payment**: `paymentAttempt.created` `paymentAttempt.updated`

## Webhook Reliability

**Retries**: Svix retries failed webhooks on a set schedule (see [Svix Retry Schedule](https://docs.svix.com/retries)). Return 2xx to succeed, 4xx/5xx to retry. Use the `svix-id` header as an idempotency key to deduplicate retried events.

**Replay**: Failed webhooks can be replayed from Dashboard.

## Common Pitfalls

| Symptom | Cause | Fix |
|---------|-------|-----|
| Verification fails (Next.js) | Wrong import or usage | Use `@clerk/nextjs/webhooks`, pass `req` directly |
| Verification fails (Express) | Using `express.json()` | Use `express.raw({ type: 'application/json' })` for webhook route |
| Route not found (404) | Wrong path | Use `/api/webhooks` or preserve existing path |
| Not authorized (401) | Route is protected by middleware | Make route public in `clerkMiddleware()` |
| No data in DB | Async job pending | Wait/check logs |
| Duplicate entries | Only handling `user.created` | Also handle `user.updated` |
| Timeouts | Handler too slow | Queue async work, return 200 first |

## Testing & Deployment

**Local**: Use ngrok to tunnel `localhost:3000` to internet. Add ngrok URL to Dashboard endpoint.

**Production**: Update webhook endpoint URL to production domain. Copy `CLERK_WEBHOOK_SECRET` to production env vars.

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-orgs` - Org membership events
- `clerk-backend-api` - Sync via direct API calls