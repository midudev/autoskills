---
name: server-routes
description: API routes, server middleware, and Nitro server engine in Nuxt
---

# Server Routes

Nuxt includes Nitro server engine for building full-stack applications with API routes and server middleware.

## API Routes

Create files in `server/api/` directory:

```ts
// server/api/hello.ts
export default defineEventHandler((event) => {
  return { message: 'Hello World' }
})
```

Access at `/api/hello`.

### HTTP Methods

```ts
// server/api/users.get.ts - GET /api/users
export default defineEventHandler(() => {
  return getUsers()
})

// server/api/users.post.ts - POST /api/users
export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  return createUser(body)
})

// server/api/users/[id].put.ts - PUT /api/users/:id
export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  const body = await readBody(event)
  return updateUser(id, body)
})

// server/api/users/[id].delete.ts - DELETE /api/users/:id
export default defineEventHandler((event) => {
  const id = getRouterParam(event, 'id')
  return deleteUser(id)
})
```

### Route Parameters

```ts
// server/api/posts/[id].ts
export default defineEventHandler((event) => {
  const id = getRouterParam(event, 'id')
  return getPost(id)
})

// Catch-all: server/api/[...path].ts
export default defineEventHandler((event) => {
  const path = getRouterParam(event, 'path')
  return { path }
})
```

### Query Parameters

```ts
// server/api/search.ts
// GET /api/search?q=nuxt&page=1
export default defineEventHandler((event) => {
  const query = getQuery(event)
  // { q: 'nuxt', page: '1' }
  return search(query.q, Number(query.page))
})
```

### Request Body

```ts
// server/api/submit.post.ts
export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  // Validate and process body
  return { success: true, data: body }
})
```

### Headers and Cookies

```ts
// server/api/auth.ts
export default defineEventHandler((event) => {
  // Read headers
  const auth = getHeader(event, 'authorization')

  // Read cookies
  const cookies = parseCookies(event)
  const token = getCookie(event, 'token')

  // Set headers
  setHeader(event, 'X-Custom-Header', 'value')

  // Set cookies
  setCookie(event, 'token', 'new-token', {
    httpOnly: true,
    secure: true,
    maxAge: 60 * 60 * 24, // 1 day
  })

  return { authenticated: !!token }
})
```

## Server Middleware

Runs on every request before routes:

```ts
// server/middleware/auth.ts
export default defineEventHandler((event) => {
  const token = getCookie(event, 'token')

  // Attach data to event context
  event.context.user = token ? verifyToken(token) : null
})

// server/middleware/log.ts
export default defineEventHandler((event) => {
  console.log(`${event.method} ${event.path}`)
})
```

Access context in routes:

```ts
// server/api/profile.ts
export default defineEventHandler((event) => {
  const user = event.context.user
  if (!user) {
    throw createError({ statusCode: 401, message: 'Unauthorized' })
  }
  return user
})
```

## Error Handling

```ts
// server/api/users/[id].ts
export default defineEventHandler((event) => {
  const id = getRouterParam(event, 'id')
  const user = findUser(id)

  if (!user) {
    throw createError({
      statusCode: 404,
      statusMessage: 'User not found',
    })
  }

  return user
})
```

## Server Utils

Auto-imported in `server/utils/`:

```ts
// server/utils/db.ts
export function useDb() {
  return createDbConnection()
}
```

```ts
// server/api/users.ts
export default defineEventHandler(() => {
  const db = useDb() // Auto-imported
  return db.query('SELECT * FROM users')
})
```

## Server Plugins

Run once when server starts:

```ts
// server/plugins/db.ts
export default defineNitroPlugin((nitroApp) => {
  // Initialize database connection
  const db = createDbConnection()

  // Add to context
  nitroApp.hooks.hook('request', (event) => {
    event.context.db = db
  })
})
```

## Streaming Responses

```ts
// server/api/stream.ts
export default defineEventHandler((event) => {
  setHeader(event, 'Content-Type', 'text/event-stream')
  setHeader(event, 'Cache-Control', 'no-cache')
  setHeader(event, 'Connection', 'keep-alive')

  const stream = new ReadableStream({
    async start(controller) {
      for (let i = 0; i < 10; i++) {
        controller.enqueue(`data: ${JSON.stringify({ count: i })}\n\n`)
        await new Promise(r => setTimeout(r, 1000))
      }
      controller.close()
    },
  })

  return stream
})
```

## Server Storage

Key-value storage with multiple drivers:

```ts
// server/api/cache.ts
export default defineEventHandler(async (event) => {
  const storage = useStorage()

  // Set value
  await storage.setItem('key', { data: 'value' })

  // Get value
  const data = await storage.getItem('key')

  return data
})
```

Configure storage drivers in `nuxt.config.ts`:

```ts
export default defineNuxtConfig({
  nitro: {
    storage: {
      redis: {
        driver: 'redis',
        url: 'redis://localhost:6379',
      },
    },
  },
})
```

<!-- 
Source references:
- https://nuxt.com/docs/getting-started/server
- https://nuxt.com/docs/directory-structure/server
- https://nitro.build/guide
-->
