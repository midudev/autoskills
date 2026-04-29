# Drizzle vs Prisma Comparison

Feature comparison, migration guide, and decision framework for choosing between Drizzle and Prisma.

## Quick Comparison

| Feature | Drizzle ORM | Prisma |
|---------|-------------|--------|
| **Type Safety** | ✅ Compile-time inference | ✅ Generated types |
| **Bundle Size** | **~35KB** | ~230KB |
| **Runtime** | **Zero dependencies** | Heavy runtime |
| **Cold Start** | **~10ms** | ~250ms |
| **Query Performance** | **Faster (native SQL)** | Slower (translation layer) |
| **Learning Curve** | Moderate (SQL knowledge helpful) | Easier (abstracted) |
| **Migrations** | SQL-based | Declarative schema |
| **Raw SQL** | **First-class support** | Limited support |
| **Edge Runtime** | **Fully compatible** | Limited support |
| **Ecosystem** | Growing | Mature |
| **Studio (GUI)** | ✅ Drizzle Studio | ✅ Prisma Studio |

## When to Choose Drizzle

### ✅ Choose Drizzle if you need:

1. **Performance-critical applications**
   - Microservices with tight latency requirements
   - High-throughput APIs (>10K req/s)
   - Serverless/edge functions with cold start concerns

2. **Minimal bundle size**
   - Client-side database (SQLite in browser)
   - Edge runtime deployments
   - Mobile applications with bundle constraints

3. **SQL control**
   - Complex queries with CTEs, window functions
   - Raw SQL for specific database features
   - Database-specific optimizations

4. **Type inference over generation**
   - No build step for type generation
   - Immediate TypeScript feedback
   - Schema changes reflected instantly

### Example: Edge Function with Drizzle

```typescript
import { neon } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-http';

export const runtime = 'edge';

export async function GET() {
  const sql = neon(process.env.DATABASE_URL!);
  const db = drizzle(sql); // ~35KB bundle, <10ms cold start

  const users = await db.select().from(users);
  return Response.json(users);
}
```

## When to Choose Prisma

### ✅ Choose Prisma if you need:

1. **Rapid prototyping**
   - Quick schema iterations
   - Automatic migrations
   - Less SQL knowledge required

2. **Team with varied SQL experience**
   - Abstracted query interface
   - Declarative migrations
   - Generated documentation

3. **Mature ecosystem**
   - Extensive community resources
   - Third-party integrations (Nexus, tRPC)
   - Enterprise support options

4. **Rich developer experience**
   - Prisma Studio (GUI)
   - VS Code extension
   - Comprehensive documentation

### Example: Next.js App with Prisma

```typescript
// schema.prisma
model User {
  id    Int    @id @default(autoincrement())
  email String @unique
  posts Post[]
}

model Post {
  id       Int    @id @default(autoincrement())
  title    String
  authorId Int
  author   User   @relation(fields: [authorId], references: [id])
}

// app/api/users/route.ts
import { prisma } from '@/lib/prisma';

export async function GET() {
  const users = await prisma.user.findMany({
    include: { posts: true },
  });
  return Response.json(users);
}
```

## Feature Comparison

### Schema Definition

**Drizzle** (TypeScript-first):
```typescript
import { pgTable, serial, text, integer } from 'drizzle-orm/pg-core';
import { relations } from 'drizzle-orm';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: text('email').notNull().unique(),
});

export const posts = pgTable('posts', {
  id: serial('id').primaryKey(),
  title: text('title').notNull(),
  authorId: integer('author_id').notNull().references(() => users.id),
});

export const usersRelations = relations(users, ({ many }) => ({
  posts: many(posts),
}));
```

**Prisma** (Schema DSL):
```prisma
model User {
  id    Int    @id @default(autoincrement())
  email String @unique
  posts Post[]
}

model Post {
  id       Int    @id @default(autoincrement())
  title    String
  authorId Int
  author   User   @relation(fields: [authorId], references: [id])
}
```

### Querying

