---
title: Provide Custom Error Messages
impact: HIGH
impactDescription: Default messages like "Expected string, received number" confuse users; custom messages like "Email is required" are actionable
tags: error, messages, user-experience, validation
---

## Provide Custom Error Messages

Zod's default error messages are technical and confusing for end users. Provide custom messages that are clear, specific, and actionable. This dramatically improves user experience when validation fails.

**Incorrect (default error messages):**

```typescript
import { z } from 'zod'

const signupSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  age: z.number().min(18),
})

signupSchema.parse({ email: 'bad', password: '123', age: 15 })
// ZodError issues:
// - "Invalid email"
// - "String must contain at least 8 character(s)"
// - "Number must be greater than or equal to 18"
// Users see: "String must contain at least 8 character(s)" - what string?
```

**Correct (custom error messages):**

```typescript
import { z } from 'zod'

const signupSchema = z.object({
  email: z.string({
    required_error: 'Email is required',
    invalid_type_error: 'Email must be text',
  }).email('Please enter a valid email address'),

  password: z.string({
    required_error: 'Password is required',
  }).min(8, 'Password must be at least 8 characters'),

  age: z.number({
    required_error: 'Age is required',
    invalid_type_error: 'Age must be a number',
  }).min(18, 'You must be at least 18 years old'),
})

signupSchema.parse({ email: 'bad', password: '123', age: 15 })
// ZodError issues:
// - "Please enter a valid email address"
// - "Password must be at least 8 characters"
// - "You must be at least 18 years old"
```

**Message types and when they trigger:**

```typescript
const schema = z.string({
  // When field is undefined
  required_error: 'This field is required',

  // When field is wrong type (e.g., number instead of string)
  invalid_type_error: 'This field must be text',

  // Fallback for any other error
  message: 'Invalid value',
})
.min(1, 'Cannot be empty')  // When length < 1
.max(100, 'Too long')  // When length > 100
.email('Invalid email format')  // When format fails
```

**Using error maps for consistent messaging:**

```typescript
const customErrorMap: z.ZodErrorMap = (issue, ctx) => {
  // Customize messages by error code
  if (issue.code === z.ZodIssueCode.too_small) {
    if (issue.type === 'string') {
      return { message: `Must be at least ${issue.minimum} characters` }
    }
    if (issue.type === 'number') {
      return { message: `Must be at least ${issue.minimum}` }
    }
  }

  if (issue.code === z.ZodIssueCode.invalid_type) {
    if (issue.expected === 'string') {
      return { message: 'Must be text' }
    }
  }

  // Default to Zod's message
  return { message: ctx.defaultError }
}

// Apply globally
z.setErrorMap(customErrorMap)

// Or per-schema
schema.parse(data, { errorMap: customErrorMap })
```

**Good error message principles:**
- Say what's wrong: "Password too short" not "Invalid password"
- Say how to fix it: "at least 8 characters" not just "too short"
- Use user's language: "email" not "string field at path .email"
- Be specific: "Must be a positive number" not "Invalid"

**When NOT to use this pattern:**
- Internal development scripts where technical errors are fine
- When you'll map errors to user-facing messages in the UI layer

Reference: [Zod Error Customization](https://zod.dev/error-customization)
