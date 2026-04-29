---
title: Use useController for Re-render Isolation in Controlled Components
impact: HIGH
impactDescription: reduces re-renders from O(n) to O(1) per field change
tags: ctrl, useController, controlled-components, re-renders
---

## Use useController for Re-render Isolation in Controlled Components

useController creates a controlled input that only re-renders when its specific field value changes. This is essential for integrating with UI libraries like MUI, Ant Design, or custom components.

**Incorrect (inline Controller causes parent re-renders):**

```typescript
function PaymentForm() {
  const { control, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Controller
        name="amount"
        control={control}
        render={({ field }) => (
          <CurrencyInput {...field} />  // Parent re-renders affect this
        )}
      />
      <Controller
        name="currency"
        control={control}
        render={({ field }) => (
          <CurrencySelect {...field} />
        )}
      />
    </form>
  )
}
```

**Correct (useController in dedicated component isolates re-renders):**

```typescript
function PaymentForm() {
  const { control, handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <AmountInput control={control} />  {/* Only re-renders on amount change */}
      <CurrencySelectField control={control} />  {/* Only re-renders on currency change */}
    </form>
  )
}

function AmountInput({ control }: { control: Control<PaymentFormData> }) {
  const { field } = useController({ name: 'amount', control })
  return <CurrencyInput {...field} />
}

function CurrencySelectField({ control }: { control: Control<PaymentFormData> }) {
  const { field } = useController({ name: 'currency', control })
  return <CurrencySelect {...field} />
}
```

Reference: [useController](https://react-hook-form.com/docs/usecontroller)
