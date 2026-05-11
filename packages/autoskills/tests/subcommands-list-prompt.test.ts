import { describe, it } from "node:test";
import { equal, deepEqual, ok } from "node:assert/strict";
import { readFileSync, existsSync } from "node:fs";
import { resolve } from "node:path";
import { runList, runPrompt } from "../subcommands.ts";

// Capture stdout / stderr via monkey-patching for the duration of a single test.
//
// NOTE: colors.ts exports `write = process.stdout.write.bind(process.stdout)`, a pre-bound
// function. Patching `process.stdout.write` after the bind doesn't intercept calls through
// that bound reference (bind captures the function value, not the property). Similarly,
// patching `require('node:fs').writeSync` misses the native binding used by SyncWriteStream.
//
// Solution: patch `SyncWriteStream.prototype._write` — the method that Writable internals
// eventually dispatch to via `this._write(...)`, which IS a live prototype lookup and therefore
// interceptable regardless of when the write function was bound. This captures:
//   - calls via the pre-bound `write` export from colors.ts
//   - calls via `process.stdout.write` directly
//   - calls via `console.log` (which goes through process.stdout)
//
// stderr is captured by patching `console.error` at the JS level (errors from subcommands.ts
// always go through console.error, never through a pre-bound reference).
// fn MUST be synchronous. captureStdio mutates a shared Writable prototype; async work would race the restore across tests.
function captureStdio<T>(fn: () => T): { out: string; err: string; result: T } {
  let out = "";
  let err = "";

  // Get the SyncWriteStream prototype (immediate prototype of process.stdout).
  const stdoutProto = Object.getPrototypeOf(process.stdout) as {
    _write: (chunk: Buffer | string, encoding: string, cb: (err?: Error | null) => void) => void;
  };
  const origUnderscoreWrite = stdoutProto._write;
  const origErr = console.error;

  // Intercept _write so that both pre-bound and live writes to stdout are captured.
  stdoutProto._write = function (
    chunk: Buffer | string,
    encoding: string,
    cb: (err?: Error | null) => void,
  ) {
    if (this === process.stdout) {
      out += typeof chunk === "string" ? chunk : chunk.toString();
      cb();
      return;
    }
    return origUnderscoreWrite.call(this, chunk, encoding, cb);
  };

  // Capture console.error (used by subcommands.ts for error output).
  console.error = (...args: unknown[]) => {
    err += args.map(String).join(" ") + "\n";
  };

  try {
    const result = fn();
    return { out, err, result };
  } finally {
    stdoutProto._write = origUnderscoreWrite;
    console.error = origErr;
  }
}

describe("runList", () => {
  it("--json emits parseable ListJson on stdout", () => {
    const { out, result } = captureStdio(() => runList({ json: true, version: "test-1.0.0" }));
    equal(result, 0);
    const parsed = JSON.parse(out);
    equal(parsed.version, "test-1.0.0");
    ok(Array.isArray(parsed.technologies));
    ok(parsed.technologies.length > 0);
  });

  it("--json --filter react returns one tech", () => {
    const { out, result } = captureStdio(() => runList({ json: true, filter: "react", version: "t" }));
    equal(result, 0);
    const parsed = JSON.parse(out);
    equal(parsed.technologies.length, 1);
    equal(parsed.technologies[0].id, "react");
  });

  it("--json --filter NextJS (alias) returns nextjs", () => {
    const { out, result } = captureStdio(() => runList({ json: true, filter: "NextJS", version: "t" }));
    equal(result, 0);
    const parsed = JSON.parse(out);
    equal(parsed.technologies.length, 1);
    equal(parsed.technologies[0].id, "nextjs");
  });

  it("no --json prints human table", () => {
    const { out, result } = captureStdio(() => runList({ json: false, version: "t" }));
    equal(result, 0);
    ok(out.includes("react"));
    ok(out.includes("React"));
  });

  it("no --json with unknown --filter prints 'no technologies match' to stderr, exit 0", () => {
    const { out, err, result } = captureStdio(() =>
      runList({ json: false, filter: "zzz-nope", version: "t" }),
    );
    equal(result, 0);
    ok(err.includes("no technologies match 'zzz-nope'"));
    equal(out, "");
  });

  it("--json with unknown --filter still emits valid JSON (empty technologies)", () => {
    const { out, result } = captureStdio(() => runList({ json: true, filter: "zzz", version: "t" }));
    equal(result, 0);
    const parsed = JSON.parse(out);
    deepEqual(parsed.technologies, []);
  });
});

describe("runPrompt", () => {
  const PROMPT_PATH = resolve(import.meta.dirname!, "..", "prompts", "spec-generator-prompt.md");

  it("stdouts the prompt file when it exists", () => {
    if (!existsSync(PROMPT_PATH)) return;
    const expected = readFileSync(PROMPT_PATH, "utf-8");
    const { out, result } = captureStdio(() => runPrompt());
    equal(result, 0);
    equal(out, expected);
  });

  it("emits prompt-file-missing JSON envelope (exit 1) when the injected path does not exist", () => {
    const { err, result } = captureStdio(() =>
      runPrompt({ promptPath: "/definitely/does/not/exist/spec-generator-prompt.md" }),
    );
    equal(result, 1);
    const parsed = JSON.parse(err.trim());
    equal(parsed.error.code, "prompt-file-missing");
    ok(parsed.error.message.includes("prompt file missing"));
  });
});
