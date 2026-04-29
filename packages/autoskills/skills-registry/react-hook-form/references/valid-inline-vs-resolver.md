---
title: Prefer Resolver Over Inline Validation for Complex Rules
impact: HIGH
impactDescription: centralizes validation logic and enables type inference
tags: valid, resolver, inline-validation, schema
---

## Prefer Resolver Over Inline Validation for Complex Rules

Inline validation rules in `register()` are convenient for simple cases, but resolvers (Zod, Yup) provide better type safety, centralized logic, and cross-field validation capabilities.

**Incorrect (complex inline validation scattered across inputs):**

```typescript
function CheckoutForm() {
  const { register, handleSubmit, watch } = useForm()
  const billingAddressSame = watch('billingAddressSame')

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', {
        required: 'Email required',
        pattern: { value: /^\S+@\S+$/i, message: 'Invalid email' },
      })} />
      <input {...register('billingAddressSame')} type="checkbox" />
      <input {...register('billingStreet', {
        required: !billingAddressSame && 'Street required',  // Cross-field logic inline
      })} />
    </form>
  )
}
```

**Correct (resolver centralizes all validation):**

```typescript
const checkoutSchema = z.object({
  email: z.string().email('Invalid email'),
  billingAddressSame: z.boolean(),
  billingStreet: z.string().optional(),
}).refine(
  (data) => data.billingAddressSame || data.billingStreet,
  { message: 'Street required', path: ['billingStreet'] }
)

type CheckoutFormData = z.infer<typeof checkoutSchema>

function CheckoutForm() {
  const { register, handleSubmit } = useForm<CheckoutFormData>({
    resolver: zodResolver(checkoutSchema),
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <input {...register('billingAddressSame')} type="checkbox" />
      <input {...register('billingStreet')} />
    </form>
  )
}
```

Reference: [React Hook Form Resolvers](https://github.com/react-hook-form/resolvers)
