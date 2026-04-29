---
title: Create Test Wrapper with QueryClient and AuthProvider
impact: LOW
impactDescription: enables proper hook testing with required context providers
tags: adv, testing, wrapper, vitest, react-testing-library
---

## Create Test Wrapper with QueryClient and AuthProvider

Hook tests require proper context providers. Create a reusable wrapper function that provides QueryClient, AuthProvider, and any other required context for your forms.

**Incorrect (missing providers causes hook errors):**

```typescript
import { renderHook } from '@testing-library/react'
import { useForm } from 'react-hook-form'

test('form submits correctly', () => {
  const { result } = renderHook(() => useForm())  // May fail if form uses context

  act(() => {
    result.current.setValue('email', 'test@example.com')
  })

  expect(result.current.getValues('email')).toBe('test@example.com')
})
```

**Correct (wrapper provides all required context):**

```typescript
import { renderHook, act } from '@testing-library/react'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { useForm } from 'react-hook-form'

const createWrapper = () => {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  })

  return function Wrapper({ children }: { children: React.ReactNode }) {
    return (
      <QueryClientProvider client={queryClient}>
        {children}
      </QueryClientProvider>
    )
  }
}

test('form submits correctly', () => {
  const { result } = renderHook(() => useForm(), {
    wrapper: createWrapper(),
  })

  act(() => {
    result.current.setValue('email', 'test@example.com')
  })

  expect(result.current.getValues('email')).toBe('test@example.com')
})
```

Reference: [React Hook Form - Testing](https://react-hook-form.com/advanced-usage#TestingForm)
