# Xquik workflow examples

Use these code examples for authentication, retries, pagination, extractions, and monitoring.

## Authentication

> These examples send credentials, parameters, and
> returned data to and from `xquik.com`. Keep the key in a secret store. Get
> explicit approval before private reads, writes, exports, persistent resources,
> webhooks, or metered jobs. Never forward private results without separate
> approval.

```javascript
const apiKey = process.env.XQUIK_API_KEY;
if (!apiKey) throw new Error("Set XQUIK_API_KEY first.");

const BASE = "https://xquik.com/api/v1";
const headers = { "x-api-key": apiKey, "Content-Type": "application/json" };
```

## Retry with exponential backoff

Outside documented cursor recovery, retry only idempotent requests after a
connection failure, timeout, `408`, `429`, or `5xx`. Retry `424` only when the
response explicitly marks the read safe to retry. Never automatically retry
`POST`, `PATCH`, or `DELETE`. Stop after 3 retries.

```javascript
class XquikApiError extends Error {
  constructor(status, code, message) {
    super(`Xquik API ${status}: ${message}`);
    this.status = status;
    this.code = code;
  }
}

function isDefinitiveWriteRejection(error) {
  return error instanceof XquikApiError &&
    error.status >= 400 &&
    error.status < 500 &&
    ![408, 409, 423, 424, 425, 429].includes(error.status);
}

async function fetchTextWithTimeout(url, { timeoutMs = 30_000, ...options } = {}) {
  if (!Number.isFinite(timeoutMs) || timeoutMs <= 0) {
    throw new Error("timeoutMs must be a finite positive number.");
  }
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), Math.min(30_000, timeoutMs));

  try {
    const response = await fetch(url, { ...options, signal: controller.signal });
    const body = await response.text();
    return { response, body };
  } finally {
    clearTimeout(timeout);
  }
}

async function xquikFetch(path, options = {}) {
  const baseDelay = 1000;
  const maxRetryDelay = 30_000;
  const { timeoutMs, ...requestOptions } = options;
  if (timeoutMs !== undefined && (!Number.isFinite(timeoutMs) || timeoutMs <= 0)) {
    throw new Error("timeoutMs must be a finite positive number.");
  }
  const deadline = Number.isFinite(timeoutMs) ? performance.now() + timeoutMs : null;
  const remainingMs = () => deadline === null ? 30_000 : deadline - performance.now();
  const waitBeforeRetry = async (delayMs) => {
    if (!Number.isFinite(delayMs) || delayMs < 0) {
      throw new Error("Retry delay must be a finite nonnegative number.");
    }
    const remaining = remainingMs();
    if (deadline !== null && remaining <= 0) {
      throw new Error("Xquik request deadline exceeded.");
    }
    const waitMs = deadline === null ? delayMs : Math.min(delayMs, remaining);
    await new Promise((resolve) => setTimeout(resolve, waitMs));
  };
  const method = (requestOptions.method || "GET").toUpperCase();
  const retrySafe = ["GET", "HEAD", "OPTIONS"].includes(method);
  let retriedCoverageCursor = false;

  for (let attempt = 0; attempt <= 3; attempt++) {
    let response;
    let responseBody;

    try {
      const requestTimeoutMs = remainingMs();
      if (requestTimeoutMs <= 0) throw new Error("Xquik request deadline exceeded.");
      ({ response, body: responseBody } = await fetchTextWithTimeout(
        `${BASE}${path}`,
        {
          ...requestOptions,
          timeoutMs: requestTimeoutMs,
          headers: { ...headers, ...requestOptions.headers },
        },
      ));
    } catch (error) {
      if (!retrySafe || attempt === 3) throw error;
      await waitBeforeRetry(
        Math.min(maxRetryDelay, baseDelay * 2 ** attempt + Math.random() * 1000),
      );
      continue;
    }

    if (response.ok) return responseBody ? JSON.parse(responseBody) : null;

    let parsedError = null;
    try {
      parsedError = responseBody ? JSON.parse(responseBody) : null;
    } catch {
      // Use the generic error below.
    }
    const error = parsedError && typeof parsedError === "object"
      ? parsedError
      : { error: "request failed" };
    const code = typeof error.error === "string" ? error.error : error.error?.code;
    const coverageRetry =
      response.status === 409 &&
      code === "coverage_cursor_unavailable" &&
      !retriedCoverageCursor;
    const retryable =
      retrySafe &&
      (response.status === 408 ||
        response.status === 429 ||
        response.status >= 500 ||
        coverageRetry ||
        (response.status === 424 && error.safeToRetry === true));
    if (!retryable || attempt === 3) {
      const message = typeof error.error === "string"
        ? error.error
        : error.error?.message || code || "request failed";
      throw new XquikApiError(response.status, code, message);
    }

    const retryAfter = response.headers.get("Retry-After");
    const retryAfterMs = retryAfter && /^\d+$/.test(retryAfter)
      ? Number(retryAfter) * 1000
      : null;
    if (coverageRetry && retryAfterMs === null) {
      throw new Error("Xquik API 409: missing Retry-After");
    }
    if (coverageRetry) retriedCoverageCursor = true;
    const delay = Math.min(
      maxRetryDelay,
      retryAfterMs !== null
        ? retryAfterMs
        : baseDelay * 2 ** attempt + Math.random() * 1000,
    );

    await waitBeforeRetry(delay);
  }
}
```

