# Custom Sign-In Flow

Build a custom sign-in experience using the `useSignIn()` hook.

## Hook API

```typescript
import { useSignIn } from '@clerk/nextjs' // or @clerk/react, @clerk/expo

const { signIn, errors, fetchStatus } = useSignIn()
```

| Property | Type | Description |
|----------|------|-------------|
| `signIn` | `SignInFuture` | Sign-in object with namespaced methods |
| `errors` | `Errors<SignInFields>` | Structured error object |
| `fetchStatus` | `'idle' \| 'fetching'` | Network request status |

## Sign-In Methods

### Password

```typescript
const { error } = await signIn.password({
  identifier: 'user@example.com',
  password: 'securePassword123',
})
```

### SSO (OAuth / Enterprise)

```typescript
const { error } = await signIn.sso({
  strategy: 'oauth_google', // or 'oauth_github', 'enterprise_sso', etc.
  redirectUrl: '/dashboard', // where to go after SSO completes
  redirectCallbackUrl: '/sso-callback', // intermediate callback route
})
```

### Passkey

```typescript
const { error } = await signIn.passkey({ flow: 'discoverable' })
```

### Web3

```typescript
const { error } = await signIn.web3({ strategy: 'web3_solana_signature' })
// or
const { error } = await signIn.web3({ strategy: 'web3_base_signature' })
```

### Ticket (Invitation link)

```typescript
const { error } = await signIn.ticket({ ticket: 'ticket_abc123' })
```

### Email Code

```typescript
// Send code (emailAddress is optional if a signIn already exists from a prior method call)
const { error } = await signIn.emailCode.sendCode({ emailAddress: 'user@example.com' })

// Verify code
const { error } = await signIn.emailCode.verifyCode({ code: '123456' })
```

### Phone Code

```typescript
// Send code (phoneNumber is optional if a signIn already exists from a prior method call)
const { error } = await signIn.phoneCode.sendCode({ phoneNumber: '+12015551234' })

// Verify code
const { error } = await signIn.phoneCode.verifyCode({ code: '123456' })
```

## MFA (Second Factor)

A second factor is required when `signIn.status` is one of:
- `'needs_second_factor'` — user has MFA enabled (TOTP, backup codes, etc.)
- `'needs_client_trust'` — new device sign-in without MFA; requires email or phone code verification

```typescript
// TOTP (Authenticator app)
const { error } = await signIn.mfa.verifyTOTP({ code: '123456' })

// Backup code
const { error } = await signIn.mfa.verifyBackupCode({ code: 'backup-code-here' })

// Email code
const { error: sendErr } = await signIn.mfa.sendEmailCode()
const { error: verifyErr } = await signIn.mfa.verifyEmailCode({ code: '123456' })

// Phone code
const { error: sendErr } = await signIn.mfa.sendPhoneCode()
const { error: verifyErr } = await signIn.mfa.verifyPhoneCode({ code: '123456' })
```

## Password Reset

```typescript
// 1. Send reset code
const { error } = await signIn.resetPasswordEmailCode.sendCode()

// 2. Verify the code
const { error } = await signIn.resetPasswordEmailCode.verifyCode({ code: '123456' })

// 3. Submit new password
const { error } = await signIn.resetPasswordEmailCode.submitPassword({
  password: 'newSecurePassword123',
})
```

## Client Trust

When a user signs in with a valid password from a new device without MFA enabled, the sign-in status becomes `needs_client_trust`. This requires an additional verification step:

```typescript
if (signIn.status === 'needs_client_trust') {
  // Check supportedSecondFactors for available methods (email_code or phone_code)
  const factors = signIn.supportedSecondFactors
  // Use the appropriate mfa method to verify
}
```

## Finalizing Sign-In

After successful authentication, call `finalize()` to activate the session:

```typescript
await signIn.finalize({
  navigate: async ({ session, decorateUrl }) => {
    const destination = session.currentTask
      ? `/sign-in/tasks/${session.currentTask.key}`
      : '/'
    const url = decorateUrl(destination)
    // decorateUrl may return an absolute URL for Safari ITP
    if (url.startsWith('http')) {
      window.location.href = url
    } else {
      router.push(url)
    }
  },
})
```

