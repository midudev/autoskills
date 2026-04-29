# Performance Optimization

Connection pooling, query optimization, edge runtime integration, and performance best practices.

## Connection Pooling

### PostgreSQL (node-postgres)

```typescript
import { Pool } from 'pg';
import { drizzle } from 'drizzle-orm/node-postgres';

const pool = new Pool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20,                    // Maximum pool size
  idleTimeoutMillis: 30000,   // Close idle clients after 30s
  connectionTimeoutMillis: 2000, // Timeout connection attempts
});

export const db = drizzle(pool);

// Graceful shutdown
process.on('SIGTERM', async () => {
  await pool.end();
});
```

### MySQL (mysql2)

```typescript
import mysql from 'mysql2/promise';
import { drizzle } from 'drizzle-orm/mysql2';

const poolConnection = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  maxIdle: 10,
  idleTimeout: 60000,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
});

export const db = drizzle(poolConnection);
```

### SQLite (better-sqlite3)

```typescript
import Database from 'better-sqlite3';
import { drizzle } from 'drizzle-orm/better-sqlite3';

const sqlite = new Database('sqlite.db', {
  readonly: false,
  fileMustExist: false,
  timeout: 5000,
  verbose: console.log, // Remove in production
});

// Performance pragmas
sqlite.pragma('journal_mode = WAL');
sqlite.pragma('synchronous = normal');
sqlite.pragma('cache_size = -64000'); // 64MB cache
sqlite.pragma('temp_store = memory');

export const db = drizzle(sqlite);

process.on('exit', () => sqlite.close());
```

## Query Optimization

### Select Only Needed Columns

```typescript
// ❌ Bad: Fetch all columns
const users = await db.select().from(users);

// ✅ Good: Fetch only needed columns
const users = await db.select({
  id: users.id,
  email: users.email,
  name: users.name,
}).from(users);
```

### Use Indexes Effectively

```typescript
import { pgTable, serial, text, varchar, index } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull(),
  city: text('city'),
  status: text('status'),
}, (table) => ({
  // Index frequently queried columns
  emailIdx: index('email_idx').on(table.email),

  // Composite index for common query patterns
  cityStatusIdx: index('city_status_idx').on(table.city, table.status),
}));

// Query uses index
const activeUsersInNYC = await db.select()
  .from(users)
  .where(and(
    eq(users.city, 'NYC'),
    eq(users.status, 'active')
  ));
```

### Analyze Query Plans

```typescript
import { sql } from 'drizzle-orm';

// PostgreSQL EXPLAIN
const plan = await db.execute(
  sql`EXPLAIN ANALYZE SELECT * FROM ${users} WHERE ${users.email} = 'user@example.com'`
);

console.log(plan.rows);

// Check for:
// - "Seq Scan" (bad) vs "Index Scan" (good)
// - Actual time vs estimated time
// - Rows removed by filter
```

### Pagination Performance

```typescript
// ❌ Bad: OFFSET on large datasets (gets slower as offset increases)
const page = await db.select()
  .from(users)
  .limit(20)
  .offset(10000); // Scans 10,020 rows!

// ✅ Good: Cursor-based pagination (constant time)
const page = await db.select()
  .from(users)
  .where(gt(users.id, lastSeenId))
  .orderBy(asc(users.id))
  .limit(20);

// ✅ Good: Seek method for timestamp-based pagination
const page = await db.select()
  .from(posts)
  .where(lt(posts.createdAt, lastSeenTimestamp))
  .orderBy(desc(posts.createdAt))
  .limit(20);
```

## Edge Runtime Integration

### Cloudflare Workers (D1)

```typescript
import { drizzle } from 'drizzle-orm/d1';

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const db = drizzle(env.DB);

    const users = await db.select().from(users).limit(10);

    return Response.json(users);
  },
};
```

### Vercel Edge (Neon)

```typescript
import { neon } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-http';

export const runtime = 'edge';

export async function GET() {
  const sql = neon(process.env.DATABASE_URL!);
  const db = drizzle(sql);

  const users = await db.select().from(users);

  return Response.json(users);
}
```

### Supabase Edge Functions

```typescript
import { createClient } from '@supabase/supabase-js';
import { drizzle } from 'drizzle-orm/postgres-js';
import postgres from 'postgres';

Deno.serve(async (req) => {
  const client = postgres(Deno.env.get('DATABASE_URL')!);
  const db = drizzle(client);

  const data = await db.select().from(users);

  return new Response(JSON.stringify(data), {
    headers: { 'Content-Type': 'application/json' },
  });
});
```

