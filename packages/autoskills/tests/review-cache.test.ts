import { describe, it } from "node:test";
import { equal } from "node:assert/strict";

import { isReviewReusable } from "../review-cache.ts";

describe("isReviewReusable", () => {
  it("reuses completed reviews", () => {
    equal(isReviewReusable("approved", false), true);
    equal(isReviewReusable("flagged", false), true);
  });

  it("reuses skipped reviews only during no-review syncs", () => {
    equal(isReviewReusable("skipped", true), true);
    equal(isReviewReusable("skipped", false), false);
    equal(isReviewReusable(undefined, false), false);
  });
});
