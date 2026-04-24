---
title: Use FormProvider for Virtualized Field Arrays
impact: MEDIUM
impactDescription: maintains field state when rows exit/enter viewport
tags: array, useFieldArray, virtualization, FormProvider
---

## Use FormProvider for Virtualized Field Arrays

When using virtualization libraries (react-window, react-virtuoso) with field arrays, fields exiting the viewport lose their DOM reference. Use FormProvider with useFormContext to maintain state across virtualization boundaries.

**Incorrect (direct props break with virtualization):**

```typescript
function VirtualizedList() {
  const { control, register } = useForm()
  const { fields } = useFieldArray({ control, name: 'rows' })

  return (
    <VirtualList
      itemCount={fields.length}
      itemSize={50}
      renderItem={({ index }) => (
        <input {...register(`rows.${index}.value`)} />  // Loses state when scrolled out
      )}
    />
  )
}
```

**Correct (FormProvider preserves context across virtualization):**

```typescript
function VirtualizedList() {
  const methods = useForm()
  const { fields } = useFieldArray({ control: methods.control, name: 'rows' })

  return (
    <FormProvider {...methods}>
      <VirtualList
        itemCount={fields.length}
        itemSize={50}
        renderItem={({ index }) => (
          <VirtualizedRow index={index} fieldId={fields[index].id} />
        )}
      />
    </FormProvider>
  )
}

function VirtualizedRow({ index, fieldId }: { index: number; fieldId: string }) {
  const { register, getValues } = useFormContext()

  return (
    <input
      key={fieldId}
      defaultValue={getValues(`rows.${index}.value`)}  // Restore from form state
      {...register(`rows.${index}.value`)}
    />
  )
}
```

Reference: [React Hook Form - Advanced Usage](https://react-hook-form.com/advanced-usage)
