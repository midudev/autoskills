---
title: Provide Complete Default Objects for Field Array Operations
impact: HIGH
impactDescription: prevents partial data and validation failures
tags: array, useFieldArray, append, default-values
---

## Provide Complete Default Objects for Field Array Operations

When using `append()`, `prepend()`, `insert()`, or `update()`, always provide complete field objects with all required properties. Empty or partial objects cause validation and data inconsistencies.

**Incorrect (empty object causes undefined fields):**

```typescript
function TasksForm() {
  const { control, register } = useForm<{ tasks: Task[] }>()
  const { fields, append } = useFieldArray({ control, name: 'tasks' })

  return (
    <div>
      {fields.map((field, index) => (
        <div key={field.id}>
          <input {...register(`tasks.${index}.title`)} />  {/* undefined initially */}
          <input {...register(`tasks.${index}.priority`)} />  {/* undefined initially */}
        </div>
      ))}
      <button type="button" onClick={() => append({})}>Add Task</button>  {/* Empty object */}
    </div>
  )
}
```

**Correct (complete object with all fields):**

```typescript
function TasksForm() {
  const { control, register } = useForm<{ tasks: Task[] }>()
  const { fields, append } = useFieldArray({ control, name: 'tasks' })

  const addTask = () => {
    append({
      title: '',
      priority: 'medium',
      dueDate: null,
    })
  }

  return (
    <div>
      {fields.map((field, index) => (
        <div key={field.id}>
          <input {...register(`tasks.${index}.title`)} />
          <select {...register(`tasks.${index}.priority`)}>
            <option value="low">Low</option>
            <option value="medium">Medium</option>
            <option value="high">High</option>
          </select>
        </div>
      ))}
      <button type="button" onClick={addTask}>Add Task</button>
    </div>
  )
}
```

Reference: [useFieldArray](https://react-hook-form.com/docs/usefieldarray)
