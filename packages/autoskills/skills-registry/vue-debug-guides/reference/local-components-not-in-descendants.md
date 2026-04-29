---
title: Locally Registered Components Are Not Available in Descendants
impact: HIGH
impactDescription: Common source of "component not found" errors in nested components
type: gotcha
tags: [vue3, component-registration, local-registration, scope, nested-components]
---

# Locally Registered Components Are Not Available in Descendants

**Impact: HIGH** - Locally registered components are only available in the component where they are registered, NOT in its child or descendant components. This is a common source of "Unknown component" or "Failed to resolve component" errors when developers expect a component registered in a parent to be available in children.

## Task Checklist

- [ ] Import and register components in every file where they are used
- [ ] Do not expect parent's local components to be available in children
- [ ] If a component is needed in many places, consider global registration only as a last resort
- [ ] Use IDE auto-import features to simplify repeated imports

**Incorrect:**
```vue
<!-- ParentComponent.vue -->
<script setup>
import Card from './Card.vue'
import ChildComponent from './ChildComponent.vue'
</script>

<template>
  <Card>Parent content</Card>
  <ChildComponent />
</template>
```

```vue
<!-- ChildComponent.vue -->
<script setup>
// WRONG: Expecting Card to be available because parent imported it
// This will cause "Failed to resolve component: Card" error
</script>

<template>
  <!-- ERROR: Card is not available here! -->
  <Card>
    Child content
  </Card>
</template>
```

**Correct:**
```vue
<!-- ParentComponent.vue -->
<script setup>
import Card from './Card.vue'
import ChildComponent from './ChildComponent.vue'
</script>

<template>
  <Card>Parent content</Card>
  <ChildComponent />
</template>
```

```vue
<!-- ChildComponent.vue -->
<script setup>
// CORRECT: Each component must import what it uses
import Card from './Card.vue'
</script>

<template>
  <Card>
    Child content
  </Card>
</template>
```

## Common Scenarios

### Scenario 1: Deeply Nested Components
```vue
<!-- GrandchildComponent.vue -->
<script setup>
// Even if parent and grandparent both use Card,
// grandchild must import it separately
import Card from '@/components/Card.vue'
import Button from '@/components/Button.vue'
</script>

<template>
  <Card>
    <Button>Click me</Button>
  </Card>
</template>
```

### Scenario 2: Slot Content with Components
```vue
<!-- Parent.vue -->
<script setup>
import Modal from './Modal.vue'
import Form from './Form.vue'
</script>

<template>
  <!-- Form is registered in Parent, so it works in slot content -->
  <Modal>
    <Form /> <!-- This works because slot content is compiled in Parent's scope -->
  </Modal>
</template>
```

```vue
<!-- Modal.vue -->
<script setup>
// Modal doesn't need to import Form because slot content
// is compiled in the parent's scope, not Modal's scope
</script>

<template>
  <div class="modal">
    <slot /> <!-- Form component works here because it's parent's slot content -->
  </div>
</template>
```

### Scenario 3: Dynamic Components
```vue
<!-- Container.vue -->
<script setup>
import TabA from './TabA.vue'
import TabB from './TabB.vue'
import { ref, shallowRef } from 'vue'

// When using dynamic components, all possible components must be imported
const currentTab = shallowRef(TabA)
</script>

<template>
  <component :is="currentTab" />
</template>
```

## Why This Design?

Local registration provides:
1. **Explicit dependencies** - You can see exactly what each component uses
2. **Tree-shaking** - Unused components are removed from bundles
3. **Clear scope** - No magic or implicit behavior

## Reference
- [Vue.js Component Registration - Local Registration](https://vuejs.org/guide/components/registration.html#local-registration)
