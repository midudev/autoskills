# Custom Flows (HIGH)

## Custom Sign-In with useSignIn

```tsx
import { useSignIn } from '@clerk/react'
import { useNavigate } from 'react-router-dom'
import { useState } from 'react'

export function CustomSignIn() {
  const { isLoaded, signIn, setActive } = useSignIn()
  const navigate = useNavigate()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!isLoaded) return

    try {
      const result = await signIn.create({
        identifier: email,
        password,
      })

      if (result.status === 'complete') {
        await setActive({ session: result.createdSessionId })
        navigate('/dashboard')
      }
    } catch (err: unknown) {
      const clerkError = err as { errors?: Array<{ message: string }> }
      setError(clerkError.errors?.[0]?.message ?? 'Sign in failed')
    }
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={e => setEmail(e.target.value)}
        placeholder="Email"
      />
      <input
        type="password"
        value={password}
        onChange={e => setPassword(e.target.value)}
        placeholder="Password"
      />
      {error && <p>{error}</p>}
      <button type="submit">Sign In</button>
    </form>
  )
}
```

## Custom Sign-Up with useSignUp

```tsx
import { useSignUp } from '@clerk/react'

export function CustomSignUp() {
  const { isLoaded, signUp, setActive } = useSignUp()

  async function handleSubmit(email: string, password: string) {
    if (!isLoaded) return

    const result = await signUp.create({ emailAddress: email, password })

    if (result.status === 'complete') {
      await setActive({ session: result.createdSessionId })
    } else if (result.status === 'missing_requirements') {
      // Email verification needed
      await signUp.prepareEmailAddressVerification({ strategy: 'email_code' })
    }
  }
}
```

## Email Verification

```tsx
async function verifyEmail(code: string) {
  const result = await signUp.attemptEmailAddressVerification({ code })

  if (result.status === 'complete') {
    await setActive({ session: result.createdSessionId })
    navigate('/dashboard')
  }
}
```

## signIn.status Values

| Status | Meaning |
|--------|---------|
| `'complete'` | Auth successful, call `setActive` |
| `'needs_first_factor'` | First factor required (e.g., password) |
| `'needs_second_factor'` | MFA required |
| `'needs_new_password'` | Password reset required |

Always check `result.status === 'complete'` before calling `setActive`.

[Docs](https://clerk.com/docs/react/getting-started/quickstart)
