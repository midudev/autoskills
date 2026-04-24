# Content Scripts

## Constraint

Content scripts run in an isolated JavaScript world injected into web pages. They cannot:
- Use Clerk React hooks
- Call Clerk APIs directly (Clerk enforces strict origin restrictions -- content scripts could run on any domain)
- Access the extension's React context

Use message passing to request auth state from the background service worker.

## Pattern: Request Token from Background

`src/content.ts`:
```typescript
async function getToken(): Promise<string | null> {
  return new Promise((resolve) => {
    chrome.runtime.sendMessage({ type: 'GET_TOKEN' }, (response) => {
      resolve(response?.token ?? null)
    })
  })
}

async function isSignedIn(): Promise<boolean> {
  const token = await getToken()
  return token !== null
}

async function injectUI() {
  const signedIn = await isSignedIn()

  if (!signedIn) {
    console.log('User not signed in, skipping injection')
    return
  }

  const overlay = document.createElement('div')
  overlay.id = 'my-extension-overlay'
  document.body.appendChild(overlay)
}

injectUI()
```

`src/background/index.ts`:
```typescript
import { createClerkClient } from '@clerk/chrome-extension/client'

const publishableKey = process.env.PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY

async function getToken(): Promise<string | null> {
  const clerk = await createClerkClient({ publishableKey, background: true })
  if (!clerk.session) return null
  return await clerk.session.getToken()
}

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.type === 'GET_TOKEN') {
    getToken()
      .then((token) => sendResponse({ token }))
      .catch(() => sendResponse({ token: null }))
    return true
  }
})
```

## Pattern: Authenticated Fetch from Content Script

```typescript
// content.ts
async function fetchUserData() {
  const token = await getToken()
  if (!token) return null

  const res = await fetch('https://api.yourapp.com/me', {
    headers: { Authorization: `Bearer ${token}` },
  })

  return res.json()
}
```

## Manifest Permissions

`package.json` (Plasmo):
```json
{
  "manifest": {
    "permissions": ["storage", "tabs"],
    "host_permissions": ["<all_urls>"]
  }
}
```

For content scripts on specific domains only:
```json
{
  "manifest": {
    "permissions": ["storage"],
    "host_permissions": ["https://specific-site.com/*"]
  }
}
```

## Content Script Registration (Plasmo)

A file named `content.ts` or `content.tsx` at the project root is auto-registered as a content script matching all URLs.

For multiple content scripts with different match patterns, use `package.json`:
```json
{
  "manifest": {
    "content_scripts": [
      {
        "matches": ["https://specific-site.com/*"],
        "js": ["content.js"]
      }
    ]
  }
}
```

## Why Clerk Can't Be Used Directly in Content Scripts

Clerk enforces strict allowed origins for API requests. A content script can be injected into any domain (e.g., `https://github.com`, `https://google.com`). There is no way to add all possible domains to Clerk's allowed origins, so direct Clerk usage in content scripts is blocked by design.

[Docs](https://clerk.com/docs/chrome-extension/getting-started/quickstart)
