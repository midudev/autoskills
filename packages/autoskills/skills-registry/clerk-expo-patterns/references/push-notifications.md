# Push Notifications with User Context

Store the Expo push token against the Clerk user using `publicMetadata` or your own database.

## Register Push Token After Sign-In

```tsx
import { useUser } from '@clerk/expo'
import * as Notifications from 'expo-notifications'
import { useEffect } from 'react'

export function PushTokenRegistrar() {
  const { user, isLoaded } = useUser()

  useEffect(() => {
    if (!isLoaded || !user) return

    async function register() {
      const { status } = await Notifications.requestPermissionsAsync()
      if (status !== 'granted') return

      const token = (await Notifications.getExpoPushTokenAsync()).data

      await user.update({
        unsafeMetadata: {
          ...user.unsafeMetadata,
          expoPushToken: token,
        },
      })
    }

    register()
  }, [isLoaded, user])

  return null
}
```

> Use `unsafeMetadata` for client-writable data. Use `publicMetadata` (server-only write) for verified data.

## Send Notification to User (Server)

```tsx
import { clerkClient } from '@clerk/nextjs/server'

async function sendNotification(userId: string, title: string, body: string) {
  const client = await clerkClient()
  const user = await client.users.getUser(userId)
  const token = user.unsafeMetadata?.expoPushToken as string | undefined

  if (!token) return

  await fetch('https://exp.host/--/api/v2/push/send', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ to: token, title, body }),
  })
}
```

## CRITICAL

- `user.update()` is client-side — it writes `unsafeMetadata` without server auth
- For verified/sensitive data, use the Clerk Backend SDK from your server to write `publicMetadata`
- Re-register the push token if `user.id` changes (org switch does not change user.id, but sign-out/sign-in as different user does)
