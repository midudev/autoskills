---
title: Avoid Hidden Side Effects in Composables
impact: HIGH
impactDescription: Side effects hidden in composables make debugging difficult and create implicit coupling between components
type: best-practice
tags: [vue3, composables, composition-api, side-effects, provide-inject, global-state]
---

# Avoid Hidden Side Effects in Composables

**Impact: HIGH** - Composables should encapsulate stateful logic, not hide side effects that affect things outside their scope. Hidden side effects like modifying global state, using provide/inject internally, or manipulating the DOM directly make composables unpredictable and hard to debug.

When a composable has unexpected side effects, consumers can't reason about what calling it will do. This leads to bugs that are difficult to trace and composables that can't be safely reused.

## Task Checklist

- [ ] Avoid using provide/inject inside composables (make dependencies explicit)
- [ ] Don't modify Pinia/Vuex store state internally (accept store as parameter instead)
- [ ] Don't manipulate DOM directly (use template refs passed as arguments)
- [ ] Document any unavoidable side effects clearly
- [ ] Keep composables focused on returning reactive state and methods

**Incorrect:**
```javascript
// WRONG: Hidden provide/inject dependency
export function useTheme() {
  // Consumer has no idea this depends on a provided theme
  const theme = inject('theme')  // What if nothing provides this?

  const isDark = computed(() => theme?.mode === 'dark')
  return { isDark }
}

// WRONG: Modifying global store internally
import { useUserStore } from '@/stores/user'

export function useLogin() {
  const userStore = useUserStore()

  async function login(credentials) {
    const user = await api.login(credentials)
    // Hidden side effect: modifying global state
    userStore.setUser(user)
    userStore.setToken(user.token)
    // Consumer doesn't know the store was modified!
  }

  return { login }
}

// WRONG: Hidden DOM manipulation
export function useFocusTrap() {
  onMounted(() => {
    // Which element? Consumer has no control
    document.querySelector('.modal')?.focus()
  })
}

// WRONG: Hidden provide that affects descendants
export function useFormContext() {
  const form = reactive({ values: {}, errors: {} })
  // Components calling this have no idea it provides something
  provide('form-context', form)
  return form
}
```

**Correct:**
```javascript
// CORRECT: Explicit dependency injection
export function useTheme(injectedTheme) {
  // If no theme passed, consumer must handle it
  const theme = injectedTheme ?? { mode: 'light' }

  const isDark = computed(() => theme.mode === 'dark')
  return { isDark }
}

// Usage - dependency is explicit
const theme = inject('theme', { mode: 'light' })
const { isDark } = useTheme(theme)

// CORRECT: Return actions, let consumer decide when to call them
export function useLogin() {
  const user = ref(null)
  const token = ref(null)
  const isLoading = ref(false)
  const error = ref(null)

  async function login(credentials) {
    isLoading.value = true
    error.value = null
    try {
      const response = await api.login(credentials)
      user.value = response.user
      token.value = response.token
      return response
    } catch (e) {
      error.value = e
      throw e
    } finally {
      isLoading.value = false
    }
  }

  return { user, token, isLoading, error, login }
}

// Consumer decides what to do with the result
const { user, token, login } = useLogin()
const userStore = useUserStore()

async function handleLogin(credentials) {
  await login(credentials)
  // Consumer explicitly updates the store
  userStore.setUser(user.value)
  userStore.setToken(token.value)
}

// CORRECT: Accept element as parameter
export function useFocusTrap(targetRef) {
  onMounted(() => {
    targetRef.value?.focus()
  })

  onUnmounted(() => {
    // Cleanup focus trap
  })
}

// Usage - consumer controls which element
const modalRef = ref(null)
useFocusTrap(modalRef)

// CORRECT: Separate composable from provider
export function useFormContext() {
  const form = reactive({ values: {}, errors: {} })
  return form
}

// In parent component - explicit provide
const form = useFormContext()
provide('form-context', form)
```

## Acceptable Side Effects (With Documentation)

Some side effects are acceptable when they're the core purpose of the composable:

```javascript
/**
 * Tracks mouse position globally.
 *
 * SIDE EFFECTS:
 * - Adds 'mousemove' event listener to window (cleaned up on unmount)
 *
 * @returns {Object} Mouse coordinates { x, y }
 */
export function useMouse() {
  const x = ref(0)
  const y = ref(0)

  // This side effect is the whole point of the composable
  // and is properly cleaned up
  onMounted(() => window.addEventListener('mousemove', update))
  onUnmounted(() => window.removeEventListener('mousemove', update))

  function update(event) {
    x.value = event.pageX
    y.value = event.pageY
  }

  return { x, y }
}
```

## Pattern: Dependency Injection for Flexibility

```javascript
// Composable accepts its dependencies
export function useDataFetcher(apiClient, cache = null) {
  const data = ref(null)

  async function fetch(url) {
    if (cache) {
      const cached = cache.get(url)
      if (cached) {
        data.value = cached
        return
      }
    }

    data.value = await apiClient.get(url)
    cache?.set(url, data.value)
  }

  return { data, fetch }
}

// Usage - dependencies are explicit and testable
const apiClient = inject('apiClient')
const cache = inject('cache', null)
const { data, fetch } = useDataFetcher(apiClient, cache)
```

## Reference
- [Vue.js Composables](https://vuejs.org/guide/reusability/composables.html)
- [Common Mistakes Creating Composition Functions](https://www.telerik.com/blogs/common-mistakes-creating-composition-functions-vue)
