---
title: Wire Controller Field Props Correctly for UI Libraries
impact: HIGH
impactDescription: prevents form binding bugs and eliminates silent failures in 100% of UI library integrations
tags: ctrl, Controller, field-props, ui-libraries
---

## Wire Controller Field Props Correctly for UI Libraries

Different UI libraries expect different prop names. Map Controller's field props correctly: `onChange` sends data back, `onBlur` reports interaction, `value` sets the display, `ref` enables focus on error.

**Incorrect (spreading field on incompatible component):**

```typescript
function FormWithSelect({ control }: { control: Control<FormData> }) {
  return (
    <Controller
      name="country"
      control={control}
      render={({ field }) => (
        <Select {...field} />  // Select may not accept all field props directly
      )}
    />
  )
}
```

**Correct (manually wire required props):**

```typescript
function FormWithSelect({ control }: { control: Control<FormData> }) {
  return (
    <Controller
      name="country"
      control={control}
      render={({ field }) => (
        <Select
          value={field.value}
          onValueChange={field.onChange}  // Map to component's change handler
          onBlur={field.onBlur}
        >
          <SelectItem value="us">United States</SelectItem>
          <SelectItem value="uk">United Kingdom</SelectItem>
        </Select>
      )}
    />
  )
}
```

**Common mappings by library:**
- MUI Select: `value`, `onChange` (receives event)
- Radix/shadcn Select: `value`, `onValueChange` (receives value directly)
- React Select: `value`, `onChange` (receives option object)

Reference: [useController](https://react-hook-form.com/docs/usecontroller)
