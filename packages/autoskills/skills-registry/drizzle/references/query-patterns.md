# Query Patterns

Advanced querying techniques, subqueries, CTEs, and raw SQL in Drizzle ORM.

## Subqueries

### SELECT Subqueries

```typescript
import { sql, eq } from 'drizzle-orm';

// Scalar subquery
const avgPrice = db.select({ value: avg(products.price) }).from(products);

const expensiveProducts = await db
  .select()
  .from(products)
  .where(gt(products.price, avgPrice));

// Correlated subquery
const authorsWithPostCount = await db
  .select({
    author: authors,
    postCount: sql<number>`(
      SELECT COUNT(*)
      FROM ${posts}
      WHERE ${posts.authorId} = ${authors.id}
    )`,
  })
  .from(authors);
```

### EXISTS Subqueries

```typescript
// Find authors with posts
const authorsWithPosts = await db
  .select()
  .from(authors)
  .where(
    sql`EXISTS (
      SELECT 1
      FROM ${posts}
      WHERE ${posts.authorId} = ${authors.id}
    )`
  );

// Find authors without posts
const authorsWithoutPosts = await db
  .select()
  .from(authors)
  .where(
    sql`NOT EXISTS (
      SELECT 1
      FROM ${posts}
      WHERE ${posts.authorId} = ${authors.id}
    )`
  );
```

### IN Subqueries

```typescript
// Find users who commented
const usersWhoCommented = await db
  .select()
  .from(users)
  .where(
    sql`${users.id} IN (
      SELECT DISTINCT ${comments.userId}
      FROM ${comments}
    )`
  );
```

## Common Table Expressions (CTEs)

### Basic CTE

```typescript
import { sql } from 'drizzle-orm';

const topAuthors = db.$with('top_authors').as(
  db.select({
    id: authors.id,
    name: authors.name,
    postCount: sql<number>`COUNT(${posts.id})`.as('post_count'),
  })
    .from(authors)
    .leftJoin(posts, eq(authors.id, posts.authorId))
    .groupBy(authors.id)
    .having(sql`COUNT(${posts.id}) > 10`)
);

const result = await db
  .with(topAuthors)
  .select()
  .from(topAuthors);
```

### Recursive CTE

```typescript
// Organizational hierarchy
export const employees = pgTable('employees', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
  managerId: integer('manager_id').references((): AnyPgColumn => employees.id),
});

const employeeHierarchy = db.$with('employee_hierarchy').as(
  db.select({
    id: employees.id,
    name: employees.name,
    managerId: employees.managerId,
    level: sql<number>`1`.as('level'),
  })
    .from(employees)
    .where(isNull(employees.managerId))
    .unionAll(
      db.select({
        id: employees.id,
        name: employees.name,
        managerId: employees.managerId,
        level: sql<number>`employee_hierarchy.level + 1`,
      })
        .from(employees)
        .innerJoin(
          sql`employee_hierarchy`,
          sql`${employees.managerId} = employee_hierarchy.id`
        )
    )
);

const hierarchy = await db
  .with(employeeHierarchy)
  .select()
  .from(employeeHierarchy);
```

### Multiple CTEs

```typescript
const activeUsers = db.$with('active_users').as(
  db.select().from(users).where(eq(users.isActive, true))
);

const recentPosts = db.$with('recent_posts').as(
  db.select().from(posts).where(gt(posts.createdAt, sql`NOW() - INTERVAL '30 days'`))
);

const result = await db
  .with(activeUsers, recentPosts)
  .select({
    user: activeUsers,
    post: recentPosts,
  })
  .from(activeUsers)
  .leftJoin(recentPosts, eq(activeUsers.id, recentPosts.authorId));
```

## Raw SQL

### Safe Raw Queries

```typescript
import { sql } from 'drizzle-orm';

// Parameterized query (safe from SQL injection)
const userId = 123;
const user = await db.execute(
  sql`SELECT * FROM ${users} WHERE ${users.id} = ${userId}`
);

// Raw SQL with type safety
const result = await db.execute<{ count: number }>(
  sql`SELECT COUNT(*) as count FROM ${users}`
);
```

### SQL Template Composition

```typescript
// Reusable SQL fragments
function whereActive() {
  return sql`${users.isActive} = true`;
}

function whereRole(role: string) {
  return sql`${users.role} = ${role}`;
}

// Compose fragments
const admins = await db
  .select()
  .from(users)
  .where(sql`${whereActive()} AND ${whereRole('admin')}`);
```

