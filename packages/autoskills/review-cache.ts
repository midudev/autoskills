type CachedReview = {
  status?: unknown;
  audit?: unknown;
};

export function isReviewReusable(review: unknown, noReview: boolean): boolean {
  if (review === null || typeof review !== "object") return false;
  const { status, audit } = review as CachedReview;
  if (noReview) return status === "approved" || status === "flagged" || status === "skipped";
  return (status === "approved" || status === "flagged") && audit === "openai";
}
