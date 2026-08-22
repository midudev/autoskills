# Xquik TypeScript types: X write

```typescript

interface CreateTweetBase {
  account: string;            // Connected X username or account ID
  reply_to_tweet_id?: string; // Tweet ID to reply to
  community_id?: string;      // Community ID to post into
  is_note_tweet?: boolean;    // Long-form note tweet up to 25,000 characters.
}

type NonEmptyTweetMedia =
  | [string]
  | [string, string]
  | [string, string, string]
  | [string, string, string, string];

type CreateTweetRequest = CreateTweetBase &
  (
    | { text: string; media?: NonEmptyTweetMedia }
    | { text?: string; media: NonEmptyTweetMedia }
  );

type TweetMediaMime =
  | "image/jpeg"
  | "image/png"
  | "image/gif"
  | "image/webp"
  | "video/mp4";

interface ResolvedTweetMedia {
  url: string;
  mimeType: TweetMediaMime;
}

function assertCreateTweetRequest(
  request: unknown,
  resolvedMedia: ResolvedTweetMedia[] = [],
): asserts request is CreateTweetRequest {
  if (request === null || typeof request !== "object" || Array.isArray(request)) {
    throw new Error("CreateTweetRequest must be an object.");
  }
  const value = request as Record<string, unknown>;
  if (typeof value.account !== "string" || !value.account.trim()) {
    throw new Error("account must be a nonempty string.");
  }
  if (value.is_note_tweet !== undefined && typeof value.is_note_tweet !== "boolean") {
    throw new Error("is_note_tweet must be a boolean when present.");
  }
  const hasText = typeof value.text === "string" && value.text.trim().length > 0;
  if (value.text !== undefined && !hasText) {
    throw new Error("text must be a nonempty string when present.");
  }
  if (hasText) {
    const limit = value.is_note_tweet === true ? 25_000 : 280;
    if ([...(value.text as string)].length > limit) {
      throw new Error(`text must not exceed ${limit} characters.`);
    }
  }
  const hasMedia =
    Array.isArray(value.media) &&
    value.media.length >= 1 &&
    value.media.length <= 4 &&
    value.media.every((item) => typeof item === "string" && item.trim().length > 0);
  if (value.media !== undefined && !hasMedia) {
    throw new Error("media must contain 1-4 nonempty URLs.");
  }
  if (!hasText && !hasMedia) {
    throw new Error("Provide nonempty text, nonempty media, or both.");
  }
  const media = hasMedia ? value.media as string[] : [];
  if (
    resolvedMedia.length !== media.length ||
    resolvedMedia.some((item, index) =>
      item === null ||
      typeof item !== "object" ||
      item.url !== media[index] ||
      !["image/jpeg", "image/png", "image/gif", "image/webp", "video/mp4"].includes(item.mimeType)
    )
  ) {
    throw new Error("Resolve every media URL and validate its MIME type before posting.");
  }
  const imagesOnly = resolvedMedia.every((item) => item.mimeType.startsWith("image/"));
  const oneMp4 = resolvedMedia.length === 1 && resolvedMedia[0].mimeType === "video/mp4";
  if (resolvedMedia.length > 0 && !imagesOnly && !oneMp4) {
    throw new Error("media must contain 1-4 images or exactly 1 MP4.");
  }
}

// Resolve media URLs first. Pass their verified MIME types to this assertion
// immediately before POST /api/v1/x/tweets.

type XWriteStatus =
  | "accepted"
  | "dispatching"
  | "pending_confirmation"
  | "success"
  | "failed"
  | "expired";

interface XWriteAction {
  object: "x_write_action";
  id: string;
  writeActionId: string;
  action: string;
  status: XWriteStatus;
  terminal: boolean;
  retryable: boolean;
  safeToRetry: boolean;
  statusUrl: string;
  pollAfterMs: number | null;
  charged: boolean;
  chargedCredits: string;
  billing: {
    status: "not_charged" | "pending" | "charged" | "charge_failed" | "refunded";
    charged: boolean;
    plannedCredits: string;
    chargedCredits: string;
  };
  request: { hash: string | null; payload: Record<string, unknown> | null };
  account: { id: string; username: string } | null;
  target: { type: "tweet" | "user" | "community"; id: string } | null;
  targetId: string | null;
  result: {
    type: "tweet" | "direct_message" | "media" | "community" | "state_change";
    id?: string;
    state?: string;
  } | null;
  nextAction: {
    type: "poll" | "retry" | "verify_result" | "fix_request";
    url?: string;
    afterMs?: number;
    requiresNewIdempotencyKey?: boolean;
  } | null;
  sendDispatched: boolean;
  success: boolean;
}

interface WriteActionRequest {
  account: string;            // Connected X username or account ID
}

interface SendDmRequest {
  account: string;            // Connected X username or account ID
  text: string;               // Message text
  media_ids?: [string];       // Exactly 1 media ID when present
}

interface UpdateProfileRequest {
  account: string;            // Connected X username or account ID
  name?: string;              // Display name
  description?: string;       // Bio
  location?: string;          // Location
  url?: string;               // Website URL
}

```
