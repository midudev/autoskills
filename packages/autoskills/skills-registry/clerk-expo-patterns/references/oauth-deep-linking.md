# OAuth Deep Linking

## Prerequisites

1. Add scheme to `app.json`:

```json
{
  "expo": {
    "scheme": "myapp"
  }
}
```

2. Install deps: `npx expo install expo-web-browser expo-auth-session`

## OAuth with useSSO

```tsx
import { useSSO } from '@clerk/expo'
import * as WebBrowser from 'expo-web-browser'
import { useEffect } from 'react'

WebBrowser.maybeCompleteAuthSession()

export function SignInScreen() {
  const { startSSOFlow } = useSSO()

  const handleGoogle = async () => {
    try {
      const { createdSessionId, setActive, signIn, signUp } = await startSSOFlow({
        strategy: 'oauth_google',
        redirectUrl: 'myapp://oauth-callback',
      })

      if (createdSessionId) {
        await setActive!({ session: createdSessionId })
      } else if (signUp?.status === 'missing_requirements') {
        // Handle missing fields (e.g. username)
      }
    } catch (err) {
      console.error(err)
    }
  }

  return <Button onPress={handleGoogle} title="Sign in with Google" />
}
```

## Supported Strategies

| Provider | Strategy |
|----------|----------|
| Google | `oauth_google` |
| Apple | `oauth_apple` |
| GitHub | `oauth_github` |
| Microsoft | `oauth_microsoft` |
| Facebook | `oauth_facebook` |

## Callback Screen

Create `app/oauth-callback.tsx`:

```tsx
import { useEffect } from 'react'
import * as WebBrowser from 'expo-web-browser'

WebBrowser.maybeCompleteAuthSession()

export default function OAuthCallback() {
  return null
}
```

## CRITICAL

- `WebBrowser.maybeCompleteAuthSession()` must be called at the TOP LEVEL of the callback screen (not inside a hook or effect)
- `redirectUrl` must match the scheme in `app.json` exactly
- `useSSO` replaces `useOAuth` from older `@clerk/expo` versions
