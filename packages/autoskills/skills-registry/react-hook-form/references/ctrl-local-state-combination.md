---
title: Combine Local State with useController for UI-Only State
impact: MEDIUM
impactDescription: reduces form re-renders by 50%+ when UI state changes don't affect form data
tags: ctrl, useController, local-state, ui-state
---

## Combine Local State with useController for UI-Only State

It's valid to combine useController with local useState for UI-only state (like dropdown open/closed, formatting preview). Keep form data in useController and UI state separate.

**Incorrect (mixing UI state into form state):**

```typescript
function PhoneInput({ control }: { control: Control<FormData> }) {
  const { field } = useController({
    name: 'phone',
    control,
    defaultValue: { number: '', showFormatted: false },  // UI state in form
  })

  return (
    <div>
      <input
        value={field.value.number}
        onChange={(e) => field.onChange({ ...field.value, number: e.target.value })}
      />
      <label>
        <input
          type="checkbox"
          checked={field.value.showFormatted}  // UI state pollutes form data
          onChange={(e) => field.onChange({ ...field.value, showFormatted: e.target.checked })}
        />
        Show formatted
      </label>
    </div>
  )
}
```

**Correct (separate UI state from form state):**

```typescript
function PhoneInput({ control }: { control: Control<FormData> }) {
  const { field } = useController({ name: 'phone', control })
  const [showFormatted, setShowFormatted] = useState(false)  // UI-only state

  const displayValue = showFormatted ? formatPhone(field.value) : field.value

  return (
    <div>
      <input
        value={displayValue}
        onChange={(e) => field.onChange(e.target.value)}  // Only phone number in form
      />
      <label>
        <input
          type="checkbox"
          checked={showFormatted}
          onChange={(e) => setShowFormatted(e.target.checked)}  // Local state only
        />
        Show formatted
      </label>
    </div>
  )
}
```

Reference: [useController](https://react-hook-form.com/docs/usecontroller)
