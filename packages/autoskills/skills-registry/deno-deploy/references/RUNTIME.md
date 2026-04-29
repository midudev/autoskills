# Deno Deploy Runtime

## Overview

Deno Deploy uses the standard Deno runtime. You can use JSR and NPM packages, filesystem operations, network requests, subprocesses, and FFI/native addons.

## Current Environment

- **Runtime:** Deno 2.5.0
- **Platform:** Linux (x64 or ARM64)
- **Permissions:** All permissions enabled automatically (`--allow-all`)

**Note:** Custom Deno flags cannot be passed to the runtime.

## Serverless Lifecycle

Understanding how your app starts and stops is important for building reliable applications.

### Startup

Your application starts when a request arrives. If your app crashes before the HTTP server starts, requests return a 502 error.

**Tip:** Keep startup fast by:
- Reducing dependencies
- Using dynamic imports for rarely-used code
- Avoiding network requests during startup

### Idle Shutdown

After 5-10 minutes without requests:
1. The system sends a `SIGINT` signal
2. Your app has 5 seconds to shut down gracefully
3. If still running, `SIGKILL` terminates it

```typescript
// Handle graceful shutdown
Deno.addSignalListener("SIGINT", () => {
  console.log("Shutting down...");
  // Clean up resources, close connections
  Deno.exit(0);
});
```

### Eviction

Even during active traffic, instances may be terminated due to:
- Infrastructure updates
- Resource constraints

The system redirects traffic first, then signals shutdown. **Long-running connections should expect reconnections.**

## Cold Start Performance

Cold starts typically complete:
- **~100ms** for simple "hello world" apps
- **A few hundred ms** for larger applications

Deno Deploy optimizes cold starts using:
- Pre-provisioned microVMs
- Early TCP connection setup
- File system warmup

### Minimizing Cold Start Time

```typescript
// BAD: Top-level network request delays startup
const config = await fetch("https://api.example.com/config").then(r => r.json());

// GOOD: Lazy load on first request
let config: Config | null = null;
async function getConfig() {
  if (!config) {
    config = await fetch("https://api.example.com/config").then(r => r.json());
  }
  return config;
}
```

## Limitations

| Feature | Status |
|---------|--------|
| Custom Deno flags | Not supported |
| Persistent filesystem | Use Deno KV instead |
| Long-running background tasks | May be interrupted |
| System tools | Available but may change |

## Documentation

- Runtime reference: https://docs.deno.com/deploy/reference/runtime/
