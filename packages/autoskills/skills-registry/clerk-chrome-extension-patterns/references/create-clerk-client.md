# createClerkClient() -- Vanilla JS and Service Workers

## When to Use

Use `createClerkClient()` when:
- Your extension doesn't use React
- You need Clerk in a background service worker
- You need Clerk in a content script context (via message passing from background)
- You want to keep sessions fresh without a visible popup

Import from `@clerk/chrome-extension/client`, NOT from `@clerk/chrome-extension`.

## Background Service Worker

The key option is `background: true`. This tells Clerk to refresh the session token continuously, even when no popup or side panel is open. Without it, tokens expire after 60 seconds of the UI being closed.

`src/background/index.ts`:
```typescript
import { createClerkClient } from '@clerk/chrome-extension/client'

const publishableKey = process.env.PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY

if (!publishableKey) {
  throw new Error('Missing PLASMO_PUBLIC_CLERK_PUBLISHABLE_KEY')
}

async function getToken(): Promise<string | null> {
  const clerk = await createClerkClient({
    publishableKey,
    background: true,
  })

  if (!clerk.session) return null

  return await clerk.session.getToken()
}

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  getToken()
    .then((token) => sendResponse({ token }))
    .catch((error) => {
      console.error('[Background service worker] Error:', JSON.stringify(error))
      sendResponse({ token: null })
    })
  return true
})
```

The listener MUST `return true` to keep the message channel open for the async `sendResponse` call.

## Requesting the Token from a Tab or Content Script

```typescript
// tabs/my-tab.tsx or a content script
async function getTokenFromBackground(): Promise<string | null> {
  return new Promise((resolve) => {
    chrome.runtime.sendMessage({ type: 'GET_TOKEN' }, (response) => {
      resolve(response?.token ?? null)
    })
  })
}

async function makeAuthenticatedRequest() {
  const token = await getTokenFromBackground()
  if (!token) {
    console.warn('User not signed in')
    return
  }

  const res = await fetch('https://api.example.com/me', {
    headers: { Authorization: `Bearer ${token}` },
  })

  return res.json()
}
```

## Vanilla JS Popup (no React)

For popups or side panels that use plain TypeScript instead of React:

`src/popup.ts`:
```typescript
import { createClerkClient } from '@clerk/chrome-extension/client'

const publishableKey = process.env.CLERK_PUBLISHABLE_KEY
const EXTENSION_URL = chrome.runtime.getURL('.')
const POPUP_URL = `${EXTENSION_URL}popup.html`

const clerk = createClerkClient({ publishableKey })
const contentEl = document.getElementById('content') as HTMLDivElement

function render() {
  const email = clerk.user?.primaryEmailAddress?.emailAddress
  contentEl.textContent = email ?? 'Not signed in'
}

clerk.load({
  afterSignOutUrl: POPUP_URL,
  signInForceRedirectUrl: POPUP_URL,
  signUpForceRedirectUrl: POPUP_URL,
  allowedRedirectProtocols: ['chrome-extension:'],
}).then(() => {
  clerk.addListener(render)
  render()
})
```

`allowedRedirectProtocols: ['chrome-extension:']` is required to allow redirects to `chrome-extension://` URLs.

## createClerkClient() Options

| Option | Type | Description |
|--------|------|-------------|
| `publishableKey` | `string` | Required. Your Clerk publishable key. |
| `background` | `boolean` | Set `true` in service workers to keep sessions fresh. |
| `syncHost` | `string` | The web app domain to sync auth from (headless extensions). |

## Making Authenticated API Calls from Background

```typescript
async function callMyAPI() {
  const clerk = await createClerkClient({ publishableKey, background: true })

  if (!clerk.session) return

  const token = await clerk.session.getToken()

  const res = await fetch('https://api.yourapp.com/data', {
    headers: { Authorization: `Bearer ${token}` },
  })

  return res.json()
}
```

## Docs

[createClerkClient() reference](https://clerk.com/docs/reference/chrome-extension/create-clerk-client)
