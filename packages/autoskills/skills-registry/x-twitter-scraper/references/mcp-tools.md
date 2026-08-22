# Xquik MCP tools reference

The MCP server at `https://xquik.com/mcp` provides 2 API tools. The client sends requests through the server, which authenticates calls to `xquik.com/api/v1`.

Hosted MCP v2.6.0 supports `2026-07-28` through `server/discover`.
Current MCP SDKs add request metadata and headers automatically.
Modern calls need no initialization session.

## Tools

| Tool | Description | Usage |
|------|-------------|------|
| `explore` | Search the API endpoint catalog (read-only, no network calls) | Included |
| `xquik` | Send confirmed Xquik API requests | Varies by endpoint |

### Search the API spec with `explore`

The tool provides an in-memory `spec.endpoints` array. Search or filter it before calling an endpoint.

```typescript
interface EndpointInfo {
  method: string;
  path: string;
  summary: string;
  category: string; // account, composition, credits, extraction, media, monitoring, support, twitter, x-accounts, x-write
  free: boolean; // Included usage flag from endpoint metadata
  parameters?: Array<{ name: string; in: 'query' | 'path' | 'body'; required: boolean; type: string; description: string }>;
  injectedHeaders?: string[];
  responseShape?: string;
}

declare const spec: { endpoints: EndpointInfo[] };
```

For example:

```javascript
// Find all included-usage endpoints.
async () => spec.endpoints.filter(e => e.free);

// Find endpoints by category.
async () => spec.endpoints.filter(e => e.category === 'x-write');

// Search summaries by keyword.
async () => spec.endpoints.filter(e => e.summary.toLowerCase().includes('tweet'));
```

### Send API requests with `xquik`

The tool provides `xquik.request()` with authentication and required idempotency headers injected automatically. Never pass API keys or headers. The sandbox reuses each generated key for bounded transient retries. After an unresolved write failure, verify state. Start a new attempt only when `safeToRetry` is true and the user approves.

For `409 coverage_cursor_unavailable`, wait the exact `Retry-After` seconds and
retry the same cursor once. For `410 coverage_cursor_gone`, the response omits
`Retry-After`. Restart without a cursor and deduplicate by ID.

## Require approval

Apply these rules before using `xquik`:

| Capability | Rule |
|------------|------|
| Public writes | Show the exact tweet, reply, like, retweet, follow, unfollow, profile, or community action. Wait for explicit approval. |
| Direct messages | Show sender, recipient, and message text. Never send bulk or automatic DMs. |
| Persistent resources | Create monitors and webhooks only when the user explicitly asks for ongoing delivery. Show target, event types, URL, and ongoing usage before creation. |
| Cached style writes | Before creating, replacing, or deleting a cached style, show the account, purpose, exact resource, usage, and storage effect. Obtain approval for that write. |
| Private reads | Confirm the account, purpose, exact resource, bound, recipients, and retention before DMs, bookmarks, bookmark folders, notifications, home timeline, or cached style reads. Forward private data only after separate approval. |
| Metered operations | Build the exact path, query, and body. Get an estimate when available. Verify its shape and require `allowed === true`. Otherwise, show the published usage limitation. Show the destination, recipients, and retention. Wait for approval, then send exactly that request. |
| Plan and credit changes | Dashboard-only. The agent may read credit balance, but must not start account changes. |
| X account login | Never ask for or submit X login material. Account connection and re-authentication happen in the dashboard. |

```typescript
declare const xquik: {
  request(path: string, options?: {
    method?: string;  // default: 'GET'
    body?: unknown;
    query?: Record<string, string | number | boolean>;
  }): Promise<unknown>;
};
declare const spec: { endpoints: EndpointInfo[] };
```

## Tool selection rules

Use `explore` first to find endpoints, then `xquik` to call them.

