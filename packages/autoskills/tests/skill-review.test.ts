import { describe, it } from "node:test";
import { equal } from "node:assert/strict";

import { securityStatus } from "../scripts/skill-review.mjs";

describe("securityStatus", () => {
  it("is ok when the reviewer lists nothing", () => {
    equal(securityStatus("none", []), "ok");
  });

  it("keeps notes the reviewer considers normal practice as info", () => {
    equal(securityStatus("info", ["Runs a vendor CLI with --yes"]), "info");
  });

  it("keeps warnings as warnings", () => {
    equal(securityStatus("warning", ["Example CORS config allows all origins"]), "warning");
  });

  it("never drops listed findings when the severity is none", () => {
    equal(securityStatus("none", ["Runs a vendor CLI with --yes"]), "info");
  });

  it("never downgrades a warning without findings", () => {
    equal(securityStatus("warning", []), "warning");
  });
});
