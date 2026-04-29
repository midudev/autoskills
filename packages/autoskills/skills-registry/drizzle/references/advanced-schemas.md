# Advanced Schemas

Deep dive into complex schema patterns, custom types, and database-specific features in Drizzle ORM.

## Custom Column Types

### Enums

```typescript
import { pgEnum, pgTable, serial } from 'drizzle-orm/pg-core';

// PostgreSQL native enum
export const roleEnum = pgEnum('role', ['admin', 'user', 'guest']);

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  role: roleEnum('role').default('user'),
});

// MySQL/SQLite: Use text with constraints
import { mysqlTable, text } from 'drizzle-orm/mysql-core';

export const users = mysqlTable('users', {
  role: text('role', { enum: ['admin', 'user', 'guest'] }).default('user'),
});
```

### Custom JSON Types

```typescript
import { pgTable, serial, json } from 'drizzle-orm/pg-core';
import { z } from 'zod';

// Type-safe JSON with Zod
const MetadataSchema = z.object({
  theme: z.enum(['light', 'dark']),
  locale: z.string(),
  notifications: z.boolean(),
});

type Metadata = z.infer<typeof MetadataSchema>;

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  metadata: json('metadata').$type<Metadata>(),
});

// Runtime validation
async function updateMetadata(userId: number, metadata: unknown) {
  const validated = MetadataSchema.parse(metadata);
  await db.update(users).set({ metadata: validated }).where(eq(users.id, userId));
}
```

### Arrays

```typescript
import { pgTable, serial, text } from 'drizzle-orm/pg-core';

export const posts = pgTable('posts', {
  id: serial('id').primaryKey(),
  tags: text('tags').array(),
});

// Query array columns
import { arrayContains, arrayContained } from 'drizzle-orm';

await db.select().from(posts).where(arrayContains(posts.tags, ['typescript', 'drizzle']));
```

## Indexes

### Basic Indexes

```typescript
import { pgTable, serial, text, varchar, index, uniqueIndex } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull(),
  name: text('name'),
  city: text('city'),
}, (table) => ({
  emailIdx: uniqueIndex('email_idx').on(table.email),
  nameIdx: index('name_idx').on(table.name),
  cityNameIdx: index('city_name_idx').on(table.city, table.name),
}));
```

### Partial Indexes

```typescript
import { sql } from 'drizzle-orm';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }),
  deletedAt: timestamp('deleted_at'),
}, (table) => ({
  activeEmailIdx: uniqueIndex('active_email_idx')
    .on(table.email)
    .where(sql`${table.deletedAt} IS NULL`),
}));
```

### Full-Text Search

```typescript
import { pgTable, serial, text, index } from 'drizzle-orm/pg-core';
import { sql } from 'drizzle-orm';

export const posts = pgTable('posts', {
  id: serial('id').primaryKey(),
  title: text('title').notNull(),
  content: text('content').notNull(),
}, (table) => ({
  searchIdx: index('search_idx').using(
    'gin',
    sql`to_tsvector('english', ${table.title} || ' ' || ${table.content})`
  ),
}));

// Full-text search query
const results = await db.select().from(posts).where(
  sql`to_tsvector('english', ${posts.title} || ' ' || ${posts.content}) @@ plainto_tsquery('english', 'typescript orm')`
);
```

## Composite Keys

```typescript
import { pgTable, text, primaryKey } from 'drizzle-orm/pg-core';

export const userPreferences = pgTable('user_preferences', {
  userId: integer('user_id').notNull(),
  key: text('key').notNull(),
  value: text('value').notNull(),
}, (table) => ({
  pk: primaryKey({ columns: [table.userId, table.key] }),
}));
```

## Check Constraints

```typescript
import { pgTable, serial, integer, check } from 'drizzle-orm/pg-core';
import { sql } from 'drizzle-orm';

export const products = pgTable('products', {
  id: serial('id').primaryKey(),
  price: integer('price').notNull(),
  discountPrice: integer('discount_price'),
}, (table) => ({
  priceCheck: check('price_check', sql`${table.price} > 0`),
  discountCheck: check('discount_check', sql`${table.discountPrice} < ${table.price}`),
}));
```

## Generated Columns

```typescript
import { pgTable, serial, text, integer } from 'drizzle-orm/pg-core';
import { sql } from 'drizzle-orm';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  firstName: text('first_name').notNull(),
  lastName: text('last_name').notNull(),
  fullName: text('full_name').generatedAlwaysAs(
    (): SQL => sql`${users.firstName} || ' ' || ${users.lastName}`,
    { mode: 'stored' }
  ),
});
```

## Multi-Tenant Patterns