## Cursor pagination

Events, draws, extractions, and extraction results use cursor-based pagination.
When more results exist, the response includes `hasMore: true` and a
`nextCursor` string. Pass it as `cursor`. Radar alone uses `after`.

```javascript
async function fetchAllPages(path, dataKey, maxResults, identityForItem) {
  if (!Number.isInteger(maxResults) || maxResults < 1) {
    throw new Error("maxResults must be a finite positive integer.");
  }
  if (typeof identityForItem !== "function") {
    throw new Error("identityForItem must select a stable endpoint-specific ID.");
  }

  const results = [];
  const seenIds = new Set();
  const seenCursors = new Set();
  let cursor;
  let pageCount = 0;
  let restartedExpiredCursor = false;

  while (results.length < maxResults) {
    if (pageCount >= maxResults) {
      throw new Error("Pagination exceeded the maximum page count without enough results.");
    }
    pageCount++;
    const remaining = maxResults - results.length;
    const params = new URLSearchParams({ limit: String(Math.min(100, remaining)) });
    if (cursor) params.set("cursor", cursor);

    let data;
    try {
      data = await xquikFetch(`${path}?${params}`);
    } catch (error) {
      if (
        error instanceof XquikApiError &&
        error.status === 410 &&
        error.code === "coverage_cursor_gone" &&
        cursor &&
        !restartedExpiredCursor
      ) {
        cursor = undefined;
        seenCursors.clear();
        restartedExpiredCursor = true;
        continue;
      }
      throw error;
    }

    const page = data?.[dataKey];
    if (!Array.isArray(page)) throw new Error(`Missing ${dataKey} page.`);
    for (const item of page) {
      const identity = identityForItem(item);
      if (typeof identity !== "string" || !identity) {
        throw new Error(`Every ${dataKey} item needs a stable identity.`);
      }
      if (!seenIds.has(identity)) {
        seenIds.add(identity);
        results.push(item);
      }
      if (results.length === maxResults) break;
    }

    if (results.length === maxResults || !data.hasMore) break;
    if (typeof data.nextCursor !== "string" || !data.nextCursor) {
      throw new Error("Missing nextCursor for a paginated response.");
    }
    if (seenCursors.has(data.nextCursor)) {
      throw new Error("Repeated nextCursor without pagination progress.");
    }
    seenCursors.add(data.nextCursor);
    cursor = data.nextCursor;
  }

  return results;
}
```

Cursors are opaque strings. Never decode or construct them manually.

For `409 coverage_cursor_unavailable`, wait the exact `Retry-After` seconds and
retry the same cursor once. For `410 coverage_cursor_gone`, the response omits
`Retry-After`. Restart without a cursor and deduplicate by an endpoint-specific
stable identity.

## Complete extraction workflow

```javascript
function requireExplicitApproval(scope) {
  throw new Error(`Approval required for ${scope}. Implement the approval gate first.`);
}

// Estimate usage before creating the job.
const estimate = await xquikFetch("/extractions/estimate", {
  method: "POST",
  body: JSON.stringify({
    toolType: "follower_explorer",
    targetUsername: "elonmusk",
    resultsLimit: 1000,
  }),
});

if (!estimate.allowed) {
  throw new Error(`Extraction requires ${estimate.creditsRequired} credits. Balance: ${estimate.creditsAvailable}.`);
}

// Create the bounded job only after approval.
requireExplicitApproval("the bounded extraction job, usage, recipients, and retention");
let job = await xquikFetch("/extractions", {
  method: "POST",
  body: JSON.stringify({
    toolType: "follower_explorer",
    targetUsername: "elonmusk",
    resultsLimit: 1000,
  }),
});

// Poll for at most 5 minutes, including waits, retries, and network time.
const pollDeadline = performance.now() + 5 * 60 * 1000;
while (["pending", "running"].includes(job.status)) {
  let remainingPollMs = pollDeadline - performance.now();
  if (remainingPollMs <= 0) break;
  await new Promise((resolve) => setTimeout(resolve, Math.min(2000, remainingPollMs)));
  remainingPollMs = pollDeadline - performance.now();
  if (remainingPollMs <= 0) break;
  job = await xquikFetch(`/extractions/${job.id}`, { timeoutMs: remainingPollMs });
}

if (job.status !== "completed") {
  throw new Error(job.errorMessage || "Extraction failed.");
}

// Retrieve no more than the approved 1,000 results.
const allResults = await fetchAllPages(
  `/extractions/${job.id}`,
  "results",
  1000,
  (item) => typeof item?.xUserId === "string" ? `user:${item.xUserId}` : null,
);

// Review a bounded preview and approve the export first.
requireExplicitApproval("the fixed export scope, audience, storage, and retention");
const exportUrl = `${BASE}/extractions/${job.id}/export?format=csv`;
const { response: csvResponse, body: csvData } = await fetchTextWithTimeout(
  exportUrl,
  { headers },
);
if (!csvResponse.ok) {
  throw new Error(`Xquik export failed with HTTP ${csvResponse.status}.`);
}
```

