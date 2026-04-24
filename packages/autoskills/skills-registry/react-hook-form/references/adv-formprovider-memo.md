---
title: Wrap FormProvider Children with React.memo
impact: LOW
impactDescription: prevents cascade re-renders from FormProvider state updates
tags: adv, FormProvider, memo, optimization
---

## Wrap FormProvider Children with React.memo

FormProvider triggers re-renders on form state updates. Wrap expensive child components with `React.memo` to prevent unnecessary re-renders when their props haven't changed.

**Incorrect (children re-render on any form state change):**

```typescript
function LargeForm() {
  const methods = useForm()

  return (
    <FormProvider {...methods}>
      <form onSubmit={methods.handleSubmit(onSubmit)}>
        <PersonalInfoSection />  {/* Re-renders on ANY form state change */}
        <AddressSection />  {/* Re-renders on ANY form state change */}
        <PaymentSection />  {/* Re-renders on ANY form state change */}
      </form>
    </FormProvider>
  )
}

function PersonalInfoSection() {
  const { register } = useFormContext()
  return (
    <div>
      <input {...register('firstName')} />
      <input {...register('lastName')} />
    </div>
  )
}
```

**Correct (memo prevents unnecessary child re-renders):**

```typescript
function LargeForm() {
  const methods = useForm()

  return (
    <FormProvider {...methods}>
      <form onSubmit={methods.handleSubmit(onSubmit)}>
        <PersonalInfoSection />
        <AddressSection />
        <PaymentSection />
      </form>
    </FormProvider>
  )
}

const PersonalInfoSection = memo(function PersonalInfoSection() {
  const { register } = useFormContext()
  return (
    <div>
      <input {...register('firstName')} />
      <input {...register('lastName')} />
    </div>
  )
})

const AddressSection = memo(function AddressSection() {
  const { register } = useFormContext()
  return (
    <div>
      <input {...register('address.street')} />
      <input {...register('address.city')} />
    </div>
  )
})
```

Reference: [React Hook Form - Advanced Usage](https://react-hook-form.com/advanced-usage)
