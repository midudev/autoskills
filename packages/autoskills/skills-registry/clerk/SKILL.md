---
name: clerk
description: Clerk authentication router. Use when user asks about adding authentication,
  setting up Clerk, custom sign-in flows, Swift or native iOS auth, native Android
  auth, Next.js patterns, React patterns, Vue patterns, Nuxt patterns, Astro patterns,
  TanStack Start patterns, Expo patterns, React Router patterns, Chrome Extension patterns,
  organizations, syncing users, or testing. Automatically routes to the specific skill
  based on their task.
license: MIT
metadata:
  version: 2.0.0
---

# Clerk Skills Router

## Version Detection

Check `package.json` to determine the Clerk SDK version. This determines which patterns to use:

| Package | Core 2 (LTS until Jan 2027) | Current |
|---------|----------------------------|---------|
| `@clerk/nextjs` | v5–v6 | v7+ |
| `@clerk/react` or `@clerk/clerk-react` | v5–v6 | v7+ |
| `@clerk/expo` or `@clerk/clerk-expo` | v1–v2 | v3+ |
| `@clerk/react-router` | v1–v2 | v3+ |
| `@clerk/tanstack-react-start` | < v0.26.0 | v0.26.0+ |

**Default to current** if the version is unclear or the project is new. Core 2 packages use `@clerk/clerk-react` and `@clerk/clerk-expo` (with `clerk-` prefix); current packages use `@clerk/react` and `@clerk/expo`.

All skills are written for the current SDK. When something differs in Core 2, it's noted inline with `> **Core 2 ONLY (skip if current SDK):**` callouts. The exception is `clerk-custom-ui`, which has separate `core-2/` and `core-3/` directories for custom flow hooks since those APIs are entirely different between versions.

---

## By Task

**Adding Clerk to your project** → Use `clerk-setup`
- Framework detection and quickstart
- Environment setup, API keys, Keyless flow
- Migration from other auth providers

**Custom sign-in/sign-up UI** → Use `clerk-custom-ui`
- Custom authentication flows with `useSignIn` / `useSignUp` hooks
- Appearance and styling (themes, colors, layout)
- `<Show>` component for conditional rendering

**Advanced Next.js patterns** → Use `clerk-nextjs-patterns`
- Server vs Client auth APIs
- Middleware strategies
- Server Actions, caching
- API route protection

**React patterns** → Use `clerk-react-patterns`
- Hooks (`useAuth`, `useUser`, `useClerk`)
- Protected routes, auth guards
- Router integration

**React Router patterns** → Use `clerk-react-router-patterns`
- Loaders & actions with auth
- Route protection
- SSR auth

**Vue patterns** → Use `clerk-vue-patterns`
- Composables (`useAuth`, `useUser`, `useClerk`)
- Vue Router guards
- Pinia auth store integration

**Nuxt patterns** → Use `clerk-nuxt-patterns`
- Server middleware auth
- SSR auth with composables
- Server API routes

**Astro patterns** → Use `clerk-astro-patterns`
- SSR auth pages
- Island components with React
- Middleware & API routes

**TanStack Start patterns** → Use `clerk-tanstack-patterns`
- Server functions with auth
- Route protection via loaders
- Vinxi server integration

**Expo patterns** → Use `clerk-expo-patterns`
- Secure token storage
- OAuth deep linking
- Push notifications with auth

**Chrome Extension patterns** → Use `clerk-chrome-extension-patterns`
- Background scripts auth
- Popup auth flows
- Content scripts with sync host

**B2B / Organizations** → Use `clerk-orgs`
- Multi-tenant apps
- Organization slugs in URLs
- Roles, permissions, RBAC
- Member management

**Webhooks** → Use `clerk-webhooks`
- Real-time events
- Data syncing
- Notifications & integrations

**E2E Testing** → Use `clerk-testing`
- Playwright/Cypress setup
- Auth flow testing
- Test utilities

**Swift / native iOS auth** → Use `clerk-swift`
- Native iOS Swift and SwiftUI projects
- ClerkKit and ClerkKitUI implementation guidance
- Source-driven patterns from `clerk-ios`

**Android / native mobile auth** → Use `clerk-android`
- Native Android Kotlin and Jetpack Compose projects
- `clerk-android-api` and `clerk-android-ui` implementation guidance
- Source-driven patterns from `clerk-android`
- Do not use for Expo or React Native projects

**Backend REST API** → Use `clerk-backend-api`
- Browse API tags and endpoints
- Inspect endpoint schemas
- Execute API requests with scope enforcement

## Quick Navigation

If you know your task, you can directly access:
- `/clerk-setup` - Framework setup
- `/clerk-custom-ui` - Custom flows & appearance
- `/clerk-nextjs-patterns` - Next.js patterns
- `/clerk-react-patterns` - React patterns
- `/clerk-react-router-patterns` - React Router patterns
- `/clerk-vue-patterns` - Vue patterns
- `/clerk-nuxt-patterns` - Nuxt patterns
- `/clerk-astro-patterns` - Astro patterns
- `/clerk-tanstack-patterns` - TanStack Start patterns
- `/clerk-expo-patterns` - Expo patterns
- `/clerk-chrome-extension-patterns` - Chrome Extension patterns
- `/clerk-orgs` - Organizations
- `/clerk-webhooks` - Webhooks
- `/clerk-testing` - Testing
- `/clerk-swift` - Swift/native iOS
- `/clerk-android` - Native Android
- `/clerk-backend-api` - Backend REST API

Or describe what you need and I'll recommend the right one.
