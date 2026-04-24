---
title: v-else Must Immediately Follow v-if or v-else-if
impact: MEDIUM
impactDescription: Misplaced v-else causes a compile-time error in SFCs, or renders unconditionally with runtime template compilation
type: capability
tags: [vue3, conditional-rendering, v-if, v-else, v-else-if]
---

# v-else Must Immediately Follow v-if or v-else-if

**Impact: MEDIUM** - A `v-else` or `v-else-if` element must immediately follow a `v-if` or `v-else-if` element in the DOM. If there's any element in between:

- **SFC compilation (Vite/vue-loader):** Vue throws a **compile-time SyntaxError** - the code won't build at all
- **Runtime template compilation:** The element renders unconditionally (always visible), losing its conditional behavior

In most modern Vue projects using Single File Components, this is caught at build time.

## Task Checklist

- [ ] Place v-else immediately after the v-if element (no elements in between)
- [ ] Place v-else-if immediately after v-if or another v-else-if
- [ ] Use `<template>` wrapper if you need to group multiple elements within a branch
- [ ] If you need content between conditions, restructure using nested conditionals or computed

**Incorrect:**
```html
<!-- WRONG: v-else not immediately after v-if -->
<template>
  <div v-if="isLoggedIn">
    Welcome back!
  </div>

  <p>Some other content in between</p>

  <div v-else>
    <!-- This v-else is NOT recognized! It will ALWAYS render (unconditionally) -->
    Please log in
  </div>
</template>
```

```html
<!-- WRONG: Comment or whitespace element between -->
<template>
  <span v-if="status === 'loading'">Loading...</span>
  <!-- This comment breaks the chain! -->
  <span v-else-if="status === 'error'">Error occurred</span>
  <span v-else>Done</span>
</template>
```

```html
<!-- WRONG: Text node between conditions -->
<template>
  <div v-if="showA">A</div>
  Just some text here
  <div v-else>B</div>  <!-- Not recognized, always renders -->
</template>
```

**Correct:**
```html
<!-- CORRECT: v-else immediately follows v-if -->
<template>
  <div v-if="isLoggedIn">
    Welcome back!
  </div>
  <div v-else>
    Please log in
  </div>

  <p>Some other content (placed after the conditional block)</p>
</template>
```

```html
<!-- CORRECT: Full v-if/v-else-if/v-else chain -->
<template>
  <span v-if="status === 'loading'">Loading...</span>
  <span v-else-if="status === 'error'">Error: {{ errorMessage }}</span>
  <span v-else-if="status === 'empty'">No data found</span>
  <span v-else>{{ data }}</span>
</template>
```

```html
<!-- CORRECT: Using <template> for multiple elements per branch -->
<template>
  <template v-if="isLoggedIn">
    <h1>Welcome back!</h1>
    <p>Your dashboard</p>
    <UserStats />
  </template>
  <template v-else>
    <h1>Please log in</h1>
    <LoginForm />
  </template>
</template>
```

```html
<!-- CORRECT: Restructure if you need content between conditions -->
<template>
  <div class="conditional-section">
    <div v-if="isLoggedIn">Welcome back!</div>
    <div v-else>Please log in</div>
  </div>

  <div class="always-shown">
    Some other content
  </div>

  <div class="another-conditional">
    <div v-if="showMore">More info</div>
    <div v-else>Click to expand</div>
  </div>
</template>
```

## Debugging Tips

```html
<!-- If v-else is always visible (rendering unconditionally), check for: -->

<!-- 1. Elements between v-if and v-else -->
<!-- 2. HTML comments that break the chain -->
<!-- 3. Text nodes (including whitespace in some cases) -->
<!-- 4. Component tags that render content between -->

<!-- SFC compilation throws: "v-else/v-else-if has no adjacent v-if or v-else-if" (build fails) -->
<!-- Runtime template compilation shows a warning but renders the element unconditionally -->
<!-- Vue DevTools will show the v-else element as not part of the condition chain -->
```

## Reference
- [Vue.js Conditional Rendering - v-else](https://vuejs.org/guide/essentials/conditional.html#v-else)
