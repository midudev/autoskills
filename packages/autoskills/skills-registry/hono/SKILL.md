---
name: hono
description: Use when building Hono web applications or when the user asks about Hono APIs, routing, middleware, JSX, validation, testing, or streaming. TRIGGER when code imports from 'hono' or 'hono/*', or user mentions Hono. Use `npx hono request` to test endpoints.
---

# Hono Skill

Build Hono web applications. This skill provides inline API knowledge for AI. Use `npx hono request` to test endpoints. If the `hono-docs` MCP server is configured, prefer its tools for the latest documentation over the inline reference.

## Hono CLI Usage

### Request Testing

Test endpoints without starting an HTTP server. Uses `app.request()` internally.

```bash
# GET request
npx hono request [file] -P /path

# POST request with JSON body
npx hono request [file] -X POST -P /api/users -d '{"name": "test"}'
```

**Note:** Do not pass credentials directly in CLI arguments. Use environment variables for sensitive values. `hono request` does not support Cloudflare Workers bindings (KV, D1, R2, etc.). When bindings are required, use `workers-fetch` instead:

```bash
npx workers-fetch /path
npx workers-fetch -X POST -H "Content-Type:application/json" -d '{"name":"test"}' /api/users
```

---

## Hono API Reference

### App Constructor

```ts
import { Hono } from 'hono'

const app = new Hono()

// With TypeScript generics
type Env = {
  Bindings: { DATABASE: D1Database; KV: KVNamespace }
  Variables: { user: User }
}
const app = new Hono<Env>()
```

### Routing Methods

```ts
app.get('/path', handler)
app.post('/path', handler)
app.put('/path', handler)
app.delete('/path', handler)
app.patch('/path', handler)
app.options('/path', handler)
app.all('/path', handler) // all HTTP methods
app.on('PURGE', '/path', handler) // custom method
app.on(['PUT', 'DELETE'], '/path', handler) // multiple methods
```

### Routing Patterns

```ts
// Path parameters
app.get('/user/:name', (c) => {
  const name = c.req.param('name')
  return c.json({ name })
})

// Multiple params
app.get('/posts/:id/comments/:commentId', (c) => {
  const { id, commentId } = c.req.param()
})

// Optional parameters
app.get('/api/animal/:type?', (c) => c.text('Animal!'))

// Wildcards
app.get('/wild/*/card', (c) => c.text('Wildcard'))

// Regexp constraints
app.get('/post/:date{[0-9]+}/:title{[a-z]+}', (c) => {
  const { date, title } = c.req.param()
})

// Chained routes
app
  .get('/endpoint', (c) => c.text('GET'))
  .post((c) => c.text('POST'))
  .delete((c) => c.text('DELETE'))
```

### Route Grouping

```ts
// Using route()
const api = new Hono()
api.get('/users', (c) => c.json([]))

const app = new Hono()
app.route('/api', api) // mounts at /api/users

// Using basePath()
const app = new Hono().basePath('/api')
app.get('/users', (c) => c.json([])) // GET /api/users
```

### Error Handling

```ts
app.notFound((c) => c.json({ message: 'Not Found' }, 404))

app.onError((err, c) => {
  console.error(err)
  return c.json({ message: 'Internal Server Error' }, 500)
})
```

---

## Context (c)

### Response Methods

```ts
c.text('Hello') // text/plain
c.json({ message: 'Hello' }) // application/json
c.html('<h1>Hello</h1>') // text/html
c.redirect('/new-path') // 302 redirect
c.redirect('/new-path', 301) // 301 redirect
c.body('raw body', 200, headers) // raw response
c.notFound() // 404 response
```

### Headers & Status

```ts
c.status(201)
c.header('X-Custom', 'value')
c.header('Cache-Control', 'no-store')
```

### Variables (request-scoped data)

```ts
// In middleware
c.set('user', { id: 1, name: 'Alice' })

// In handler
const user = c.get('user')
// or
const user = c.var.user
```

### Environment (Cloudflare Workers)

```ts
const value = await c.env.KV.get('key')
const db = c.env.DATABASE
c.executionCtx.waitUntil(promise)
```

### Renderer

```ts
app.use(async (c, next) => {
  c.setRenderer((content) =>
    c.html(
      <html><body>{content}</body></html>
    )
  )
  await next()
})

app.get('/', (c) => c.render(<h1>Hello</h1>))
```

---

## HonoRequest (c.req)

