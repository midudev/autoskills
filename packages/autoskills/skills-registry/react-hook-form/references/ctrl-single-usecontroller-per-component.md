---
title: Use Single useController Per Component
impact: MEDIUM-HIGH
impactDescription: prevents prop name collisions and simplifies component logic
tags: ctrl, useController, component-design, separation
---

## Use Single useController Per Component

Each component should use at most one useController. Multiple useControllers in a single component cause prop name collisions and complex state management. Split into separate components instead.

**Incorrect (multiple useControllers cause collisions):**

```typescript
function DateRangeInput({ control }: { control: Control<FormData> }) {
  const startField = useController({ name: 'startDate', control })
  const endField = useController({ name: 'endDate', control })  // Prop names collide

  return (
    <div>
      <DatePicker
        value={startField.field.value}
        onChange={startField.field.onChange}
        error={startField.fieldState.error?.message}
      />
      <DatePicker
        value={endField.field.value}
        onChange={endField.field.onChange}
        error={endField.fieldState.error?.message}
      />
    </div>
  )
}
```

**Correct (separate components for each controlled field):**

```typescript
function DateRangeInput({ control }: { control: Control<FormData> }) {
  return (
    <div>
      <DateInput control={control} name="startDate" label="Start Date" />
      <DateInput control={control} name="endDate" label="End Date" />
    </div>
  )
}

function DateInput({ control, name, label }: DateInputProps) {
  const { field, fieldState } = useController({ name, control })

  return (
    <DatePicker
      label={label}
      value={field.value}
      onChange={field.onChange}
      error={fieldState.error?.message}
    />
  )
}
```

Reference: [useController](https://react-hook-form.com/docs/usecontroller)
