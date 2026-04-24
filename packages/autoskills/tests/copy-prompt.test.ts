import { describe, it } from "node:test";
import { equal, ok } from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import { resolve } from "node:path";
import { runCopyPrompt } from "../subcommands.ts";
import type { CopyResult } from "../clipboard.ts";

// Reuse the captureStdio pattern from subcommands-list-prompt.test.ts (kept inline to avoid
// cross-test coupling — captureStdio mutates a shared prototype and must be self-contained).
function captureStdio<T>(fn: () => Promise<T> | T): Promise<{ out: string; err: string; result: T }> {
  let out = "";
  let err = "";
  const stdoutProto = Object.getPrototypeOf(process.stdout) as {
    _write: (chunk: Buffer | string, encoding: string, cb: (err?: Error | null) => void) => void;
  };
  const origUnderscoreWrite = stdoutProto._write;
  const origErr = console.error;
  stdoutProto._write = function (chunk, encoding, cb) {
    if (this === process.stdout) {
      out += typeof chunk === "string" ? chunk : chunk.toString();
      cb();
      return;
    }
    return origUnderscoreWrite.call(this, chunk, encoding, cb);
  };
  console.error = (...args: unknown[]) => {
    err += args.map(String).join(" ") + "\n";
  };
  const restore = () => {
    stdoutProto._write = origUnderscoreWrite;
    console.error = origErr;
  };
  return Promise.resolve(fn()).then(
    (result) => { restore(); return { out, err, result }; },
    (e) => { restore(); throw e; },
  );
}

const PROMPT_PATH = resolve(import.meta.dirname!, "..", "prompts", "spec-generator-prompt.md");

describe("runCopyPrompt", () => {
  it("copies prompt to clipboard and prints success + Cmd+V hint on darwin", async () => {
    if (!existsSync(PROMPT_PATH)) return;
    const expected = readFileSync(PROMPT_PATH, "utf-8");
    let captured = "";
    const copyFn = async (text: string): Promise<CopyResult> => {
      captured = text;
      return { ok: true, tool: "pbcopy" };
    };
    const { out, result } = await captureStdio(() =>
      runCopyPrompt({ copyFn, platform: "darwin" }),
    );
    equal(result, 0);
    equal(captured, expected);
    ok(out.includes("✓ prompt copied to clipboard"));
    ok(out.includes("Cmd+V"));
    ok(!out.includes("Ctrl+V"));
  });

  it("prints Ctrl+V hint on linux", async () => {
    if (!existsSync(PROMPT_PATH)) return;
    const copyFn = async (): Promise<CopyResult> => ({ ok: true, tool: "wl-copy" });
    const { out, result } = await captureStdio(() =>
      runCopyPrompt({ copyFn, platform: "linux" }),
    );
    equal(result, 0);
    ok(out.includes("Ctrl+V"));
    ok(!out.includes("Cmd+V"));
  });

  it("prints Ctrl+V hint on win32", async () => {
    if (!existsSync(PROMPT_PATH)) return;
    const copyFn = async (): Promise<CopyResult> => ({ ok: true, tool: "clip.exe" });
    const { out, result } = await captureStdio(() =>
      runCopyPrompt({ copyFn, platform: "win32" }),
    );
    equal(result, 0);
    ok(out.includes("Ctrl+V"));
  });

  it("falls back to printing prompt + warning when clipboard fails", async () => {
    if (!existsSync(PROMPT_PATH)) return;
    const expected = readFileSync(PROMPT_PATH, "utf-8");
    const copyFn = async (): Promise<CopyResult> => ({ ok: false, error: "no clipboard tool found" });
    const { out, err, result } = await captureStdio(() =>
      runCopyPrompt({ copyFn, platform: "linux" }),
    );
    equal(result, 0); // graceful, no exit-1
    ok(out.includes(expected.split("\n")[0])); // prompt content printed to stdout for manual pipe
    ok(err.includes("no clipboard tool found"));
    ok(err.toLowerCase().includes("warning"));
  });

  it("emits prompt-file-missing envelope (exit 1) when the injected path does not exist", async () => {
    const { err, result } = await captureStdio(() =>
      runCopyPrompt({
        promptPath: "/definitely/does/not/exist/spec-generator-prompt.md",
        copyFn: async () => ({ ok: true }),
        platform: "darwin",
      }),
    );
    equal(result, 1);
    const parsed = JSON.parse(err.trim());
    equal(parsed.error.code, "prompt-file-missing");
  });
});
