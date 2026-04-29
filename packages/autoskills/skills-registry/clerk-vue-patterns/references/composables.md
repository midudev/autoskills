# Composables

All composables come from `@clerk/vue`.

## useAuth

```ts
import { useAuth } from '@clerk/vue'

const { isSignedIn, isLoaded, userId, sessionId, signOut, getToken } = useAuth()
```

| Property | Type | Description |
|----------|------|-------------|
| `isSignedIn` | `Ref<boolean>` | True when user is authenticated |
| `isLoaded` | `Ref<boolean>` | True when Clerk has initialized |
| `userId` | `Ref<string \| null>` | Current user ID |
| `sessionId` | `Ref<string \| null>` | Current session ID |
| `signOut()` | `function` | Sign out and clear session |
| `getToken()` | `async function` | Get JWT for external APIs |

## useUser

```ts
import { useUser } from '@clerk/vue'

const { user, isLoaded } = useUser()
```

`user` is `Ref<UserResource | null>` with `.firstName`, `.lastName`, `.fullName`, `.imageUrl`, `.primaryEmailAddress`, etc.

## useClerk

```ts
import { useClerk } from '@clerk/vue'

const clerk = useClerk()
await clerk.value.openSignIn()
await clerk.value.openUserProfile()
```

Use for programmatic UI control (open modals, redirect, etc.).

## useOrganization

```ts
import { useOrganization } from '@clerk/vue'

const { organization, membership, isLoaded } = useOrganization()
```

`organization` is `Ref<Organization | null>`. `membership` includes `role`.

## useOrganizationList

```ts
import { useOrganizationList } from '@clerk/vue'

const { userMemberships, setActive } = useOrganizationList()
```

`userMemberships.data` is an array of memberships. Call `setActive({ organization: id })` to switch.

## useSignIn / useSignUp

```ts
import { useSignIn } from '@clerk/vue'

const { signIn, setActive, isLoaded } = useSignIn()

async function submit(email: string, password: string) {
  const result = await signIn.value!.create({
    identifier: email,
    password,
  })
  if (result.status === 'complete') {
    await setActive.value!({ session: result.createdSessionId })
  }
}
```

## CRITICAL

- All composables return refs — access values with `.value` outside of templates
- Check `isLoaded` before rendering auth-gated UI to prevent flashes
- `useOrganizationList` returns `userMemberships` as a paginated resource — access `.data` for the array
