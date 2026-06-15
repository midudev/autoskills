# Serialization: What Can/Can't Be Returned

## The Rule

**Server load functions and form actions must return JSON-serializable
data.**

Data travels from server → client as JSON. Non-JSON types break.

## ✅ Serializable (Safe)

| Type         | Example                   | Notes                             |
| ------------ | ------------------------- | --------------------------------- |
| String       | `"hello"`                 | ✅                                |
| Number       | `42`, `3.14`              | ✅                                |
| Boolean      | `true`, `false`           | ✅                                |
| null         | `null`                    | ✅                                |
| Array        | `[1, 2, 3]`               | ✅                                |
| Plain Object | `{ name: 'Alice' }`       | ✅                                |
| Nested       | `{ user: { posts: [] } }` | ✅ If all values are serializable |

## ❌ NOT Serializable (Breaks)

| Type           | Example        | Why                        | Fix                                          |
| -------------- | -------------- | -------------------------- | -------------------------------------------- |
| Date           | `new Date()`   | Becomes string             | Use `.toISOString()`                         |
| undefined      | `undefined`    | Removed from JSON          | Use `null`                                   |
| Function       | `() => {}`     | Can't serialize            | Remove or convert to data                    |
| Class instance | `new User()`   | Only serializes properties | Convert to plain object                      |
| Map            | `new Map()`    | Becomes `{}`               | Convert to object: `Object.fromEntries(map)` |
| Set            | `new Set()`    | Becomes `{}`               | Convert to array: `Array.from(set)`          |
| BigInt         | `123n`         | Error                      | Convert to string                            |
| Symbol         | `Symbol('id')` | Removed                    | Don't use                                    |
| RegExp         | `/test/`       | Becomes `{}`               | Convert to string                            |
| Error          | `new Error()`  | Loses stack                | Extract message/code                         |

## Examples

### ❌ Wrong: Returning Date

```typescript
// +page.server.ts - WRONG
export const load = async () => {
	return {
		createdAt: new Date(), // Serializes as string, not Date object
	};
};
```

```svelte
<!-- +page.svelte -->
<script>
	let { data } = $props();
	console.log(data.createdAt); // String, not Date
	console.log(data.createdAt.getTime()); // ERROR - not a Date
</script>
```

### ✅ Right: Convert Date to ISO String

```typescript
// +page.server.ts - RIGHT
export const load = async () => {
	const user = await db.users.findFirst();

	return {
		user: {
			id: user.id,
			name: user.name,
			createdAt: user.createdAt.toISOString(), // Convert to string
		},
	};
};
```

```svelte
<!-- +page.svelte -->
<script>
	let { data } = $props();
	const createdAt = new Date(data.user.createdAt); // Parse back to Date
</script>
```

### ❌ Wrong: Returning Class Instance

```typescript
// +page.server.ts - WRONG
class User {
	constructor(
		public id: number,
		public name: string,
	) {}

	getDisplayName() {
		return `User: ${this.name}`;
	}
}

export const load = async () => {
	const user = new User(1, 'Alice');
	return { user }; // Methods are lost during serialization
};
```

```svelte
<script>
	let { data } = $props();
	console.log(data.user.getDisplayName()); // ERROR - method doesn't exist
</script>
```

### ✅ Right: Return Plain Object

```typescript
// +page.server.ts - RIGHT
export const load = async () => {
	const user = await db.users.findFirst();

	return {
		user: {
			id: user.id,
			name: user.name,
			email: user.email,
			// Only plain data, no methods
		},
	};
};
```

### ❌ Wrong: undefined Values

```typescript
// +page.server.ts - WRONG
export const load = async () => {
	return {
		name: 'Alice',
		email: undefined, // Removed during JSON.stringify
	};
};
```

```svelte
<script>
	let { data } = $props();
	console.log('email' in data); // false - key is missing!
</script>
```

### ✅ Right: Use null

```typescript
// +page.server.ts - RIGHT
export const load = async () => {
	return {
		name: 'Alice',
		email: null, // Preserved
	};
};
```

### ❌ Wrong: Map/Set

```typescript
// +page.server.ts - WRONG
export const load = async () => {
	const tags = new Set(['svelte', 'typescript']);
	const metadata = new Map([['version', '1.0']]);

	return {
		tags, // Becomes {}
		metadata, // Becomes {}
	};
};
```

### ✅ Right: Convert to Array/Object

```typescript
// +page.server.ts - RIGHT
export const load = async () => {
	const tags = new Set(['svelte', 'typescript']);
	const metadata = new Map([['version', '1.0']]);

	return {
		tags: Array.from(tags), // ['svelte', 'typescript']
		metadata: Object.fromEntries(metadata), // { version: '1.0' }
	};
};
```

## ORM Returns (Drizzle, Prisma)

Most ORMs return plain objects with Date fields:

```typescript
// +page.server.ts
export const load = async () => {
	const user = await db.query.users.findFirst();
	// user = { id: 1, name: 'Alice', createdAt: Date }

	return {
		user: {
			...user,
			createdAt: user.createdAt.toISOString(), // Convert Date
		},
	};
};
```

Or use a helper:

```typescript
function serialize<T extends Record<string, any>>(obj: T): T {
	return JSON.parse(JSON.stringify(obj)); // Forces serialization
}

export const load = async () => {
	const user = await db.query.users.findFirst();
	return { user: serialize(user) };
};
```

## BigInt

```typescript
// +page.server.ts - WRONG
export const load = async () => {
	return {
		userId: 123456789012345678901234567890n, // ERROR - can't serialize
	};
};

// +page.server.ts - RIGHT
export const load = async () => {
	return {
		userId: '123456789012345678901234567890', // String
	};
};
```

## Detecting Serialization Issues

SvelteKit will throw an error if you try to return non-serializable
data:

```
Error: Data returned from `load` while rendering / is not serializable:
  - Cannot stringify arbitrary non-POJOs
```

## Testing Serialization

```typescript
const data = { user: new User() };

try {
	JSON.parse(JSON.stringify(data));
	console.log('✅ Serializable');
} catch (e) {
	console.log('❌ Not serializable');
}
```

## TypeScript Help

Use `satisfies` to catch issues at compile time:

```typescript
import type { PageServerLoad } from './$types';

export const load = (async () => {
	return {
		user: {
			id: 1,
			name: 'Alice',
			createdAt: new Date(), // TypeScript allows this, but it's problematic
		},
	};
}) satisfies PageServerLoad;
```

Better: Create a type that only allows primitives:

```typescript
type Serializable =
	| string
	| number
	| boolean
	| null
	| { [key: string]: Serializable }
	| Serializable[];

export const load: PageServerLoad = async () => {
	const data: Serializable = {
		user: {
			id: 1,
			name: 'Alice',
			createdAt: new Date().toISOString(), // Must be string
		},
	};

	return data;
};
```

## Quick Checklist

Before returning from server load or form action:

1. ✅ All values are string, number, boolean, null, array, or plain
   object?
2. ✅ No Date objects? (convert to `.toISOString()`)
3. ✅ No undefined? (use null)
4. ✅ No class instances? (convert to plain objects)
5. ✅ No Map/Set? (convert to object/array)
6. ✅ No functions?
7. ✅ No BigInt? (convert to string)
