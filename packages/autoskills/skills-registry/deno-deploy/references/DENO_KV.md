# Deno KV

## What is Deno KV?

Deno KV is a key-value database built into Deno. On Deno Deploy, it's a fast, globally distributed store that requires no setup or configuration.

## Quick Start

```typescript
// Open the KV store (auto-connects on Deno Deploy)
const kv = await Deno.openKv();

// Store a value
await kv.set(["users", "alice"], { name: "Alice", email: "alice@example.com" });

// Retrieve a value
const result = await kv.get(["users", "alice"]);
console.log(result.value); // { name: "Alice", email: "alice@example.com" }

// Delete a value
await kv.delete(["users", "alice"]);
```

## Keys

Keys are arrays of "key parts" that form a hierarchy:

```typescript
// Simple key
["settings"]

// Hierarchical keys
["users", "alice"]
["users", "bob"]
["posts", "2024", "01", "my-post"]
```

Key parts can be strings, numbers, booleans, Uint8Array, or bigints.

## Basic Operations

### Get

```typescript
const result = await kv.get<User>(["users", "alice"]);
if (result.value) {
  console.log(result.value.name);
}
```

### Set

```typescript
await kv.set(["users", "alice"], { name: "Alice" });

// With expiration (in milliseconds)
await kv.set(["sessions", sessionId], data, { expireIn: 3600000 }); // 1 hour
```

### Delete

```typescript
await kv.delete(["users", "alice"]);
```

### List

```typescript
// List all users
const users = kv.list<User>({ prefix: ["users"] });
for await (const entry of users) {
  console.log(entry.key, entry.value);
}

// With limit
const firstTen = kv.list<User>({ prefix: ["users"] }, { limit: 10 });
```

## Atomic Transactions

Perform multiple operations atomically (all succeed or all fail):

```typescript
// Transfer credits between users
const alice = await kv.get<number>(["credits", "alice"]);
const bob = await kv.get<number>(["credits", "bob"]);

const result = await kv.atomic()
  .check(alice) // Ensure alice hasn't changed
  .check(bob)   // Ensure bob hasn't changed
  .set(["credits", "alice"], alice.value! - 100)
  .set(["credits", "bob"], bob.value! + 100)
  .commit();

if (!result.ok) {
  console.log("Transaction failed - data was modified");
}
```

## Example: Request Counter

```typescript
const kv = await Deno.openKv();

Deno.serve(async () => {
  // Increment counter atomically
  const key = ["requests"];

  let result = { ok: false };
  while (!result.ok) {
    const current = await kv.get<number>(key);
    const newCount = (current.value ?? 0) + 1;

    result = await kv.atomic()
      .check(current)
      .set(key, newCount)
      .commit();
  }

  const count = (await kv.get<number>(key)).value;
  return new Response(`Requests: ${count}`);
});
```

## Data Location

On Deno Deploy, KV data is replicated across at least three data centers in Northern Virginia (us-east-4). Cross-region replication is not currently available.

## Local Development

When running locally with `deno run`, KV data is stored in memory by default. For persistent local storage:

```typescript
// Persist to a local file
const kv = await Deno.openKv("./my-database.sqlite");
```

## Important Notes

- **Deletion is permanent** - Deleting a KV instance removes all data with no recovery
- **Back up important data** before deleting instances
- **No cross-region replication** yet - data lives in us-east-4

## Documentation

- Deno KV on Deploy: https://docs.deno.com/deploy/reference/deno_kv/
- Deno KV API: https://docs.deno.com/api/deno/~/Deno.Kv