```ts
c.req.param('id') // path parameter
c.req.param() // all path params as object
c.req.query('page') // query string parameter
c.req.query() // all query params as object
c.req.queries('tags') // multiple values: ?tags=A&tags=B → ['A', 'B']
c.req.header('Authorization') // request header
c.req.header() // all headers (keys are lowercase)

// Body parsing
await c.req.json() // parse JSON body
await c.req.text() // parse text body
await c.req.formData() // parse as FormData
await c.req.parseBody() // parse multipart/form-data or urlencoded
await c.req.arrayBuffer() // parse as ArrayBuffer
await c.req.blob() // parse as Blob

// Validated data (used with validator middleware)
c.req.valid('json')
c.req.valid('query')
c.req.valid('form')
c.req.valid('param')

// Properties
c.req.url // full URL string
c.req.path // pathname
c.req.method // HTTP method
c.req.raw // underlying Request object
```

---

## Middleware

### Using Built-in Middleware

```ts
import { cors } from 'hono/cors'
import { logger } from 'hono/logger'
import { basicAuth } from 'hono/basic-auth'
import { prettyJSON } from 'hono/pretty-json'
import { secureHeaders } from 'hono/secure-headers'
import { etag } from 'hono/etag'
import { compress } from 'hono/compress'
import { poweredBy } from 'hono/powered-by'
import { timing } from 'hono/timing'
import { cache } from 'hono/cache'
import { bearerAuth } from 'hono/bearer-auth'
import { jwt } from 'hono/jwt'
import { csrf } from 'hono/csrf'
import { ipRestriction } from 'hono/ip-restriction'
import { bodyLimit } from 'hono/body-limit'
import { requestId } from 'hono/request-id'
import { methodOverride } from 'hono/method-override'
import { trailingSlash, trimTrailingSlash } from 'hono/trailing-slash'

// Registration
app.use(logger()) // all routes
app.use('/api/*', cors()) // specific path
app.post('/api/*', basicAuth({ username: 'admin', password: 'secret' }))
```

### Custom Middleware

```ts
// Inline
app.use(async (c, next) => {
  const start = Date.now()
  await next()
  const elapsed = Date.now() - start
  c.res.headers.set('X-Response-Time', `${elapsed}ms`)
})

// Reusable with createMiddleware
import { createMiddleware } from 'hono/factory'

const auth = createMiddleware(async (c, next) => {
  const token = c.req.header('Authorization')
  if (!token) return c.json({ error: 'Unauthorized' }, 401)
  await next()
})

app.use('/api/*', auth)
```

### Middleware Execution Order

Middleware executes in registration order. `await next()` calls the next middleware/handler, and code after `next()` runs on the way back:

```
Request → mw1 before → mw2 before → handler → mw2 after → mw1 after → Response
```

```ts
app.use(async (c, next) => {
  // before handler
  await next()
  // after handler
})
```

---

## Validation

Validation targets: `json`, `form`, `query`, `header`, `param`, `cookie`.

### Zod Validator

```ts
import { zValidator } from '@hono/zod-validator'
import { z } from 'zod'

const schema = z.object({
  title: z.string().min(1),
  body: z.string()
})

app.post('/posts', zValidator('json', schema), (c) => {
  const data = c.req.valid('json') // fully typed
  return c.json(data, 201)
})
```

### Valibot / Standard Schema Validator

```ts
import { sValidator } from '@hono/standard-validator'
import * as v from 'valibot'

const schema = v.object({ name: v.string(), age: v.number() })

app.post('/users', sValidator('json', schema), (c) => {
  const data = c.req.valid('json')
  return c.json(data, 201)
})
```

---

## JSX

### Setup

In `tsconfig.json`:

```json
{
  "compilerOptions": {
    "jsx": "react-jsx",
    "jsxImportSource": "hono/jsx"
  }
}
```

Or use pragma: `/** @jsxImportSource hono/jsx */`

**Important:** Files using JSX must have a `.tsx` extension. Rename `.ts` to `.tsx` or the compiler will fail.

### Components

```tsx
import type { PropsWithChildren } from 'hono/jsx'

const Layout = (props: PropsWithChildren) => (
  <html>
    <head>
      <title>My App</title>
    </head>
    <body>{props.children}</body>
  </html>
)

const UserCard = ({ name }: { name: string }) => (
  <div class="card">
    <h2>{name}</h2>
  </div>
)

app.get('/', (c) => {
  return c.html(
    <Layout>
      <UserCard name="Alice" />
    </Layout>
  )
})
```

### jsxRenderer Middleware

Use `jsxRenderer` middleware for layouts. See `npx hono docs /docs/middleware/builtin/jsx-renderer` for details.

### Async Components

```tsx
const UserList = async () => {
  const users = await fetchUsers()
  return (
    <ul>
      {users.map((u) => (
        <li>{u.name}</li>
      ))}
    </ul>
  )
}
```

### Fragments

```tsx
const Items = () => (
  <>
    <li>Item 1</li>
    <li>Item 2</li>
  </>
)
```

---

## Streaming

