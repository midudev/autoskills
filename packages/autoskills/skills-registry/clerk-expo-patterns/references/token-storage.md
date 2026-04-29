# Token Storage

Clerk stores the active session token in memory by default. In native apps, use a persistent token cache so sessions survive app restarts.

## Built-in Cache (Recommended)

```tsx
import { tokenCache } from '@clerk/expo/token-cache'

<ClerkProvider publishableKey={key} tokenCache={tokenCache}>
```

Uses `expo-secure-store` with `keychainAccessible: AFTER_FIRST_UNLOCK`.

Install peer dep: `npx expo install expo-secure-store`

## Custom Cache

Implement the `TokenCache` interface:

```tsx
import * as SecureStore from 'expo-secure-store'
import type { TokenCache } from '@clerk/expo/token-cache'

const tokenCache: TokenCache = {
  async getToken(key: string) {
    try {
      return await SecureStore.getItemAsync(key, {
        keychainAccessible: SecureStore.AFTER_FIRST_UNLOCK,
      })
    } catch {
      await SecureStore.deleteItemAsync(key)
      return null
    }
  },
  saveToken(key: string, token: string) {
    return SecureStore.setItemAsync(key, token, {
      keychainAccessible: SecureStore.AFTER_FIRST_UNLOCK,
    })
  },
}
```

## Expo Web

`expo-secure-store` is not available on web. Provide separate implementations:

```tsx
import { Platform } from 'react-native'
import { tokenCache as nativeCache } from '@clerk/expo/token-cache'

const cache = Platform.OS === 'web' ? undefined : nativeCache
<ClerkProvider tokenCache={cache} ... />
```

## CRITICAL

- `AFTER_FIRST_UNLOCK` means the token is inaccessible until the user unlocks the device at least once after a restart
- Always delete the item on `getToken` error — corrupted keychain entries cause silent auth failures
- Never store tokens in AsyncStorage — it is not encrypted
