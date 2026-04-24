---
title: Avoid Double Registration with useController
impact: HIGH
impactDescription: prevents duplicate state management and validation bugs
tags: ctrl, useController, register, double-registration
---

## Avoid Double Registration with useController

useController handles field registration automatically. Calling `register()` on a field already managed by useController creates duplicate state tracking and validation conflicts.

**Incorrect (double registration causes state conflicts):**

```typescript
function CustomInput({ control, name }: CustomInputProps) {
  const { register } = useFormContext()
  const { field, fieldState } = useController({ name, control })

  return (
    <div>
      <input
        {...field}
        {...register(name)}  // Double registration!
      />
      {fieldState.error && <span>{fieldState.error.message}</span>}
    </div>
  )
}
```

**Correct (useController handles registration):**

```typescript
function CustomInput({ control, name }: CustomInputProps) {
  const { field, fieldState } = useController({ name, control })

  return (
    <div>
      <input {...field} />  {/* useController provides all needed props */}
      {fieldState.error && <span>{fieldState.error.message}</span>}
    </div>
  )
}
```

Reference: [useController](https://react-hook-form.com/docs/usecontroller)