## Caching Strategies

### In-Memory Cache

```typescript
import { LRUCache } from 'lru-cache';

const cache = new LRUCache<string, any>({
  max: 500,
  ttl: 1000 * 60 * 5, // 5 minutes
});

async function getCachedUser(id: number) {
  const key = `user:${id}`;
  const cached = cache.get(key);

  if (cached) return cached;

  const user = await db.select().from(users).where(eq(users.id, id));
  cache.set(key, user);

  return user;
}
```

### Redis Cache Layer

```typescript
import { Redis } from 'ioredis';

const redis = new Redis(process.env.REDIS_URL);

async function getCachedData<T>(
  key: string,
  fetcher: () => Promise<T>,
  ttl: number = 300
): Promise<T> {
  // Try cache first
  const cached = await redis.get(key);
  if (cached) return JSON.parse(cached);

  // Fetch from database
  const data = await fetcher();

  // Store in cache
  await redis.setex(key, ttl, JSON.stringify(data));

  return data;
}

// Usage
const users = await getCachedData(
  'users:all',
  () => db.select().from(users),
  600
);
```

### Materialized Views (PostgreSQL)

```typescript
// Create materialized view (via migration)
/*
CREATE MATERIALIZED VIEW user_stats AS
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count,
  COUNT(c.id) AS comment_count
FROM users u
LEFT JOIN posts p ON p.author_id = u.id
LEFT JOIN comments c ON c.user_id = u.id
GROUP BY u.id;

CREATE UNIQUE INDEX ON user_stats (id);
*/

// Define schema
export const userStats = pgMaterializedView('user_stats').as((qb) =>
  qb.select({
    id: users.id,
    name: users.name,
    postCount: sql<number>`COUNT(${posts.id})`,
    commentCount: sql<number>`COUNT(${comments.id})`,
  })
  .from(users)
  .leftJoin(posts, eq(posts.authorId, users.id))
  .leftJoin(comments, eq(comments.userId, users.id))
  .groupBy(users.id)
);

// Refresh materialized view
await db.execute(sql`REFRESH MATERIALIZED VIEW CONCURRENTLY user_stats`);

// Query materialized view (fast!)
const stats = await db.select().from(userStats);
```

## Batch Operations Optimization

### Batch Insert with COPY (PostgreSQL)

```typescript
import { copyFrom } from 'pg-copy-streams';
import { pipeline } from 'stream/promises';
import { Readable } from 'stream';

async function bulkInsert(data: any[]) {
  const client = await pool.connect();

  try {
    const stream = client.query(
      copyFrom(`COPY users (email, name) FROM STDIN WITH (FORMAT csv)`)
    );

    const input = Readable.from(
      data.map(row => `${row.email},${row.name}\n`)
    );

    await pipeline(input, stream);
  } finally {
    client.release();
  }
}

// 10x faster than batch INSERT for large datasets
```

### Chunk Processing

```typescript
async function* chunked<T>(array: T[], size: number) {
  for (let i = 0; i < array.length; i += size) {
    yield array.slice(i, i + size);
  }
}

async function bulkUpdate(updates: { id: number; name: string }[]) {
  for await (const chunk of chunked(updates, 100)) {
    await db.transaction(async (tx) => {
      for (const update of chunk) {
        await tx.update(users)
          .set({ name: update.name })
          .where(eq(users.id, update.id));
      }
    });
  }
}
```

## Connection Management

### Serverless Optimization

```typescript
// ❌ Bad: New connection per request
export async function handler() {
  const pool = new Pool({ connectionString: process.env.DATABASE_URL });
  const db = drizzle(pool);

  const users = await db.select().from(users);

  await pool.end();
  return users;
}

// ✅ Good: Reuse connection across warm starts
let cachedDb: ReturnType<typeof drizzle> | null = null;

export async function handler() {
  if (!cachedDb) {
    const pool = new Pool({
      connectionString: process.env.DATABASE_URL,
      max: 1, // Serverless: single connection per instance
    });
    cachedDb = drizzle(pool);
  }

  const users = await cachedDb.select().from(users);
  return users;
}
```

### HTTP-based Databases (Neon, Turso)

```typescript
// No connection pooling needed - uses HTTP
import { neon } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-http';

const sql = neon(process.env.DATABASE_URL!);
const db = drizzle(sql);

// Each query is a single HTTP request
const users = await db.select().from(users);
```

## Read Replicas

