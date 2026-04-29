---
title: Use intersection() for Type Combinations
impact: MEDIUM
impactDescription: Manual field combination loses type relationships; intersection creates proper TypeScript intersection types
tags: compose, intersection, and, combination
---

## Use intersection() for Type Combinations

When you need an object that satisfies multiple schemas simultaneously (like combining a base type with mixins), use `.and()` or `z.intersection()`. This creates proper TypeScript intersection types and validates against all schemas.

**Incorrect (manual combination):**

```typescript
import { z } from 'zod'

const timestampsSchema = z.object({
  createdAt: z.date(),
  updatedAt: z.date(),
})

const softDeleteSchema = z.object({
  deletedAt: z.date().nullable(),
  deletedBy: z.string().nullable(),
})

const userSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
})

// Manual combination - verbose and error-prone
const fullUserSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
  createdAt: z.date(),
  updatedAt: z.date(),
  deletedAt: z.date().nullable(),
  deletedBy: z.string().nullable(),
})
```

**Correct (using intersection):**

```typescript
import { z } from 'zod'

const timestampsSchema = z.object({
  createdAt: z.date(),
  updatedAt: z.date(),
})

const softDeleteSchema = z.object({
  deletedAt: z.date().nullable(),
  deletedBy: z.string().nullable(),
})

const userSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
})

// Using .and() for intersection
const fullUserSchema = userSchema
  .and(timestampsSchema)
  .and(softDeleteSchema)

// Or using z.intersection()
const fullUserSchema2 = z.intersection(
  z.intersection(userSchema, timestampsSchema),
  softDeleteSchema
)

type FullUser = z.infer<typeof fullUserSchema>
// {
//   id: string;
//   name: string;
//   email: string;
//   createdAt: Date;
//   updatedAt: Date;
//   deletedAt: Date | null;
//   deletedBy: string | null;
// }
```

**Creating mixins:**

```typescript
// Reusable mixins
const auditable = z.object({
  createdBy: z.string(),
  updatedBy: z.string(),
})

const versioned = z.object({
  version: z.number().int().positive(),
})

const tagged = z.object({
  tags: z.array(z.string()),
})

// Apply mixins to any schema
function withAudit<T extends z.ZodRawShape>(schema: z.ZodObject<T>) {
  return schema.and(auditable).and(timestampsSchema)
}

function withVersioning<T extends z.ZodRawShape>(schema: z.ZodObject<T>) {
  return schema.and(versioned)
}

// Usage
const documentSchema = z.object({
  id: z.string(),
  title: z.string(),
  content: z.string(),
})

const fullDocumentSchema = withAudit(withVersioning(documentSchema))
```

**Intersection vs Merge:**

```typescript
// .merge() - replaces fields from first with second
const a = z.object({ x: z.string(), y: z.number() })
const b = z.object({ y: z.string() })  // y is string, not number

a.merge(b)  // { x: string, y: string } - b's y wins

// .and() - requires fields to be compatible
// If both have y with different types, intersection fails at runtime
a.and(b)  // Validation will fail - y can't be both number and string
```

**When NOT to use this pattern:**
- When schemas have overlapping fields with different types (use merge)
- When you need to override fields (use extend)
- Simple cases where extend works fine

Reference: [Zod API - intersection](https://zod.dev/api#intersection)
