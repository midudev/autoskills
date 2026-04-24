---
title: Transform Values at Controller Level for Type Coercion
impact: MEDIUM
impactDescription: prevents type coercion bugs in 100% of numeric/date form fields
tags: integ, transform, value-coercion, Controller
---

## Transform Values at Controller Level for Type Coercion

Native inputs return strings. When your form needs numbers, dates, or other types, transform values in the Controller render function rather than relying solely on `valueAsNumber` or `valueAsDate`.

**Incorrect (valueAsNumber has edge cases):**

```typescript
function QuantityInput() {
  const { register } = useForm()

  return (
    <input
      {...register('quantity', { valueAsNumber: true })}  // Returns NaN for empty string
      type="number"
    />
  )
}
```

**Correct (explicit transformation in Controller):**

```typescript
function QuantityInput({ control }: { control: Control }) {
  return (
    <Controller
      name="quantity"
      control={control}
      render={({ field }) => (
        <input
          type="number"
          value={field.value ?? ''}
          onChange={(e) => {
            const value = e.target.value
            field.onChange(value === '' ? null : parseInt(value, 10))
          }}
          onBlur={field.onBlur}
        />
      )}
    />
  )
}
```

**Alternative (Zod transform at schema level):**

```typescript
const schema = z.object({
  quantity: z.string().transform((val) => (val === '' ? null : parseInt(val, 10))),
})
```

Reference: [React Hook Form - Advanced Usage](https://react-hook-form.com/advanced-usage)