| Goal | Endpoint (via `xquik`) |
|------|------------------------|
| Single tweet by ID or URL | `GET /api/v1/x/tweets/{id}` |
| Full X Article by tweet ID | `GET /api/v1/x/articles/{tweetId}` |
| Search tweets by keyword/hashtag | `GET /api/v1/x/tweets/search?q=...` |
| User profile, bio, and follower counts | `GET /api/v1/x/users/{id}`; `id` accepts a username or numeric ID |
| Download media from tweets | `POST /api/v1/x/media/download`; metered and requires approval for the exact `tweetInput`, usage estimate or limitation, destination, recipients, and retention |
| Check follow relationship | `GET /api/v1/x/followers/check?source=A&target=B` |
| X trending topics by region | `GET /api/v1/trends?woeid=1` |
| Trending news from 7 sources | `GET /api/v1/radar` through `xquik` |
| Activity from monitored accounts | `GET /api/v1/events` |
| Credit balance | `GET /api/v1/credits` |
| Monitor an X account | `POST /api/v1/monitors`; persistent and requires approval |
| Set up webhook notifications | `POST /api/v1/webhooks`; persistent and requires approval |
| Run a giveaway draw | `POST /api/v1/draws`; metered and requires approval for the exact request and data plan |
| Compose or draft a tweet | `POST /api/v1/compose`; run compose, refine, then score |
| Link your X username | Use the Xquik dashboard account settings |
| Analyze tweet style | `POST /api/v1/styles` |
| Get cached style | `GET /api/v1/styles/{id}` |
| Compare two styles | `GET /api/v1/styles/compare` |
| Post a tweet | `POST /api/v1/x/tweets`; requires approval |
| Like or unlike a tweet | `POST /api/v1/x/tweets/{id}/like` likes it. The `DELETE` method on the same route removes the like. Both require approval. |
| Retweet | `POST /api/v1/x/tweets/{id}/retweet`; requires approval |
| Unretweet | Use the `DELETE` method on `/api/v1/x/tweets/{id}/retweet`; requires approval |
| Follow or unfollow | `POST /api/v1/x/users/{id}/follow` follows. The `DELETE` method on the same route unfollows. Both require approval. |
| Send a DM | `POST /api/v1/x/dm/{userId}`; requires approval |
| Upload media | `POST /api/v1/x/media`; approve its use in a post or profile change |
| Open support ticket | `POST /api/v1/support/tickets`; requires approval for the exact content and attachments |
| List support tickets | `GET /api/v1/support/tickets` |
| Get user's recent tweets | `GET /api/v1/x/users/{id}/tweets` |
| Get user's liked tweets | `GET /api/v1/x/users/{id}/likes` |
| Get user's media tweets | `GET /api/v1/x/users/{id}/media` |
| Get accounts that liked a tweet | `GET /api/v1/x/tweets/{id}/favoriters` |
| Get mutual followers | `GET /api/v1/x/users/{id}/followers-you-know` |
| Get followers or following | `GET /api/v1/x/users/{id}/followers` or `GET /api/v1/x/users/{id}/following` |
| Get tweet quotes, replies, retweeters, or thread | `GET /api/v1/x/tweets/{id}/quotes`, `/replies`, `/retweeters`, or `/thread` |
| Read X Lists | `GET /api/v1/x/lists/{id}/members`, `/followers`, `/tweets` |
| Read X Communities | `GET /api/v1/x/communities/search`, `/tweets`, `/{id}/info`, `/{id}/members`, `/{id}/moderators`, `/{id}/tweets` |
| Get bookmarks | `GET /api/v1/x/bookmarks`; private and requires approval |
| Get bookmark folders | `GET /api/v1/x/bookmarks/folders` |
| Get notifications | `GET /api/v1/x/notifications`; private and requires approval |
| Get home timeline | `GET /api/v1/x/timeline`; private and requires approval |
| Get DM history | `GET /api/v1/x/dm/{userId}/history?account={username}`; private and requires exact-account approval |
| Check credit balance | `GET /api/v1/credits` |

Before a draw, confirm the source tweet, `winnerCount`, `backupCount`, every
filter, published usage estimate or estimate limitation, purpose, data scope,
export audience, and retention. Send exactly the approved request.

