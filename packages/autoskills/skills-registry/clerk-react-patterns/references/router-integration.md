# Router Integration (HIGH)

## ClerkProvider Position

Place `ClerkProvider` outside the router but inside `StrictMode`:

```tsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import { ClerkProvider } from '@clerk/react'
import App from './App'

const PUBLISHABLE_KEY = import.meta.env.VITE_CLERK_PUBLISHABLE_KEY

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <ClerkProvider publishableKey={PUBLISHABLE_KEY}>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </ClerkProvider>
  </StrictMode>,
)
```

`ClerkProvider` must wrap `BrowserRouter` so hooks work inside route components.

## Redirect URLs

Configure where users land after sign-in/sign-up:

```tsx
<ClerkProvider
  publishableKey={PUBLISHABLE_KEY}
  afterSignInUrl="/dashboard"
  afterSignUpUrl="/onboarding"
>
```

Or via environment variables:
```
VITE_CLERK_SIGN_IN_URL=/sign-in
VITE_CLERK_SIGN_UP_URL=/sign-up
VITE_CLERK_SIGN_IN_FALLBACK_REDIRECT_URL=/dashboard
VITE_CLERK_SIGN_UP_FALLBACK_REDIRECT_URL=/dashboard
```

## Using Prebuilt Sign-In Component

```tsx
import { SignIn } from '@clerk/react'

export function SignInPage() {
  return (
    <div style={{ display: 'flex', justifyContent: 'center', paddingTop: '4rem' }}>
      <SignIn />
    </div>
  )
}
```

Register the route:
```tsx
<Route path="/sign-in/*" element={<SignInPage />} />
<Route path="/sign-up/*" element={<SignUpPage />} />
```

The `/*` wildcard is required for Clerk's multi-step flows (email verification, etc.) to work with React Router.

## useNavigate with Clerk Actions

```tsx
import { useClerk } from '@clerk/react'
import { useNavigate } from 'react-router-dom'

export function SignOutButton() {
  const { signOut } = useClerk()
  const navigate = useNavigate()

  return (
    <button onClick={() => signOut(() => navigate('/'))}>
      Sign out
    </button>
  )
}
```

Pass a callback to `signOut` to navigate after the sign-out completes.

[Docs](https://clerk.com/docs/react/getting-started/quickstart)