## Real-time monitoring setup

Create a monitor, register a webhook, then handle events. Get explicit approval for the target, event types, destination URL, and ongoing usage first.

```javascript
function requireExplicitApproval(scope) {
  throw new Error(`Approval required for ${scope}. Implement the approval gate first.`);
}

requireExplicitApproval(
  "the monitor target, event types, destination URL, preflight webhook list, ongoing usage, and disable path",
);

const eventTypes = ["tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet"];
const monitorConfig = {
  username: "elonmusk",
  eventTypes,
};
const webhookConfig = {
  url: "https://your-server.com/webhook",
  eventTypes,
};

function readMonitorList(data) {
  if (Array.isArray(data)) return data;
  if (data && Array.isArray(data.monitors)) return data.monitors;
  throw new Error("Unexpected monitor list response.");
}

function readWebhookList(data) {
  if (Array.isArray(data)) return data;
  if (data && Array.isArray(data.webhooks)) return data.webhooks;
  throw new Error("Unexpected webhook list response.");
}

function eventTypeKey(eventTypes) {
  return [...eventTypes].sort().join("\u0000");
}

// Snapshot existing IDs before creating anything. These private reads need the
// approval above and enable safe reconciliation after ambiguous timeouts.
const existingMonitorIds = new Set(
  readMonitorList(await xquikFetch("/monitors")).map((item) => item.id),
);
const existingWebhookIds = new Set(
  readWebhookList(await xquikFetch("/webhooks")).map((item) => item.id),
);

// Create a persistent monitor. Active monitors are metered hourly.
let monitor;
try {
  monitor = await xquikFetch("/monitors", {
    method: "POST",
    body: JSON.stringify(monitorConfig),
  });
} catch (monitorCreationError) {
  if (isDefinitiveWriteRejection(monitorCreationError)) {
    throw monitorCreationError;
  }
  let candidates;
  try {
    candidates = readMonitorList(await xquikFetch("/monitors")).filter(
      (item) =>
        typeof item.id === "string" &&
        Array.isArray(item.eventTypes) &&
        !existingMonitorIds.has(item.id) &&
        item.username === monitorConfig.username &&
        eventTypeKey(item.eventTypes) === eventTypeKey(monitorConfig.eventTypes),
    );
  } catch (reconciliationError) {
    throw new AggregateError(
      [monitorCreationError, reconciliationError],
      "Monitor creation is ambiguous. Reconcile new monitors manually.",
    );
  }
  if (candidates.length !== 1) {
    throw new AggregateError(
      [monitorCreationError],
      `Monitor creation is ambiguous. Found ${candidates.length} new matches. Reconcile them manually.`,
    );
  }
  [monitor] = candidates;
}

// Register a persistent delivery destination. POST /webhooks does not accept
// Idempotency-Key, so reconcile an ambiguous failure before deleting anything.
let webhook;
try {
  webhook = await xquikFetch("/webhooks", {
    method: "POST",
    body: JSON.stringify(webhookConfig),
  });
} catch (creationError) {
  if (isDefinitiveWriteRejection(creationError)) {
    try {
      await xquikFetch(`/monitors/${encodeURIComponent(monitor.id)}`, {
        method: "DELETE",
      });
    } catch (cleanupError) {
      throw new AggregateError(
        [creationError, cleanupError],
        `Webhook creation was rejected. Reconcile monitor ${monitor.id} manually.`,
      );
    }
    throw creationError;
  }
  const failures = [creationError];
  let candidates = [];
  try {
    candidates = readWebhookList(await xquikFetch("/webhooks")).filter(
      (item) =>
        typeof item.id === "string" &&
        Array.isArray(item.eventTypes) &&
        !existingWebhookIds.has(item.id) &&
        item.url === webhookConfig.url &&
        eventTypeKey(item.eventTypes) === eventTypeKey(webhookConfig.eventTypes),
    );
  } catch (reconciliationError) {
    failures.push(reconciliationError);
  }

  let webhookRemoved = false;
  if (candidates.length === 1) {
    try {
      await xquikFetch(`/webhooks/${encodeURIComponent(candidates[0].id)}`, {
        method: "DELETE",
      });
      webhookRemoved = true;
    } catch (cleanupError) {
      failures.push(cleanupError);
    }
  } else {
    failures.push(
      new Error(`Found ${candidates.length} new webhook matches. Reconcile them manually.`),
    );
  }

  if (webhookRemoved) {
    try {
      await xquikFetch(`/monitors/${encodeURIComponent(monitor.id)}`, {
        method: "DELETE",
      });
    } catch (cleanupError) {
      failures.push(cleanupError);
    }
  } else {
    failures.push(new Error(`Monitor ${monitor.id} was retained for manual reconciliation.`));
  }

  throw new AggregateError(
    failures,
    `Webhook setup failed. Reconcile monitor ${monitor.id} and webhook resources manually.`,
  );
}
// Store webhook.secret now. The API returns it once.
```

