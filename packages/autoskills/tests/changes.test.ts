import { describe, it } from "node:test";
import { ok, strictEqual, deepStrictEqual, throws } from "node:assert/strict";
import { Readable, Writable } from "node:stream";

import { computeChanges, confirmDestructive } from "../changes.ts";
import type { SkillEntry } from "../lib.ts";

function skill(name: string, installed: boolean): SkillEntry {
  return { skill: name, sources: ["React"], installed };
}

// Suppress stdout noise from the prompt when running confirmDestructive tests.
function silentOutput(): Writable {
  return new Writable({
    write(_chunk, _enc, cb) {
      cb();
    },
  });
}

describe("computeChanges", () => {
  it("buckets a pure install scenario", () => {
    const skills = [skill("a", false), skill("b", false)];
    const { installs, removes, keeps, skips } = computeChanges(skills, [true, true]);

    deepStrictEqual(
      installs.map((s) => s.skill),
      ["a", "b"],
    );
    deepStrictEqual(removes, []);
    deepStrictEqual(keeps, []);
    deepStrictEqual(skips, []);
  });

  it("buckets a pure remove scenario", () => {
    const skills = [skill("a", true), skill("b", true)];
    const { installs, removes, keeps, skips } = computeChanges(skills, [false, false]);

    deepStrictEqual(installs, []);
    deepStrictEqual(removes, ["a", "b"]);
    deepStrictEqual(keeps, []);
    deepStrictEqual(skips, []);
  });

  it("buckets a mixed install + remove + keep + skip scenario", () => {
    const skills = [
      skill("new-keep", false), // installs
      skill("new-skip", false), // skips
      skill("old-remove", true), // removes
      skill("old-keep", true), // keeps
    ];
    const { installs, removes, keeps, skips } = computeChanges(skills, [true, false, false, true]);

    deepStrictEqual(
      installs.map((s) => s.skill),
      ["new-keep"],
    );
    deepStrictEqual(removes, ["old-remove"]);
    deepStrictEqual(
      keeps.map((s) => s.skill),
      ["old-keep"],
    );
    deepStrictEqual(
      skips.map((s) => s.skill),
      ["new-skip"],
    );
  });

  it("treats already-installed checked items as keeps, not installs", () => {
    const skills = [skill("a", true)];
    const { installs, keeps, removes } = computeChanges(skills, [true]);

    deepStrictEqual(installs, []);
    deepStrictEqual(
      keeps.map((s) => s.skill),
      ["a"],
    );
    deepStrictEqual(removes, []);
  });

  it("handles an empty list", () => {
    const out = computeChanges([], []);
    deepStrictEqual(out, { installs: [], removes: [], keeps: [], skips: [] });
  });

  it("throws when selected length does not match skills length", () => {
    throws(
      () => computeChanges([skill("a", false)], [true, false]),
      /selected length \(2\) must match skills length \(1\)/,
    );
  });
});

describe("confirmDestructive", () => {
  it("returns true immediately when there are no removals", async () => {
    const result = await confirmDestructive(3, 0, { output: silentOutput() });
    strictEqual(result, true);
  });

  it("returns true immediately when autoYes is set, even with removals", async () => {
    const result = await confirmDestructive(0, 2, { autoYes: true, output: silentOutput() });
    strictEqual(result, true);
  });

  it("returns true when the user types y", async () => {
    const result = await confirmDestructive(2, 1, {
      input: Readable.from(["y\n"]),
      output: silentOutput(),
    });
    strictEqual(result, true);
  });

  it("returns true when the user types Y", async () => {
    const result = await confirmDestructive(0, 1, {
      input: Readable.from(["Y\n"]),
      output: silentOutput(),
    });
    strictEqual(result, true);
  });

  it("returns false when the user types n", async () => {
    const result = await confirmDestructive(0, 1, {
      input: Readable.from(["n\n"]),
      output: silentOutput(),
    });
    strictEqual(result, false);
  });

  it("returns false on a bare newline (default N)", async () => {
    const result = await confirmDestructive(0, 1, {
      input: Readable.from(["\n"]),
      output: silentOutput(),
    });
    strictEqual(result, false);
  });

  it("returns false on anything that is not y/Y", async () => {
    const result = await confirmDestructive(0, 1, {
      input: Readable.from(["yes\n"]),
      output: silentOutput(),
    });
    strictEqual(result, false);
  });

  it("writes the summary line with both counts when both apply", async () => {
    const chunks: string[] = [];
    const output = new Writable({
      write(chunk, _enc, cb) {
        chunks.push(chunk.toString());
        cb();
      },
    });
    await confirmDestructive(4, 1, {
      input: Readable.from(["y\n"]),
      output,
    });
    const text = chunks.join("");
    ok(/About to install 4 and remove 1 skill\b/.test(text), `unexpected prompt: ${text}`);
    ok(/Continue\?/.test(text), `prompt missing Continue?: ${text}`);
    ok(/\[y\/N\]/.test(text), `prompt missing [y/N]: ${text}`);
  });

  it("uses the singular noun when removing exactly one skill", async () => {
    const chunks: string[] = [];
    const output = new Writable({
      write(chunk, _enc, cb) {
        chunks.push(chunk.toString());
        cb();
      },
    });
    await confirmDestructive(0, 1, {
      input: Readable.from(["n\n"]),
      output,
    });
    ok(/remove 1 skill\./.test(chunks.join("")));
  });

  it("uses the plural noun when removing multiple skills", async () => {
    const chunks: string[] = [];
    const output = new Writable({
      write(chunk, _enc, cb) {
        chunks.push(chunk.toString());
        cb();
      },
    });
    await confirmDestructive(0, 3, {
      input: Readable.from(["n\n"]),
      output,
    });
    ok(/remove 3 skills\./.test(chunks.join("")));
  });
});
