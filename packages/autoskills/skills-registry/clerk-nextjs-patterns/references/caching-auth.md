# Caching with Auth (CRITICAL)

**CRITICAL**: Cache keys MUST include userId/orgId to prevent data leaking between users.

## User-Scoped Cache

```typescript
import { auth } from '@clerk/nextjs/server';
import { unstable_cache } from 'next/cache';

export default async function ProfilePage() {
  const { userId } = await auth();
  if (!userId) return <div>Not signed in</div>;

  const cachedGetUserData = unstable_cache(
    () => getUserData(userId),
    [`user-${userId}`],
    { revalidate: 60, tags: [`user-${userId}`] }
  );

  const userData = await cachedGetUserData();
  return <div>{userData.name}</div>;
}
```

## Revalidate After Updates

```typescript
'use server';
import { revalidateTag } from 'next/cache';
import { auth } from '@clerk/nextjs/server';

export async function updateProfile(formData: FormData) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  await db.users.update({
    where: { id: userId },
    data: { name: formData.get('name') as string },
  });
  revalidateTag(`user-${userId}`);
}
```

## Org-Scoped Cache

```typescript
const { orgId } = await auth();
const getOrgData = unstable_cache(
  () => db.orgData.findMany({ where: { organizationId: orgId } }),
  [`org-${orgId}-data`],
  { revalidate: 300, tags: [`org-${orgId}`] }
);
```

[Docs](https://nextjs.org/docs/app/building-your-application/caching)