Before a media download, confirm the exact `tweetInput`. Show the endpoint's
current usage estimate or limitation, local or remote destination, recipients,
and retention. Wait for explicit approval. Send the unchanged body only after
approval.

Before a support ticket, show the exact subject, body, and attachments. Send
the ticket only after explicit approval for that content.

Use `POST /api/v1/extractions` only for bulk data that simpler endpoints cannot provide. Examples include complete follower lists, replies, and community members. Always call `POST /api/v1/extractions/estimate` first.

Fresh cursorless Tweet Search with `queryType=Latest` is newest-first across
pages. Existing cursors retain their ordering. Thread reads accept 32 effective
result filters. They exclude `nativeRetweets`, `sinceTime`, and `untilTime`.
See [direct lookups](api-endpoints-x-api.md) for the exact names.

## Workflow patterns

| Workflow | Steps |
|----------|-------|
| Set up ongoing alerts | Confirm target, event types, destination, and usage estimate -> `POST /monitors` -> `POST /webhooks` -> `POST /webhooks/{id}/test` |
| Run a giveaway | Show the exact request, usage estimate or limitation, and data plan -> approve -> `POST /draws` |
| Bulk extraction | Build one body -> `POST /extractions/estimate` with it -> validate the response and require `allowed === true` -> show that body, estimate, destination, recipients, and retention -> approve -> `POST /extractions` with the unchanged body -> `GET /extractions/{id}` |
| Compose and score a tweet | `POST /compose` with `step=compose` -> `refine` -> `score` |
| Analyze tweet style | `POST /styles` -> `GET /styles/{id}` -> `POST /compose` with `styleUsername` |
| Post a tweet | `GET /x/accounts` -> approve -> `POST /x/tweets` with `account` and `text` -> hosted MCP adds a unique `Idempotency-Key` -> poll `statusUrl` |
| Get trending news | `GET /radar` through `xquik` -> `POST /compose` with the selected topic |
| Open a support ticket | Show exact content and attachments -> approve -> `POST /support/tickets` -> `GET /support/tickets/{id}` |
| Collect complete reply coverage | `GET /x/tweets/{id}/replies?mode=complete&limit=<1-25000>` -> filter direct rows by `inReplyToId` -> keep `nested_replies` separate -> inspect `diagnostic` |

## Common mistakes

| Mistake | Fix |
|---------|-----|
| Combining included and metered calls in `Promise.all` | Keep approval and billing steps sequential. `Promise.all` starts every call, then rejects without returning fulfilled values when 1 call fails. |
| Using `compose` when the user wants to send a tweet | `POST /compose` creates drafts. Use `POST /x/tweets` to send. |
| Using `POST /x/tweets` when the user wants writing help | Use compose, refine, and score instead. |
| Falling back to web search after an API error | Keep data already fetched from Xquik. |
| Skipping account checks before metered calls | Attempt the requested call. On 402, explain the account state and direct the user to the dashboard. |
| Passing API keys in code | The server adds authentication. Do not include keys. |
| Using `explore` for API calls | `explore` searches the API spec. Use `xquik` for API calls. |
| Looking up follow or DM targets by username | These routes need a numeric user ID. Resolve it through `GET /x/users/{id}` first. |
| Treating nested replies as direct replies | Match `inReplyToId` to the root ID. Keep `nested_replies` separate. |
| Treating 424 as an empty failure | Keep safe partial rows. Follow `diagnostic.recommendedFallback` and disclose coverage. |

## REST-only operations

Hosted MCP v2.6.0 catalogs 120 of 128 REST operations.
Of these, 119 support JSON or text. Binary support downloads use REST.
These 8 credential, checkout, or guest-wallet operations remain outside MCP:

- API key creation
- API key listing
- API key revocation
- Saved-payment top-ups
- Dashboard checkout redirects
- Guest wallet creation
- Guest wallet status polling
- Guest wallet top-ups

## Usage reference

- Included operations cover account info, compose steps, cached styles, drafts, Radar, support tickets, credit balance, and webhook management.
- Metered or account-gated operations cover tweet search, lookups, media, extractions, draws, monitors, analysis, trends, and approved writes.