```typescript
import { Pool } from 'pg';
import { drizzle } from 'drizzle-orm/node-postgres';

// Primary (writes)
const primaryPool = new Pool({ connectionString: process.env.PRIMARY_DB_URL });
const primaryDb = drizzle(primaryPool);

// Replica (reads)
const replicaPool = new Pool({ connectionString: process.env.REPLICA_DB_URL });
const replicaDb = drizzle(replicaPool);

// Route queries appropriately
async function getUsers() {
  return replicaDb.select().from(users); // Read from replica
}

async function createUser(data: NewUser) {
  return primaryDb.insert(users).values(data).returning(); // Write to primary
}
```

## Monitoring & Profiling

### Query Logging

```typescript
import { drizzle } from 'drizzle-orm/node-postgres';

const db = drizzle(pool, {
  logger: {
    logQuery(query: string, params: unknown[]) {
      console.log('Query:', query);
      console.log('Params:', params);
      console.time('query');
    },
  },
});

// Custom logger with metrics
class MetricsLogger {
  private queries: Map<string, { count: number; totalTime: number }> = new Map();

  logQuery(query: string) {
    const start = Date.now();

    return () => {
      const duration = Date.now() - start;
      const stats = this.queries.get(query) || { count: 0, totalTime: 0 };

      this.queries.set(query, {
        count: stats.count + 1,
        totalTime: stats.totalTime + duration,
      });

      if (duration > 1000) {
        console.warn(`Slow query (${duration}ms):`, query);
      }
    };
  }

  getStats() {
    return Array.from(this.queries.entries()).map(([query, stats]) => ({
      query,
      count: stats.count,
      avgTime: stats.totalTime / stats.count,
    }));
  }
}
```

### Performance Monitoring

```typescript
import { performance } from 'perf_hooks';

async function measureQuery<T>(
  name: string,
  query: Promise<T>
): Promise<T> {
  const start = performance.now();

  try {
    const result = await query;
    const duration = performance.now() - start;

    console.log(`[${name}] completed in ${duration.toFixed(2)}ms`);

    return result;
  } catch (error) {
    const duration = performance.now() - start;
    console.error(`[${name}] failed after ${duration.toFixed(2)}ms`, error);
    throw error;
  }
}

// Usage
const users = await measureQuery(
  'fetchUsers',
  db.select().from(users).limit(100)
);
```

## Database-Specific Optimizations

### PostgreSQL

```typescript
// Connection optimization
const pool = new Pool({
  max: 20,
  application_name: 'myapp',
  statement_timeout: 30000, // 30s query timeout
  query_timeout: 30000,
  connectionTimeoutMillis: 5000,
  idle_in_transaction_session_timeout: 10000,
});

// Session optimization
await db.execute(sql`SET work_mem = '256MB'`);
await db.execute(sql`SET maintenance_work_mem = '512MB'`);
await db.execute(sql`SET effective_cache_size = '4GB'`);
```

### MySQL

```typescript
const pool = mysql.createPool({
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
  dateStrings: false,
  supportBigNumbers: true,
  bigNumberStrings: false,
  multipleStatements: false, // Security
  timezone: 'Z', // UTC
});
```

### SQLite

```typescript
// WAL mode for concurrent reads
sqlite.pragma('journal_mode = WAL');

// Optimize for performance
sqlite.pragma('synchronous = NORMAL');
sqlite.pragma('cache_size = -64000'); // 64MB
sqlite.pragma('temp_store = MEMORY');
sqlite.pragma('mmap_size = 30000000000'); // 30GB mmap

// Disable for bulk inserts
const stmt = sqlite.prepare('INSERT INTO users (email, name) VALUES (?, ?)');

const insertMany = sqlite.transaction((users) => {
  for (const user of users) {
    stmt.run(user.email, user.name);
  }
});

insertMany(users); // 100x faster than individual inserts
```

## Best Practices Summary

1. **Always use connection pooling** in long-running processes
2. **Select only needed columns** to reduce network transfer
3. **Add indexes** on frequently queried columns and foreign keys
4. **Use cursor-based pagination** instead of OFFSET for large datasets
5. **Batch operations** when inserting/updating multiple records
6. **Cache expensive queries** with appropriate TTL
7. **Monitor slow queries** and optimize with EXPLAIN ANALYZE
8. **Use prepared statements** for frequently executed queries
9. **Implement read replicas** for high-traffic read operations
10. **Use HTTP-based databases** (Neon, Turso) for edge/serverless
