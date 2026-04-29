---
title: Subscribe Deep in Component Tree Where Data Is Needed
impact: CRITICAL
impactDescription: prevents parent re-renders from propagating to unrelated children
tags: sub, subscription, component-tree, re-renders
---

## Subscribe Deep in Component Tree Where Data Is Needed

Subscribe to form values as deep in the component tree as possible, where the data is actually used. This isolates re-renders to the specific component that needs the value.

**Incorrect (subscription at parent re-renders all children):**

```typescript
function CheckoutPage() {
  const { control, register, handleSubmit } = useForm()
  const paymentMethod = useWatch({ control, name: 'paymentMethod' })  // Parent subscribes

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <ShippingSection register={register} />  {/* Re-renders on paymentMethod change */}
      <BillingSection register={register} />  {/* Re-renders on paymentMethod change */}
      <PaymentSection
        register={register}
        paymentMethod={paymentMethod}  {/* Prop drilling */}
      />
    </form>
  )
}
```

**Correct (subscription at leaf component isolates re-renders):**

```typescript
function CheckoutPage() {
  const { control, register, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <ShippingSection register={register} />  {/* Never re-renders for payment */}
      <BillingSection register={register} />  {/* Never re-renders for payment */}
      <PaymentSection register={register} control={control} />
    </form>
  )
}

function PaymentSection({ register, control }: PaymentSectionProps) {
  const paymentMethod = useWatch({ control, name: 'paymentMethod' })  // Only this re-renders

  return (
    <div>
      <select {...register('paymentMethod')}>
        <option value="card">Credit Card</option>
        <option value="paypal">PayPal</option>
      </select>
      {paymentMethod === 'card' && <CardFields register={register} />}
    </div>
  )
}
```

Reference: [useWatch](https://react-hook-form.com/docs/usewatch)
