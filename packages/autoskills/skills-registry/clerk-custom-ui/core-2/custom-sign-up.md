# Custom Sign-Up Flow (Core 2)

> This document covers the **older SDK** (`@clerk/nextjs` v5–v6, `@clerk/clerk-react` v5–v6, `@clerk/clerk-expo` v1–v2). For the current SDK, see `core-3/custom-sign-up.md`.

Build a custom sign-up experience using the `useSignUp()` hook.

## Hook API

```typescript
import { useSignUp } from '@clerk/nextjs' // or @clerk/clerk-react, @clerk/clerk-expo

const { signUp, isLoaded, setActive } = useSignUp()
```

| Property | Type | Description |
|----------|------|-------------|
| `signUp` | `SignUp` | Sign-up object with methods |
| `isLoaded` | `boolean` | Whether the hook has loaded |
| `setActive` | `(params) => Promise` | Sets the active session |

## Sign-Up Flow

### 1. Create Sign-Up

```typescript
const result = await signUp.create({
  emailAddress: 'user@example.com',
  password: 'securePassword123',
  firstName: 'Jane',  // optional
  lastName: 'Doe',    // optional
})
```

### 2. Prepare Verification

Send a verification code to the user's email or phone:

```typescript
await signUp.prepareVerification({
  strategy: 'email_code', // or 'phone_code', 'email_link'
})
```

### 3. Attempt Verification

Verify the code the user received:

```typescript
const result = await signUp.attemptVerification({
  strategy: 'email_code',
  code: '123456',
})
```

### 4. Finalize

Set the active session after successful sign-up:

```typescript
await setActive({ session: signUp.createdSessionId })
```

### SSO (OAuth)

```typescript
await signUp.authenticateWithRedirect({
  strategy: 'oauth_google',
  redirectUrl: '/sso-callback',
  redirectUrlComplete: '/',
})
```

## Error Handling

Use try/catch with `isClerkAPIResponseError()`:

```typescript
import { isClerkAPIResponseError } from '@clerk/nextjs/errors'

try {
  await signUp.create({ emailAddress, password })
} catch (err) {
  if (isClerkAPIResponseError(err)) {
    err.errors.forEach((e) => {
      console.log(e.code)        // e.g. 'form_password_pwned'
      console.log(e.message)     // Human-readable message
      console.log(e.longMessage) // Detailed message
    })
  }
}
```

## Complete Example: Email/Password with Email Verification

```tsx
'use client'
import { useState } from 'react'
import { useSignUp } from '@clerk/nextjs'
import { isClerkAPIResponseError } from '@clerk/nextjs/errors'
import { useRouter } from 'next/navigation'

export default function SignUpPage() {
  const { signUp, isLoaded, setActive } = useSignUp()
  const router = useRouter()

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [code, setCode] = useState('')
  const [step, setStep] = useState<'register' | 'verify'>('register')
  const [error, setError] = useState('')

  if (!isLoaded) return <div>Loading...</div>

  async function handleRegister(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    try {
      await signUp.create({ emailAddress: email, password })
      await signUp.prepareVerification({ strategy: 'email_code' })
      setStep('verify')
    } catch (err) {
      if (isClerkAPIResponseError(err)) {
        setError(err.errors[0]?.message || 'Sign up failed')
      }
    }
  }

  async function handleVerify(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    try {
      const result = await signUp.attemptVerification({
        strategy: 'email_code',
        code,
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

  if (step === 'verify') {
    return (
      <form onSubmit={handleVerify}>
        <p>Check your email for a verification code.</p>
        <input
          type="text"
          value={code}
          onChange={(e) => setCode(e.target.value)}
          placeholder="Verification code"
        />
        {error && <p>{error}</p>}
        <button type="submit">Verify Email</button>
      </form>
    )
  }

  return (
    <form onSubmit={handleRegister}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
      />
      {error && <p>{error}</p>}
      <button type="submit">Sign Up</button>
    </form>
  )
}
```

## Docs

- [Custom sign-up flow](https://clerk.com/docs/custom-flows/overview)
- [useSignUp() reference](https://clerk.com/docs/references/react/use-sign-up)
