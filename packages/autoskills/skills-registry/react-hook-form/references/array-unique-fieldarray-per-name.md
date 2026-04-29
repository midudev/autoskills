---
title: Use Single useFieldArray Instance Per Field Name
impact: MEDIUM-HIGH
impactDescription: prevents state conflicts from duplicate subscriptions
tags: array, useFieldArray, instance, state-management
---

## Use Single useFieldArray Instance Per Field Name

Each field name should have only one useFieldArray instance. Multiple instances managing the same field name cause state conflicts and unpredictable behavior.

**Incorrect (multiple instances for same field):**

```typescript
function OrderForm() {
  const { control } = useForm()

  return (
    <div>
      <ItemsList control={control} />
      <ItemsSummary control={control} />
    </div>
  )
}

function ItemsList({ control }: { control: Control }) {
  const { fields, append } = useFieldArray({ control, name: 'items' })  // Instance 1
  return <div>{/* render items */}</div>
}

function ItemsSummary({ control }: { control: Control }) {
  const { fields } = useFieldArray({ control, name: 'items' })  // Instance 2 - conflicts!
  return <div>Total items: {fields.length}</div>
}
```

**Correct (single instance, pass fields down or use useWatch):**

```typescript
function OrderForm() {
  const { control } = useForm()
  const { fields, append, remove } = useFieldArray({ control, name: 'items' })

  return (
    <div>
      <ItemsList fields={fields} append={append} remove={remove} />
      <ItemsSummary control={control} />  {/* Uses useWatch, not useFieldArray */}
    </div>
  )
}

function ItemsSummary({ control }: { control: Control }) {
  const items = useWatch({ control, name: 'items' })  // Read-only subscription
  return <div>Total items: {items?.length ?? 0}</div>
}
```

Reference: [useFieldArray](https://react-hook-form.com/docs/usefieldarray)
