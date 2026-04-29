---
title: Lazy Load Large Schemas
impact: LOW-MEDIUM
impactDescription: Large schemas increase initial bundle and parse time; dynamic imports defer loading until needed
tags: perf, lazy, import, code-splitting
---

## Lazy Load Large Schemas

For applications with many complex schemas, importing all of them upfront increases initial bundle size and startup time. Use dynamic imports to lazy load schemas that aren't needed immediately.

**Incorrect (importing all schemas upfront):**

```typescript
// schemas/index.ts - barrel file with everything
export * from './user'
export * from './order'
export * from './product'
export * from './analytics'  // Large, complex schema
export * from './reports'    // Another large schema
export * from './admin'      // Admin-only schemas

// app/page.tsx
import { userSchema, orderSchema, analyticsSchema, reportsSchema } from '@/schemas'
// All schemas loaded even if not used on this page
```

**Correct (lazy loading schemas):**

```typescript
// Only import what's immediately needed
import { userSchema } from '@/schemas/user'

async function loadAnalyticsSchema() {
  const { analyticsSchema } = await import('@/schemas/analytics')
  return analyticsSchema
}

// Use when needed
async function handleAnalyticsData(data: unknown) {
  const schema = await loadAnalyticsSchema()
  return schema.safeParse(data)
}
```

**Route-based schema loading:**

```typescript
// app/admin/reports/page.tsx
'use client'

import { useEffect, useState } from 'react'
import type { z } from 'zod'

export default function ReportsPage() {
  const [schema, setSchema] = useState<z.ZodType | null>(null)

  useEffect(() => {
    // Load schema only when this route is accessed
    import('@/schemas/reports').then(({ reportsSchema }) => {
      setSchema(reportsSchema)
    })
  }, [])

  if (!schema) return <Loading />

  // Use schema...
}
```

**Better pattern with React Suspense:**

```typescript
// schemas/reports.ts
import { z } from 'zod'

export const reportsSchema = z.object({
  // Large complex schema
})

// app/admin/reports/page.tsx
import { lazy, Suspense } from 'react'

const ReportsForm = lazy(() => import('./ReportsForm'))

export default function ReportsPage() {
  return (
    <Suspense fallback={<Loading />}>
      <ReportsForm />
    </Suspense>
  )
}

// ReportsForm.tsx - schema imported with component
import { reportsSchema } from '@/schemas/reports'

export default function ReportsForm() {
  // Schema available when component loads
}
```

**Schema registry for conditional loading:**

```typescript
// schemas/registry.ts
const schemaLoaders = {
  user: () => import('./user').then(m => m.userSchema),
  order: () => import('./order').then(m => m.orderSchema),
  analytics: () => import('./analytics').then(m => m.analyticsSchema),
  reports: () => import('./reports').then(m => m.reportsSchema),
} as const

type SchemaName = keyof typeof schemaLoaders

const schemaCache = new Map<SchemaName, z.ZodType>()

export async function getSchema(name: SchemaName) {
  if (!schemaCache.has(name)) {
    const schema = await schemaLoaders[name]()
    schemaCache.set(name, schema)
  }
  return schemaCache.get(name)!
}

// Usage
const schema = await getSchema('analytics')
schema.parse(data)
```

**When NOT to use this pattern:**
- Server-side rendering where all code is available
- Small applications with few schemas
- Schemas used on every page (defeats purpose)

Reference: [Next.js Dynamic Imports](https://nextjs.org/docs/app/building-your-application/optimizing/lazy-loading)
