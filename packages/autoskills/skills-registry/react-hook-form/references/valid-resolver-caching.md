---
title: Define Schema Outside Component for Resolver Caching
impact: HIGH
impactDescription: prevents schema recreation on every render
tags: valid, resolver, schema, caching, zod
---

## Define Schema Outside Component for Resolver Caching

Define validation schemas outside the component to enable resolver caching. Schemas defined inside components are recreated on every render, bypassing optimization.

**Incorrect (schema recreated on every render):**

```typescript
function RegistrationForm() {
  const schema = z.object({  // Created fresh on every render
    email: z.string().email(),
    password: z.string().min(8),
  })

  const { register, handleSubmit } = useForm({
    resolver: zodResolver(schema),  // New resolver instance each render
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <input {...register('password')} type="password" />
    </form>
  )
}
```

**Correct (schema defined once, resolver cached):**

```typescript
const registrationSchema = z.object({  // Created once at module load
  email: z.string().email(),
  password: z.string().min(8),
})

type RegistrationFormData = z.infer<typeof registrationSchema>

function RegistrationForm() {
  const { register, handleSubmit } = useForm<RegistrationFormData>({
    resolver: zodResolver(registrationSchema),  // Stable resolver reference
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <input {...register('password')} type="password" />
    </form>
  )
}
```

Reference: [React Hook Form Resolvers](https://github.com/react-hook-form/resolvers)