Use `GET /events` only in a separate polling-only workflow. Do not register a
webhook and poll the same monitor simultaneously.

Monitor event types include `tweet.new`, `tweet.quote`, `tweet.reply`, and
`tweet.retweet`. Test deliveries use `webhook.test`; do not subscribe to it.

## Endpoint guide

| Goal | Endpoint | Usage |
|------|----------|------|
| Get a tweet by ID or URL | `GET /x/tweets/{id}` | Metered |
| Get an X Article by tweet ID | `GET /x/articles/{tweetId}` | Metered |
| Search tweets by keyword or hashtag | `GET /x/tweets/search?q=...` | Metered per result |
| Get a user profile | `GET /x/users/{id}` | Metered |
| Get a user's recent tweets | `GET /x/users/{id}/tweets` | Metered per result |
| Get a user's liked tweets | `GET /x/users/{id}/likes` | Metered per result |
| Get a user's media tweets | `GET /x/users/{id}/media` | Metered per result |
| Get tweet favoriters | `GET /x/tweets/{id}/favoriters` | Metered per result |
| Get mutual followers | `GET /x/users/{id}/followers-you-know` | Metered per result |
| Check a follow relationship | `GET /x/followers/check?source=A&target=B` | Metered |
| Get trending topics | `GET /trends?woeid=1` | Metered |
| Get Radar news | `GET /radar?source=hacker_news` | Included |
| Get bookmarks | `GET /x/bookmarks` | Metered per result |
| Get bookmark folders | `GET /x/bookmarks/folders` | Metered |
| Get notifications | `GET /x/notifications` | Metered per result |
| Get the home timeline | `GET /x/timeline` | Metered per result |
| Get DM history | `GET /x/dm/{userId}/history?account={username}` | Private; approve the exact account |
| Monitor an X account | `POST /monitors` | Active monitors are metered hourly |
| Poll for events | `GET /events` | Included |
| Receive webhook events | `POST /webhooks` | Included; approve the destination URL |
| Run a giveaway draw | `POST /draws` | Metered per entry |
| Download tweet media | `POST /x/media/download` | Metered per item |
| Extract bulk data | `POST /extractions` | Metered per result |
| Check credits | `GET /credits` | Included |
| Compose a tweet | `POST /compose` | Included |
| Post a tweet | `POST /x/tweets` | Metered write action |
| Like or unlike a tweet | `POST /x/tweets/{id}/like` likes it. The `DELETE` method on the same route removes the like. | Metered write action |
| Retweet or unretweet | `POST /x/tweets/{id}/retweet` retweets. The same route with the `DELETE` method unretweets. | Metered write action |
| Follow or unfollow | `POST /x/users/{id}/follow` follows. The `DELETE` method on the same route unfollows. | Metered write action |
| Send a DM | `POST /x/dm/{userId}` | Metered write action |
| Update a profile | `PATCH /x/profile` | Metered write action |
| Upload media | `POST /x/media` | Metered write action |
| Create or delete a community | `POST /x/communities` creates. The `/x/communities/{id}` route with the `DELETE` method deletes. | Metered write action |
| Join or leave a community | `POST /x/communities/{id}/join` joins. The same route with the `DELETE` method leaves. | Metered write action |
| Manage support tickets | `POST /support/tickets` | Included |
