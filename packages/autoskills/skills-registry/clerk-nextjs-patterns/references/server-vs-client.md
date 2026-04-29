# Server vs Client (CRITICAL)

## CRITICAL: Always `await auth()`

```tsx
// WRONG
const { userId } = auth(); // undefined!

// CORRECT
const { userId } = await auth();
```

## When to Use

- **Server Components** - Initial load, SEO, DB queries
- **Client Components** - Interactive UI, sign out, token fetching

## Import Rules

```tsx
// Server Components
import { auth, currentUser } from '@clerk/nextjs/server';

// Client Components
'use client';
import { useAuth, useUser } from '@clerk/nextjs';
```

## Server Component

```tsx
import { auth, currentUser } from '@clerk/nextjs/server';

export default async function DashboardPage() {
  const { isAuthenticated } = await auth();
  if (!isAuthenticated) return <div>Please sign in</div>;

  const user = await currentUser();
  return <h1>Welcome, {user?.firstName}!</h1>;
}
```

> **Core 2 ONLY (skip if current SDK):** `isAuthenticated` is not available. Use `const { userId } = await auth()` and check `if (!userId)` instead.

## Client Component

```tsx
'use client';
import { useUser, useAuth } from '@clerk/nextjs';

export function UserDashboard() {
  const { isLoaded, isSignedIn, user } = useUser();
  const { signOut } = useAuth();

  if (!isLoaded) return <div>Loading...</div>;
  if (!isSignedIn) return <div>Not signed in</div>;

  return (
    <div>
      <p>Hello, {user.firstName}!</p>
      <button onClick={() => signOut()}>Sign out</button>
    </div>
  );
}
```

## Hybrid Pattern

```tsx
// Server: fetch initial data
import { currentUser } from '@clerk/nextjs/server';
import { ProfileForm } from './ProfileForm';

export default async function ProfilePage() {
  const user = await currentUser();
  if (!user) return <div>Please sign in</div>;
  return <ProfileForm initialData={{ firstName: user.firstName }} />;
}

// Client: handle interactions
'use client';
import { useUser } from '@clerk/nextjs';

export function ProfileForm({ initialData }) {
  const { user } = useUser();
  return <form>...</form>;
}
```

## Conditional Rendering

Use `<Show>` for client-side conditional rendering based on auth state:

```tsx
import { Show } from '@clerk/nextjs';

<Show when="signed-in" fallback={<div>Please sign in</div>}>
  <Dashboard />
</Show>
```

> **Core 2 ONLY (skip if current SDK):** Use `<SignedIn>` and `<SignedOut>` components instead of `<Show>`.

[Docs](https://clerk.com/docs/reference/nextjs/auth)