- `decorateUrl(path)` — decorates the URL with session info (required to support Safari's Intelligent Tracking Prevention). May return an absolute URL.
- `session.currentTask` — check for pending session tasks before redirecting

### Reset State

Clear local sign-in state and start over:

```typescript
signIn.reset()
```

## Error Handling

All methods return `Promise<{ error: ClerkError | null }>`. Errors are also available reactively on the hook:

```typescript
const { signIn, errors } = useSignIn()

// Field-level errors
errors?.fields?.identifier // { code, message, longMessage? }
errors?.fields?.password   // { code, message, longMessage? }
errors?.fields?.code       // { code, message, longMessage? }

// Global errors (not tied to a field)
errors?.global // ClerkGlobalHookError[] | null

// Raw error array
errors?.raw // ClerkError[] | null
```

## Complete Example: Email/Password with MFA

From [the docs](https://clerk.com/docs/guides/development/custom-flows/authentication/multi-factor-authentication). Supports SMS verification codes, authenticator app (TOTP), and backup codes.

```tsx
'use client'

import { useSignIn } from '@clerk/nextjs'
import { useRouter } from 'next/navigation'

export default function Page() {
  const { signIn, errors, fetchStatus } = useSignIn()
  const router = useRouter()

  const handleSubmit = async (formData: FormData) => {
    const emailAddress = formData.get('email') as string
    const password = formData.get('password') as string

    await signIn.password({
      emailAddress,
      password,
    })

    // If you're using the authenticator app strategy, remove this check.
    if (signIn.status === 'needs_second_factor') {
      await signIn.mfa.sendPhoneCode()
    }

    if (signIn.status === 'complete') {
      await signIn.finalize({
        navigate: ({ session, decorateUrl }) => {
          if (session?.currentTask) {
            // Handle pending session tasks
            // See https://clerk.com/docs/guides/development/custom-flows/authentication/session-tasks
            console.log(session?.currentTask)
            return
          }

          const url = decorateUrl('/')
          if (url.startsWith('http')) {
            window.location.href = url
          } else {
            router.push(url)
          }
        },
      })
    }
  }

  const handleMFAVerification = async (formData: FormData) => {
    const code = formData.get('code') as string
    const useBackupCode = formData.get('useBackupCode') === 'on'

    if (useBackupCode) {
      await signIn.mfa.verifyBackupCode({ code })
    } else {
      await signIn.mfa.verifyPhoneCode({ code })
      // If you're using the authenticator app strategy, use the following method instead:
      // await signIn.mfa.verifyTOTP({ code })
    }

    if (signIn.status === 'complete') {
      await signIn.finalize({
        navigate: ({ session, decorateUrl }) => {
          if (session?.currentTask) {
            // Handle pending session tasks
            // See https://clerk.com/docs/guides/development/custom-flows/authentication/session-tasks
            console.log(session?.currentTask)
            return
          }

          const url = decorateUrl('/')
          if (url.startsWith('http')) {
            window.location.href = url
          } else {
            router.push(url)
          }
        },
      })
    }
  }

  if (signIn.status === 'needs_second_factor') {
    return (
      <div>
        <h1>Verify your account</h1>
        <form action={handleMFAVerification}>
          <div>
            <label htmlFor="code">Code</label>
            <input id="code" name="code" type="text" />
            {errors.fields.code && <p>{errors.fields.code.message}</p>}
          </div>
          <div>
            <label>
              Use backup code
              <input type="checkbox" name="useBackupCode" />
            </label>
          </div>
          <button type="submit" disabled={fetchStatus === 'fetching'}>
            Verify
          </button>
        </form>
      </div>
    )
  }

  return (
    <>
      <h1>Sign in</h1>
      <form action={handleSubmit}>
        <div>
          <label htmlFor="email">Enter email address</label>
          <input id="email" name="email" type="email" />
          {errors.fields.identifier && <p>{errors.fields.identifier.message}</p>}
        </div>
        <div>
          <label htmlFor="password">Enter password</label>
          <input id="password" name="password" type="password" />
          {errors.fields.password && <p>{errors.fields.password.message}</p>}
        </div>
        <button type="submit" disabled={fetchStatus === 'fetching'}>
          Continue
        </button>
      </form>
      {errors && <p>{JSON.stringify(errors, null, 2)}</p>}
    </>
  )
}
```

## Docs

- [Custom sign-in flow](https://clerk.com/docs/custom-flows/overview)
- [MFA custom flow](https://clerk.com/docs/guides/development/custom-flows/authentication/multi-factor-authentication)
- [useSignIn() reference](https://clerk.com/docs/references/react/use-sign-in)
