---
title: Avoid Calling watch() in Render for One-Time Reads
impact: HIGH
impactDescription: prevents unnecessary subscriptions and re-renders
tags: sub, watch, getValues, render, one-time-read
---

## Avoid Calling watch() in Render for One-Time Reads

If you only need to read a value once (not subscribe to changes), use `getValues()` instead of `watch()`. Calling watch() creates a subscription that triggers re-renders on every change.

**Incorrect (watch creates subscription for one-time read):**

```typescript
function SubmitButton() {
  const { watch, handleSubmit, formState: { isValid } } = useForm()

  const handleClick = () => {
    const email = watch('email')  // Creates subscription, but we only need current value
    analytics.track('form_submit_attempt', { email })
    handleSubmit(onSubmit)()
  }

  return <button onClick={handleClick} disabled={!isValid}>Submit</button>
}
```

**Correct (getValues for one-time read):**

```typescript
function SubmitButton() {
  const { getValues, handleSubmit, formState: { isValid } } = useForm()

  const handleClick = () => {
    const email = getValues('email')  // No subscription, just current value
    analytics.track('form_submit_attempt', { email })
    handleSubmit(onSubmit)()
  }

  return <button onClick={handleClick} disabled={!isValid}>Submit</button>
}
```

**When to use each:**
- `watch()`: Need to react to value changes (display, conditional rendering)
- `getValues()`: Need current value at a point in time (event handlers, submit)

Reference: [useForm - getValues](https://react-hook-form.com/docs/useform/getvalues)
