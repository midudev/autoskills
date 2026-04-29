# Custom Sign-Up Flow

Build a custom sign-up experience using the `useSignUp()` hook.

## Hook API

```typescript
import { useSignUp } from '@clerk/nextjs' // or @clerk/react, @clerk/expo

const { signUp, errors, fetchStatus } = useSignUp()
```

| Property | Type | Description |
|----------|------|-------------|
| `signUp` | `SignUpFuture` | Sign-up object with namespaced methods |
| `errors` | `Errors<SignUpFields>` | Structured error object |
| `fetchStatus` | `'idle' \| 'fetching'` | Network request status |

## Sign-Up Methods

### Password (Email/Password)

```typescript
const { error } = await signUp.password({
  emailAddress: 'user@example.com',
  password: 'securePassword123',
  firstName: 'Jane',  // optional
  lastName: 'Doe',    // optional
})
```

### SSO (OAuth)

```typescript
const { error } = await signUp.sso({
  strategy: 'oauth_google', // or 'oauth_github', etc.
  redirectUrl: '/dashboard', // where to go after SSO completes
  redirectCallbackUrl: '/sso-callback', // intermediate callback route
})
```

### Web3

```typescript
const { error } = await signUp.web3({ strategy: 'web3_solana_signature' })
```

### Update (add fields to existing sign-up)

Use `update()` to add optional fields (name, metadata, legal acceptance, locale) to an existing sign-up before finalization.

```typescript
const { error } = await signUp.update({
  firstName: 'Jane',
  lastName: 'Doe',
  unsafeMetadata: { referralSource: 'twitter' },
  legalAccepted: true,
})
```

## Email / Phone Verification

After creating a sign-up, verify the user's email or phone:

### Email Code

```typescript
// Send verification code
const { error } = await signUp.verifications.sendEmailCode()

// Verify the code
const { error } = await signUp.verifications.verifyEmailCode({ code: '123456' })
```

### Phone Code

```typescript
// Send verification code
const { error } = await signUp.verifications.sendPhoneCode()

// Verify the code
const { error } = await signUp.verifications.verifyPhoneCode({ code: '123456' })
```

### Email Link

```typescript
// verificationUrl: where the user lands after clicking the email link (relative or absolute)
const { error } = await signUp.verifications.sendEmailLink({ verificationUrl: '/verify' })
// User clicks the link in their email to verify
```

## Finalizing Sign-Up

After successful sign-up and verification, call `finalize()` to activate the session:

```typescript
await signUp.finalize({
  navigate: async ({ session, decorateUrl }) => {
    const destination = session.currentTask
      ? `/sign-up/tasks/${session.currentTask.key}`
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

### Transferable Sign-Ups

If `signUp.isTransferable` is `true`, the identifier matches an existing user and the sign-up should be transferred to a sign-in flow. This involves coordinating between sign-up and sign-in resources. See the [transferable sign-up docs](https://clerk.com/docs/custom-flows/overview) for the full implementation.

### Reset State

Clear local sign-up state and start over:

```typescript
signUp.reset()
```

## Error Handling

All methods return `Promise<{ error: ClerkError | null }>`. Errors are also available reactively on the hook:

```typescript
const { signUp, errors } = useSignUp()

// Field-level errors
errors?.fields?.emailAddress // { code, message, longMessage? }
errors?.fields?.password     // { code, message, longMessage? }
errors?.fields?.firstName    // { code, message, longMessage? }
errors?.fields?.lastName     // { code, message, longMessage? }
errors?.fields?.phoneNumber  // { code, message, longMessage? }
errors?.fields?.username     // { code, message, longMessage? }
errors?.fields?.code         // { code, message, longMessage? }

// Global errors
errors?.global // ClerkGlobalHookError[] | null

// Raw error array
errors?.raw // ClerkError[] | null
```

## Complete Example: Phone OTP Sign-Up

From [the docs](https://clerk.com/docs/guides/development/custom-flows/authentication/email-sms-otp). Uses phone OTP with inline comments for adapting to email OTP.

```tsx
'use client'

import * as React from 'react'
import { useAuth, useSignUp } from '@clerk/nextjs'
import { useRouter } from 'next/navigation'

export default function SignUpPage() {
  const { signUp, errors, fetchStatus } = useSignUp()
  const { isSignedIn } = useAuth()
  const router = useRouter()

  const handleSubmit = async (formData: FormData) => {
    // For email OTP: collect the email address instead of the phone number
    const phoneNumber = formData.get('phoneNumber') as string

    // For email OTP: change create({ phoneNumber }) to create({ emailAddress })
    const error = await signUp.create({ phoneNumber })

    // For email OTP: change sendPhoneCode() to sendEmailCode()
    if (!error) await signUp.verifications.sendPhoneCode()
  }

  const handleVerify = async (formData: FormData) => {
    const code = formData.get('code') as string

    // For email OTP: change verifyPhoneCode() to verifyEmailCode()
    await signUp.verifications.verifyPhoneCode({ code })

    if (signUp.status === 'complete') {
      await signUp.finalize({
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

  if (signUp.status === 'complete' || isSignedIn) {
    return null
  }

  if (
    signUp.status === 'missing_requirements' &&
    // For email OTP: check for phone_number instead of email_address
    signUp.unverifiedFields.includes('phone_number') &&
    signUp.missingFields.length === 0
  ) {
    return (
      <>
        <h1>Verify your account</h1>
        <form action={handleVerify}>
          <div>
            <label htmlFor="code">Code</label>
            <input id="code" name="code" type="text" />
          </div>
          {errors.fields.code && <p>{errors.fields.code.message}</p>}
          <button type="submit" disabled={fetchStatus === 'fetching'}>
            Verify
          </button>
        </form>
        {/* For email OTP: change sendPhoneCode() to sendEmailCode() */}
        <button onClick={() => signUp.verifications.sendPhoneCode()}>I need a new code</button>
      </>
    )
  }

  return (
    <>
      <h1>Sign up</h1>
      <form action={handleSubmit}>
        {/* For email OTP: collect the emailAddress instead */}
        <div>
          <label htmlFor="phoneNumber">Phone number</label>
          <input id="phoneNumber" name="phoneNumber" type="tel" />
          {errors.fields.phoneNumber && <p>{errors.fields.phoneNumber.message}</p>}
        </div>
        <button type="submit" disabled={fetchStatus === 'fetching'}>
          Continue
        </button>
      </form>
      {errors && <p>{JSON.stringify(errors, null, 2)}</p>}

      {/* Required for sign-up flows. Clerk's bot sign-up protection is enabled by default */}
      <div id="clerk-captcha" />
    </>
  )
}
```

## Docs

- [Custom sign-up flow](https://clerk.com/docs/custom-flows/overview)
- [Email/phone OTP custom flow](https://clerk.com/docs/guides/development/custom-flows/authentication/email-sms-otp)
- [useSignUp() reference](https://clerk.com/docs/references/react/use-sign-up)
