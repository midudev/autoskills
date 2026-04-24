---
title: Slot Name is Reserved and Not Included in Slot Props
impact: LOW
impactDescription: Expecting 'name' in scoped slot props when it's reserved causes confusion
type: gotcha
tags: [vue3, slots, scoped-slots, reserved-props, naming]
---

# Slot Name is Reserved and Not Included in Slot Props

**Impact: LOW** - When using scoped slots, the `name` attribute on the `<slot>` element is reserved for identifying the slot. It is not passed as part of the slot props to the parent component.

## Task Checklist

- [ ] Don't expect `name` in slot props - it's reserved
- [ ] Use a different prop name if you need to pass a name value
- [ ] Remember only explicitly bound attributes become slot props

**Incorrect Expectation:**
```vue
<!-- ChildComponent.vue -->
<template>
  <div>
    <slot name="header" title="Welcome"></slot>
  </div>
</template>
```

```vue
<!-- ParentComponent.vue -->
<ChildComponent>
  <template #header="props">
    <!-- props = { title: "Welcome" } -->
    <!-- 'name' is NOT included! -->
    {{ props.name }}  <!-- undefined -->
    {{ props.title }} <!-- "Welcome" -->
  </template>
</ChildComponent>
```

**If You Need to Pass a "Name" Value:**
```vue
<!-- ChildComponent.vue -->
<template>
  <div>
    <!-- Use a different prop name like 'slotName' or 'label' -->
    <slot name="header" :label="slotLabel" :title="title"></slot>
  </div>
</template>

<script setup>
const slotLabel = 'header'
const title = 'Welcome'
</script>
```

```vue
<!-- ParentComponent.vue -->
<ChildComponent>
  <template #header="{ label, title }">
    <h2>{{ title }}</h2>
    <span>Section: {{ label }}</span>
  </template>
</ChildComponent>
```

## What Gets Passed as Slot Props

| Attribute on `<slot>` | Passed to Parent? |
|----------------------|-------------------|
| `name` | No (reserved for slot identification) |
| `:text="message"` | Yes, as `text` |
| `:count="5"` | Yes, as `count` |
| `v-bind="object"` | Yes, spreads object properties |
| `class="..."` | No (not bound with `:`) |

## Multiple Named Slots Example

```vue
<!-- TabPanel.vue -->
<template>
  <div class="tabs">
    <slot name="tab1" :active="activeTab === 1" :label="'First Tab'"></slot>
    <slot name="tab2" :active="activeTab === 2" :label="'Second Tab'"></slot>
  </div>
</template>

<script setup>
import { ref } from 'vue'
const activeTab = ref(1)
</script>
```

```vue
<!-- Usage -->
<TabPanel>
  <template #tab1="{ active, label }">
    <!-- 'name' not available, but 'label' is -->
    <button :class="{ active }">{{ label }}</button>
  </template>

  <template #tab2="{ active, label }">
    <button :class="{ active }">{{ label }}</button>
  </template>
</TabPanel>
```

## Reference
- [Vue.js Slots - Scoped Slots](https://vuejs.org/guide/components/slots.html#scoped-slots)
