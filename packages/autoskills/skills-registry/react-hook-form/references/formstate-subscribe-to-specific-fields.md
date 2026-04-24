---
title: Subscribe to Specific Field Names in useFormState
impact: MEDIUM
impactDescription: reduces re-renders to only relevant field changes
tags: formstate, useFormState, name, specific-fields
---

## Subscribe to Specific Field Names in useFormState

useFormState accepts a `name` option to subscribe only to specific field state changes. Without it, the component re-renders on any field's state change.

**Incorrect (subscribes to all field state changes):**

```typescript
function PasswordStrengthIndicator({ control }: { control: Control }) {
  const { errors, dirtyFields } = useFormState({ control })  // All fields

  const passwordError = errors.password
  const isPasswordDirty = dirtyFields.password

  return isPasswordDirty && !passwordError ? (
    <span>Password looks good!</span>
  ) : null
}
```

**Correct (subscribes only to password field):**

```typescript
function PasswordStrengthIndicator({ control }: { control: Control }) {
  const { errors, dirtyFields } = useFormState({
    control,
    name: 'password',  // Only re-renders on password state changes
  })

  const passwordError = errors.password
  const isPasswordDirty = dirtyFields.password

  return isPasswordDirty && !passwordError ? (
    <span>Password looks good!</span>
  ) : null
}
```

**Multiple fields:**

```typescript
const { errors } = useFormState({
  control,
  name: ['email', 'password'],  // Subscribe to multiple specific fields
})
```

Reference: [useFormState](https://react-hook-form.com/docs/useformstate)
