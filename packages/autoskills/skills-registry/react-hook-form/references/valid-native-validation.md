---
title: Consider Native Validation for Simple Forms
impact: MEDIUM
impactDescription: reduces JavaScript validation overhead for basic constraints
tags: valid, native-validation, browser, performance
---

## Consider Native Validation for Simple Forms

For simple forms with basic constraints (required, minLength, pattern), browser-native validation eliminates JavaScript validation overhead. Enable with `shouldUseNativeValidation`.

**Incorrect (JavaScript validates simple constraints):**

```typescript
function NewsletterForm() {
  const { register, handleSubmit, formState: { errors } } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register('email', {
          required: 'Email required',
          pattern: { value: /^\S+@\S+$/i, message: 'Invalid email' },
        })}
        type="email"
      />
      {errors.email && <span>{errors.email.message}</span>}
      <button type="submit">Subscribe</button>
    </form>
  )
}
```

**Correct (browser handles validation natively):**

```typescript
function NewsletterForm() {
  const { register, handleSubmit } = useForm({
    shouldUseNativeValidation: true,
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register('email', { required: true })}
        type="email"  // Browser validates email format
        required  // Browser shows native required message
      />
      <button type="submit">Subscribe</button>
    </form>
  )
}
```

**When NOT to use:**
- Custom error message styling required
- Complex cross-field validation
- Need consistent UX across browsers

Reference: [useForm - shouldUseNativeValidation](https://react-hook-form.com/docs/useform)
