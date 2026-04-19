import { describe, it } from "node:test";
import { ok, equal, deepEqual } from "node:assert/strict";
import { getNpxCommand, getNpxSpawnOptions, buildInstallArgs } from "../installer.ts";

describe("installer", () => {
  it("uses npx.cmd on Windows", () => {
    equal(getNpxCommand("win32"), "npx.cmd");
  });

  it("uses npx on non-Windows platforms", () => {
    equal(getNpxCommand("linux"), "npx");
    equal(getNpxCommand("darwin"), "npx");
  });

  it("uses shell mode on Windows", () => {
    deepEqual(getNpxSpawnOptions("win32"), { stdio: ["pipe", "pipe", "pipe"], shell: true });
  });

  it("avoids shell mode on non-Windows platforms", () => {
    deepEqual(getNpxSpawnOptions("linux"), { stdio: ["pipe", "pipe", "pipe"], shell: false });
    deepEqual(getNpxSpawnOptions("darwin"), { stdio: ["pipe", "pipe", "pipe"], shell: false });
  });
});

describe("buildInstallArgs", () => {
  it("builds args without -a when no agents specified", () => {
    const args = buildInstallArgs("owner/repo/my-skill");
    deepEqual(args, ["-y", "skills", "add", "owner/repo", "--skill", "my-skill", "-y"]);
    ok(!args.includes("-a"));
  });

  it("appends -a with a single agent", () => {
    deepEqual(buildInstallArgs("owner/repo/my-skill", ["cursor"]), [
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
    deepEqual(buildInstallArgs("owner/repo/my-skill", ["cursor", "claude-code"]), [
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

  it("passes through wildcard agent", () => {
    deepEqual(buildInstallArgs("owner/repo/my-skill", ["*"]), [
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
    deepEqual(buildInstallArgs("owner/repo", ["cursor"]), [
      "-y",
      "skills",
      "add",
      "owner/repo",
      "-y",
      "-a",
      "cursor",
    ]);
  });
});
