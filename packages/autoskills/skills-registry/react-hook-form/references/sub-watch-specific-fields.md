---
title: Watch Specific Fields Instead of Entire Form
impact: CRITICAL
impactDescription: reduces re-renders from N fields to 1 field change
tags: sub, watch, specific-fields, re-renders
---

## Watch Specific Fields Instead of Entire Form

Calling `watch()` without arguments subscribes to ALL form fields, causing re-renders on any field change. Always specify the field names you need.

**Incorrect (watches all fields, re-renders on any change):**

```typescript
function OrderForm() {
  const { register, watch, handleSubmit } = useForm()
  const formValues = watch()  // Re-renders when ANY field changes

  const total = calculateTotal(formValues.quantity, formValues.price)

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('customerName')} />  {/* Changes here trigger total recalc */}
      <input {...register('email')} />  {/* Changes here trigger total recalc */}
      <input {...register('quantity', { valueAsNumber: true })} />
      <input {...register('price', { valueAsNumber: true })} />
      <div>Total: ${total}</div>
    </form>
  )
}
```

**Correct (watches only needed fields):**

```typescript
function OrderForm() {
  const { register, watch, handleSubmit } = useForm()
  const [quantity, price] = watch(['quantity', 'price'])  // Only re-renders when these change

  const total = calculateTotal(quantity, price)

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('customerName')} />  {/* No re-render on change */}
      <input {...register('email')} />  {/* No re-render on change */}
      <input {...register('quantity', { valueAsNumber: true })} />
      <input {...register('price', { valueAsNumber: true })} />
      <div>Total: ${total}</div>
    </form>
  )
}
```

Reference: [useForm - watch](https://react-hook-form.com/docs/useform/watch)
