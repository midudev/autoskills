---
name: clerk-setup
description: Add Clerk authentication to any project by following the official quickstart
  guides.
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 2.3.0
---

# Adding Clerk

> **Version**: Check `package.json` for the SDK version — see `clerk` skill for the version table. Core 2 differences are noted inline with `> **Core 2 ONLY (skip if current SDK):**` callouts.

This skill sets up Clerk for authentication by following the official quickstart documentation.

## Quick Reference

| Step | Action |
|------|--------|
| 1. Detect framework | Check `package.json` dependencies |
| 2. Fetch quickstart | Use WebFetch on the appropriate docs URL |
| 3. Follow instructions | Execute steps; create `proxy.ts` (Next.js <=15: `middleware.ts`) |
| 4. Get API keys | From [dashboard.clerk.com](https://dashboard.clerk.com/last-active?path=api-keys) |

> If the project has `components.json` (shadcn/ui), apply the shadcn theme after setup. See `clerk-custom-ui` skill → shadcn Theme.

## Framework Detection

Check `package.json` to identify the framework:

| Dependency | Framework | Quickstart URL |
|------------|-----------|----------------|
| `next` | Next.js | `https://clerk.com/docs/nextjs/getting-started/quickstart` |
| `@remix-run/react` | Remix | `https://clerk.com/docs/remix/getting-started/quickstart` |
| `astro` | Astro | `https://clerk.com/docs/astro/getting-started/quickstart` |
| `nuxt` | Nuxt | `https://clerk.com/docs/nuxt/getting-started/quickstart` |
| `react-router` | React Router | `https://clerk.com/docs/react-router/getting-started/quickstart` |
| `@tanstack/react-start` | TanStack Start | `https://clerk.com/docs/tanstack-react-start/getting-started/quickstart` |
| `react` (no framework) | React SPA | `https://clerk.com/docs/react/getting-started/quickstart` |
| `vue` | Vue | `https://clerk.com/docs/vue/getting-started/quickstart` |
| `express` | Express | `https://clerk.com/docs/expressjs/getting-started/quickstart` |
| `fastify` | Fastify | `https://clerk.com/docs/fastify/getting-started/quickstart` |
| `expo` | Expo | `https://clerk.com/docs/expo/getting-started/quickstart` |

For other platforms:
- **Chrome Extension**: `https://clerk.com/docs/chrome-extension/getting-started/quickstart`
- **Android**: `https://clerk.com/docs/android/getting-started/quickstart`
- **iOS**: `https://clerk.com/docs/ios/getting-started/quickstart`
- **Vanilla JavaScript**: `https://clerk.com/docs/js-frontend/getting-started/quickstart`

## Decision Tree

```
User Request: "Add Clerk" / "Add authentication"
    │
    ├─ Read package.json
    │
    ├─ Existing auth detected?
    │   ├─ YES → Audit → Migration plan
    │   └─ NO → Fresh install
    │
    ├─ Identify framework → WebFetch quickstart → Follow instructions
    │   └─ Next.js? → Create proxy.ts (Next.js <=15: middleware.ts)
    │
    └─ components.json exists? → YES → Apply shadcn theme (see clerk-custom-ui)
```

## Setup Process

### 1. Detect the Framework

Read the project's `package.json` and match dependencies to the table above.

### 2. Fetch the Quickstart Guide

Use WebFetch to retrieve the official quickstart for the detected framework:

```
WebFetch: https://clerk.com/docs/{framework}/getting-started/quickstart
Prompt: "Extract the complete setup instructions including all code snippets, file paths, and configuration steps."
```

### 3. Follow the Instructions

Execute each step from the quickstart guide:
- Install the required packages
- Set up environment variables
- Add the provider and proxy/middleware
- Create sign-in/sign-up routes if needed
- Test the integration

> **Next.js:** Create `proxy.ts` (Next.js <=15: `middleware.ts`). See the `clerk-nextjs-patterns` skill for middleware strategies.

> **shadcn/ui detected** (`components.json` exists): ALWAYS apply the shadcn theme. See `clerk-custom-ui` skill → shadcn Theme section.

### 4. Get API Keys

Two paths for development API keys:

**Keyless (Automatic)**
- On first SDK initialization, Clerk auto-generates dev keys and shows "Claim your application" popover
- No manual key setup required—keys are created and injected automatically
- Simplest path for new projects

**Manual (Dashboard)**
- Get keys from [dashboard.clerk.com](https://dashboard.clerk.com/last-active?path=api-keys) if Keyless doesn't trigger
- **Publishable Key**: Starts with `pk_test_` or `pk_live_`
- **Secret Key**: Starts with `sk_test_` or `sk_live_`
- Set as environment variables: `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` and `CLERK_SECRET_KEY`

## Migrating from Another Auth Provider

If the project already has authentication, create a migration plan before replacing it.

### Detect Existing Auth

Check `package.json` for existing auth libraries:
- `next-auth` / `@auth/core` → NextAuth/Auth.js
- `@supabase/supabase-js` → Supabase Auth
- `firebase` / `firebase-admin` → Firebase Auth
- `@aws-amplify/auth` → AWS Cognito
- `auth0` / `@auth0/nextjs-auth0` → Auth0
- `passport` → Passport.js
- Custom JWT/session implementation

### Migration Process

1. **Audit current auth** - Identify all auth touchpoints:
   - Sign-in/sign-up pages
   - Session/token handling
   - Protected routes and middleware
   - User data storage (database tables, external IDs)
   - OAuth providers configured

2. **Create migration plan** - Consider:
   - **User data export** - Export users and import via Clerk's Backend API
   - **Password hashes** - Clerk can upgrade hashes to Bcrypt transparently
   - **External IDs** - Store legacy user IDs as `external_id` in Clerk
   - **Session handling** - Existing sessions will terminate on switch

3. **Choose migration strategy**:
   - **Big bang** - Switch all users at once (simpler, requires maintenance window)
   - **Trickle migration** - Run both systems temporarily (lower risk, higher complexity)

### Migration Reference

- **Migration Overview**: https://clerk.com/docs/guides/development/migrating/overview

## SDK Notes

### Package Names

| Package | Install |
|---------|---------|
| Next.js | `@clerk/nextjs` |
| React | `@clerk/react` |
| Expo | `@clerk/expo` |
| React Router | `@clerk/react-router` |
| TanStack Start | `@clerk/tanstack-react-start` |

> **Core 2 ONLY (skip if current SDK):** React and Expo packages have different names: `@clerk/clerk-react` and `@clerk/clerk-expo` (with `clerk-` prefix).

### ClerkProvider Placement (Next.js)

`ClerkProvider` must be placed **inside `<body>`**, not wrapping `<html>`:

```tsx
// root layout.tsx
export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <ClerkProvider>{children}</ClerkProvider>
      </body>
    </html>
  )
}
```

> **Core 2 ONLY (skip if current SDK):** `ClerkProvider` can wrap `<html>` directly.

### Dynamic Rendering (Next.js)

For dynamic rendering with auth data, use the `dynamic` prop:

```tsx
<ClerkProvider dynamic>{children}</ClerkProvider>
```

### Node.js Requirement

Requires **Node.js 20.9.0** or higher.

> **Core 2 ONLY (skip if current SDK):** Minimum Node.js 18.17.0.

### Themes Package

Themes are installed from `@clerk/ui`:

```bash
npm install @clerk/ui
```

> **Core 2 ONLY (skip if current SDK):** Themes are from `@clerk/themes` instead of `@clerk/ui`.

### shadcn Theme

If the project uses shadcn/ui (check for `components.json` in the project root), apply the shadcn theme so Clerk components match the app's design system:

```bash
npm install @clerk/ui
```

```tsx
import { shadcn } from '@clerk/ui/themes'

<ClerkProvider appearance={{ theme: shadcn }}>{children}</ClerkProvider>
```

Also import the shadcn CSS in your global styles:
```css
@import 'tailwindcss';
@import '@clerk/ui/themes/shadcn.css';
```

> **Core 2 ONLY (skip if current SDK):** Import from `@clerk/themes` and `@clerk/themes/shadcn.css` instead.

## Common Pitfalls

| Level | Issue | Solution |
|-------|-------|----------|
| CRITICAL | Missing `await` on `auth()` | In Next.js 15+, `auth()` is async: `const { userId } = await auth()` |
| CRITICAL | Exposing `CLERK_SECRET_KEY` | Never use secret key in client code; only `NEXT_PUBLIC_*` keys are safe |
| HIGH | Missing middleware matcher | Include API routes: `matcher: ['/((?!.*\\..*|_next).*)', '/']` |
| HIGH | ClerkProvider placement | Must be inside `<body>` in root layout (Core 2: could wrap `<html>`) |
| HIGH | Auth routes not public | Allow `/sign-in`, `/sign-up` in middleware config |
| HIGH | Landing page requires auth | To keep "/" public, exclude it: `matcher: ['/((?!.*\\..*|_next|^/$).*)', '/api/(.*)']` |
| MEDIUM | Wrong import path | Server code uses `@clerk/nextjs/server`, client uses `@clerk/nextjs` |
| MEDIUM | Wrong package name | Use `@clerk/react` not `@clerk/clerk-react` (Core 2 naming) |

## See Also

- `clerk-custom-ui` - Custom sign-in/up components
- `clerk-nextjs-patterns` - Advanced Next.js patterns
- `clerk-react-patterns` - React SPA patterns
- `clerk-react-router-patterns` - React Router patterns
- `clerk-vue-patterns` - Vue patterns
- `clerk-nuxt-patterns` - Nuxt patterns
- `clerk-astro-patterns` - Astro patterns
- `clerk-tanstack-patterns` - TanStack Start patterns
- `clerk-expo-patterns` - Expo patterns
- `clerk-chrome-extension-patterns` - Chrome Extension patterns
- `clerk-orgs` - B2B multi-tenant organizations
- `clerk-webhooks` - Webhook → database sync
- `clerk-testing` - E2E testing setup
- `clerk-swift` - Native iOS auth
- `clerk-android` - Native Android auth
- `clerk-backend-api` - Backend REST API explorer

## Documentation

- **Quickstart Overview**: https://clerk.com/docs/getting-started/quickstart/overview
- **Migration Guide**: https://clerk.com/docs/guides/development/migrating/overview
- **Full Documentation**: https://clerk.com/docs