### Row-Level Security (PostgreSQL)

```typescript
import { pgTable, serial, text, uuid } from 'drizzle-orm/pg-core';

export const tenants = pgTable('tenants', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').notNull(),
});

export const documents = pgTable('documents', {
  id: serial('id').primaryKey(),
  tenantId: uuid('tenant_id').notNull().references(() => tenants.id),
  title: text('title').notNull(),
  content: text('content'),
});

// Apply RLS policy (via migration SQL)
/*
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation ON documents
  USING (tenant_id = current_setting('app.current_tenant_id')::uuid);
*/

// Set tenant context
await db.execute(sql`SET app.current_tenant_id = ${tenantId}`);
```

### Schema-Per-Tenant

```typescript
import { drizzle } from 'drizzle-orm/node-postgres';

// Create schema-aware connection
function getTenantDb(tenantId: string) {
  const schemaName = `tenant_${tenantId}`;

  return drizzle(pool, {
    schema: {
      ...schema,
    },
    schemaPrefix: schemaName,
  });
}

// Use tenant-specific DB
const tenantDb = getTenantDb('tenant123');
await tenantDb.select().from(users);
```

## Database-Specific Features

### PostgreSQL: JSONB Operations

```typescript
import { pgTable, serial, jsonb } from 'drizzle-orm/pg-core';
import { sql } from 'drizzle-orm';

export const settings = pgTable('settings', {
  id: serial('id').primaryKey(),
  config: jsonb('config').$type<Record<string, unknown>>(),
});

// JSONB operators
await db.select().from(settings).where(
  sql`${settings.config}->>'theme' = 'dark'`
);

// JSONB path query
await db.select().from(settings).where(
  sql`${settings.config} @> '{"notifications": {"email": true}}'::jsonb`
);
```

### MySQL: Spatial Types

```typescript
import { mysqlTable, serial, geometry } from 'drizzle-orm/mysql-core';
import { sql } from 'drizzle-orm';

export const locations = mysqlTable('locations', {
  id: serial('id').primaryKey(),
  point: geometry('point', { type: 'point', srid: 4326 }),
});

// Spatial query
await db.select().from(locations).where(
  sql`ST_Distance_Sphere(${locations.point}, POINT(${lng}, ${lat})) < 1000`
);
```

### SQLite: FTS5

```typescript
import { sqliteTable, text } from 'drizzle-orm/sqlite-core';

export const documents = sqliteTable('documents', {
  title: text('title'),
  content: text('content'),
});

// Create FTS5 virtual table (via migration)
/*
CREATE VIRTUAL TABLE documents_fts USING fts5(title, content, content='documents');
*/
```

## Schema Versioning

### Migration Strategy

```typescript
// db/schema.ts
export const schemaVersion = pgTable('schema_version', {
  version: serial('version').primaryKey(),
  appliedAt: timestamp('applied_at').defaultNow(),
});

// Track migrations
await db.insert(schemaVersion).values({ version: 1 });

// Check version
const [currentVersion] = await db.select().from(schemaVersion).orderBy(desc(schemaVersion.version)).limit(1);
```

## Type Inference Helpers

```typescript
import { InferSelectModel, InferInsertModel } from 'drizzle-orm';

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: text('email').notNull(),
  name: text('name'),
});

// Generate types
export type User = InferSelectModel<typeof users>;
export type NewUser = InferInsertModel<typeof users>;

// Partial updates
export type UserUpdate = Partial<NewUser>;

// Nested relation types
export type UserWithPosts = User & {
  posts: Post[];
};
```

## Best Practices

### Schema Organization

```typescript
// db/schema/users.ts
export const users = pgTable('users', { ... });
export const userRelations = relations(users, { ... });

// db/schema/posts.ts
export const posts = pgTable('posts', { ... });
export const postRelations = relations(posts, { ... });

// db/schema/index.ts
export * from './users';
export * from './posts';

// db/client.ts
import * as schema from './schema';
export const db = drizzle(pool, { schema });
```

### Naming Conventions

```typescript
// ✅ Good: Consistent naming
export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  firstName: text('first_name'),
  createdAt: timestamp('created_at'),
});

// ❌ Bad: Inconsistent naming
export const Users = pgTable('user', {
  ID: serial('userId').primaryKey(),
  first_name: text('firstname'),
});
```

### Default Values

```typescript
import { sql } from 'drizzle-orm';

export const posts = pgTable('posts', {
  id: serial('id').primaryKey(),
  slug: text('slug').notNull(),
  views: integer('views').default(0),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').default(sql`CURRENT_TIMESTAMP`),
  uuid: uuid('uuid').defaultRandom(),
});
```
