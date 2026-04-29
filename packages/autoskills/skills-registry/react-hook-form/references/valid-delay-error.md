---
title: Use delayError to Debounce Rapid Error Display
impact: MEDIUM
impactDescription: reduces UI flicker during fast typing validation
tags: valid, delayError, debounce, user-experience
---

## Use delayError to Debounce Rapid Error Display

When using `onChange` mode, errors appear and disappear rapidly as users type. Use `delayError` to add a small delay, preventing UI flicker while still providing timely feedback.

**Incorrect (errors flash rapidly during typing):**

```typescript
function SearchForm() {
  const { register, formState: { errors } } = useForm({
    mode: 'onChange',
  })

  return (
    <form>
      <input {...register('query', { minLength: 3 })} />
      {errors.query && <span>Min 3 characters</span>}  {/* Flashes on/off rapidly */}
    </form>
  )
}
```

**Correct (error display debounced):**

```typescript
function SearchForm() {
  const { register, formState: { errors } } = useForm({
    mode: 'onChange',
    delayError: 300,  // 300ms delay before showing errors
  })

  return (
    <form>
      <input {...register('query', { minLength: 3 })} />
      {errors.query && <span>Min 3 characters</span>}  {/* Appears after 300ms delay */}
    </form>
  )
}
```

**When to use:**
- Real-time validation with `onChange` mode
- Fields with character count requirements
- Search inputs with minimum length

Reference: [useForm - delayError](https://react-hook-form.com/docs/useform)
