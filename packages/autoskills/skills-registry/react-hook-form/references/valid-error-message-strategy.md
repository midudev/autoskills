---
title: Access Errors via Optional Chaining or Lodash Get
impact: MEDIUM-HIGH
impactDescription: prevents runtime errors from undefined nested properties
tags: valid, errors, optional-chaining, nested-fields
---

## Access Errors via Optional Chaining or Lodash Get

Error objects can have deeply nested paths for nested fields. Use optional chaining or lodash `get()` to safely access error messages without runtime errors.

**Incorrect (direct access throws on undefined):**

```typescript
function AddressForm() {
  const { register, formState: { errors } } = useForm()

  return (
    <form>
      <input {...register('address.street', { required: true })} />
      <span>{errors.address.street.message}</span>  {/* Throws if address undefined */}

      <input {...register('address.city', { required: true })} />
      <span>{errors.address.city.message}</span>  {/* Throws if address undefined */}
    </form>
  )
}
```

**Correct (optional chaining for safe access):**

```typescript
function AddressForm() {
  const { register, formState: { errors } } = useForm()

  return (
    <form>
      <input {...register('address.street', { required: true })} />
      <span>{errors.address?.street?.message}</span>  {/* Safe access */}

      <input {...register('address.city', { required: true })} />
      <span>{errors.address?.city?.message}</span>  {/* Safe access */}
    </form>
  )
}
```

**Alternative (lodash get for complex paths):**

```typescript
import { get } from 'lodash'

function AddressForm() {
  const { register, formState: { errors } } = useForm()

  return (
    <form>
      <input {...register('address.street', { required: true })} />
      <span>{get(errors, 'address.street.message')}</span>
    </form>
  )
}
```

Reference: [React Hook Form - Advanced Usage](https://react-hook-form.com/advanced-usage)