```ts
import { stream, streamText, streamSSE } from 'hono/streaming'

// Basic stream
app.get('/stream', (c) => {
  return stream(c, async (stream) => {
    stream.onAbort(() => console.log('Aborted'))
    await stream.write(new Uint8Array([0x48, 0x65]))
    await stream.pipe(readableStream)
  })
})

// Text stream
app.get('/stream-text', (c) => {
  return streamText(c, async (stream) => {
    await stream.writeln('Hello')
    await stream.sleep(1000)
    await stream.write('World')
  })
})

// Server-Sent Events
app.get('/sse', (c) => {
  return streamSSE(c, async (stream) => {
    let id = 0
    while (true) {
      await stream.writeSSE({
        data: JSON.stringify({ time: new Date().toISOString() }),
        event: 'time-update',
        id: String(id++)
      })
      await stream.sleep(1000)
    }
  })
})
```

---

## Testing with app.request()

Test endpoints without starting an HTTP server:

```ts
// GET
const res = await app.request('/posts')
expect(res.status).toBe(200)
expect(await res.json()).toEqual({ posts: [] })

// POST with JSON
const res = await app.request('/posts', {
  method: 'POST',
  body: JSON.stringify({ title: 'Hello' }),
  headers: { 'Content-Type': 'application/json' }
})

// POST with FormData
const formData = new FormData()
formData.append('name', 'Alice')
const res = await app.request('/users', { method: 'POST', body: formData })

// With mock env (Cloudflare Workers bindings)
const res = await app.request('/api/data', {}, { KV: mockKV, DATABASE: mockDB })

// Using Request object
const req = new Request('http://localhost/api', { method: 'DELETE' })
const res = await app.request(req)
```

---

## Hono Client (RPC)

Type-safe API client using shared types between server and client.

**IMPORTANT: Routes MUST be chained for type inference to work. Without chaining, the client cannot infer route types.**

```ts
// Server: routes MUST be chained to preserve types
const route = app
  .post('/posts', zValidator('json', schema), (c) => {
    return c.json({ ok: true }, 201)
  })
  .get('/posts', (c) => {
    return c.json({ posts: [] })
  })
export type AppType = typeof route

// Client: use hc() with the exported type
import { hc } from 'hono/client'
import type { AppType } from './server'

const client = hc<AppType>('http://localhost:8787/')
const res = await client.posts.$post({ json: { title: 'Hello' } })
const data = await res.json() // fully typed
```

Type utilities:

```ts
import type { InferRequestType, InferResponseType } from 'hono/client'

type ReqType = InferRequestType<typeof client.posts.$post>
type ResType = InferResponseType<typeof client.posts.$post, 200>
```

---

## Helpers

Helpers are utility functions imported from `hono/<helper-name>`:

```ts
import { getConnInfo } from 'hono/conninfo'
import { getCookie, setCookie, deleteCookie } from 'hono/cookie'
import { css, Style } from 'hono/css'
import { createFactory } from 'hono/factory'
import { html, raw } from 'hono/html'
import { stream, streamText, streamSSE } from 'hono/streaming'
import { testClient } from 'hono/testing'
import { upgradeWebSocket } from 'hono/cloudflare-workers' // or other adapter
```

Available helpers: Accepts, Adapter, ConnInfo, Cookie, css, Dev, Factory, html, JWT, Proxy, Route, SSG, Streaming, Testing, WebSocket.

For details, use `npx hono docs /docs/helpers/<helper-name>`.

### Factory

Use `createFactory` to define `Env` once and share it across app, middleware, and handlers:

```ts
import { createFactory } from 'hono/factory'

const factory = createFactory<Env>()

// Create app (Env type is inherited)
const app = factory.createApp()

// Create middleware (Env type is inherited, no need to pass generics)
const mw = factory.createMiddleware(async (c, next) => {
  await next()
})

// Create handlers separately (preserves type inference)
const handlers = factory.createHandlers(logger(), (c) => c.json({ message: 'Hello' }))
app.get('/api', ...handlers)
```

---

## Best Practices

- Write handlers inline in route definitions for proper type inference of path params.
- Use `app.route()` to organize large apps by feature, not Rails-style controllers.
- Use `createFactory()` to share Env type across app, middleware, and handlers.
- Use `c.set()`/`c.get()` to pass data between middleware and handlers.
- Chain validators for multiple request parts (param + query + json).
- Export app type for RPC: `export type AppType = typeof routes`
- Use `app.request()` for testing — no server startup needed.

## Adapters

Hono runs on multiple runtimes. The default export works for Cloudflare Workers, Deno, and Bun. For Node.js, use the Node adapter:

```ts
// Cloudflare Workers / Deno / Bun
export default app

// Node.js
import { serve } from '@hono/node-server'
serve(app)
```
