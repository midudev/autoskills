---
title: v-show Does Not Work on template or With v-else
impact: MEDIUM
impactDescription: Using v-show on template silently fails, element is always rendered
type: capability
tags: [vue3, conditional-rendering, v-show, template, limitations]
---

# v-show Does Not Work on template or With v-else

**Impact: MEDIUM** - `v-show` cannot be used on `<template>` elements because templates don't render to the DOM (so there's nothing to apply `display: none` to). Additionally, `v-show` does not support `v-else`. Using these incorrectly results in elements that are always visible or else branches that never work.

## Task Checklist

- [ ] Never use v-show on `<template>` elements - use v-if instead
- [ ] Never use v-else with v-show - use separate v-show with negated condition
- [ ] Remember v-show only works on actual DOM elements
- [ ] If you need to toggle multiple elements frequently, wrap in a real element (div, span)

**Incorrect:**
```html
<!-- WRONG: v-show on <template> - silently does nothing -->
<template>
  <template v-show="isVisible">
    <h1>Title</h1>
    <p>Content</p>
  </template>
  <!-- These elements will ALWAYS be visible -->
</template>
```

```html
<!-- WRONG: v-else with v-show - v-else is not supported -->
<template>
  <div v-show="isLoggedIn">Welcome!</div>
  <div v-else>Please log in</div>  <!-- This v-else won't work -->
</template>
```

```html
<!-- WRONG: Mixing v-show and v-else expectations -->
<template>
  <span v-show="status === 'success'">Success!</span>
  <span v-else-if="status === 'error'">Error</span>  <!-- Not supported -->
</template>
```

**Correct:**
```html
<!-- CORRECT: Use v-if on <template> for multiple elements -->
<template>
  <template v-if="isVisible">
    <h1>Title</h1>
    <p>Content</p>
  </template>
</template>
```

```html
<!-- CORRECT: Use negated v-show for "else" behavior -->
<template>
  <div v-show="isLoggedIn">Welcome!</div>
  <div v-show="!isLoggedIn">Please log in</div>
</template>
```

```html
<!-- CORRECT: Wrap in a real element if you need v-show for multiple elements -->
<template>
  <div v-show="isVisible">
    <h1>Title</h1>
    <p>Content</p>
  </div>
</template>
```

```html
<!-- CORRECT: Use v-if/v-else when you need else branches -->
<template>
  <div v-if="status === 'success'">Success!</div>
  <div v-else-if="status === 'error'">Error</div>
  <div v-else>Loading...</div>
</template>
```

```html
<!-- CORRECT: Multiple v-show conditions -->
<template>
  <span v-show="status === 'success'">Success!</span>
  <span v-show="status === 'error'">Error</span>
  <span v-show="status === 'loading'">Loading...</span>
</template>
```

## Why This Limitation Exists

```javascript
// v-show works by toggling the CSS display property
// This requires an actual DOM element

// <template> is a virtual element - it doesn't render to DOM
// It's just a wrapper for Vue's rendering logic

// After compilation:
// <template v-if="show"><p>Hi</p></template>
// Renders as: <p>Hi</p> (when show is true)
// Template itself is gone

// v-show needs a real element to set display: none on
// Since <template> doesn't exist in DOM, v-show has nothing to work with
```

## When to Choose Each

| Need | Use |
|------|-----|
| Toggle multiple elements with CSS | Wrap in real element + `v-show` |
| Toggle multiple elements without wrapper | `<template v-if>` |
| Need v-else branches | `v-if`/`v-else` |
| Frequent toggle, single element | `v-show` |
| Frequent toggle, need "else" | Two `v-show` with negated conditions |

## Reference
- [Vue.js Conditional Rendering - v-show](https://vuejs.org/guide/essentials/conditional.html#v-show)
