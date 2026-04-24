---
title: Call toValue() Inside watchEffect for Proper Dependency Tracking
impact: HIGH
impactDescription: Calling toValue() outside watchEffect prevents reactive dependency tracking, causing the effect to never re-run
type: gotcha
tags: [vue3, composables, composition-api, watchEffect, toValue, reactivity]
---

# Call toValue() Inside watchEffect for Proper Dependency Tracking

**Impact: HIGH** - When writing composables that accept `MaybeRefOrGetter` arguments, you must call `toValue()` inside the `watchEffect` callback, not outside. If you extract the value before the watchEffect, Vue cannot track the dependency and the effect will never re-run when the source changes.

This is a subtle but critical mistake that leads to composables that work with initial values but never update.

## Task Checklist

- [ ] Always call `toValue()` inside `watchEffect` callbacks, not before
- [ ] Similarly, access `.value` on refs inside watchEffect, not outside
- [ ] For `watch()`, use a getter function that calls `toValue()`
- [ ] Test that composables update when their inputs change

**Incorrect:**
```javascript
import { ref, watchEffect, toValue } from 'vue'

export function useFetch(url) {
  const data = ref(null)
  const error = ref(null)

  // WRONG: toValue called outside watchEffect
  // This extracts the value ONCE and passes a static string
  const urlValue = toValue(url)

  watchEffect(async () => {
    try {
      // urlValue is a static string - no dependency tracked!
      const response = await fetch(urlValue)
      data.value = await response.json()
    } catch (e) {
      error.value = e
    }
  })

  return { data, error }
}

// When used like this:
const apiUrl = ref('/api/users')
const { data } = useFetch(apiUrl)

// Later...
apiUrl.value = '/api/products'  // useFetch will NOT refetch!
```

**Correct:**
```javascript
import { ref, watchEffect, toValue } from 'vue'

export function useFetch(url) {
  const data = ref(null)
  const error = ref(null)

  watchEffect(async () => {
    // CORRECT: toValue called INSIDE watchEffect
    // Vue tracks this as a dependency
    const urlValue = toValue(url)

    try {
      const response = await fetch(urlValue)
      data.value = await response.json()
    } catch (e) {
      error.value = e
    }
  })

  return { data, error }
}

// Now when used:
const apiUrl = ref('/api/users')
const { data } = useFetch(apiUrl)

// Later...
apiUrl.value = '/api/products'  // useFetch WILL refetch!
```

## The Same Applies to Direct Ref Access

```javascript
// WRONG: Accessing .value outside the effect
export function useDebounce(source, delay = 300) {
  // This captures the initial value, not a reactive dependency
  const initialValue = source.value  // or toValue(source)

  watchEffect(() => {
    // initialValue is static - this only runs once
    console.log('Value:', initialValue)
  })
}

// CORRECT: Access inside the effect
export function useDebounce(source, delay = 300) {
  watchEffect(() => {
    // Vue tracks source.value or toValue(source) as dependency
    console.log('Value:', toValue(source))
  })
}
```

## Pattern: Using watch() with Getter Functions

For `watch()`, wrap `toValue()` in a getter:

```javascript
import { ref, watch, toValue } from 'vue'

export function useLocalStorage(key, defaultValue) {
  const data = ref(defaultValue)

  // CORRECT: Use getter function with watch
  watch(
    () => toValue(key),  // Getter calls toValue, tracks dependency
    (newKey) => {
      const stored = localStorage.getItem(newKey)
      data.value = stored ? JSON.parse(stored) : defaultValue
    },
    { immediate: true }
  )

  return data
}
```

## Why This Happens

Vue's reactivity tracking works by detecting property accesses during effect execution:

```javascript
watchEffect(() => {
  // When this runs, Vue is "recording" what reactive sources are accessed
  const value = someRef.value  // Vue records: "this effect depends on someRef"
})

// But if you extract the value before:
const value = someRef.value  // Vue isn't recording yet
watchEffect(() => {
  console.log(value)  // Just using a plain JavaScript variable
})
```

`toValue()` works the same way - it accesses `.value` internally, so it must happen during effect execution for tracking to work.

## Quick Checklist for Composable Authors

When accepting `MaybeRefOrGetter` inputs:

1. Store the raw argument (don't call `toValue` during setup)
2. Call `toValue()` inside any reactive context (`watchEffect`, `watch`, `computed`)
3. Test with both static values AND refs that change

```javascript
export function useMyComposable(input) {
  // Store raw - don't extract value here
  // const value = toValue(input)  // WRONG

  const result = computed(() => {
    // Extract value inside reactive context
    return transform(toValue(input))  // CORRECT
  })

  watchEffect(() => {
    // Extract value inside reactive context
    doSomething(toValue(input))  // CORRECT
  })

  return { result }
}
```

## Reference
- [Vue.js Reactivity API - toValue](https://vuejs.org/api/reactivity-utilities.html#tovalue)
- [Vue.js Composables - Accepting Ref Arguments](https://vuejs.org/guide/reusability/composables.html#accepting-reactive-state)
