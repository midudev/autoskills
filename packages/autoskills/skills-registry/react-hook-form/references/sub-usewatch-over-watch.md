---
title: Use useWatch Instead of watch for Isolated Re-renders
impact: CRITICAL
impactDescription: reduces re-renders by 10-50× in complex forms with multiple watchers
tags: sub, useWatch, watch, re-renders, subscription
---

## Use useWatch Instead of watch for Isolated Re-renders

The `watch()` method triggers re-renders at the useForm hook level, affecting the entire form component. Use `useWatch()` in child components to isolate re-renders to only the components that need the watched value.

**Incorrect (watch at root causes entire form to re-render):**

```typescript
function CheckoutForm() {
  const { register, watch, handleSubmit } = useForm()
  const shippingMethod = watch('shippingMethod')  // Every change re-renders entire form

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <select {...register('shippingMethod')}>
        <option value="standard">Standard</option>
        <option value="express">Express</option>
      </select>
      <ShippingCost method={shippingMethod} />
      <input {...register('address')} />
      <input {...register('city')} />
    </form>
  )
}
```

**Correct (useWatch isolates re-render to child component):**

```typescript
function CheckoutForm() {
  const { register, handleSubmit, control } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <select {...register('shippingMethod')}>
        <option value="standard">Standard</option>
        <option value="express">Express</option>
      </select>
      <ShippingCostDisplay control={control} />  {/* Only this re-renders */}
      <input {...register('address')} />
      <input {...register('city')} />
    </form>
  )
}

function ShippingCostDisplay({ control }: { control: Control<CheckoutFormData> }) {
  const shippingMethod = useWatch({ control, name: 'shippingMethod' })
  return <ShippingCost method={shippingMethod} />
}
```

Reference: [useWatch](https://react-hook-form.com/docs/usewatch)
