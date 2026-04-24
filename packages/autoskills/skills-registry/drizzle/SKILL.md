---
name: drizzle-orm
description: "Type-safe SQL ORM for TypeScript with zero runtime overhead"
user-invocable: false
disable-model-invocation: true
progressive_disclosure:
  entry_point:
    summary: "Type-safe SQL ORM for TypeScript with zero runtime overhead"
    when_to_use: "When working with drizzle-orm or related functionality."
    quick_start: "1. Review the core concepts below. 2. Apply patterns to your use case. 3. Follow best practices for implementation."
  references:
    - advanced-schemas.md
    - performance.md
    - query-patterns.md
    - vs-prisma.md
---
# Drizzle ORM

Modern TypeScript-first ORM with zero dependencies, compile-time type safety, and SQL-like syntax. Optimized for edge runtimes and serverless environments.

## Quick Start

### Installation

```bash
# Core ORM
npm install drizzle-orm

# Database driver (choose one)
npm install pg            # PostgreSQL
npm install mysql2        # MySQL
npm install better-sqlite3 # SQLite

# Drizzle Kit (migrations)
npm install -D drizzle-kit
```

### Basic Setup

```typescript
// db/schema.ts
import { pgTable, serial, text, timestamp } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: text('email').notNull().unique(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at').defaultNow(),
});

// db/client.ts
import { drizzle } from 'drizzle-orm/node-postgres';
import { Pool } from 'pg';
import * as schema from './schema';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
export const db = drizzle(pool, { schema });
```

### First Query

```typescript
import { db } from './db/client';
import { users } from './db/schema';
import { eq } from 'drizzle-orm';

// Insert
const newUser = await db.insert(users).values({
  email: 'user@example.com',
  name: 'John Doe',
}).returning();

// Select
const allUsers = await db.select().from(users);

// Where
const user = await db.select().from(users).where(eq(users.id, 1));

// Update
await db.update(users).set({ name: 'Jane Doe' }).where(eq(users.id, 1));

// Delete
await db.delete(users).where(eq(users.id, 1));
```

## Schema Definition

### Column Types Reference

| PostgreSQL | MySQL | SQLite | TypeScript |
|------------|-------|--------|------------|
| `serial()` | `serial()` | `integer()` | `number` |
| `text()` | `text()` | `text()` | `string` |
| `integer()` | `int()` | `integer()` | `number` |
| `boolean()` | `boolean()` | `integer()` | `boolean` |
| `timestamp()` | `datetime()` | `integer()` | `Date` |
| `json()` | `json()` | `text()` | `unknown` |
| `uuid()` | `varchar(36)` | `text()` | `string` |

### Common Schema Patterns

```typescript
import { pgTable, serial, text, varchar, integer, boolean, timestamp, json, unique } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull().unique(),
  passwordHash: varchar('password_hash', { length: 255 }).notNull(),
  role: text('role', { enum: ['admin', 'user', 'guest'] }).default('user'),
  metadata: json('metadata').$type<{ theme: string; locale: string }>(),
  isActive: boolean('is_active').default(true),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}, (table) => ({
  emailIdx: unique('email_unique_idx').on(table.email),
}));

// Infer TypeScript types
type User = typeof users.$inferSelect;
type NewUser = typeof users.$inferInsert;
```

## Relations

### One-to-Many

```typescript
import { pgTable, serial, text, integer } from 'drizzle-orm/pg-core';
import { relations } from 'drizzle-orm';

export const authors = pgTable('authors', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
});

export const posts = pgTable('posts', {
  id: serial('id').primaryKey(),
  title: text('title').notNull(),
  authorId: integer('author_id').notNull().references(() => authors.id),
});

export const authorsRelations = relations(authors, ({ many }) => ({
  posts: many(posts),
}));

export const postsRelations = relations(posts, ({ one }) => ({
  author: one(authors, {
    fields: [posts.authorId],
    references: [authors.id],
  }),
}));

// Query with relations
const authorsWithPosts = await db.query.authors.findMany({
  with: { posts: true },
});
```

### Many-to-Many

```typescript
export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
});

export const groups = pgTable('groups', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
});

export const usersToGroups = pgTable('users_to_groups', {
  userId: integer('user_id').notNull().references(() => users.id),
  groupId: integer('group_id').notNull().references(() => groups.id),
}, (table) => ({
  pk: primaryKey({ columns: [table.userId, table.groupId] }),
}));

export const usersRelations = relations(users, ({ many }) => ({
  groups: many(usersToGroups),
}));

export const groupsRelations = relations(groups, ({ many }) => ({
  users: many(usersToGroups),
}));

export const usersToGroupsRelations = relations(usersToGroups, ({ one }) => ({
  user: one(users, { fields: [usersToGroups.userId], references: [users.id] }),
  group: one(groups, { fields: [usersToGroups.groupId], references: [groups.id] }),
}));
```

## Queries

### Filtering

