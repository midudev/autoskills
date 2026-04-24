---
title: Use useFormContext Sparingly for Deep Nesting
impact: MEDIUM
impactDescription: reduces prop drilling but increases implicit dependencies
tags: sub, useFormContext, FormProvider, prop-drilling
---

## Use useFormContext Sparingly for Deep Nesting

useFormContext eliminates prop drilling by accessing form methods via context, but creates implicit dependencies that are harder to track. Use it for deeply nested components; prefer explicit props for shallow nesting.

**Incorrect (useFormContext for shallow nesting):**

```typescript
function ContactForm() {
  const methods = useForm()

  return (
    <FormProvider {...methods}>
      <form onSubmit={methods.handleSubmit(onSubmit)}>
        <NameInput />  {/* One level deep, context overhead not needed */}
        <EmailInput />
      </form>
    </FormProvider>
  )
}

function NameInput() {
  const { register } = useFormContext()  // Implicit dependency
  return <input {...register('name')} />
}
```

**Correct (explicit props for shallow nesting):**

```typescript
function ContactForm() {
  const { register, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <NameInput register={register} />  {/* Explicit dependency */}
      <EmailInput register={register} />
    </form>
  )
}

function NameInput({ register }: { register: UseFormRegister<ContactFormData> }) {
  return <input {...register('name')} />
}
```

**When to use useFormContext:**
- Components nested 3+ levels deep
- Shared components used across multiple forms
- Complex form sections with many fields

Reference: [useFormContext](https://react-hook-form.com/docs/useformcontext)