**Drizzle** (SQL-like):
```typescript
import { eq, like, and, gt } from 'drizzle-orm';

// Simple query
const user = await db.select().from(users).where(eq(users.id, 1));

// Complex filtering
const results = await db.select()
  .from(users)
  .where(
    and(
      like(users.email, '%@example.com'),
      gt(users.createdAt, new Date('2024-01-01'))
    )
  );

// Joins
const usersWithPosts = await db
  .select({
    user: users,
    post: posts,
  })
  .from(users)
  .leftJoin(posts, eq(users.id, posts.authorId));
```

**Prisma** (Fluent API):
```typescript
// Simple query
const user = await prisma.user.findUnique({ where: { id: 1 } });

// Complex filtering
const results = await prisma.user.findMany({
  where: {
    email: { endsWith: '@example.com' },
    createdAt: { gt: new Date('2024-01-01') },
  },
});

// Relations
const usersWithPosts = await prisma.user.findMany({
  include: { posts: true },
});
```

### Migrations

**Drizzle** (SQL-based):
```bash
# Generate migration
npx drizzle-kit generate

# Output: drizzle/0000_migration.sql
# CREATE TABLE "users" (
#   "id" serial PRIMARY KEY,
#   "email" text NOT NULL UNIQUE
# );

# Apply migration
npx drizzle-kit migrate
```

**Prisma** (Declarative):
```bash
# Generate and apply migration
npx prisma migrate dev --name add_users

# Prisma compares schema.prisma to database
# Generates SQL automatically
# Applies migration
```

### Type Generation

**Drizzle** (Inferred):
```typescript
// Types are inferred at compile time
type User = typeof users.$inferSelect;
type NewUser = typeof users.$inferInsert;

// Immediate feedback in IDE
const user: User = await db.select().from(users);
```

**Prisma** (Generated):
```typescript
// Types generated after schema change
// Run: npx prisma generate

import { User, Post } from '@prisma/client';

const user: User = await prisma.user.findUnique({ where: { id: 1 } });
```

### Raw SQL

**Drizzle** (First-class):
```typescript
import { sql } from 'drizzle-orm';

// Tagged template with type safety
const result = await db.execute(
  sql`SELECT * FROM ${users} WHERE ${users.email} = ${email}`
);

// Mix ORM and raw SQL
const customQuery = await db
  .select({
    user: users,
    postCount: sql<number>`COUNT(${posts.id})`,
  })
  .from(users)
  .leftJoin(posts, eq(users.id, posts.authorId))
  .groupBy(users.id);
```

**Prisma** (Limited):
```typescript
// Raw query (loses type safety)
const result = await prisma.$queryRaw`
  SELECT * FROM users WHERE email = ${email}
`;

// Typed raw query (manual type annotation)
const users = await prisma.$queryRaw<User[]>`
  SELECT * FROM users
`;
```

## Performance Benchmarks

### Query Execution Time (1000 queries)

| Operation | Drizzle | Prisma | Difference |
|-----------|---------|--------|------------|
| findUnique | 1.2s | 3.1s | **2.6x faster** |
| findMany (10 rows) | 1.5s | 3.8s | **2.5x faster** |
| findMany (100 rows) | 2.1s | 5.2s | **2.5x faster** |
| create | 1.8s | 4.1s | **2.3x faster** |
| update | 1.7s | 3.9s | **2.3x faster** |

### Bundle Size Impact

```bash
# Next.js production build

# With Drizzle
├─ Client (First Load JS)
│  └─ pages/index.js: 85 KB (+35KB Drizzle)

# With Prisma
├─ Client (First Load JS)
│  └─ pages/index.js: 280 KB (+230KB Prisma)
```

### Cold Start Times (AWS Lambda)

| Database | Drizzle | Prisma |
|----------|---------|--------|
| PostgreSQL | ~50ms | ~300ms |
| MySQL | ~45ms | ~280ms |
| SQLite | ~10ms | ~150ms |

## Migration from Prisma to Drizzle

### Step 1: Install Drizzle

```bash
npm install drizzle-orm
npm install -D drizzle-kit

# Keep Prisma temporarily
# npm uninstall prisma @prisma/client
```

### Step 2: Introspect Existing Database

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

```bash
# Generate Drizzle schema from existing database
npx drizzle-kit introspect
```

### Step 3: Convert Queries

