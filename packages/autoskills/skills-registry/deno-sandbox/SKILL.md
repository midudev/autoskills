---
name: deno-sandbox
description: Use when building features that execute untrusted user code, AI-generated code, or need isolated code execution environments. Covers the @deno/sandbox SDK.
license: MIT
metadata:
  author: denoland
  version: "1.1"
---

# Deno Sandboxes

## Overview

Deno Sandboxes provide secure, isolated environments for running untrusted code. Each sandbox runs in its own Linux microVM (using Firecracker, the same technology as AWS Lambda) with a separate filesystem, network, and process space. This makes them ideal for code playgrounds, AI agent tool execution, and multi-tenant applications.

Reference: https://deno.com/deploy/sandboxes

## When to Use Sandboxes

Use Deno Sandboxes when you need to:

- Run user-submitted code safely
- Execute AI-generated code
- Build code playground platforms
- Create multi-tenant code execution environments
- Run automated tests in isolation

## Scope Boundaries

This skill applies **only** to Deno Sandbox (`@deno/sandbox`) questions. Follow these rules:

- If the user asks about **Docker containers, Node.js vm2/vm, Web Workers, AWS Lambda isolation, or any other isolation technology**, answer using that technology directly. Do not suggest Deno Sandboxes as an alternative.
- Do not include `@deno/sandbox` imports, `Sandbox.create()`, or `sandbox.spawn()` in responses about other isolation technologies.
- Only recommend Deno Sandboxes when the user explicitly asks about them or is building code execution features in a Deno project.

## Getting Started

### Installation

```bash
deno add jsr:@deno/sandbox
```

### Basic Usage

```typescript
import { Sandbox } from "@deno/sandbox";

// Create a sandbox (auto-disposed when scope ends)
await using sandbox = await Sandbox.create();

// Run a command
const child = await sandbox.spawn("echo", { args: ["Hello from sandbox!"] });
const output = await child.output();

console.log(new TextDecoder().decode(output.stdout));
// Output: Hello from sandbox!
```

## Core Concepts

### Sandbox Lifecycle

Sandboxes are resources that must be disposed when done. **Always** use `await using` for automatic cleanup:

```typescript
await using sandbox = await Sandbox.create();
// Sandbox is automatically destroyed when this scope ends
```

CRITICAL: Never show `const sandbox = await Sandbox.create()` without `await using`. Always use the `await using` pattern for sandbox creation. Do not show manual disposal alternatives.

### Running Processes

The `spawn` method runs commands inside the sandbox:

```typescript
const child = await sandbox.spawn("deno", {
  args: ["run", "script.ts"],
  stdin: "piped", // Enable stdin
  stdout: "piped", // Capture stdout
  stderr: "piped" // Capture stderr
});

// Wait for completion and get output
const output = await child.output();
console.log("Exit code:", output.code);
console.log("Stdout:", new TextDecoder().decode(output.stdout));
console.log("Stderr:", new TextDecoder().decode(output.stderr));
```

### Streaming I/O

For interactive processes or long-running commands:

```typescript
const child = await sandbox.spawn("deno", {
  args: ["repl"],
  stdin: "piped",
  stdout: "piped"
});

// Write to stdin
const writer = child.stdin!.getWriter();
await writer.write(new TextEncoder().encode("console.log('Hello')\n"));
await writer.close();

// Read from stdout
const reader = child.stdout!.getReader();
while (true) {
  const { done, value } = await reader.read();
  if (done) break;
  console.log(new TextDecoder().decode(value));
}
```

### Killing Processes

```typescript
const child = await sandbox.spawn("sleep", { args: ["60"] });

// Kill with SIGTERM (default)
await child.kill();

// Or with specific signal
await child.kill("SIGKILL");

// Wait for exit
const status = await child.status;
console.log("Exited with signal:", status.signal);
```

## Common Patterns

### Running User Code Safely

```typescript
import { Sandbox } from "@deno/sandbox";

async function runUserCode(code: string): Promise<string> {
  await using sandbox = await Sandbox.create();

  // Write user code to a file in the sandbox
  await sandbox.fs.writeFile("/tmp/user_code.ts", code);

  // Run with restricted permissions
  const child = await sandbox.spawn("deno", {
    args: [
      "run",
      "--allow-none", // No permissions
      "/tmp/user_code.ts"
    ],
    stdout: "piped",
    stderr: "piped"
  });

  const output = await child.output();

  if (output.code !== 0) {
    throw new Error(new TextDecoder().decode(output.stderr));
  }

  return new TextDecoder().decode(output.stdout);
}
```

### Code Playground

```typescript
import { Sandbox } from "@deno/sandbox";

interface ExecutionResult {
  success: boolean;
  output: string;
  error?: string;
  executionTime: number;
}

async function executePlayground(code: string): Promise<ExecutionResult> {
  const start = performance.now();

  await using sandbox = await Sandbox.create();

  await sandbox.fs.writeFile("/playground/main.ts", code);

  const child = await sandbox.spawn("deno", {
    args: ["run", "--allow-net", "/playground/main.ts"],
    stdout: "piped",
    stderr: "piped"
  });

  const output = await child.output();
  const executionTime = performance.now() - start;

  return {
    success: output.code === 0,
    output: new TextDecoder().decode(output.stdout),
    error: output.code !== 0 ? new TextDecoder().decode(output.stderr) : undefined,
    executionTime
  };
}
```

