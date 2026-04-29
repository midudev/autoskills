# Protected Routes (CRITICAL)

## ProtectedRoute Component

Wrap protected routes with a guard component:

```tsx
import { Navigate, Outlet } from 'react-router-dom'
import { useAuth } from '@clerk/react'

export function ProtectedRoute() {
  const { isLoaded, isSignedIn } = useAuth()

  if (!isLoaded) return <div>Loading...</div>
  if (!isSignedIn) return <Navigate to="/sign-in" replace />

  return <Outlet />
}
```

## Router Setup (React Router v6/v7)

```tsx
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { ClerkProvider } from '@clerk/react'
import { ProtectedRoute } from './ProtectedRoute'
import { Dashboard } from './Dashboard'
import { Settings } from './Settings'
import { SignInPage } from './SignInPage'

function App() {
  return (
    <ClerkProvider publishableKey={import.meta.env.VITE_CLERK_PUBLISHABLE_KEY}>
      <BrowserRouter>
        <Routes>
          <Route path="/sign-in" element={<SignInPage />} />
          <Route element={<ProtectedRoute />}>
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/settings" element={<Settings />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </ClerkProvider>
  )
}
```

`ClerkProvider` must be an ancestor of both the router and any Clerk hooks/components.

## Org-Gated Route

```tsx
import { Navigate, Outlet } from 'react-router-dom'
import { useAuth } from '@clerk/react'

export function OrgRoute() {
  const { isLoaded, isSignedIn, orgId } = useAuth()

  if (!isLoaded) return <div>Loading...</div>
  if (!isSignedIn) return <Navigate to="/sign-in" replace />
  if (!orgId) return <Navigate to="/select-org" replace />

  return <Outlet />
}
```

## Using Prebuilt Components

For simpler cases, wrap with `<SignedIn>` / `<SignedOut>` equivalents:

```tsx
import { Show } from '@clerk/react'
import { Navigate } from 'react-router-dom'

export function Dashboard() {
  return (
    <Show when="signed-in" fallback={<Navigate to="/sign-in" replace />}>
      <DashboardContent />
    </Show>
  )
}
```

The `ProtectedRoute` pattern is preferred for route-level control; `<Show>` is better for component-level.

[Docs](https://clerk.com/docs/react/getting-started/quickstart)
