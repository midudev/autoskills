---
title: Imported Types Have Limitations in defineProps
impact: MEDIUM
impactDescription: Complex imported types like conditional types can cause compiler errors in defineProps
type: gotcha
tags: [vue3, typescript, defineProps, imported-types, vue3.3]
---

# Imported Types Have Limitations in defineProps

**Impact: MEDIUM** - While Vue 3.3+ supports imported types in `defineProps<>()`, certain complex types are not fully supported. Conditional types, mapped types that require full type analysis, and global ambient types can cause "Unresolvable type reference" errors.

## Task Checklist

- [ ] Understand which type patterns are supported vs unsupported
- [ ] Keep prop type definitions simple and explicit
- [ ] Move complex type logic outside of defineProps
- [ ] Export interfaces explicitly rather than using global declarations

## Supported Patterns (Vue 3.3+)

```typescript
// types/user.ts
export interface User {
  id: string
  name: string
  email?: string
}

export interface ListProps<T> {
  items: T[]
  selectedItem?: T
}

export type Status = 'pending' | 'active' | 'completed'
```

```vue
<script setup lang="ts">
import type { User, Status } from '@/types/user'

// WORKS: Simple imported interface
defineProps<{
  user: User
}>()

// WORKS: Imported union type
defineProps<{
  status: Status
}>()

// WORKS: Direct imported interface
defineProps<User>()
</script>
```

## Unsupported Patterns

### Conditional Types for Entire Props Object

```typescript
// types/conditional.ts
export type ConditionalProps<T> = T extends string
  ? { value: string; onChange: (v: string) => void }
  : { value: number; onChange: (v: number) => void }
```

```vue
<script setup lang="ts">
import type { ConditionalProps } from '@/types/conditional'

// ERROR: Conditional types not supported for entire props object
defineProps<ConditionalProps<string>>()
</script>
```

**Workaround:**
```vue
<script setup lang="ts">
// Define the resolved type directly
interface StringProps {
  value: string
  onChange: (v: string) => void
}

defineProps<StringProps>()
</script>
```

### Conditional Types for Individual Props ARE Supported

```vue
<script setup lang="ts">
// This WORKS - conditional type on individual prop
interface Props {
  value: SomeType extends string ? string : number  // OK
}

defineProps<Props>()
</script>
```

### Global Ambient Types

```typescript
// global.d.ts (ambient declaration without export)
interface GlobalUser {
  id: string
  name: string
}

// No export statement - this is an ambient declaration
```

```vue
<script setup lang="ts">
// ERROR: "Unresolvable type reference"
defineProps<{
  user: GlobalUser  // Can't resolve ambient global type
}>()
</script>
```

**Workaround:**
```typescript
// types/user.ts - Use explicit export
export interface GlobalUser {
  id: string
  name: string
}
```

```vue
<script setup lang="ts">
import type { GlobalUser } from '@/types/user'

// WORKS: Explicitly imported
defineProps<{
  user: GlobalUser
}>()
</script>
```

### Complex Mapped Types

```typescript
// types/complex.ts
export type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P]
}

export interface User {
  id: string
  profile: { name: string }
}
```

```vue
<script setup lang="ts">
import type { DeepReadonly, User } from '@/types/complex'

// May fail or produce incorrect types
defineProps<{
  user: DeepReadonly<User>
}>()
</script>
```

**Workaround:**
```typescript
// Resolve the type explicitly
export interface ReadonlyUser {
  readonly id: string
  readonly profile: { readonly name: string }
}
```

### Union of Imported Interfaces

```typescript
// types/forms.ts
export interface TextInput { type: 'text'; value: string }
export interface NumberInput { type: 'number'; value: number }
```

```vue
<script setup lang="ts">
import type { TextInput, NumberInput } from '@/types/forms'

// Can cause issues in some Vue versions
defineProps<{
  input: TextInput | NumberInput
}>()
</script>
```

**Workaround:**
```typescript
// Define the union in the types file
export type AnyInput = TextInput | NumberInput
```

```vue
<script setup lang="ts">
import type { AnyInput } from '@/types/forms'

defineProps<{
  input: AnyInput
}>()
</script>
```

## Best Practices

### Keep Props Types Simple

```typescript
// GOOD: Simple, explicit interface
export interface ButtonProps {
  variant: 'primary' | 'secondary' | 'danger'
  size: 'sm' | 'md' | 'lg'
  disabled?: boolean
  loading?: boolean
}

// AVOID: Over-engineered generic types
export type ButtonProps<V extends string, S extends string> = {
  variant: V
  size: S
  // ...complex type gymnastics
}
```

### Resolve Types Before Export

```typescript
// Instead of exporting generic utilities
// export type PartialBy<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>

// Export the resolved type
export interface CreateUserProps {
  name: string
  email: string
  age?: number  // Made optional
  role?: 'admin' | 'user'  // Made optional
}
```

### Use Dual Script Blocks for Complex Cases

```vue
<script lang="ts">
// Regular script block for complex type definitions
import type { ComplexType } from '@/types'

// Resolve the type here
type ResolvedProps = ComplexType extends SomeCondition
  ? { a: string }
  : { b: number }
</script>

<script setup lang="ts">
// Use the resolved type
defineProps<ResolvedProps>()
</script>
```

## Version-Specific Behavior

| Vue Version | Imported Types | Complex Types |
|-------------|---------------|---------------|
| 3.2 | Not supported | Not supported |
| 3.3 | Supported | Limited |
| 3.4+ | Supported | Better support |

Always check the Vue changelog for updates to type support in defineProps.

## Reference
- [Vue.js TypeScript with Composition API](https://vuejs.org/guide/typescript/composition-api.html)
- [GitHub Issue: defineProps with imported interfaces](https://github.com/vuejs/core/issues/8612)
- [GitHub Issue: Union types in defineProps](https://github.com/vuejs/core/issues/5804)
