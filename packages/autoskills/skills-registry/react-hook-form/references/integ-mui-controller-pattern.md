---
title: Use Controller for Material-UI Components
impact: MEDIUM
impactDescription: maintains controlled component behavior with proper event handling
tags: integ, mui, material-ui, Controller
---

## Use Controller for Material-UI Components

Material-UI components are controlled by design. Use Controller to wrap them, handling the onChange event object correctly (MUI passes the event, not the value directly).

**Incorrect (register doesn't work with MUI controlled components):**

```typescript
import { TextField } from '@mui/material'

function MuiForm() {
  const { register, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <TextField
        {...register('email')}  // MUI TextField is controlled, register won't work
        label="Email"
      />
    </form>
  )
}
```

**Correct (Controller handles MUI's event-based onChange):**

```typescript
import { TextField } from '@mui/material'
import { Controller } from 'react-hook-form'

function MuiForm() {
  const { control, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Controller
        name="email"
        control={control}
        render={({ field, fieldState }) => (
          <TextField
            {...field}  // MUI TextField accepts onChange with event
            label="Email"
            error={!!fieldState.error}
            helperText={fieldState.error?.message}
          />
        )}
      />
    </form>
  )
}
```

Reference: [React Hook Form - UI Libraries](https://react-hook-form.com/get-started#IntegratingwithUIlibraries)
