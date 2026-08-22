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

// Validate media MIME types before the request. Allow up to 4 images or exactly
// 1 MP4. A request must include nonempty text, nonempty media, or both.

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
