import { describe, it } from "node:test";
import { deepStrictEqual, ok, strictEqual } from "node:assert/strict";

// colors.ts binds process.stdout.write when it is imported, so the capture
// hook has to be installed before loading ui.ts.
let captured: string[] | null = null;
const originalWrite = process.stdout.write;
process.stdout.write = function (chunk: string | Uint8Array, ...rest: unknown[]): boolean {
  if (captured) {
    captured.push(String(chunk));
    return true;
  }
  return (originalWrite as (...args: unknown[]) => boolean).call(process.stdout, chunk, ...rest);
} as typeof process.stdout.write;

const { multiSelect } = await import("../ui.ts");

// eslint-disable-next-line no-control-regex
const stripAnsi = (s: string): string => s.replace(/\x1b\[[0-9;?]*[A-Za-z]/g, "");

function stub(target: object, values: Record<string, unknown>): () => void {
  const t = target as Record<string, unknown>;
  const previous = Object.keys(values).map((key) => ({
    key,
    descriptor: Object.getOwnPropertyDescriptor(t, key),
  }));
  Object.assign(t, values);
  return () => {
    for (const { key, descriptor } of previous) {
      if (descriptor) Object.defineProperty(t, key, descriptor);
      else delete t[key];
    }
  };
}

type SelectOptions = Parameters<typeof multiSelect<string>>[1];

// Drives multiSelect as if it were attached to a terminal and returns the
// frame drawn after each key press (the first one is the initial render).
async function runSelect(
  items: string[],
  options: SelectOptions,
  keys: string[],
  { columns = 80, rows = 40 }: { columns?: number; rows?: number } = {},
): Promise<{ frames: string[]; result: string[] }> {
  const noop = () => process.stdin;
  const restoreStdin = stub(process.stdin, {
    isTTY: true,
    setRawMode: noop,
    resume: noop,
    pause: noop,
    setEncoding: noop,
  });
  const restoreStdout = stub(process.stdout, { columns, rows });

  captured = [];
  const frames: string[] = [];
  try {
    const promise = multiSelect(items, options);
    frames.push(stripAnsi(captured.at(-1) ?? ""));
    for (const key of keys) {
      process.stdin.emit("data", key);
      frames.push(stripAnsi(captured.at(-1) ?? ""));
    }
    process.stdin.emit("data", "\r");
    return { frames, result: await promise };
  } finally {
    captured = null;
    restoreStdin();
    restoreStdout();
  }
}

describe("multiSelect", () => {
  it("shows details only for the item under the cursor", async () => {
    const { frames, result } = await runSelect(
      ["safe", "risky"],
      {
        labelFn: (item) => item,
        detailFn: (item) => (item === "risky" ? ["DETAIL for risky"] : []),
      },
      ["j", "j"],
    );

    ok(!frames[0].includes("DETAIL"));
    ok(frames[1].includes("DETAIL for risky"));
    ok(!frames[2].includes("DETAIL"));
    deepStrictEqual(result, ["safe", "risky"]);
  });

  it("passes the usable terminal width to detailFn", async () => {
    const widths: number[] = [];
    await runSelect(
      ["only"],
      {
        labelFn: (item) => item,
        detailFn: (_item, _i, width) => {
          widths.push(width);
          return [];
        },
      },
      [],
      { columns: 60 },
    );

    strictEqual(widths[0], 59);
  });

  it("keeps the frame within the terminal height when details are long", async () => {
    const rows = 8;
    const { frames } = await runSelect(
      ["a", "b", "c"],
      {
        labelFn: (item) => item,
        detailFn: () => Array.from({ length: 20 }, (_, i) => `detail ${i}`),
      },
      ["j"],
      { rows },
    );

    for (const frame of frames) {
      const lines = frame.split("\n").length;
      ok(lines <= rows, `frame has ${lines} lines`);
      ok(frame.includes("❯"), "cursor line is visible");
    }
  });
});
