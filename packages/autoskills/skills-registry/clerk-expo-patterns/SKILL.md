---
name: clerk-expo-patterns
description: 'Expo / React Native patterns with Clerk — SecureStore token cache, OAuth
  deep linking, useAuth in native, Expo Router protected routes, push notifications
  with user context. Triggers on: expo clerk, clerk react native, SecureStore token
  cache, expo router auth, OAuth deep link clerk, mobile auth clerk.'
license: MIT
allowed-tools: WebFetch
metadata:
  author: clerk
  version: 1.0.0
compatibility: Requires Expo CLI and expo-secure-store package
---

# Expo Patterns

SDK: `@clerk/expo` v3+. Requires Expo 53+, React Native 0.73+.

## What Do You Need?

| Task | Reference |
|------|-----------|
| Persist tokens with SecureStore | references/token-storage.md |
| OAuth (Google, Apple, GitHub) | references/oauth-deep-linking.md |
| Protected screens with Expo Router | references/protected-routes.md |
| Push notifications with user data | references/push-notifications.md |

## Mental Model

Clerk stores the session token in memory by default. In native apps:

- **SecureStore** — encrypt token in device keychain (recommended for production)
- **`tokenCache`** — prop on `<ClerkProvider>` that provides custom storage
- **`useAuth`** — same API as web, works in any component
- **OAuth** — requires `useSSO` + deep link scheme configured in `app.json`

## Minimal Setup

### app/_layout.tsx

```tsx
import { ClerkProvider } from '@clerk/expo'
import { tokenCache } from '@clerk/expo/token-cache'
import { Stack } from 'expo-router'

const publishableKey = process.env.EXPO_PUBLIC_CLERK_PUBLISHABLE_KEY!

export default function RootLayout() {
  return (
    <ClerkProvider publishableKey={publishableKey} tokenCache={tokenCache}>
      <Stack />
    </ClerkProvider>
  )
}
```

> **CRITICAL**: Use `EXPO_PUBLIC_CLERK_PUBLISHABLE_KEY` — not `NEXT_PUBLIC_`. Env vars inside `node_modules` are not inlined in production builds. Always pass `publishableKey` explicitly.

## Built-in Token Cache

```tsx
import { tokenCache } from '@clerk/expo/token-cache'
```

This uses `expo-secure-store` with `keychainAccessible: AFTER_FIRST_UNLOCK`. Install the peer dep:

```bash
npx expo install expo-secure-store
```

## Auth Hooks

```tsx
import { useAuth, useUser, useSignIn, useSignUp, useClerk } from '@clerk/expo'

export function ProfileScreen() {
  const { isSignedIn, userId, signOut } = useAuth()
  const { user } = useUser()

  if (!isSignedIn) return <Redirect href="/sign-in" />
  return (
    <View>
      <Text>{user?.fullName}</Text>
      <Button title="Sign Out" onPress={() => signOut()} />
    </View>
  )
}
```

## OAuth Flow (Google)

```tsx
import { useSSO } from '@clerk/expo'
import * as WebBrowser from 'expo-web-browser'

WebBrowser.maybeCompleteAuthSession()

export function GoogleSignIn() {
  const { startSSOFlow } = useSSO()

  const handlePress = async () => {
    try {
      const { createdSessionId, setActive } = await startSSOFlow({
        strategy: 'oauth_google',
        redirectUrl: 'myapp://oauth-callback',
      })
      if (createdSessionId) await setActive!({ session: createdSessionId })
    } catch (err) {
      console.error(err)
    }
  }

  return <Button title="Continue with Google" onPress={handlePress} />
}
```

## Org Switching

```tsx
import { useOrganization, useOrganizationList } from '@clerk/expo'

export function OrgSwitcher() {
  const { organization } = useOrganization()
  const { setActive, userMemberships } = useOrganizationList()

  return (
    <View>
      <Text>Current: {organization?.name ?? 'Personal'}</Text>
      {userMemberships.data?.map(mem => (
        <Button
          key={mem.organization.id}
          title={mem.organization.name}
          onPress={() => setActive({ organization: mem.organization.id })}
        />
      ))}
    </View>
  )
}
```

## Common Pitfalls

| Symptom | Cause | Fix |
|---------|-------|-----|
| `publishableKey` undefined in prod | Using env var without `EXPO_PUBLIC_` | Rename to `EXPO_PUBLIC_CLERK_PUBLISHABLE_KEY` |
| Token lost on app restart | No `tokenCache` | Pass `tokenCache` from `@clerk/expo/token-cache` |
| OAuth redirect not working | Missing scheme in `app.json` | Add `"scheme": "myapp"` to `app.json` |
| `WebBrowser.maybeCompleteAuthSession` | Not called | Call it at the top level of the OAuth callback screen |
| `useSSO` not found | Old `@clerk/expo` version | `useSSO` replaced `useOAuth` in v3+ |

## Import Map

| What | Import From |
|------|-------------|
| `ClerkProvider` | `@clerk/expo` |
| `tokenCache` | `@clerk/expo/token-cache` |
| `useAuth`, `useUser`, `useSignIn` | `@clerk/expo` |
| `useSSO` | `@clerk/expo` |
| `useOrganization`, `useOrganizationList` | `@clerk/expo` |

## See Also

- `clerk-setup` - Initial Clerk install
- `clerk-custom-ui` - Custom flows & appearance
- `clerk-orgs` - B2B organizations

## Docs

[Expo SDK](https://clerk.com/docs/expo/getting-started/quickstart)
