---
title: Never Mutate Computed Property Return Values
impact: HIGH
impactDescription: Mutating computed values causes silent failures and lost changes
type: capability
tags: [vue3, computed, reactivity, immutability, common-mistake]
---

# Never Mutate Computed Property Return Values

**Impact: HIGH** - The returned value from a computed property is derived state - a temporary snapshot. Mutating this value leads to bugs that are difficult to debug.

**Important:** Mutations DO persist while the computed cache remains valid, but are lost when recomputation occurs. The danger lies in unpredictable cache invalidation timing - any change to the computed's dependencies triggers recomputation, silently discarding your mutations. This makes bugs intermittent and hard to reproduce.

Every time the source state changes, a new snapshot is created. Mutating a snapshot is meaningless because it will be discarded on the next recalculation.

## Task Checklist

- [ ] Treat computed return values as read-only
- [ ] Update the source state instead of the computed value
- [ ] Use writable computed properties if bidirectional binding is needed
- [ ] Avoid array mutating methods (push, pop, splice, reverse, sort) on computed arrays

**Incorrect:**
```vue
<script setup>
import { ref, computed } from 'vue'

const books = ref(['Vue Guide', 'React Handbook'])

const publishedBooks = computed(() => {
  return books.value.filter(book => book.includes('Guide'))
})

function addBook() {
  // BAD: Mutating computed value - change will be lost!
  publishedBooks.value.push('New Book')
}

// BAD: Mutating computed array
const sortedBooks = computed(() => books.value.filter(b => b))

function reverseBooks() {
  // BAD: This mutates the computed snapshot
  sortedBooks.value.reverse()
}
</script>
```

```vue
<script>
export default {
  data() {
    return {
      author: {
        name: 'John',
        books: ['Book A', 'Book B']
      }
    }
  },
  computed: {
    authorBooks() {
      return this.author.books
    }
  },
  methods: {
    addBook() {
      // BAD: Mutating computed value
      this.authorBooks.push('New Book')
    }
  }
}
</script>
```

**Correct:**
```vue
<script setup>
import { ref, computed } from 'vue'

const books = ref(['Vue Guide', 'React Handbook'])

const publishedBooks = computed(() => {
  return books.value.filter(book => book.includes('Guide'))
})

function addBook(bookName) {
  // GOOD: Update the source state
  books.value.push(bookName)
}

// GOOD: Create a copy before mutating for display
const sortedBooks = computed(() => {
  return [...books.value].sort()  // Spread to create copy before sort
})

const reversedBooks = computed(() => {
  return [...books.value].reverse()  // Spread to create copy before reverse
})
</script>
```

```vue
<script>
export default {
  data() {
    return {
      author: {
        name: 'John',
        books: ['Book A', 'Book B']
      }
    }
  },
  computed: {
    authorBooks() {
      return this.author.books
    }
  },
  methods: {
    addBook(bookName) {
      // GOOD: Update source state
      this.author.books.push(bookName)
    }
  }
}
</script>
```

## Writable Computed for Bidirectional Binding

If you genuinely need to "set" a computed value, use a writable computed property:

```vue
<script setup>
import { ref, computed } from 'vue'

const firstName = ref('John')
const lastName = ref('Doe')

// Writable computed with getter and setter
const fullName = computed({
  get() {
    return `${firstName.value} ${lastName.value}`
  },
  set(newValue) {
    // Update source state based on the new value
    const parts = newValue.split(' ')
    firstName.value = parts[0] || ''
    lastName.value = parts[1] || ''
  }
})

// Now this is valid:
fullName.value = 'Jane Smith'  // Updates firstName and lastName
</script>
```

## Reference
- [Vue.js Computed Properties - Avoid Mutating Computed Value](https://vuejs.org/guide/essentials/computed.html#avoid-mutating-computed-value)
- [Vue.js Computed Properties - Writable Computed](https://vuejs.org/guide/essentials/computed.html#writable-computed)
