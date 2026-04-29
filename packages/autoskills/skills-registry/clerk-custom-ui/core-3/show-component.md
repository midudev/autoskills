# `<Show>` Component

The `<Show>` component conditionally renders content based on authentication state, roles, permissions, billing plans, and features.

> **Core 2 ONLY (skip if current SDK):** The `<Show>` component does not exist in Core 2. Use `<SignedIn>`, `<SignedOut>`, and `<Protect>` instead. See migration table below.

## Import

```typescript
import { Show } from '@clerk/nextjs'       // Next.js
import { Show } from '@clerk/react'         // React
import { Show } from '@clerk/react-router'  // React Router
import { Show } from '@clerk/expo'          // Expo
```

## Props

| Prop | Type | Description |
|------|------|-------------|
| `when` | `string \| object \| function` | Condition for rendering children |
| `fallback?` | `ReactNode` | Content shown when condition fails |
| `treatPendingAsSignedOut?` | `boolean` | Treat pending sessions as signed-out (default: `true`) |

## `when` Prop Variants

### Authentication State

```tsx
// Show content only when signed in
<Show when="signed-in">
  <p>Welcome back!</p>
</Show>

// Show content only when signed out
<Show when="signed-out">
  <p>Please sign in.</p>
</Show>
```

### Role Check

```tsx
<Show when={{ role: 'org:admin' }}>
  <AdminPanel />
</Show>
```

### Permission Check

```tsx
<Show when={{ permission: 'org:billing:manage' }}>
  <BillingSettings />
</Show>
```

### Billing Feature Check

```tsx
<Show when={{ feature: 'widgets' }}>
  <WidgetBuilder />
</Show>
```

### Billing Plan Check

```tsx
<Show when={{ plan: 'gold' }}>
  <PremiumContent />
</Show>
```

### Custom Condition (Function)

```tsx
<Show when={(has) => has({ role: 'org:admin' }) || has({ permission: 'org:billing:manage' })}>
  <SettingsPanel />
</Show>
```

## Fallback Content

Show alternative content when the condition fails:

```tsx
<Show when="signed-in" fallback={<p>Please sign in to continue.</p>}>
  <Dashboard />
</Show>
```

## Session Tasks and Pending State

The `treatPendingAsSignedOut` prop controls how pending sessions (sessions with incomplete tasks) are handled:

```tsx
// Default: pending sessions are treated as signed-out
<Show when="signed-in" treatPendingAsSignedOut>
  <Dashboard />
</Show>

// Treat pending sessions as signed-in (e.g., to show task completion UI)
<Show when="signed-in" treatPendingAsSignedOut={false}>
  <TaskCompletionFlow />
</Show>
```

## Security Caveat

**`<Show>` only visually hides content** — it remains in browser source. It is not a security boundary. For protecting sensitive data, always verify authentication server-side with `auth()` or use `auth.protect()` in middleware.

## Migration from Core 2

| Core 2 | Current |
|--------|---------|
| `<SignedIn>` | `<Show when="signed-in">` |
| `<SignedOut>` | `<Show when="signed-out">` |
| `<Protect role="org:admin">` | `<Show when={{ role: 'org:admin' }}>` |
| `<Protect permission="org:billing:manage">` | `<Show when={{ permission: 'org:billing:manage' }}>` |
| `<Protect condition={(has) => expr}>` | `<Show when={(has) => expr}>` |
| `<Protect fallback={...}>` | `<Show when={...} fallback={...}>` |
| *(no equivalent)* | `<Show when={{ feature: 'widgets' }}>` |
| *(no equivalent)* | `<Show when={{ plan: 'gold' }}>` |

## Docs

- [Show component reference](https://clerk.com/docs/components/control/show)
