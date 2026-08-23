# Xquik REST API endpoints: monitors

## Require approval for monitors

Monitor reads expose private configuration and require exact-scope approval.
Creating, updating, enabling, disabling, or deleting a monitor changes a
persistent and potentially metered resource.
Before every write, show the exact account or keyword, event types, delivery
plan, ongoing usage, and disable path. If delivery uses a webhook, show its
exact URL and HMAC verification plan. Proceed only after explicit approval for
that exact action. Never create monitoring from an ambiguous request.

### Create monitor

```http
POST /monitors
```

Get approval first. This starts persistent monitoring. Confirm the exact
username, event types, delivery plan, ongoing usage, and disable path first.
Include the exact URL and HMAC verification plan for webhook delivery.

Send this body:
```json
{
  "username": "elonmusk",
  "eventTypes": ["tweet.new", "tweet.reply", "tweet.quote"]
}
```

The API returns:
```json
{
  "id": "7",
  "username": "elonmusk",
  "xUserId": "44196397",
  "eventTypes": ["tweet.new", "tweet.reply", "tweet.quote"],
  "isActive": true,
  "createdAt": "2026-02-24T10:30:00.000Z",
  "nextBillingAt": "2026-02-24T10:30:00.000Z"
}
```

Event types include tweet activity and profile-change events. Use the OpenAPI
`EventType` enum for the current values. `webhook.test` is only a test payload.

Returns `409 monitor_already_exists` if the username is already monitored.

### List monitors

```http
GET /monitors
```

Returns up to 200 monitors without pagination. The response includes `monitors` and `total`.

This is a private read. List monitor targets and delivery configuration only after
explicit approval for that account scope.

### Get monitor

```http
GET /monitors/{id}
```

This is a private read. Show the monitor ID. Retrieve its configuration only after
explicit approval for that exact read.

### Update monitor

```http
PATCH /monitors/{id}
```

Get approval first. Show the current and proposed event types and active
state. Apply only the explicitly approved change.

Send `{ "eventTypes": [...], "isActive": true|false }`. Both fields are optional.

### Delete monitor

```http
DELETE /monitors/{id}
```

This action is destructive. This permanently stops tracking and deletes associated
monitor data. Show the monitor ID, target, and lost data. Delete only after
explicit approval immediately before the call.

### Keyword monitors

```http
GET /monitors/keywords
POST /monitors/keywords
GET /monitors/keywords/{id}
PATCH /monitors/keywords/{id}
DELETE /monitors/keywords/{id}
```

Create and manage ongoing keyword monitors. They are persistent resources. Confirm the query, event delivery, and ongoing usage before creating or enabling one.

Create with `{ "query": "#buildinpublic", "eventTypes": ["tweet.new"] }`.
Poll its events with `GET /events?keywordMonitorId=<id>`.

Creating, updating, enabling, disabling, or deleting a keyword monitor requires
explicit approval for the exact monitor. For create and update operations, show the
proposed keyword, event types, and delivery changes. For enable or disable,
show the active-state transition. For deletion, show the exact target and all
associated data that will be permanently lost.

---
