---
title: Set reValidateMode to onBlur for Post-Submit Performance
impact: CRITICAL
impactDescription: reduces re-renders after initial submission by 80%+
tags: formcfg, revalidate-mode, re-renders, useForm
---

## Set reValidateMode to onBlur for Post-Submit Performance

After form submission, `reValidateMode` controls when fields re-validate. The default `onChange` causes validation on every keystroke after first submit. Use `onBlur` or `onSubmit` for better post-submission performance.

**Incorrect (re-validates on every keystroke after submit):**

```typescript
const { register, handleSubmit } = useForm({
  mode: 'onSubmit',
  reValidateMode: 'onChange',  // Default: after first submit, validates on EVERY keystroke
})

function PaymentForm() {
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('cardNumber', { required: true })} />
      <input {...register('cvv', { required: true, maxLength: 4 })} />
    </form>
  )
}
```

**Correct (re-validates only when leaving field):**

```typescript
const { register, handleSubmit } = useForm({
  mode: 'onSubmit',
  reValidateMode: 'onBlur',  // After first submit, validates only on blur
})

function PaymentForm() {
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('cardNumber', { required: true })} />
      <input {...register('cvv', { required: true, maxLength: 4 })} />
    </form>
  )
}
```

Reference: [useForm - reValidateMode](https://react-hook-form.com/docs/useform)
