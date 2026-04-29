---
title: Avoid isValid with onSubmit Mode for Button State
impact: MEDIUM
impactDescription: prevents validation on every render for button disabled state
tags: formstate, isValid, onSubmit, validation-mode
---

## Avoid isValid with onSubmit Mode for Button State

When using `mode: 'onSubmit'`, accessing `isValid` forces validation on every render to determine the current validity state. This defeats the purpose of deferred validation.

**Incorrect (isValid triggers validation despite onSubmit mode):**

```typescript
function RegistrationForm() {
  const { register, handleSubmit, formState: { isValid } } = useForm({
    mode: 'onSubmit',  // Expects validation only on submit
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', { required: true })} />
      <input {...register('password', { required: true })} />
      <button disabled={!isValid}>Register</button>  {/* Forces validation on every render */}
    </form>
  )
}
```

**Correct (use isSubmitting or allow submit attempt):**

```typescript
function RegistrationForm() {
  const { register, handleSubmit, formState: { isSubmitting } } = useForm({
    mode: 'onSubmit',
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', { required: true })} />
      <input {...register('password', { required: true })} />
      <button disabled={isSubmitting}>
        {isSubmitting ? 'Registering...' : 'Register'}
      </button>
    </form>
  )
}
```

**Alternative (use onChange mode if real-time validation needed):**

```typescript
const { formState: { isValid } } = useForm({
  mode: 'onChange',  // Explicit: validation runs on every change
})
```

Reference: [useForm - mode](https://react-hook-form.com/docs/useform)
