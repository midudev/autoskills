# API Routes (HIGH)

## Auth Check Pattern

```typescript
import { auth } from '@clerk/nextjs/server';

export async function GET() {
  const { isAuthenticated, userId } = await auth();
  if (!isAuthenticated) {
    return Response.json({ error: 'Unauthorized' }, { status: 401 });
  }
  const data = await db.data.findMany({ where: { userId } });
  return Response.json(data);
}
```

> **Core 2 ONLY (skip if current SDK):** `isAuthenticated` is not available. Use `if (!userId)` instead.

## 401 vs 403

- **401** - Not authenticated
- **403** - Authenticated but lacks permission

```typescript
export async function DELETE(req: Request) {
  const { isAuthenticated, has } = await auth();
  if (!isAuthenticated) return Response.json({ error: 'Unauthorized' }, { status: 401 });

  const isAdmin = await has({ role: 'org:admin' });
  if (!isAdmin) return Response.json({ error: 'Forbidden' }, { status: 403 });

  return Response.json({ success: true });
}
```

## Org Route Protection

```typescript
export async function GET(req: Request, { params }: { params: { orgId: string } }) {
  const { userId, orgId } = await auth();
  if (!userId) return Response.json({ error: 'Unauthorized' }, { status: 401 });
  if (orgId !== params.orgId) return Response.json({ error: 'Forbidden' }, { status: 403 });

  const orgData = await db.orgs.findUnique({ where: { id: orgId } });
  return Response.json(orgData);
}
```

[Docs](https://clerk.com/docs/reference/nextjs/auth)