**Prisma**:
```typescript
// Before (Prisma)
const users = await prisma.user.findMany({
  where: { email: { contains: 'example.com' } },
  include: { posts: true },
  orderBy: { createdAt: 'desc' },
  take: 10,
});
```

**Drizzle**:
```typescript
// After (Drizzle)
import { like, desc } from 'drizzle-orm';

const users = await db.query.users.findMany({
  where: like(users.email, '%example.com%'),
  with: { posts: true },
  orderBy: [desc(users.createdAt)],
  limit: 10,
});

// Or SQL-style
const users = await db
  .select()
  .from(users)
  .where(like(users.email, '%example.com%'))
  .orderBy(desc(users.createdAt))
  .limit(10);
```

### Step 4: Conversion Patterns

```typescript
// Prisma → Drizzle mapping

// findUnique
await prisma.user.findUnique({ where: { id: 1 } });
await db.select().from(users).where(eq(users.id, 1));

// findMany with filters
await prisma.user.findMany({ where: { role: 'admin' } });
await db.select().from(users).where(eq(users.role, 'admin'));

// create
await prisma.user.create({ data: { email: 'user@example.com' } });
await db.insert(users).values({ email: 'user@example.com' }).returning();

// update
await prisma.user.update({ where: { id: 1 }, data: { name: 'John' } });
await db.update(users).set({ name: 'John' }).where(eq(users.id, 1));

// delete
await prisma.user.delete({ where: { id: 1 } });
await db.delete(users).where(eq(users.id, 1));

// count
await prisma.user.count();
await db.select({ count: count() }).from(users);

// aggregate
await prisma.post.aggregate({ _avg: { views: true } });
await db.select({ avg: avg(posts.views) }).from(posts);
```

### Step 5: Test & Remove Prisma

```bash
# Run tests with Drizzle
npm test

# Remove Prisma when confident
npm uninstall prisma @prisma/client
rm -rf prisma/
```

## Decision Matrix

| Requirement | Drizzle | Prisma |
|-------------|---------|--------|
| Need minimal bundle size | ✅ | ❌ |
| Edge runtime deployment | ✅ | ⚠️ |
| Team unfamiliar with SQL | ❌ | ✅ |
| Complex raw SQL queries | ✅ | ❌ |
| Rapid prototyping | ⚠️ | ✅ |
| Type-safe migrations | ✅ | ✅ |
| Performance critical | ✅ | ❌ |
| Mature ecosystem | ⚠️ | ✅ |
| First-class TypeScript | ✅ | ✅ |
| Zero dependencies | ✅ | ❌ |

## Hybrid Approach

You can use both in the same project:

```typescript
// Use Drizzle for performance-critical paths
import { db as drizzleDb } from './lib/drizzle';

export async function GET() {
  const users = await drizzleDb.select().from(users);
  return Response.json(users);
}

// Use Prisma for admin dashboards (less performance-critical)
import { prisma } from './lib/prisma';

export async function getStaticProps() {
  const stats = await prisma.user.aggregate({
    _count: true,
    _avg: { posts: true },
  });
  return { props: { stats } };
}
```

## Community & Resources

### Drizzle
- Docs: [orm.drizzle.team](https://orm.drizzle.team)
- Discord: [drizzle.team/discord](https://drizzle.team/discord)
- GitHub: [drizzle-team/drizzle-orm](https://github.com/drizzle-team/drizzle-orm)

### Prisma
- Docs: [prisma.io/docs](https://prisma.io/docs)
- Discord: [pris.ly/discord](https://pris.ly/discord)
- GitHub: [prisma/prisma](https://github.com/prisma/prisma)

## Final Recommendation

**Choose Drizzle for:**
- Greenfield projects prioritizing performance
- Edge/serverless applications
- Teams comfortable with SQL
- Minimal bundle size requirements

**Choose Prisma for:**
- Established teams with Prisma experience
- Rapid MVP development
- Teams new to databases
- Reliance on Prisma ecosystem (Nexus, etc.)

**Consider migration when:**
- Performance becomes a bottleneck
- Bundle size impacts user experience
- Edge runtime deployment needed
- Team SQL proficiency increases
