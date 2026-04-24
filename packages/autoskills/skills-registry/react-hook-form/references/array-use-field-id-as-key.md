---
title: Use field.id as Key in useFieldArray Maps
impact: MEDIUM-HIGH
impactDescription: prevents state corruption and unnecessary re-renders
tags: array, useFieldArray, key, react-key
---

## Use field.id as Key in useFieldArray Maps

useFieldArray generates a unique `id` for each field. Using array index as key causes React to lose track of component identity when items are reordered, removed, or inserted.

**Incorrect (index as key causes state corruption):**

```typescript
function IngredientsForm() {
  const { control, register } = useForm()
  const { fields, append, remove } = useFieldArray({ control, name: 'ingredients' })

  return (
    <div>
      {fields.map((field, index) => (
        <div key={index}>  {/* Index key causes re-render issues */}
          <input {...register(`ingredients.${index}.name`)} />
          <button type="button" onClick={() => remove(index)}>Remove</button>
        </div>
      ))}
      <button type="button" onClick={() => append({ name: '' })}>Add</button>
    </div>
  )
}
```

**Correct (field.id ensures stable identity):**

```typescript
function IngredientsForm() {
  const { control, register } = useForm()
  const { fields, append, remove } = useFieldArray({ control, name: 'ingredients' })

  return (
    <div>
      {fields.map((field, index) => (
        <div key={field.id}>  {/* Stable identity across operations */}
          <input {...register(`ingredients.${index}.name`)} />
          <button type="button" onClick={() => remove(index)}>Remove</button>
        </div>
      ))}
      <button type="button" onClick={() => append({ name: '' })}>Add</button>
    </div>
  )
}
```

Reference: [useFieldArray](https://react-hook-form.com/docs/usefieldarray)
