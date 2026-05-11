import { describe, it } from "node:test";
import { equal, deepEqual, ok } from "node:assert/strict";
import { runInstall } from "../subcommands.ts";
import { mockInstaller } from "./helpers.ts";

async function captureAsync<T>(fn: () => Promise<T>): Promise<{ out: string; err: string; result: T }> {
  let out = "";
  let err = "";
  const stdoutProto = Object.getPrototypeOf(process.stdout);
  const origWrite = stdoutProto._write;
  const origLog = console.log;
  const origErr = console.error;
  stdoutProto._write = function (chunk: Buffer | string, encoding: string, cb: () => void) {
    if (this === process.stdout) {
      out += typeof chunk === "string" ? chunk : chunk.toString(encoding as BufferEncoding);
      cb();
      return true;
    }
    return origWrite.call(this, chunk, encoding, cb);
  };
  console.log = (...a: unknown[]) => { out += a.map(String).join(" ") + "\n"; };
  console.error = (...a: unknown[]) => { err += a.map(String).join(" ") + "\n"; };
  try {
    const result = await fn();
    return { out, err, result };
  } finally {
    stdoutProto._write = origWrite;
    console.log = origLog;
    console.error = origErr;
  }
}

describe("runInstall — validation", () => {
  it("missing --only returns install-missing-only error (json)", async () => {
    const { out, result } = await captureAsync(() =>
      runInstall({ only: "", agents: [], autoYes: false, json: true, verbose: false }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.error.code, "install-missing-only");
  });

  it("--only '' (empty string after trim) returns install-empty-only (json)", async () => {
    const { out, result } = await captureAsync(() =>
      runInstall({ only: "   ", agents: [], autoYes: false, json: true, verbose: false }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.error.code, "install-empty-only");
  });

  it("--only ',,,' returns install-empty-only after dedupe", async () => {
    const { out, result } = await captureAsync(() =>
      runInstall({ only: ",,,", agents: [], autoYes: false, json: true, verbose: false }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.error.code, "install-empty-only");
  });

  it("--only reakt suggests react (distance 1, json)", async () => {
    const { out, result } = await captureAsync(() =>
      runInstall({ only: "reakt", agents: [], autoYes: false, json: true, verbose: false }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.error.code, "install-unknown-id");
    equal(parsed.error.hint, "did you mean: react?");
    deepEqual(parsed.error.details.suggestions, ["react"]);
    deepEqual(parsed.error.details.unknown_ids, ["reakt"]);
  });

  it("--only unknownfoo (distance > 2) returns error without suggestion", async () => {
    const { out, result } = await captureAsync(() =>
      runInstall({ only: "unknownfoo", agents: [], autoYes: false, json: true, verbose: false }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.error.code, "install-unknown-id");
    equal(parsed.error.hint, undefined);
    deepEqual(parsed.error.details.suggestions, []);
  });

  it("--only react,reakt returns unknown-id for reakt (mixed valid/invalid)", async () => {
    const { out, result } = await captureAsync(() =>
      runInstall({ only: "react,reakt", agents: [], autoYes: false, json: true, verbose: false }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.error.code, "install-unknown-id");
    deepEqual(parsed.error.details.unknown_ids, ["reakt"]);
  });

  it("human mode error goes to stderr, not stdout", async () => {
    const { out, err, result } = await captureAsync(() =>
      runInstall({ only: "reakt", agents: [], autoYes: false, json: false, verbose: false }),
    );
    equal(result, 1);
    equal(out, "");
    ok(err.includes("unknown tech id 'reakt'"));
    ok(err.includes("did you mean: react?"));
  });
});

describe("runInstall — happy path with mock installer", () => {
  it("installs one tech's skills with mock installer, json output", async () => {
    const mock = mockInstaller({ success: true });
    const { out, result } = await captureAsync(() =>
      runInstall({
        only: "react",
        agents: ["claude-code"],
        autoYes: true,
        json: true,
        verbose: false,
        deps: { installSkill: mock.installSkill },
      }),
    );
    equal(result, 0);
    const parsed = JSON.parse(out.trim());
    ok(Array.isArray(parsed.installed));
    ok(parsed.installed.length >= 1);
    ok(mock.calls.length >= 1);
    // Confirm agents were propagated
    ok(mock.calls.every(c => c.agents[0] === "claude-code"));
  });

  it("dedupes duplicate ids before resolution", async () => {
    const mock = mockInstaller({ success: true });
    const { result } = await captureAsync(() =>
      runInstall({
        only: "react,react",
        agents: [],
        autoYes: true,
        json: true,
        verbose: false,
        deps: { installSkill: mock.installSkill },
      }),
    );
    equal(result, 0);
    // Because ids are deduped before resolution, calls should equal react's unique skill count
    const reactSkills = (await import("../skills-map.ts")).SKILLS_MAP.find(t => t.id === "react")!.skills;
    equal(mock.calls.length, reactSkills.length);
  });

  it("reports failures in json output", async () => {
    const mock = mockInstaller({ success: false, stderr: "boom" });
    const { out, result } = await captureAsync(() =>
      runInstall({
        only: "react",
        agents: [],
        autoYes: true,
        json: true,
        verbose: false,
        deps: { installSkill: mock.installSkill },
      }),
    );
    equal(result, 1);
    const parsed = JSON.parse(out.trim());
    equal(parsed.installed.length, 0);
    ok(parsed.failed.length >= 1);
    equal(parsed.failed[0].error, "boom");
  });

  it("human output prints installed/failed lines", async () => {
    const mock = mockInstaller({ success: true });
    const { out, result } = await captureAsync(() =>
      runInstall({
        only: "react",
        agents: [],
        autoYes: true,
        json: false,
        verbose: false,
        deps: { installSkill: mock.installSkill },
      }),
    );
    equal(result, 0);
    ok(out.includes("installed"));
  });

});
