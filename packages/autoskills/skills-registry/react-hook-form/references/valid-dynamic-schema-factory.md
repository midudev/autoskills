---
title: Use Schema Factory for Dynamic Validation
impact: HIGH
impactDescription: enables context-dependent validation without render-time schema creation
tags: valid, schema, factory, dynamic, conditional
---

## Use Schema Factory for Dynamic Validation

When validation rules depend on runtime context (user role, feature flags), use a factory function to create schemas. This keeps schema creation outside the render cycle while allowing dynamic rules.

**Incorrect (schema recreated in component based on props):**

```typescript
function OrderForm({ maxQuantity }: { maxQuantity: number }) {
  const { register, handleSubmit } = useForm({
    resolver: zodResolver(
      z.object({
        quantity: z.number().max(maxQuantity),  // Recreated when maxQuantity changes
        notes: z.string().optional(),
      })
    ),
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('quantity', { valueAsNumber: true })} />
    </form>
  )
}
```

**Correct (factory function creates schema outside render):**

```typescript
const createOrderSchema = (maxQuantity: number) =>
  z.object({
    quantity: z.number().max(maxQuantity, `Maximum ${maxQuantity} items`),
    notes: z.string().optional(),
  })

function OrderForm({ maxQuantity }: { maxQuantity: number }) {
  const schema = useMemo(() => createOrderSchema(maxQuantity), [maxQuantity])

  const { register, handleSubmit } = useForm({
    resolver: zodResolver(schema),
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('quantity', { valueAsNumber: true })} />
    </form>
  )
}
```

Reference: [React Hook Form Resolvers](https://github.com/react-hook-form/resolvers)
