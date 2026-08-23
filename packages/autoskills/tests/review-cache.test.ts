import { describe, it } from "node:test";
import { equal } from "node:assert/strict";

import { isReviewReusable } from "../review-cache.ts";

describe("isReviewReusable", () => {
  it("reuses marked audits", () => {
    equal(isReviewReusable({ status: "approved", audit: "openai" }, false), true);
    equal(isReviewReusable({ status: "flagged", audit: "openai" }, false), true);
  });

  it("reuses skipped reviews only during no-review syncs", () => {
    equal(isReviewReusable({ status: "skipped", audit: "skipped" }, true), true);
    equal(isReviewReusable({ status: "skipped", audit: "skipped" }, false), false);
    equal(isReviewReusable(undefined, false), false);
  });

  it("invalidates ambiguous historical approvals before an audited sync", () => {
    const historicalManifest = {
      skills: {
        legacy: {
          review: {
            status: "approved",
            summary: "review skipped (--no-review)",
          },
        },
      },
    };
    const review = historicalManifest.skills.legacy.review;

    equal(isReviewReusable(review, false), false);
    equal(isReviewReusable(review, true), true);
  });
});
