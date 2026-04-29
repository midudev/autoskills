---
title: Use .exact Modifier for Precise Keyboard/Mouse Shortcuts
impact: MEDIUM
impactDescription: Without .exact, shortcuts fire even when additional modifier keys are pressed, causing unintended behavior
type: best-practice
tags: [vue3, events, keyboard, modifiers, shortcuts, accessibility]
---

# Use .exact Modifier for Precise Keyboard/Mouse Shortcuts

**Impact: MEDIUM** - By default, Vue's modifier key handlers (`.ctrl`, `.alt`, `.shift`, `.meta`) fire even when other modifier keys are also pressed. Use `.exact` to require that ONLY the specified modifiers are pressed, preventing accidental triggering of shortcuts.

## Task Checklist

- [ ] Use `.exact` when you need precise modifier combinations
- [ ] Without `.exact`: `@click.ctrl` fires for Ctrl+Click AND Ctrl+Shift+Click
- [ ] With `.exact`: `@click.ctrl.exact` fires ONLY for Ctrl+Click
- [ ] Use `@click.exact` for plain clicks with no modifiers

**Incorrect:**
```html
<!-- WRONG: Fires even with additional modifiers -->
<template>
  <button @click.ctrl="copyItem">Copy</button>
  <!-- Also fires on Ctrl+Shift+Click, Ctrl+Alt+Click, etc. -->

  <button @click.ctrl.shift="copyAll">Copy All</button>
  <!-- User expects Ctrl+Shift, but also fires on Ctrl+Shift+Alt -->
</template>
```

```html
<!-- WRONG: Conflicting shortcuts without .exact -->
<template>
  <div>
    <button @click.ctrl="copy">Copy (Ctrl+Click)</button>
    <button @click.ctrl.shift="copyAll">Copy All (Ctrl+Shift+Click)</button>
    <!-- Both fire when user does Ctrl+Shift+Click! -->
  </div>
</template>
```

**Correct:**
```html
<!-- CORRECT: Precise modifier matching with .exact -->
<template>
  <button @click.ctrl.exact="copyItem">Copy (Ctrl only)</button>
  <!-- Only fires on Ctrl+Click, not Ctrl+Shift+Click -->

  <button @click.ctrl.shift.exact="copyAll">Copy All (Ctrl+Shift only)</button>
  <!-- Only fires on Ctrl+Shift+Click, not Ctrl+Shift+Alt+Click -->
</template>
```

```html
<!-- CORRECT: Plain click without any modifiers -->
<template>
  <button @click.exact="selectItem">Select</button>
  <!-- Only fires when NO modifier keys are pressed -->
  <!-- Ctrl+Click, Shift+Click, etc. will NOT trigger this -->
</template>
```

```html
<!-- CORRECT: Non-conflicting shortcuts -->
<template>
  <div class="editor">
    <div
      @click.exact="selectItem"
      @click.ctrl.exact="addToSelection"
      @click.shift.exact="extendSelection"
      @click.ctrl.shift.exact="selectRange"
    >
      Click, Ctrl+Click, Shift+Click, or Ctrl+Shift+Click
    </div>
  </div>
</template>
```

## Behavior Comparison

```javascript
// WITHOUT .exact
@click.ctrl="handler"
// Fires when: Ctrl+Click, Ctrl+Shift+Click, Ctrl+Alt+Click, Ctrl+Shift+Alt+Click
// Does NOT fire: Click (without Ctrl)

// WITH .exact
@click.ctrl.exact="handler"
// Fires when: ONLY Ctrl+Click
// Does NOT fire: Ctrl+Shift+Click, Ctrl+Alt+Click, Click

// ONLY .exact (no other modifiers)
@click.exact="handler"
// Fires when: Plain click with NO modifiers
// Does NOT fire: Ctrl+Click, Shift+Click, Alt+Click
```

## Practical Example: File Browser Selection

```vue
<template>
  <ul class="file-list">
    <li
      v-for="file in files"
      :key="file.id"
      @click.exact="selectSingle(file)"
      @click.ctrl.exact="toggleSelection(file)"
      @click.shift.exact="selectRange(file)"
      @click.ctrl.shift.exact="addRangeToSelection(file)"
      :class="{ selected: isSelected(file) }"
    >
      {{ file.name }}
    </li>
  </ul>
</template>

<script setup>
// Each click type has distinct, non-overlapping behavior
function selectSingle(file) {
  // Clear selection and select only this file
}

function toggleSelection(file) {
  // Add or remove this file from current selection
}

function selectRange(file) {
  // Select all files from last selected to this one
}

function addRangeToSelection(file) {
  // Add range to existing selection
}
</script>
```

## Keyboard Shortcuts with .exact

```html
<template>
  <div
    tabindex="0"
    @keydown.ctrl.s.exact.prevent="save"
    @keydown.ctrl.shift.s.exact.prevent="saveAs"
    @keydown.ctrl.z.exact.prevent="undo"
    @keydown.ctrl.shift.z.exact.prevent="redo"
  >
    <!-- Each shortcut is precisely defined -->
  </div>
</template>
```

## Reference
- [Vue.js Event Handling - .exact Modifier](https://vuejs.org/guide/essentials/event-handling.html#exact-modifier)
