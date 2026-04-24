---
title: Do Not Use Generic Argument with reactive()
impact: MEDIUM
impactDescription: The generic argument type differs from the actual return type due to ref unwrapping, causing type mismatches
type: gotcha
tags: [vue3, typescript, reactive, ref-unwrapping, composition-api]
---

# Do Not Use Generic Argument with reactive()

**Impact: MEDIUM** - It is NOT recommended to use the generic argument of `reactive()` because the returned type, which handles nested ref unwrapping, is different from the generic argument type. Use interface annotation on the variable instead.

## Task Checklist

- [ ] Use type annotation on the variable, not generic argument
- [ ] Understand that `reactive()` unwraps nested refs
- [ ] For generic composables, use `shallowRef` or explicit `Ref<T>` typing
- [ ] Prefer `ref()` for simple values to avoid these issues

## The Problem

```vue
<script setup lang="ts">
import { reactive, ref } from 'vue'

interface Book {
  title: string
  year: number
  author: Ref<string>  // Nested ref
}

// WRONG: Generic argument doesn't account for ref unwrapping
const book = reactive<Book>({
  title: 'Vue 3 Guide',
  year: 2024,
  author: ref('John Doe')
})

// TypeScript thinks book.author is Ref<string>
// But at runtime, it's unwrapped to just string!
book.author.value  // TypeScript: OK, Runtime: ERROR (author is a string, not a ref)
</script>
```

## The Solution: Interface Annotation

```vue
<script setup lang="ts">
import { reactive, ref } from 'vue'

interface Book {
  title: string
  year?: number
}

// CORRECT: Annotate the variable, not the generic
const book: Book = reactive({
  title: 'Vue 3 Guide'
})

book.title = 'New Title'  // TypeScript knows this is string
book.year = 2024         // TypeScript knows this is number | undefined
</script>
```

## Why This Happens

When you use `reactive()`, Vue automatically unwraps any nested refs:

```typescript
import { reactive, ref, Ref } from 'vue'

const name = ref('John')
const state = reactive({
  name: name  // This is a Ref<string>
})

// At runtime, state.name is 'John' (string), NOT a Ref
console.log(state.name)       // 'John' (not ref object)
console.log(state.name.value) // Runtime error: .value doesn't exist

// The ACTUAL return type is different from what you'd expect
// reactive<{ name: Ref<string> }>() does NOT return { name: Ref<string> }
// It returns { name: string } due to automatic unwrapping
```

## Correct Patterns

### Pattern 1: Simple Interface Annotation

```vue
<script setup lang="ts">
interface FormState {
  name: string
  email: string
  age: number
}

const form: FormState = reactive({
  name: '',
  email: '',
  age: 0
})
</script>
```

### Pattern 2: Partial for Optional Fields

```vue
<script setup lang="ts">
interface User {
  id: string
  name: string
  email: string
}

// Start with partial data
const user: Partial<User> = reactive({})

// Fill in later
user.id = '123'
user.name = 'John'
</script>
```

### Pattern 3: Use ref() Instead

For simpler cases, prefer `ref()` which has more predictable typing:

```vue
<script setup lang="ts">
interface User {
  id: string
  name: string
}

// ref() works well with generics
const user = ref<User>({
  id: '1',
  name: 'John'
})

// Access with .value - clear and predictable
user.value.name = 'Jane'
</script>
```

## Generic Composables: Use Ref<T> or shallowRef

When working with generic type parameters in composables:

```typescript
// PROBLEM: Generic T with ref() causes UnwrapRef issues
function useBroken<T>(initial: T) {
  const state = ref(initial)  // Type becomes Ref<UnwrapRef<T>>
  state.value = initial       // Error: T is not assignable to UnwrapRef<T>
  return state
}

// SOLUTION 1: Use explicit Ref<T> type
function useFixed1<T>(initial: T) {
  const state: Ref<T> = ref(initial) as Ref<T>
  return state
}

// SOLUTION 2: Use shallowRef (no unwrapping)
function useFixed2<T>(initial: T) {
  const state = shallowRef(initial)  // Properly typed as ShallowRef<T>
  return state
}
```

## When Generic Argument IS Safe

For simple non-ref values without nested reactivity, the generic is safe:

```typescript
// Safe: no nested refs
const state = reactive<{ count: number; name: string }>({
  count: 0,
  name: ''
})

// Also safe: explicit simple types
const list = reactive<string[]>([])
const map = reactive<Map<string, number>>(new Map())
```

The issue only arises when:
1. You have nested Ref types in your interface
2. You're using generic type parameters that might contain refs

## Reference
- [Vue.js TypeScript with Composition API - Typing reactive()](https://vuejs.org/guide/typescript/composition-api.html#typing-reactive)
- [GitHub Issue: ref with generic type](https://github.com/vuejs/core/discussions/9564)
- [Vue TypeScript Caveats Gist](https://gist.github.com/LinusBorg/e041ff635994b50b7cec9383c3a067f1)
