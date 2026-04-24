---
title: Use flatten() for Form Error Display
impact: HIGH
impactDescription: Raw ZodError.issues requires manual path parsing; flatten() provides field-keyed errors ready for form display
tags: error, flatten, forms, user-experience
---

## Use flatten() for Form Error Display

`ZodError.issues` is an array that requires manual processing to map errors to form fields. `ZodError.flatten()` returns an object with `fieldErrors` keyed by field name, ready for form libraries and UI display.

**Incorrect (manual issue processing):**

```typescript
import { z } from 'zod'

const formSchema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Password too short'),
  profile: z.object({
    name: z.string().min(1, 'Name required'),
  }),
})

function getFieldErrors(error: z.ZodError) {
  const errors: Record<string, string> = {}

  for (const issue of error.issues) {
    // Manual path joining - error prone
    const field = issue.path.join('.')
    if (!errors[field]) {
      errors[field] = issue.message
    }
  }

  return errors
}

const result = formSchema.safeParse(data)
if (!result.success) {
  const errors = getFieldErrors(result.error)
  // { email: 'Invalid email', 'profile.name': 'Name required' }
}
```

**Correct (using flatten):**

```typescript
import { z } from 'zod'

const formSchema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Password too short'),
  profile: z.object({
    name: z.string().min(1, 'Name required'),
  }),
})

const result = formSchema.safeParse(data)

if (!result.success) {
  const { formErrors, fieldErrors } = result.error.flatten()

  // formErrors: string[] - top-level errors (from .refine on the object)
  // fieldErrors: { [key]: string[] } - errors by field

  // Ready for form display
  console.log(fieldErrors)
  // {
  //   email: ['Invalid email'],
  //   password: ['Password too short'],
  //   'profile.name': ['Name required']
  // }
}
```

**With React Hook Form:**

```typescript
import { zodResolver } from '@hookform/resolvers/zod'
import { useForm } from 'react-hook-form'

const { register, formState: { errors } } = useForm({
  resolver: zodResolver(formSchema),
})

// errors are already flattened by the resolver
// <input {...register('email')} />
// {errors.email && <span>{errors.email.message}</span>}
```

**Customizing flatten output:**

```typescript
const flattened = result.error.flatten((issue) => ({
  message: issue.message,
  code: issue.code,
}))

// fieldErrors now contains custom objects
// {
//   email: [{ message: 'Invalid email', code: 'invalid_string' }],
// }
```

**For deeply nested objects, use format():**

```typescript
const result = formSchema.safeParse(data)

if (!result.success) {
  const formatted = result.error.format()
  // {
  //   _errors: [],
  //   email: { _errors: ['Invalid email'] },
  //   profile: {
  //     _errors: [],
  //     name: { _errors: ['Name required'] }
  //   }
  // }

  // Access nested errors naturally
  formatted.profile?.name?._errors  // ['Name required']
}
```

**When NOT to use this pattern:**
- When you need access to full issue metadata (code, path as array)
- When using a form library that expects different error format

Reference: [Zod Error Handling](https://zod.dev/error-handling)
