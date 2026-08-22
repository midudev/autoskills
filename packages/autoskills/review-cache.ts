export function isReviewReusable(status: unknown, noReview: boolean): boolean {
  return status === "approved" || status === "flagged" || (noReview && status === "skipped");
}
