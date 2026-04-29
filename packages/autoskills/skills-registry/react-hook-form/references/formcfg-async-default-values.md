---
title: Use Async defaultValues for Server Data
impact: CRITICAL
impactDescription: eliminates manual useEffect reset patterns
tags: formcfg, async, default-values, data-fetching
---

## Use Async defaultValues for Server Data

React Hook Form supports async functions for `defaultValues`, eliminating the need for manual useEffect + reset() patterns when loading initial data from an API.

**Incorrect (manual useEffect reset pattern):**

```typescript
function EditUserForm({ userId }: { userId: string }) {
  const { register, reset, handleSubmit, formState: { isLoading } } = useForm({
    defaultValues: {
      email: '',
      name: '',
    },
  })

  useEffect(() => {
    async function loadUser() {
      const user = await fetchUser(userId)
      reset(user)  // Manual reset required
    }
    loadUser()
  }, [userId, reset])

  if (isLoading) return <Spinner />

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <input {...register('name')} />
    </form>
  )
}
```

**Correct (async defaultValues handles loading automatically):**

```typescript
function EditUserForm({ userId }: { userId: string }) {
  const { register, handleSubmit, formState: { isLoading } } = useForm({
    defaultValues: async () => {
      const user = await fetchUser(userId)
      return {
        email: user.email,
        name: user.name,
      }
    },
  })

  if (isLoading) return <Spinner />

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <input {...register('name')} />
    </form>
  )
}
```

**Note:** defaultValues are cached after initial load. Use `reset()` with new values if you need to refresh data.

Reference: [useForm - defaultValues](https://react-hook-form.com/docs/useform)
