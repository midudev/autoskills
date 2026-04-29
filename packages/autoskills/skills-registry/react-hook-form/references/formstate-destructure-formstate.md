---
title: Destructure formState Properties Before Render
impact: MEDIUM
impactDescription: enables Proxy subscription optimization
tags: formstate, formState, destructure, proxy, subscription
---

## Destructure formState Properties Before Render

formState is wrapped in a Proxy that tracks which properties you access. Destructure the specific properties you need before render to enable the subscription optimization. Assigning the entire object disables it.

**Incorrect (entire object assignment disables Proxy):**

```typescript
function SubmitButton() {
  const { handleSubmit, formState } = useForm()

  return (
    <button
      disabled={!formState.isValid}  // Proxy optimization disabled
      onClick={handleSubmit(onSubmit)}
    >
      {formState.isSubmitting ? 'Saving...' : 'Save'}
    </button>
  )
}
```

**Correct (destructure enables selective subscription):**

```typescript
function SubmitButton() {
  const { handleSubmit, formState: { isValid, isSubmitting } } = useForm()

  return (
    <button
      disabled={!isValid}  // Only subscribes to isValid changes
      onClick={handleSubmit(onSubmit)}
    >
      {isSubmitting ? 'Saving...' : 'Save'}
    </button>
  )
}
```

**Note:** This also applies to useFormState hook - always destructure the properties you need.

Reference: [useFormState](https://react-hook-form.com/docs/useformstate)
