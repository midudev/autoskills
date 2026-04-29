# Composables (HIGH)

All composables are auto-imported by `@clerk/nuxt` — no import statements needed in `<script setup>`.

## useAuth()

Returns reactive auth state and helpers:

```vue
<script setup lang="ts">
const { isSignedIn, isLoaded, userId, sessionId, orgId, orgRole, orgSlug } = useAuth()
</script>

<template>
  <div v-if="!isLoaded">Loading...</div>
  <div v-else-if="!isSignedIn">Please sign in</div>
  <div v-else>Hello {{ userId }}</div>
</template>
```

## useUser()

Returns the full user object with profile data:

```vue
<script setup lang="ts">
const { isLoaded, isSignedIn, user } = useUser()
</script>

<template>
  <div v-if="isLoaded && isSignedIn">
    <img :src="user.imageUrl" :alt="user.fullName" />
    <p>{{ user.firstName }} {{ user.lastName }}</p>
    <p>{{ user.emailAddresses[0]?.emailAddress }}</p>
  </div>
</template>
```

## useClerk()

Access the Clerk instance for programmatic actions:

```vue
<script setup lang="ts">
const clerk = useClerk()

function handleSignOut() {
  clerk.signOut()
}

function openProfile() {
  clerk.openUserProfile()
}
</script>
```

## useSignIn() / useSignUp()

For custom auth flows:

```vue
<script setup lang="ts">
const { signIn, setActive } = useSignIn()

async function handleLogin(email: string, password: string) {
  const result = await signIn.create({
    identifier: email,
    password,
  })

  if (result.status === 'complete') {
    await setActive({ session: result.createdSessionId })
    navigateTo('/dashboard')
  }
}
</script>
```

## Ref vs Value

Composables return `Ref<T>` values. Access with `.value` in `<script setup>` but NOT in templates:

```vue
<script setup lang="ts">
const { isSignedIn, userId } = useAuth()
// In script: isSignedIn.value, userId.value
</script>

<template>
  <!-- In template: no .value needed -->
  <div v-if="isSignedIn">{{ userId }}</div>
</template>
```

[Docs](https://clerk.com/docs/nuxt/getting-started/quickstart)
