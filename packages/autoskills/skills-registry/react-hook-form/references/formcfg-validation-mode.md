---
title: Use onSubmit Mode for Optimal Performance
impact: CRITICAL
impactDescription: prevents re-renders on every keystroke
tags: formcfg, validation-mode, re-renders, useForm
---

## Use onSubmit Mode for Optimal Performance

The `mode` option in useForm determines when validation runs. Using `onChange` mode triggers validation on every keystroke, causing significant re-renders. Default to `onSubmit` unless real-time feedback is essential.

**Incorrect (validates on every keystroke):**

```typescript
const { register, handleSubmit, formState: { errors } } = useForm({
  mode: 'onChange',  // Triggers validation + re-render on EVERY input change
})

function RegistrationForm() {
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', { required: true, pattern: /^\S+@\S+$/i })} />
      {errors.email && <span>{errors.email.message}</span>}
    </form>
  )
}
```

**Correct (validates only on submit):**

```typescript
const { register, handleSubmit, formState: { errors } } = useForm({
  mode: 'onSubmit',  // Default: validates only when form is submitted
})

function RegistrationForm() {
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', { required: true, pattern: /^\S+@\S+$/i })} />
      {errors.email && <span>{errors.email.message}</span>}
    </form>
  )
}
```

**When to use other modes:**
- `onBlur`: Validate when user leaves a field (good balance of UX and performance)
- `onTouched`: Like `onBlur` but only after first interaction
- `onChange`: Only when real-time validation feedback is critical (use sparingly)

Reference: [useForm - mode](https://react-hook-form.com/docs/useform)
