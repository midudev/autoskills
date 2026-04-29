---
title: Disable DevTools in Production and During Performance Testing
impact: LOW
impactDescription: eliminates DevTools overhead during profiling
tags: adv, devtools, performance, debugging
---

## Disable DevTools in Production and During Performance Testing

React Hook Form DevTools can cause performance issues, especially with FormProvider. Always disable in production and temporarily remove when profiling performance.

**Incorrect (DevTools enabled regardless of environment):**

```typescript
import { DevTool } from '@hookform/devtools'

function ProfileForm() {
  const { control, register, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <DevTool control={control} />  {/* Always renders, even in production */}
    </form>
  )
}
```

**Correct (conditionally render DevTools):**

```typescript
import { DevTool } from '@hookform/devtools'

function ProfileForm() {
  const { control, register, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {process.env.NODE_ENV === 'development' && <DevTool control={control} />}
    </form>
  )
}
```

**Alternative (dynamic import to avoid bundle impact):**

```typescript
const DevTool = lazy(() =>
  import('@hookform/devtools').then((mod) => ({ default: mod.DevTool }))
)

function ProfileForm() {
  const { control, register, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {process.env.NODE_ENV === 'development' && (
        <Suspense fallback={null}>
          <DevTool control={control} />
        </Suspense>
      )}
    </form>
  )
}
```

Reference: [React Hook Form DevTools](https://react-hook-form.com/dev-tools)
