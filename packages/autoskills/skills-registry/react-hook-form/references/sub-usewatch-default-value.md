---
title: Provide defaultValue to useWatch for Initial Render
impact: MEDIUM-HIGH
impactDescription: prevents undefined flash on initial render
tags: sub, useWatch, default-value, hydration
---

## Provide defaultValue to useWatch for Initial Render

useWatch returns undefined on the first render before the subscription is established. Provide a defaultValue to prevent undefined checks and potential UI flicker.

**Incorrect (undefined on first render):**

```typescript
function PriceDisplay({ control }: { control: Control<OrderForm> }) {
  const quantity = useWatch({ control, name: 'quantity' })

  return (
    <div>
      {quantity !== undefined ? (  // Undefined check required
        <span>Quantity: {quantity}</span>
      ) : (
        <span>Loading...</span>  // Flash of loading state
      )}
    </div>
  )
}
```

**Correct (defaultValue prevents undefined):**

```typescript
function PriceDisplay({ control }: { control: Control<OrderForm> }) {
  const quantity = useWatch({
    control,
    name: 'quantity',
    defaultValue: 1,  // Immediate value, no undefined check needed
  })

  return (
    <div>
      <span>Quantity: {quantity}</span>
    </div>
  )
}
```

**Note:** defaultValue should match the type expected by your form schema to maintain type safety.

Reference: [useWatch](https://react-hook-form.com/docs/usewatch)
