import { describe, it } from "node:test";
import { equal, ok, deepEqual } from "node:assert/strict";
import { EventEmitter } from "node:events";
import { copyToClipboard } from "../clipboard.ts";

interface SpawnCall { cmd: string; args: string[]; stdin: string }

interface FakeSpawnConfig {
  /** Per-cmd outcome. Missing entry = ENOENT. */
  exitCodes?: Record<string, number>;
  /** Per-cmd raw error to emit on "error" event before close. Bypasses exitCodes for that cmd. */
  errors?: Record<string, NodeJS.ErrnoException>;
}

function makeFakeSpawn(cfg: FakeSpawnConfig): {
  spawn: (cmd: string, args: string[]) => unknown;
  calls: SpawnCall[];
} {
  const calls: SpawnCall[] = [];
  const spawn = (cmd: string, args: string[]) => {
    const call: SpawnCall = { cmd, args, stdin: "" };
    calls.push(call);
    const child = new EventEmitter() as EventEmitter & {
      stdin: { write: (s: string) => void; end: () => void };
    };
    child.stdin = {
      write(s: string) { call.stdin += s; },
      end() {
        const err = cfg.errors?.[cmd];
        if (err) {
          queueMicrotask(() => child.emit("error", err));
          return;
        }
        if (!(cmd in (cfg.exitCodes ?? {}))) {
          // Simulate ENOENT (binary not on PATH)
          const enoent = Object.assign(new Error(`spawn ${cmd} ENOENT`), { code: "ENOENT" }) as NodeJS.ErrnoException;
          queueMicrotask(() => child.emit("error", enoent));
          return;
        }
        const code = cfg.exitCodes![cmd];
        queueMicrotask(() => child.emit("close", code));
      },
    };
    return child;
  };
  return { spawn, calls };
}

describe("clipboard.copyToClipboard", () => {
  it("darwin invokes pbcopy and writes text to stdin", async () => {
    const { spawn, calls } = makeFakeSpawn({ exitCodes: { pbcopy: 0 } });
    const result = await copyToClipboard("hello world", { platform: "darwin", spawnFn: spawn });
    equal(result.ok, true);
    equal(result.tool, "pbcopy");
    equal(calls.length, 1);
    equal(calls[0].cmd, "pbcopy");
    deepEqual(calls[0].args, []);
    equal(calls[0].stdin, "hello world");
  });

  it("linux tries wl-copy first, falls back to xclip on ENOENT", async () => {
    const { spawn, calls } = makeFakeSpawn({ exitCodes: { xclip: 0 } });
    const result = await copyToClipboard("payload", { platform: "linux", spawnFn: spawn });
    equal(result.ok, true);
    equal(result.tool, "xclip");
    equal(calls.length, 2);
    equal(calls[0].cmd, "wl-copy");
    equal(calls[1].cmd, "xclip");
    deepEqual(calls[1].args, ["-selection", "clipboard"]);
    equal(calls[1].stdin, "payload");
  });

  it("linux uses wl-copy when available", async () => {
    const { spawn, calls } = makeFakeSpawn({ exitCodes: { "wl-copy": 0 } });
    const result = await copyToClipboard("payload", { platform: "linux", spawnFn: spawn });
    equal(result.ok, true);
    equal(result.tool, "wl-copy");
    equal(calls.length, 1);
    equal(calls[0].cmd, "wl-copy");
  });

  it("win32 invokes clip.exe", async () => {
    const { spawn, calls } = makeFakeSpawn({ exitCodes: { "clip.exe": 0 } });
    const result = await copyToClipboard("payload", { platform: "win32", spawnFn: spawn });
    equal(result.ok, true);
    equal(result.tool, "clip.exe");
    equal(calls.length, 1);
    equal(calls[0].cmd, "clip.exe");
    equal(calls[0].stdin, "payload");
  });

  it("returns ok:false when no clipboard tool found (all ENOENT)", async () => {
    const { spawn } = makeFakeSpawn({});
    const result = await copyToClipboard("x", { platform: "linux", spawnFn: spawn });
    equal(result.ok, false);
    ok(result.error?.includes("no clipboard tool"));
  });

  it("non-zero exit code returns ok:false with error", async () => {
    const { spawn } = makeFakeSpawn({ exitCodes: { pbcopy: 1 } });
    const result = await copyToClipboard("x", { platform: "darwin", spawnFn: spawn });
    equal(result.ok, false);
    ok(result.error?.includes("exit"));
  });

  it("non-ENOENT spawn error returns ok:false with error", async () => {
    const err = Object.assign(new Error("permission denied"), { code: "EACCES" }) as NodeJS.ErrnoException;
    const { spawn } = makeFakeSpawn({ errors: { pbcopy: err } });
    const result = await copyToClipboard("x", { platform: "darwin", spawnFn: spawn });
    equal(result.ok, false);
    ok(result.error?.includes("permission denied"));
  });

  it("unknown platform returns ok:false", async () => {
    const { spawn, calls } = makeFakeSpawn({});
    const result = await copyToClipboard("x", { platform: "freebsd" as NodeJS.Platform, spawnFn: spawn });
    equal(result.ok, false);
    equal(calls.length, 0);
    ok(result.error?.includes("unsupported platform"));
  });
});
