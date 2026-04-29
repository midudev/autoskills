---
title: Verify shadcn Form Component Import Source
impact: MEDIUM
impactDescription: prevents silent component mismatch bugs
tags: integ, shadcn, imports, Form-component
---

## Verify shadcn Form Component Import Source

React Hook Form exports its own `<Form>` component. When using shadcn/ui, ensure you import the shadcn Form wrapper, not RHF's Form. Auto-imports often get this wrong.

**Incorrect (imports RHF Form instead of shadcn):**

```typescript
import { useForm, Form } from 'react-hook-form'  // Wrong Form!
import { FormField, FormItem, FormLabel } from '@/components/ui/form'

function LoginForm() {
  const form = useForm()

  return (
    <Form {...form}>  {/* RHF Form doesn't work with shadcn FormField */}
      <FormField
        control={form.control}
        name="email"
        render={({ field }) => (
          <FormItem>
            <FormLabel>Email</FormLabel>
            <Input {...field} />
          </FormItem>
        )}
      />
    </Form>
  )
}
```

**Correct (separate imports for each library):**

```typescript
import { useForm } from 'react-hook-form'
import { Form, FormField, FormItem, FormLabel } from '@/components/ui/form'

function LoginForm() {
  const form = useForm()

  return (
    <Form {...form}>  {/* shadcn Form wraps FormProvider correctly */}
      <FormField
        control={form.control}
        name="email"
        render={({ field }) => (
          <FormItem>
            <FormLabel>Email</FormLabel>
            <Input {...field} />
          </FormItem>
        )}
      />
    </Form>
  )
}
```

Reference: [shadcn Form](https://ui.shadcn.com/docs/components/form)