```typescript
import { eq, ne, gt, gte, lt, lte, like, ilike, inArray, isNull, isNotNull, and, or, between } from 'drizzle-orm';

// Equality
await db.select().from(users).where(eq(users.email, 'user@example.com'));

// Comparison
await db.select().from(users).where(gt(users.id, 10));

// Pattern matching
await db.select().from(users).where(like(users.name, '%John%'));

// Multiple conditions
await db.select().from(users).where(
  and(
    eq(users.role, 'admin'),
    gt(users.createdAt, new Date('2024-01-01'))
  )
);

// IN clause
await db.select().from(users).where(inArray(users.id, [1, 2, 3]));

// NULL checks
await db.select().from(users).where(isNull(users.deletedAt));
```

### Joins

```typescript
import { eq } from 'drizzle-orm';

// Inner join
const result = await db
  .select({
    user: users,
    post: posts,
  })
  .from(users)
  .innerJoin(posts, eq(users.id, posts.authorId));

// Left join
const result = await db
  .select({
    user: users,
    post: posts,
  })
  .from(users)
  .leftJoin(posts, eq(users.id, posts.authorId));

// Multiple joins with aggregation
import { count, sql } from 'drizzle-orm';

const result = await db
  .select({
    authorName: authors.name,
    postCount: count(posts.id),
  })
  .from(authors)
  .leftJoin(posts, eq(authors.id, posts.authorId))
  .groupBy(authors.id);
```

### Pagination & Sorting

```typescript
import { desc, asc } from 'drizzle-orm';

// Order by
await db.select().from(users).orderBy(desc(users.createdAt));

// Limit & offset
await db.select().from(users).limit(10).offset(20);

// Pagination helper
function paginate(page: number, pageSize: number = 10) {
  return db.select().from(users)
    .limit(pageSize)
    .offset(page * pageSize);
}
```

## Transactions

```typescript
// Auto-rollback on error
await db.transaction(async (tx) => {
  await tx.insert(users).values({ email: 'user@example.com', name: 'John' });
  await tx.insert(posts).values({ title: 'First Post', authorId: 1 });
  // If any query fails, entire transaction rolls back
});

// Manual control
const tx = db.transaction(async (tx) => {
  const user = await tx.insert(users).values({ ... }).returning();

  if (!user) {
    tx.rollback();
    return;
  }

  await tx.insert(posts).values({ authorId: user.id });
});
```

## Migrations

### Drizzle Kit Configuration

```typescript
// drizzle.config.ts
import type { Config } from 'drizzle-kit';

export default {
  schema: './db/schema.ts',
  out: './drizzle',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
} satisfies Config;
```

### Migration Workflow

```bash
# Generate migration
npx drizzle-kit generate

# View SQL
cat drizzle/0000_migration.sql

# Apply migration
npx drizzle-kit migrate

# Introspect existing database
npx drizzle-kit introspect

# Drizzle Studio (database GUI)
npx drizzle-kit studio
```

### Example Migration

```sql
-- drizzle/0000_initial.sql
CREATE TABLE IF NOT EXISTS "users" (
  "id" serial PRIMARY KEY NOT NULL,
  "email" varchar(255) NOT NULL,
  "name" text NOT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL,
  CONSTRAINT "users_email_unique" UNIQUE("email")
);
```

## Navigation

### Detailed References

- **[🏗️ Advanced Schemas](./references/advanced-schemas.md)** - Custom types, composite keys, indexes, constraints, multi-tenant patterns. Load when designing complex database schemas.

- **[🔍 Query Patterns](./references/query-patterns.md)** - Subqueries, CTEs, raw SQL, prepared statements, batch operations. Load when optimizing queries or handling complex filtering.

- **[⚡ Performance](./references/performance.md)** - Connection pooling, query optimization, N+1 prevention, prepared statements, edge runtime integration. Load when scaling or optimizing database performance.

- **[🔄 vs Prisma](./references/vs-prisma.md)** - Feature comparison, migration guide, when to choose Drizzle over Prisma. Load when evaluating ORMs or migrating from Prisma.

## Red Flags

**Stop and reconsider if:**
- Using `any` or `unknown` for JSON columns without type annotation
- Building raw SQL strings without using `sql` template (SQL injection risk)
- Not using transactions for multi-step data modifications
- Fetching all rows without pagination in production queries
- Missing indexes on foreign keys or frequently queried columns
- Using `select()` without specifying columns for large tables

## Performance Benefits vs Prisma

| Metric | Drizzle | Prisma |
|--------|---------|--------|
| **Bundle Size** | ~35KB | ~230KB |
| **Cold Start** | ~10ms | ~250ms |
| **Query Speed** | Baseline | ~2-3x slower |
| **Memory** | ~10MB | ~50MB |
| **Type Generation** | Runtime inference | Build-time generation |

## Integration

- **typescript-core**: Type-safe schema inference with `satisfies`
- **nextjs-core**: Server Actions, Route Handlers, Middleware integration
- **Database Migration**: Safe schema evolution patterns

## Related Skills

When using Drizzle, these skills enhance your workflow:
- **prisma**: Alternative ORM comparison: Drizzle vs Prisma trade-offs
- **typescript**: Advanced TypeScript patterns for type-safe queries
- **nextjs**: Drizzle with Next.js Server Actions and API routes
- **sqlalchemy**: SQLAlchemy patterns for Python developers learning Drizzle

[Full documentation available in these skills if deployed in your bundle]
