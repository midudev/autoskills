import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { getNpxCommand, getNpxSpawnOptions, buildInstallArgs } from "../installer.mjs";

describe("installer", () => {
  it("uses npx.cmd on Windows", () => {
    assert.equal(getNpxCommand("win32"), "npx.cmd");
  });

  it("uses npx on non-Windows platforms", () => {
    assert.equal(getNpxCommand("linux"), "npx");
    assert.equal(getNpxCommand("darwin"), "npx");
  });

  it("uses shell mode on Windows", () => {
    assert.deepEqual(getNpxSpawnOptions("win32"), {
      stdio: ["pipe", "pipe", "pipe"],
      shell: true,
    });
  });

  it("avoids shell mode on non-Windows platforms", () => {
    assert.deepEqual(getNpxSpawnOptions("linux"), {
      stdio: ["pipe", "pipe", "pipe"],
      shell: false,
    });
    assert.deepEqual(getNpxSpawnOptions("darwin"), {
      stdio: ["pipe", "pipe", "pipe"],
      shell: false,
    });
  });
});

describe("buildInstallArgs", () => {
  it("builds args without -a when no agents specified", () => {
    const args = buildInstallArgs("owner/repo/my-skill");
    assert.deepEqual(args, ["-y", "skills", "add", "owner/repo", "--skill", "my-skill", "-y"]);
    assert.ok(!args.includes("-a"));
  });

  it("appends -a with a single agent", () => {
    const args = buildInstallArgs("owner/repo/my-skill", ["cursor"]);
    assert.deepEqual(args, [
      "-y",
      "skills",
      "add",
      "owner/repo",
      "--skill",
      "my-skill",
      "-y",
      "-a",
      "cursor",
    ]);
  });

  it("appends -a with multiple agents", () => {
    const args = buildInstallArgs("owner/repo/my-skill", ["cursor", "claude-code"]);
    assert.deepEqual(args, [
      "-y",
      "skills",
      "add",
      "owner/repo",
      "--skill",
      "my-skill",
      "-y",
      "-a",
      "cursor",
      "claude-code",
    ]);
  });

  it("appends -a with opencode", () => {
    const args = buildInstallArgs("owner/repo/my-skill", ["opencode"]);
    assert.deepEqual(args, [
      "-y",
      "skills",
      "add",
      "owner/repo",
      "--skill",
      "my-skill",
      "-y",
      "-a",
      "opencode",
    ]);
  });

  it("passes through wildcard agent", () => {
    const args = buildInstallArgs("owner/repo/my-skill", ["*"]);
    assert.deepEqual(args, [
      "-y",
      "skills",
      "add",
      "owner/repo",
      "--skill",
      "my-skill",
      "-y",
      "-a",
      "*",
    ]);
  });

  it("handles skill path without skill name", () => {
    const args = buildInstallArgs("owner/repo", ["cursor"]);
    assert.deepEqual(args, ["-y", "skills", "add", "owner/repo", "-y", "-a", "cursor"]);
  });
});
