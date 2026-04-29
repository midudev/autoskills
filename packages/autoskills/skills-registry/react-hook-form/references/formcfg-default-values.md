---
title: Always Provide defaultValues for Form Initialization
impact: CRITICAL
impactDescription: prevents undefined state bugs and enables reset() functionality
tags: formcfg, default-values, initialization, useForm
---

## Always Provide defaultValues for Form Initialization

Omitting `defaultValues` causes undefined state conflicts with controlled components and breaks `reset()` functionality. Always provide explicit defaults, using empty strings instead of undefined.

**Incorrect (no defaultValues, breaks reset and controlled components):**

```typescript
const { register, reset, handleSubmit } = useForm()

function ProfileForm({ user }: { user: User }) {
  useEffect(() => {
    reset(user)  // reset() won't restore to "initial" state without defaultValues
  }, [user, reset])

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('firstName')} />  {/* undefined initial value */}
      <input {...register('lastName')} />
    </form>
  )
}
```

**Correct (explicit defaultValues enable proper reset):**

```typescript
const { register, reset, handleSubmit } = useForm({
  defaultValues: {
    firstName: '',
    lastName: '',
  },
})

function ProfileForm({ user }: { user: User }) {
  useEffect(() => {
    reset(user)  // reset() properly restores to defaultValues when called without args
  }, [user, reset])

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('firstName')} />
      <input {...register('lastName')} />
    </form>
  )
}
```

**Note:** Avoid using custom objects with prototype methods (Moment, Luxon) as defaultValues. Use plain objects or primitives.

Reference: [useForm - defaultValues](https://react-hook-form.com/docs/useform)
