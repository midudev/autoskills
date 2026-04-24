---
title: Wire shadcn Select with onValueChange Instead of Spread
impact: MEDIUM
impactDescription: prevents 100% of silent select binding failures with Radix-based components
tags: integ, shadcn, select, radix
---

## Wire shadcn Select with onValueChange Instead of Spread

shadcn's Select (built on Radix) uses `onValueChange` instead of `onChange`. Spreading field props directly doesn't work. Manually wire the value change handler.

**Incorrect (spread doesn't work with Radix Select):**

```typescript
function CountrySelect({ control }: { control: Control }) {
  return (
    <FormField
      control={control}
      name="country"
      render={({ field }) => (
        <Select {...field}>  {/* field.onChange expects event, Radix passes value */}
          <SelectTrigger>
            <SelectValue placeholder="Select country" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="us">United States</SelectItem>
            <SelectItem value="uk">United Kingdom</SelectItem>
          </SelectContent>
        </Select>
      )}
    />
  )
}
```

**Correct (wire props individually):**

```typescript
function CountrySelect({ control }: { control: Control }) {
  return (
    <FormField
      control={control}
      name="country"
      render={({ field }) => (
        <Select
          value={field.value}
          onValueChange={field.onChange}  // Radix passes value directly
          onOpenChange={() => field.onBlur()}  // Trigger blur on close
        >
          <SelectTrigger>
            <SelectValue placeholder="Select country" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="us">United States</SelectItem>
            <SelectItem value="uk">United Kingdom</SelectItem>
          </SelectContent>
        </Select>
      )}
    />
  )
}
```

Reference: [shadcn Select](https://ui.shadcn.com/docs/components/select)
