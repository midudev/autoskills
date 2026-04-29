---
title: Dynamic Directive Arguments Have Syntax Constraints
impact: MEDIUM
impactDescription: Invalid dynamic arguments cause silent failures or browser compatibility issues
type: capability
tags: [vue3, template, directives, v-bind, v-on, dynamic-arguments]
---

# Dynamic Directive Arguments Have Syntax Constraints

**Impact: MEDIUM** - Dynamic directive arguments (e.g., `:[attributeName]`, `@[eventName]`) have value and syntax constraints that can cause silent failures. In-DOM templates also have case sensitivity issues with browsers lowercasing attribute names.

Dynamic arguments allow runtime determination of which attribute or event to bind, but they have restrictions that differ from static arguments.

## Task Checklist

- [ ] Ensure dynamic arguments evaluate to strings or `null`
- [ ] Avoid spaces and quotes inside dynamic argument brackets
- [ ] Use computed properties for complex dynamic argument expressions
- [ ] In in-DOM templates, use lowercase attribute names or switch to SFCs
- [ ] Use `null` to explicitly remove a binding

**Incorrect:**
```vue
<template>
  <!-- ERROR: Spaces and quotes not allowed in dynamic arguments -->
  <a :[' foo' + bar]="value">Link</a>
  <a :["data-" + name]="value">Link</a>

  <!-- WARNING: Non-string values (except null) trigger warnings -->
  <a :[123]="value">Link</a>
  <a :[someObject]="value">Link</a>

  <!-- BUG in in-DOM templates: Browsers lowercase attribute names -->
  <!-- This becomes :[someattr] which won't match someAttr -->
  <a :[someAttr]="url">Link</a>
</template>

<script setup>
// If component expects someAttr but browser lowercases to someattr
// the binding silently fails
const someAttr = 'href'
</script>
```

**Correct:**
```vue
<template>
  <!-- OK: Simple variable reference -->
  <a :[attributeName]="url">Link</a>

  <!-- OK: Use computed property for complex expressions -->
  <a :[dynamicAttr]="value">Link</a>

  <!-- OK: null removes the binding -->
  <button :[disabledAttr]="isDisabled">Submit</button>

  <!-- OK: Dynamic event names -->
  <button @[eventName]="handler">Click</button>

  <!-- OK: In SFCs, case is preserved -->
  <a :[someAttr]="url">Link</a>
</template>

<script setup>
import { ref, computed } from 'vue'

// Simple string variable
const attributeName = ref('href')
const url = ref('https://vuejs.org')

// Complex expression via computed property
const prefix = ref('data')
const name = ref('id')
const dynamicAttr = computed(() => `${prefix.value}-${name.value}`)

// Conditional binding with null
const isDisabled = ref(false)
const disabledAttr = computed(() => isDisabled.value ? 'disabled' : null)

// Dynamic events
const useTouch = ref(false)
const eventName = computed(() => useTouch.value ? 'touchstart' : 'click')

function handler() {
  console.log('Event triggered')
}
</script>
```

## In-DOM Template Workaround

When writing templates directly in HTML (not SFCs), use lowercase:

```html
<!-- In-DOM template (index.html) -->
<div id="app">
  <!-- Use lowercase to avoid browser issues -->
  <a :[attrname]="url">Link</a>
</div>

<script type="module">
import { createApp, ref } from 'vue'

createApp({
  setup() {
    // Match the lowercase used in template
    const attrname = ref('href')
    const url = ref('https://vuejs.org')
    return { attrname, url }
  }
}).mount('#app')
</script>
```

## SFC vs In-DOM Templates

| Feature | SFC (.vue files) | In-DOM (HTML) |
|---------|------------------|---------------|
| Case sensitivity | Preserved | Lowercased by browser |
| Dynamic arguments | Full support | Lowercase only |
| Recommendation | Preferred | Use for progressive enhancement |

## Valid Dynamic Argument Values

```vue
<script setup>
// String values - OK
const attr1 = 'href'
const attr2 = 'data-custom'

// null - OK (removes binding)
const attr3 = null

// undefined - OK (removes binding)
const attr4 = undefined

// Numbers, objects, arrays - WARNING
const attr5 = 123        // Warning: should be string
const attr6 = { foo: 1 } // Warning: should be string
</script>
```

## Reference
- [Vue.js Template Syntax - Dynamic Arguments](https://vuejs.org/guide/essentials/template-syntax.html#dynamic-arguments)
- [Vue.js Template Syntax - Dynamic Argument Value Constraints](https://vuejs.org/guide/essentials/template-syntax.html#dynamic-argument-value-constraints)
