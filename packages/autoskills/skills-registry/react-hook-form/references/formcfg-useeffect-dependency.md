---
title: Avoid useForm Return Object in useEffect Dependencies
impact: CRITICAL
impactDescription: prevents infinite render loops
tags: formcfg, useEffect, dependencies, infinite-loop
---

## Avoid useForm Return Object in useEffect Dependencies

Adding the entire useForm return object to a useEffect dependency array causes infinite loops. Destructure only the specific methods you need.

**Incorrect (entire form object causes infinite loop):**

```typescript
function ContactForm({ defaultEmail }: { defaultEmail: string }) {
  const form = useForm({
    defaultValues: { email: '' },
  })

  useEffect(() => {
    form.reset({ email: defaultEmail })
  }, [form, defaultEmail])  // form reference changes on every render = infinite loop

  return (
    <form onSubmit={form.handleSubmit(onSubmit)}>
      <input {...form.register('email')} />
    </form>
  )
}
```

**Correct (destructure specific stable methods):**

```typescript
function ContactForm({ defaultEmail }: { defaultEmail: string }) {
  const { register, handleSubmit, reset } = useForm({
    defaultValues: { email: '' },
  })

  useEffect(() => {
    reset({ email: defaultEmail })
  }, [reset, defaultEmail])  // reset is stable, no infinite loop

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
    </form>
  )
}
```

**Note:** In a future major release, useForm return will be memoized. Until then, always destructure.

Reference: [useForm](https://react-hook-form.com/docs/useform)
