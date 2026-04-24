# Custom Sign-In Flow (Core 2)

> This document covers the **older SDK** (`@clerk/nextjs` v5–v6, `@clerk/clerk-react` v5–v6, `@clerk/clerk-expo` v1–v2). For the current SDK, see `core-3/custom-sign-in.md`.

Build a custom sign-in experience using the `useSignIn()` hook.

## Hook API

```typescript
import { useSignIn } from '@clerk/nextjs' // or @clerk/clerk-react, @clerk/clerk-expo

const { signIn, isLoaded, setActive } = useSignIn()
```

| Property | Type | Description |
|----------|------|-------------|
| `signIn` | `SignIn` | Sign-in object with methods |
| `isLoaded` | `boolean` | Whether the hook has loaded |
| `setActive` | `(params) => Promise` | Sets the active session |

## Sign-In Flow

### 1. Create Sign-In

```typescript
const result = await signIn.create({
  identifier: 'user@example.com',
  password: 'securePassword123',
})
```

### 2. First Factor Verification

If additional verification is needed (email code, phone code):

```typescript
// Prepare first factor
await signIn.prepareFirstFactor({
  strategy: 'email_code', // or 'phone_code'
})

// Attempt first factor
const result = await signIn.attemptFirstFactor({
  strategy: 'email_code',
  code: '123456',
})
```

### 3. Second Factor (MFA)

If the sign-in requires MFA:

```typescript
// Prepare second factor
await signIn.prepareSecondFactor({
  strategy: 'email_code', // or 'phone_code'
})

// Attempt second factor
const result = await signIn.attemptSecondFactor({
  strategy: 'totp', // or 'email_code', 'phone_code', 'backup_code'
  code: '123456',
})
```

### 4. Finalize

Set the active session after successful authentication:

```typescript
await setActive({ session: signIn.createdSessionId })
```

### Password Reset

```typescript
// 1. Start reset flow
await signIn.create({ strategy: 'reset_password_email_code', identifier: 'user@example.com' })

// or prepare after initial create:
await signIn.prepareFirstFactor({ strategy: 'reset_password_email_code' })

// 2. Verify reset code
await signIn.attemptFirstFactor({ strategy: 'reset_password_email_code', code: '123456' })

// 3. Set new password
await signIn.resetPassword({ password: 'newSecurePassword123' })
```

### SSO (OAuth)

```typescript
await signIn.authenticateWithRedirect({
  strategy: 'oauth_google', // or 'oauth_github', etc.
  redirectUrl: '/sso-callback',
  redirectUrlComplete: '/',
})
```

## Error Handling

Use try/catch with `isClerkAPIResponseError()`:

```typescript
import { isClerkAPIResponseError } from '@clerk/nextjs/errors'

try {
  await signIn.create({ identifier, password })
} catch (err) {
  if (isClerkAPIResponseError(err)) {
    err.errors.forEach((e) => {
      console.log(e.code)        // e.g. 'form_identifier_not_found'
      console.log(e.message)     // Human-readable message
      console.log(e.longMessage) // Detailed message
    })
  }
}
```

## Complete Example: Email/Password with MFA

```tsx
'use client'
import { useState } from 'react'
import { useSignIn } from '@clerk/nextjs'
import { isClerkAPIResponseError } from '@clerk/nextjs/errors'
import { useRouter } from 'next/navigation'

export default function SignInPage() {
  const { signIn, isLoaded, setActive } = useSignIn()
  const router = useRouter()

  const [identifier, setIdentifier] = useState('')
  const [password, setPassword] = useState('')
  const [mfaCode, setMfaCode] = useState('')
  const [step, setStep] = useState<'credentials' | 'mfa'>('credentials')
  const [error, setError] = useState('')

  if (!isLoaded) return <div>Loading...</div>

  async function handleSignIn(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    try {
      const result = await signIn.create({ identifier, password })

      if (result.status === 'needs_second_factor') {
        setStep('mfa')
        return
      }

      if (result.status === 'complete') {
        await setActive({ session: result.createdSessionId })
        router.push('/')
      }
    } catch (err) {
      if (isClerkAPIResponseError(err)) {
        setError(err.errors[0]?.message || 'Sign in failed')
      }
    }
  }

  async function handleMFA(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    try {
      const result = await signIn.attemptSecondFactor({
        strategy: 'totp',
        code: mfaCode,
      })

      if (result.status === 'complete') {
        await setActive({ session: result.createdSessionId })
        router.push('/')
      }
    } catch (err) {
      if (isClerkAPIResponseError(err)) {
        setError(err.errors[0]?.message || 'Verification failed')
      }
    }
  }

  if (step === 'mfa') {
    return (
      <form onSubmit={handleMFA}>
        <input
          type="text"
          value={mfaCode}
          onChange={(e) => setMfaCode(e.target.value)}
          placeholder="Enter MFA code"
        />
        {error && <p>{error}</p>}
        <button type="submit">Verify</button>
      </form>
    )
  }

  return (
    <form onSubmit={handleSignIn}>
      <input
        type="email"
        value={identifier}
        onChange={(e) => setIdentifier(e.target.value)}
        placeholder="Email"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
      />
      {error && <p>{error}</p>}
      <button type="submit">Sign In</button>
    </form>
  )
}
```

## Docs

- [Custom sign-in flow](https://clerk.com/docs/custom-flows/overview)
- [useSignIn() reference](https://clerk.com/docs/references/react/use-sign-in)
