---
title: Composition API Uses Mutable Reactivity, Not Functional Programming
impact: MEDIUM
impactDescription: Misunderstanding the paradigm leads to incorrect state management patterns
type: gotcha
tags: [vue3, composition-api, reactivity, functional-programming, paradigm]
---

# Composition API Uses Mutable Reactivity, Not Functional Programming

**Impact: MEDIUM** - Despite being function-based, the Composition API follows Vue's mutable, fine-grained reactivity paradigm—NOT functional programming principles. Treating it like a functional paradigm leads to incorrect patterns like unnecessary cloning, immutable-style updates, or avoiding mutation when mutation is the intended pattern.

Vue's Composition API leverages imported functions to organize code, but the underlying model is based on mutable reactive state that Vue tracks and responds to. This is fundamentally different from functional programming with immutability (like Redux reducers).

## Task Checklist

- [ ] Mutate reactive state directly - don't create new objects for every update
- [ ] Don't apply immutability patterns unnecessarily (spreading, Object.assign for updates)
- [ ] Understand that `ref()` and `reactive()` enable mutable state tracking
- [ ] Use Vue's reactivity as intended: direct mutation with automatic tracking

**Incorrect:**
```javascript
import { ref } from 'vue'

const todos = ref([])

// WRONG: Treating Vue like Redux/functional - unnecessary immutability
function addTodo(todo) {
  // Creating a new array every time is wasteful in Vue
  todos.value = [...todos.value, todo]
}

function updateTodo(id, updates) {
  // Unnecessary spread - Vue tracks mutations directly
  todos.value = todos.value.map(t =>
    t.id === id ? { ...t, ...updates } : t
  )
}

const user = ref({ name: 'John', age: 30 })

// WRONG: Creating new object for simple update
function updateName(newName) {
  user.value = { ...user.value, name: newName }
}
```

**Correct:**
```javascript
import { ref, reactive } from 'vue'

const todos = ref([])

// CORRECT: Mutate directly - Vue tracks the change
function addTodo(todo) {
  todos.value.push(todo)  // Direct mutation is the Vue way
}

function updateTodo(id, updates) {
  const todo = todos.value.find(t => t.id === id)
  if (todo) {
    Object.assign(todo, updates)  // Direct mutation
  }
}

const user = ref({ name: 'John', age: 30 })

// CORRECT: Mutate the property directly
function updateName(newName) {
  user.value.name = newName  // Vue tracks this!
}

// Or with reactive():
const state = reactive({ name: 'John', age: 30 })

function updateNameReactive(newName) {
  state.name = newName  // Direct mutation, reactivity preserved
}
```

## When Immutability Patterns Make Sense

```javascript
// Immutability IS appropriate when:

// 1. Replacing the entire state (e.g., from API response)
const users = ref([])
async function fetchUsers() {
  users.value = await api.getUsers()  // Complete replacement is fine
}

// 2. When you need a snapshot for comparison
const previousState = { ...currentState }  // For undo/redo

// 3. When passing data to external libraries expecting immutable data
const chartData = computed(() => [...rawData.value])  // Copy for chart lib
```

## The Vue Mental Model

```javascript
// Vue's reactivity is like a spreadsheet:
// - Cell A1 contains a value (ref)
// - Cell B1 has a formula referencing A1 (computed)
// - Change A1, and B1 automatically updates

const a1 = ref(10)
const b1 = computed(() => a1.value * 2)

// You CHANGE A1 (mutate), you don't create a new A1
a1.value = 20  // b1 automatically becomes 40

// This is fundamentally different from:
// state = reducer(state, action)  // Functional/Redux pattern
```

## Reference
- [Composition API FAQ](https://vuejs.org/guide/extras/composition-api-faq.html)
- [Reactivity Fundamentals](https://vuejs.org/guide/essentials/reactivity-fundamentals.html)
