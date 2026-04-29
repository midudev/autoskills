---
title: Use getFieldState for Single Field State Access
impact: MEDIUM
impactDescription: avoids subscription overhead for one-time state reads
tags: formstate, getFieldState, single-field, no-subscription
---

## Use getFieldState for Single Field State Access

When you need to check a single field's state (dirty, touched, error) without subscribing to updates, use `getFieldState()`. It returns current state without creating a subscription.

**Incorrect (useFormState creates subscription for one-time check):**

```typescript
function FieldHelpText({ control, name }: { control: Control; name: string }) {
  const { touchedFields } = useFormState({ control })  // Subscribes to all touched changes

  const wasTouched = touchedFields[name]

  return wasTouched ? null : <span>Please fill out this field</span>
}
```

**Correct (getFieldState for non-reactive read):**

```typescript
function FieldHelpText({ formState, name }: { formState: FormState; name: string }) {
  const { isTouched } = getFieldState(name, formState)  // No subscription created

  return isTouched ? null : <span>Please fill out this field</span>
}

function MyForm() {
  const { register, formState } = useForm()

  return (
    <form>
      <input {...register('email')} />
      <FieldHelpText formState={formState} name="email" />
    </form>
  )
}
```

**When to use each:**
- `useFormState`: Need to react to state changes (display updates)
- `getFieldState`: Need current state at a point in time (conditional logic)

Reference: [useForm - getFieldState](https://react-hook-form.com/docs/useform/getfieldstate)
