---
title: Event Modifier Order Matters
impact: MEDIUM
impactDescription: Modifier order affects event handling behavior - wrong order causes unexpected propagation or prevention
type: gotcha
tags: [vue3, events, modifiers, v-on, click, form]
---

# Event Modifier Order Matters

**Impact: MEDIUM** - When chaining event modifiers, the order determines behavior because Vue generates code in the same sequence. Using `.prevent.self` vs `.self.prevent` produces different results that can cause subtle bugs in event handling.

## Task Checklist

- [ ] Always consider modifier order when chaining multiple modifiers
- [ ] Use `.prevent.self` to prevent default on element AND children
- [ ] Use `.self.prevent` to prevent default ONLY on the element itself
- [ ] Test event behavior on both the element and its children

**Incorrect:**
```html
<!-- WRONG: Unintended behavior - prevents clicks on children too -->
<template>
  <div @click.prevent.self="handleClick">
    <button>Child Button</button> <!-- Default also prevented here! -->
  </div>
</template>
```

```html
<!-- WRONG: Assuming order doesn't matter -->
<template>
  <!-- Developer expects only self clicks to be handled -->
  <!-- But .prevent runs first, affecting all clicks -->
  <a href="/page" @click.prevent.self="navigate">
    <span>Click me</span>
  </a>
</template>
```

**Correct:**
```html
<!-- CORRECT: Only prevent default on the element itself -->
<template>
  <div @click.self.prevent="handleClick">
    <button>Child Button</button> <!-- Default NOT prevented here -->
  </div>
</template>
```

```html
<!-- CORRECT: Prevent default on element and children -->
<template>
  <form @submit.prevent.self="onSubmit">
    <button type="submit">Submit</button>
  </form>
</template>
```

```html
<!-- CORRECT: Explicit intent with separate handlers when needed -->
<template>
  <div @click.self="handleSelfClick">
    <button @click.prevent="handleChildClick">
      Child with prevented default
    </button>
  </div>
</template>
```

## How Modifier Order Works

```javascript
// Vue compiles modifiers in order, so:

// @click.prevent.self compiles to:
// event.preventDefault()
// if (event.target !== event.currentTarget) return
// handler()

// @click.self.prevent compiles to:
// if (event.target !== event.currentTarget) return
// event.preventDefault()
// handler()
```

## Common Modifier Combinations

```html
<!-- Stop propagation AND prevent default -->
<a @click.stop.prevent="handleClick">Link</a>

<!-- Capture mode with once -->
<div @click.capture.once="handleOnce">...</div>

<!-- Only exact modifier key combination -->
<button @click.ctrl.exact="onCtrlClick">Ctrl+Click Only</button>
```

## Reference
- [Vue.js Event Handling - Event Modifiers](https://vuejs.org/guide/essentials/event-handling.html#event-modifiers)
