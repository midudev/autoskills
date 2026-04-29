---
title: Use nextTick() to Wait for DOM Updates
impact: MEDIUM
impactDescription: DOM updates are batched and asynchronous - direct DOM access after state changes sees stale values
type: capability
tags: [vue3, dom, nextTick, reactivity, async]
---

# Use nextTick() to Wait for DOM Updates

**Impact: MEDIUM** - Vue batches DOM updates asynchronously for performance. If you access the DOM immediately after changing reactive state, you'll see the old values. Use `nextTick()` to wait for the DOM to update.

When you modify reactive state, Vue doesn't update the DOM synchronously. Instead, it buffers changes and applies them in the next "tick" of the event loop. This is a performance optimization, but it can cause bugs when you need to read from or manipulate the DOM after state changes.

## Task Checklist

- [ ] Use `await nextTick()` when you need to access updated DOM elements after state changes
- [ ] Use `nextTick()` when measuring DOM elements (heights, widths) after data changes
- [ ] Use `nextTick()` when focusing inputs or scrolling after content updates
- [ ] Consider if you really need DOM access - often you can work with reactive data instead

**Incorrect:**
```javascript
import { ref } from 'vue'

const message = ref('Hello')
const messageEl = ref(null)

function updateMessage() {
  message.value = 'Updated!'

  // WRONG: DOM still shows "Hello" at this point
  console.log(messageEl.value.textContent) // "Hello" - stale!

  // WRONG: Scrolling/focusing may not work correctly
  scrollContainer.value.scrollTop = scrollContainer.value.scrollHeight
}
```

**Correct:**
```javascript
import { ref, nextTick } from 'vue'

const message = ref('Hello')
const messageEl = ref(null)

async function updateMessage() {
  message.value = 'Updated!'

  // CORRECT: Wait for DOM to update
  await nextTick()

  // Now the DOM is updated
  console.log(messageEl.value.textContent) // "Updated!"

  // Scrolling and focusing now work correctly
  scrollContainer.value.scrollTop = scrollContainer.value.scrollHeight
}

// Alternative: callback syntax
function updateWithCallback() {
  message.value = 'Updated!'

  nextTick(() => {
    console.log(messageEl.value.textContent) // "Updated!"
  })
}
```

```vue
<script setup>
import { ref, nextTick } from 'vue'

const items = ref([])
const listRef = ref(null)

async function addItem() {
  items.value.push({ id: Date.now(), text: 'New item' })

  await nextTick()

  // Now we can safely scroll to the new item
  listRef.value.lastElementChild?.scrollIntoView({ behavior: 'smooth' })
}
</script>
```

## Reference
- [Vue.js Reactivity Fundamentals - DOM Update Timing](https://vuejs.org/guide/essentials/reactivity-fundamentals.html#dom-update-timing)
- [Vue.js nextTick API](https://vuejs.org/api/general.html#nexttick)