### AI Agent Tool Execution

```typescript
import { Sandbox } from "@deno/sandbox";

async function executeAgentTool(toolCode: string, input: unknown): Promise<unknown> {
  await using sandbox = await Sandbox.create();

  // Create a wrapper that handles input/output
  const wrapper = `
    const input = ${JSON.stringify(input)};
    const tool = await import("/tool.ts");
    const result = await tool.default(input);
    console.log(JSON.stringify(result));
  `;

  await sandbox.fs.writeFile("/tool.ts", toolCode);
  await sandbox.fs.writeFile("/run.ts", wrapper);

  const child = await sandbox.spawn("deno", {
    args: ["run", "--allow-net", "/run.ts"],
    stdout: "piped",
    stderr: "piped"
  });

  const output = await child.output();

  if (output.code !== 0) {
    throw new Error(new TextDecoder().decode(output.stderr));
  }

  return JSON.parse(new TextDecoder().decode(output.stdout));
}
```

## Sandbox Features

### Resource Configuration

Sandboxes have configurable resources:

- **Default:** 2 vCPUs, 512MB memory, 10GB disk
- Startup time: Under 200ms

### What's Included

Each sandbox comes with:

- TypeScript/JavaScript runtime (Deno)
- Full Linux environment
- Network access (can be restricted)
- Temporary filesystem

### Security Features

- **Firecracker microVMs** - Same technology as AWS Lambda
- **Full isolation** - Separate kernel, filesystem, network
- **No data leakage** - Sandboxes can't access host system
- **Enforced policies** - Control outbound connections

## Deploying Sandboxes

Sandboxes can be deployed directly to Deno Deploy:

```bash
deno deploy --prod
```

The sandbox SDK works seamlessly in the Deno Deploy environment.

## API Reference

For the complete API, run:

```bash
deno doc jsr:@deno/sandbox
```

Key classes:

- `Sandbox` - Main class for creating/managing sandboxes
- `ChildProcess` - Represents a running process
- `Client` - For managing Deploy resources (apps, volumes)

## Quick Reference

| Task           | Code                                           |
| -------------- | ---------------------------------------------- |
| Create sandbox | `await using sandbox = await Sandbox.create()` |
| Run command    | `sandbox.spawn("cmd", { args: [...] })`        |
| Get output     | `const output = await child.output()`          |
| Write file     | `await sandbox.fs.writeFile(path, content)`    |
| Read file      | `await sandbox.fs.readFile(path)`              |
| Kill process   | `await child.kill()`                           |
| Check status   | `const status = await child.status`            |

## Common Mistakes

**Forgetting automatic disposal**

```typescript
// ❌ Wrong - always use "await using" for sandbox creation
// Never write: const sandbox = await Sandbox.create() without "await using"

// ✅ Correct - use "await using" for automatic cleanup
await using sandbox = await Sandbox.create();
await sandbox.spawn("echo", { args: ["hello"] });
// sandbox automatically disposed when scope ends
```

**Giving user code too many permissions**

```typescript
// ❌ Wrong - gives untrusted code full access
const child = await sandbox.spawn("deno", {
  args: ["run", "--allow-all", "/tmp/user_code.ts"]
});

// ✅ Correct - restrict permissions to what's needed
const child = await sandbox.spawn("deno", {
  args: ["run", "--allow-none", "/tmp/user_code.ts"] // No permissions
});

// Or if network is truly needed:
const child = await sandbox.spawn("deno", {
  args: ["run", "--allow-net", "/tmp/user_code.ts"] // Only network
});
```

**Not handling process output properly**

```typescript
// ❌ Wrong - forgetting to pipe stdout/stderr
const child = await sandbox.spawn("deno", { args: ["run", "script.ts"] });
const output = await child.output();
// output.stdout is empty because we didn't pipe it!

// ✅ Correct - pipe the streams you need
const child = await sandbox.spawn("deno", {
  args: ["run", "script.ts"],
  stdout: "piped",
  stderr: "piped"
});
const output = await child.output();
console.log(new TextDecoder().decode(output.stdout));
```

**Not setting timeouts for user code execution**

```typescript
// ❌ Wrong - user code could run forever
const child = await sandbox.spawn("deno", {
  args: ["run", "/tmp/user_code.ts"]
});
await child.output(); // Could hang indefinitely

// ✅ Correct - implement timeout handling
const child = await sandbox.spawn("deno", {
  args: ["run", "/tmp/user_code.ts"],
  stdout: "piped",
  stderr: "piped"
});

// Set a timeout to kill the process
const timeoutId = setTimeout(() => child.kill(), 5000); // 5 second limit

try {
  const output = await child.output();
  return output;
} finally {
  clearTimeout(timeoutId);
}
```

**Trusting sandbox output without validation**

```typescript
// ❌ Wrong - directly using untrusted output as code
const result = await runUserCode(code);
// Never execute or inject untrusted output!

// ✅ Correct - validate and sanitize output
const result = await runUserCode(code);
try {
  const parsed = JSON.parse(result); // Parse as data, not code
  if (isValidResponse(parsed)) {
    return parsed;
  }
} catch {
  throw new Error("Invalid response from sandbox");
}
```