### Dynamic WHERE Clauses

```typescript
import { and, SQL } from 'drizzle-orm';

interface Filters {
  name?: string;
  role?: string;
  isActive?: boolean;
}

function buildFilters(filters: Filters): SQL | undefined {
  const conditions: SQL[] = [];

  if (filters.name) {
    conditions.push(like(users.name, `%${filters.name}%`));
  }

  if (filters.role) {
    conditions.push(eq(users.role, filters.role));
  }

  if (filters.isActive !== undefined) {
    conditions.push(eq(users.isActive, filters.isActive));
  }

  return conditions.length > 0 ? and(...conditions) : undefined;
}

// Usage
const filters: Filters = { name: 'John', isActive: true };
const users = await db
  .select()
  .from(users)
  .where(buildFilters(filters));
```

## Aggregations

### Basic Aggregates

```typescript
import { count, sum, avg, min, max, sql } from 'drizzle-orm';

// Count
const userCount = await db.select({ count: count() }).from(users);

// Sum
const totalRevenue = await db.select({ total: sum(orders.amount) }).from(orders);

// Average
const avgPrice = await db.select({ avg: avg(products.price) }).from(products);

// Multiple aggregates
const stats = await db
  .select({
    count: count(),
    total: sum(orders.amount),
    avg: avg(orders.amount),
    min: min(orders.amount),
    max: max(orders.amount),
  })
  .from(orders);
```

### GROUP BY with HAVING

```typescript
// Authors with more than 5 posts
const prolificAuthors = await db
  .select({
    author: authors.name,
    postCount: count(posts.id),
  })
  .from(authors)
  .leftJoin(posts, eq(authors.id, posts.authorId))
  .groupBy(authors.id)
  .having(sql`COUNT(${posts.id}) > 5`);
```

### Window Functions

```typescript
// Rank products by price within category
const rankedProducts = await db
  .select({
    product: products,
    priceRank: sql<number>`RANK() OVER (PARTITION BY ${products.categoryId} ORDER BY ${products.price} DESC)`,
  })
  .from(products);

// Running total
const ordersWithRunningTotal = await db
  .select({
    order: orders,
    runningTotal: sql<number>`SUM(${orders.amount}) OVER (ORDER BY ${orders.createdAt})`,
  })
  .from(orders);

// Row number
const numberedUsers = await db
  .select({
    user: users,
    rowNum: sql<number>`ROW_NUMBER() OVER (ORDER BY ${users.createdAt})`,
  })
  .from(users);
```

## Prepared Statements

### Reusable Queries

```typescript
// Prepare once, execute many times
const getUserById = db
  .select()
  .from(users)
  .where(eq(users.id, sql.placeholder('id')))
  .prepare('get_user_by_id');

// Execute with different parameters
const user1 = await getUserById.execute({ id: 1 });
const user2 = await getUserById.execute({ id: 2 });

// Complex prepared statement
const searchUsers = db
  .select()
  .from(users)
  .where(
    and(
      like(users.name, sql.placeholder('name')),
      eq(users.role, sql.placeholder('role'))
    )
  )
  .prepare('search_users');

const admins = await searchUsers.execute({ name: '%John%', role: 'admin' });
```

## Batch Operations

### Batch Insert

```typescript
// Insert multiple rows
const newUsers = await db.insert(users).values([
  { email: 'user1@example.com', name: 'User 1' },
  { email: 'user2@example.com', name: 'User 2' },
  { email: 'user3@example.com', name: 'User 3' },
]).returning();

// Batch with onConflictDoNothing
await db.insert(users).values(bulkUsers).onConflictDoNothing();

// Batch with onConflictDoUpdate (upsert)
await db.insert(users)
  .values(bulkUsers)
  .onConflictDoUpdate({
    target: users.email,
    set: { name: sql`EXCLUDED.name` },
  });
```

### Batch Update

```typescript
// Update multiple specific rows
await db.transaction(async (tx) => {
  for (const update of updates) {
    await tx.update(users)
      .set({ name: update.name })
      .where(eq(users.id, update.id));
  }
});

// Bulk update with CASE
await db.execute(sql`
  UPDATE ${users}
  SET ${users.role} = CASE ${users.id}
    ${sql.join(
      updates.map((u) => sql`WHEN ${u.id} THEN ${u.role}`),
      sql.raw(' ')
    )}
  END
  WHERE ${users.id} IN (${sql.join(updates.map((u) => u.id), sql.raw(', '))})
