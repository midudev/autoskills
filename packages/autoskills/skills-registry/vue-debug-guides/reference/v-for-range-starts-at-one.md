---
title: v-for Range Iteration Starts at 1, Not 0
impact: LOW
impactDescription: v-for with a number range starts at 1, unlike JavaScript arrays which start at 0
type: gotcha
tags: [vue3, v-for, list-rendering, range]
---

# v-for Range Iteration Starts at 1, Not 0

**Impact: LOW** - When using `v-for` with a number (range iteration), the iteration starts at `1`, not `0`. This differs from typical JavaScript behavior where arrays are 0-indexed.

This gotcha commonly causes off-by-one errors when the generated numbers are used for calculations or array indexing.

## Task Checklist

- [ ] Remember `v-for="n in 10"` produces 1 through 10, not 0 through 9
- [ ] When using range values for array indexing, subtract 1: `items[n - 1]`
- [ ] Consider creating a computed array if you need 0-based indices

**Incorrect Assumption:**
```html
<!-- Developer expects 0-9, but gets 1-10 -->
<span v-for="n in 10">{{ n }}</span>
<!-- Output: 1 2 3 4 5 6 7 8 9 10 -->

<!-- WRONG: Off-by-one error when used for array access -->
<li v-for="n in items.length" :key="n">
  {{ items[n].name }}  <!-- Error! items[10] is undefined when length is 10 -->
</li>
```

**Correct:**
```html
<!-- Correct understanding: 1-based range -->
<span v-for="n in 10" :key="n">{{ n }}</span>
<!-- Output: 1 2 3 4 5 6 7 8 9 10 -->

<!-- CORRECT: Adjust index for array access -->
<li v-for="n in items.length" :key="n">
  {{ items[n - 1].name }}  <!-- n-1 converts to 0-based -->
</li>

<!-- BETTER: Just iterate the array directly -->
<li v-for="(item, index) in items" :key="item.id">
  {{ index + 1 }}. {{ item.name }}  <!-- index is 0-based, add 1 for display -->
</li>
```

```html
<!-- Range for repeating elements (no array involved) -->
<div v-for="n in 3" :key="n" class="skeleton-row">
  Loading placeholder {{ n }} of 3...
</div>
<!-- Output: Loading placeholder 1 of 3, 2 of 3, 3 of 3 -->
```

## When Range Iteration Is Useful

- Rendering a fixed number of placeholder/skeleton elements
- Creating pagination buttons: `v-for="page in totalPages"`
- Generating star ratings: `v-for="star in 5"`
- Repeating template structures a set number of times

## Reference
- [Vue.js List Rendering - v-for with a Range](https://vuejs.org/guide/essentials/list.html#v-for-with-a-range)
