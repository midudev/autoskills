# Loaders (HIGH)

## Auth in Loaders

Loaders receive context from `beforeLoad`. Pass `userId` or `orgId` through context:

```typescript
export const Route = createFileRoute('/dashboard')({
  beforeLoad: async () => {
    const { userId } = await requireAuth()
    return { userId }
  },
  loader: async ({ context }) => {
    const projects = await db.projects.findMany({
      where: { ownerId: context.userId },
    })
    return { projects }
  },
  component: function Dashboard() {
    const { projects } = Route.useLoaderData()
    return (
      <ul>
        {projects.map(p => <li key={p.id}>{p.name}</li>)}
      </ul>
    )
  },
})
```

## Org-Aware Loader

```typescript
const getOrgContext = createServerFn().handler(async () => {
  const { isAuthenticated, userId, orgId } = await auth()
  if (!isAuthenticated) throw redirect({ to: '/sign-in' })
  return { userId, orgId }
})

export const Route = createFileRoute('/app/projects')({
  beforeLoad: async () => await getOrgContext(),
  loader: async ({ context }) => {
    if (!context.orgId) {
      return { projects: [], requiresOrg: true }
    }

    const projects = await db.projects.findMany({
      where: { orgId: context.orgId },
    })
    return { projects, requiresOrg: false }
  },
})
```

## useLoaderData

Access loader data in the route component:

```typescript
function Projects() {
  const { projects, requiresOrg } = Route.useLoaderData()

  if (requiresOrg) {
    return <OrganizationSwitcher />
  }

  return <ProjectList projects={projects} />
}
```

## Server vs Client Data

Loaders run on the server during SSR and on the client during navigation. `auth()` works in both because it reads from the Clerk middleware context.

[Docs](https://clerk.com/docs/tanstack-react-start/getting-started/quickstart)