`);
```

### Batch Delete

```typescript
// Delete multiple IDs
await db.delete(users).where(inArray(users.id, [1, 2, 3, 4, 5]));

// Conditional batch delete
await db.delete(posts).where(
  and(
    lt(posts.createdAt, new Date('2023-01-01')),
    eq(posts.isDraft, true)
  )
);
```

## LATERAL Joins

```typescript
// Get top 3 posts for each author
const authorsWithTopPosts = await db
  .select({
    author: authors,
    post: posts,
  })
  .from(authors)
  .leftJoin(
    sql`LATERAL (
      SELECT * FROM ${posts}
      WHERE ${posts.authorId} = ${authors.id}
      ORDER BY ${posts.views} DESC
      LIMIT 3
    ) AS ${posts}`,
    sql`true`
  );
```

## UNION Queries

```typescript
// Combine results from multiple queries
const allContent = await db
  .select({ id: posts.id, title: posts.title, type: sql<string>`'post'` })
  .from(posts)
  .union(
    db.select({ id: articles.id, title: articles.title, type: sql<string>`'article'` })
      .from(articles)
  );

// UNION ALL (includes duplicates)
const allItems = await db
  .select({ id: products.id, name: products.name })
  .from(products)
  .unionAll(
    db.select({ id: services.id, name: services.name }).from(services)
  );
```

## Distinct Queries

```typescript
// DISTINCT
const uniqueRoles = await db.selectDistinct({ role: users.role }).from(users);

// DISTINCT ON (PostgreSQL)
const latestPostPerAuthor = await db
  .selectDistinctOn([posts.authorId], {
    post: posts,
  })
  .from(posts)
  .orderBy(posts.authorId, desc(posts.createdAt));
```

## Locking Strategies

```typescript
// FOR UPDATE (pessimistic locking)
await db.transaction(async (tx) => {
  const user = await tx
    .select()
    .from(users)
    .where(eq(users.id, userId))
    .for('update');

  // Critical section - user row is locked
  await tx.update(users)
    .set({ balance: user.balance - amount })
    .where(eq(users.id, userId));
});

// FOR SHARE (shared lock)
const user = await db
  .select()
  .from(users)
  .where(eq(users.id, userId))
  .for('share');

// SKIP LOCKED
const availableTask = await db
  .select()
  .from(tasks)
  .where(eq(tasks.status, 'pending'))
  .limit(1)
  .for('update', { skipLocked: true });
```

## Query Builder Patterns

### Type-Safe Query Builder

```typescript
class UserQueryBuilder {
  private query = db.select().from(users);

  whereRole(role: string) {
    this.query = this.query.where(eq(users.role, role));
    return this;
  }

  whereActive() {
    this.query = this.query.where(eq(users.isActive, true));
    return this;
  }

  orderByCreated() {
    this.query = this.query.orderBy(desc(users.createdAt));
    return this;
  }

  async execute() {
    return await this.query;
  }
}

// Usage
const admins = await new UserQueryBuilder()
  .whereRole('admin')
  .whereActive()
  .orderByCreated()
  .execute();
```

## Best Practices

### Avoid N+1 Queries

```typescript
// ❌ Bad: N+1 query
const authors = await db.select().from(authors);
for (const author of authors) {
  author.posts = await db.select().from(posts).where(eq(posts.authorId, author.id));
}

// ✅ Good: Single query with join
const authorsWithPosts = await db.query.authors.findMany({
  with: { posts: true },
});

// ✅ Good: Dataloader pattern
import DataLoader from 'dataloader';

const postLoader = new DataLoader(async (authorIds: number[]) => {
  const posts = await db.select().from(posts).where(inArray(posts.authorId, authorIds));

  const grouped = authorIds.map(id =>
    posts.filter(post => post.authorId === id)
  );

  return grouped;
});
```

### Query Timeouts

```typescript
// PostgreSQL statement timeout
await db.execute(sql`SET statement_timeout = '5s'`);

// Per-query timeout
const withTimeout = async <T>(promise: Promise<T>, ms: number): Promise<T> => {
  const timeout = new Promise<never>((_, reject) =>
    setTimeout(() => reject(new Error('Query timeout')), ms)
  );
  return Promise.race([promise, timeout]);
};

const users = await withTimeout(
  db.select().from(users),
  5000
);
```
