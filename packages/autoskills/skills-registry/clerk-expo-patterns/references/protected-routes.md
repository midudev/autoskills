# Protected Routes (Expo Router)

## Layout-Level Guard

Protect an entire group in `app/(auth)/_layout.tsx`:

```tsx
import { useAuth } from '@clerk/expo'
import { Redirect, Stack } from 'expo-router'

export default function AuthLayout() {
  const { isSignedIn, isLoaded } = useAuth()

  if (!isLoaded) return null

  if (!isSignedIn) return <Redirect href="/sign-in" />

  return <Stack />
}
```

## Screen-Level Guard

For a single screen:

```tsx
import { useAuth } from '@clerk/expo'
import { Redirect } from 'expo-router'
import { View, Text } from 'react-native'

export default function ProfileScreen() {
  const { isSignedIn, isLoaded, userId } = useAuth()

  if (!isLoaded) return null
  if (!isSignedIn) return <Redirect href="/sign-in" />

  return (
    <View>
      <Text>User: {userId}</Text>
    </View>
  )
}
```

## Recommended File Structure

```
app/
├── _layout.tsx           # Root layout with ClerkProvider
├── (public)/
│   ├── sign-in.tsx
│   └── sign-up.tsx
└── (protected)/
    ├── _layout.tsx       # Auth guard here
    ├── (tabs)/
    │   ├── _layout.tsx
    │   ├── home.tsx
    │   └── profile.tsx
    └── settings.tsx
```

## CRITICAL

- Always check `isLoaded` before checking `isSignedIn` — Clerk needs time to restore the session from the token cache
- Returning `null` while loading prevents a flash of the sign-in screen
- Use `<Redirect>` from `expo-router`, not `router.push` in effects, to avoid React render warnings
