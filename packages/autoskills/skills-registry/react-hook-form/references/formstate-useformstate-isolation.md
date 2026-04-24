---
title: Use useFormState for Isolated State Subscriptions
impact: MEDIUM
impactDescription: prevents parent re-renders from state access in children
tags: formstate, useFormState, isolation, re-renders
---

## Use useFormState for Isolated State Subscriptions

useFormState allows subscribing to form state in child components without causing parent re-renders. Each useFormState instance is isolated and doesn't affect other subscribers.

**Incorrect (formState at root re-renders entire form):**

```typescript
function ContactForm() {
  const { register, handleSubmit, formState: { errors, isDirty } } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', { required: true })} />
      {errors.email && <span>Email required</span>}  {/* Re-renders all on any state change */}
      <input {...register('message')} />
      <SaveIndicator isDirty={isDirty} />  {/* Prop drilling */}
    </form>
  )
}
```

**Correct (useFormState isolates subscriptions):**

```typescript
function ContactForm() {
  const { register, handleSubmit, control } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <EmailField register={register} control={control} />
      <input {...register('message')} />
      <SaveIndicator control={control} />  {/* Isolated subscription */}
    </form>
  )
}

function EmailField({ register, control }: EmailFieldProps) {
  const { errors } = useFormState({ control, name: 'email' })

  return (
    <div>
      <input {...register('email', { required: true })} />
      {errors.email && <span>Email required</span>}
    </div>
  )
}

function SaveIndicator({ control }: { control: Control }) {
  const { isDirty } = useFormState({ control })

  return isDirty ? <span>Unsaved changes</span> : null
}
```

Reference: [useFormState](https://react-hook-form.com/docs/useformstate)
