---
title: Separate Sequential Field Array Operations
impact: MEDIUM-HIGH
impactDescription: prevents state corruption from batched mutations
tags: array, useFieldArray, append, remove, sequential
---

## Separate Sequential Field Array Operations

Chaining `append()` and `remove()` in the same handler can cause state corruption. Defer removals to a useEffect or separate user action to allow React to process renders between operations.

**Incorrect (stacked operations cause state issues):**

```typescript
function ReplaceItemForm() {
  const { control } = useForm()
  const { fields, append, remove } = useFieldArray({ control, name: 'items' })

  const replaceItem = (indexToReplace: number, newItem: Item) => {
    remove(indexToReplace)  // Remove old item
    append(newItem)  // Immediately add new - state may be stale
  }

  return (
    <div>
      {fields.map((field, index) => (
        <ItemRow
          key={field.id}
          index={index}
          onReplace={(newItem) => replaceItem(index, newItem)}
        />
      ))}
    </div>
  )
}
```

**Correct (use update for replacements, or defer operations):**

```typescript
function ReplaceItemForm() {
  const { control } = useForm()
  const { fields, update } = useFieldArray({ control, name: 'items' })

  const replaceItem = (indexToReplace: number, newItem: Item) => {
    update(indexToReplace, newItem)  // Single atomic operation
  }

  return (
    <div>
      {fields.map((field, index) => (
        <ItemRow
          key={field.id}
          index={index}
          onReplace={(newItem) => replaceItem(index, newItem)}
        />
      ))}
    </div>
  )
}
```

**Alternative (defer removal with useEffect):**

```typescript
const [pendingRemoval, setPendingRemoval] = useState<number | null>(null)

useEffect(() => {
  if (pendingRemoval !== null) {
    remove(pendingRemoval)
    setPendingRemoval(null)
  }
}, [pendingRemoval, remove])
```

Reference: [useFieldArray](https://react-hook-form.com/docs/usefieldarray)
