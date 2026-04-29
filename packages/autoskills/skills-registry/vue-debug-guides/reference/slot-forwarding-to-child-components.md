---
title: Forward Slots to Child Components Correctly
impact: MEDIUM
impactDescription: Wrapper components that don't forward slots break slot functionality for consumers
type: best-practice
tags: [vue3, slots, component-composition, wrapper-components, slot-forwarding]
---

# Forward Slots to Child Components Correctly

**Impact: MEDIUM** - When creating wrapper components that enhance or extend other components, you need to forward slots from the parent to the wrapped child. Without proper slot forwarding, consumers of your wrapper cannot customize the inner component's slots.

## Task Checklist

- [ ] Use `v-for` with `$slots` to iterate over all provided slots
- [ ] Use dynamic slot names with `v-slot:[slotName]`
- [ ] Pass slot props through with `v-bind="slotProps"`
- [ ] Handle cases where slotProps might be undefined

**Basic Slot Forwarding Pattern:**
```vue
<!-- EnhancedButton.vue - Wrapper component -->
<script setup>
import BaseButton from './BaseButton.vue'
</script>

<template>
  <div class="button-wrapper">
    <BaseButton v-bind="$attrs">
      <!-- Forward all slots to BaseButton -->
      <template v-for="(_, slotName) in $slots" v-slot:[slotName]="slotProps">
        <slot :name="slotName" v-bind="slotProps ?? {}" />
      </template>
    </BaseButton>
  </div>
</template>
```

**Usage:**
```vue
<script setup>
import EnhancedButton from './EnhancedButton.vue'
</script>

<template>
  <!-- Slots pass through to BaseButton -->
  <EnhancedButton>
    <template #icon>
      <IconCheck />
    </template>
    <template #default>
      Click me
    </template>
  </EnhancedButton>
</template>
```

## Handling Scoped Slots

When the child component provides slot props, you must forward them:

```vue
<!-- DataTableWrapper.vue -->
<script setup>
import DataTable from './DataTable.vue'

const props = defineProps(['data'])
</script>

<template>
  <div class="table-container">
    <DataTable :items="data">
      <!-- Forward slots including scoped slot props -->
      <template v-for="(_, slotName) in $slots" v-slot:[slotName]="slotProps">
        <slot :name="slotName" v-bind="slotProps ?? {}" />
      </template>
    </DataTable>
  </div>
</template>
```

```vue
<!-- Consumer can use scoped slot props -->
<DataTableWrapper :data="users">
  <template #row="{ item, index }">
    <tr>
      <td>{{ index + 1 }}</td>
      <td>{{ item.name }}</td>
    </tr>
  </template>
</DataTableWrapper>
```

## Alternative: Handling Undefined slotProps

Some scenarios require checking if slotProps exists:

```vue
<template>
  <ChildComponent>
    <template v-for="(_, name) in $slots" v-slot:[name]="slotProps">
      <!-- Handle both scoped and non-scoped slots -->
      <slot v-if="slotProps" :name="name" v-bind="slotProps" />
      <slot v-else :name="name" />
    </template>
  </ChildComponent>
</template>
```

## Forwarding Specific Slots Only

If you only want to forward certain slots:

```vue
<template>
  <ChildComponent>
    <!-- Only forward header and footer slots -->
    <template v-if="$slots.header" #header="slotProps">
      <slot name="header" v-bind="slotProps ?? {}" />
    </template>

    <template v-if="$slots.footer" #footer="slotProps">
      <slot name="footer" v-bind="slotProps ?? {}" />
    </template>

    <!-- Default slot handled differently -->
    <slot />
  </ChildComponent>
</template>
```

## Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Not using `v-bind="slotProps"` | Scoped slot data lost | Always bind slotProps |
| Forgetting `?? {}` or null check | Error when slotProps undefined | Add nullish coalescing |
| Static slot names in loop | Only forwards one slot | Use `v-slot:[slotName]` dynamic syntax |
| Missing `v-for` key warning | Vue warning (non-critical) | Keys not needed for slot functions |

## Reference
- [Vue Land FAQ - Forwarding Slots](https://vue-land.github.io/faq/forwarding-slots)
- [Vue.js Slots - Scoped Slots](https://vuejs.org/guide/components/slots.html#scoped-slots)
