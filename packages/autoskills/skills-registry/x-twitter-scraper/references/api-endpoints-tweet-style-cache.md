# Xquik REST API endpoints: tweet-style cache

## Protect cached style data

Style creation, replacement, and deletion change persistent cached resources.
For analysis, show the username, estimated usage, and storage effect. For
custom saves, show the label, source tweets, and replacement effect. For
deletion, show the label or username and deletion effect. Proceed only after
explicit approval for that exact write.
Cached profiles and comparisons are account-scoped reads. Require exact-scope
approval before retrieving them.

### Analyze and cache style

`POST /styles`

Fetch recent tweets from an X account and cache them for style analysis. This call is metered.

Get approval first. Confirm the username, metered usage, and intent to store
the resulting profile before creating the cache.

Send this request body:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `username` | string | Yes | X username without `@` |

For a 201 response, the API returns:

```json
{
  "xUsername": "elonmusk",
  "tweetCount": 20,
  "isOwnAccount": false,
  "fetchedAt": "2026-02-24T10:30:00.000Z",
  "tweets": [
    {
      "id": "1893456789012345678",
      "text": "The future is now.",
      "authorUsername": "elonmusk",
      "createdAt": "2026-02-24T14:22:00.000Z"
    }
  ]
}
```

---

### List cached styles

`GET /styles`

List up to 200 cached tweet-style profiles ordered by fetch date.
Each summary's `xUsername` is the route identifier. For a custom style, it is
the normalized label returned when the style was saved. Use that value for
subsequent get and delete requests.

This is a private read. This endpoint returns the entire cached profile list, up to 200
entries. Show that scope, the purpose, recipients, and retention plan.
List profiles only after explicit approval for that exact read.

For a 200 response, the API returns:

```json
{
  "styles": [
    {
      "xUsername": "elonmusk",
      "tweetCount": 20,
      "isOwnAccount": false,
      "fetchedAt": "2026-02-24T10:30:00.000Z"
    }
  ]
}
```

---

### Save custom style

`PUT /styles/{id}`

Save a custom style profile from tweet texts. Set `{id}` to the same label as
the body `label`. URL-encode the label as one path segment with
`encodeURIComponent(label)`. The API normalizes that label into the response
`xUsername`. Use `encodeURIComponent(response.xUsername)` for later get,
delete, or performance requests. A matching saved style is replaced.

Get approval first. Preview the label and source texts. Warn when an existing
label will be replaced, then obtain explicit approval.

Send this body:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `label` | string | Yes | Style label from 1-50 characters. Start with a letter or number. Use letters, numbers, spaces, dots, hyphens, or apostrophes. |
| `tweets` | object[] | Yes | Array of 1-100 tweet objects; each needs a `text` field |

For a 200 response, the API returns a style object with its label, `tweetCount`, `isOwnAccount: false`, `fetchedAt`, and `tweets`.

Possible errors include `400 invalid_input`.

---

### Get cached style

`GET /styles/{id}`

Get a cached style profile with full tweet data. `id` is the cached style label
or username. URL-encode it as one path segment.

This is a private read. Show the label or username. Retrieve its tweets only after
explicit approval for that exact read.

For a 200 response, the API returns the full style object with `tweets`.

Possible errors include `404 style_not_found`.

---

### Delete cached style

```http
DELETE /styles/{id}
```

This action is destructive. This permanently deletes the cached style profile.
Show the exact label or username and explain the lost cached data. Delete only
after explicit approval immediately before the call. URL-encode `id` as one
path segment. Returns `204 No Content`.

Possible errors include `404 style_not_found`.

---

### Compare styles

`GET /styles/compare?username1=A&username2=B`

Compare 2 cached tweet-style profiles.

This is a private read. Show both labels or usernames. Compare only after explicit
approval for that exact read.

Use these query parameters. Despite their names, both values are cached style
identifiers. An analyzed profile uses its X username. A custom profile uses the
normalized label returned as `xUsername`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username1` | string | Yes | First cached `xUsername` identifier |
| `username2` | string | Yes | Second cached `xUsername` identifier |

For a 200 response, the API returns:

```json
{
  "style1": { "xUsername": "user1", "tweetCount": 20, "isOwnAccount": true, "fetchedAt": "...", "tweets": [...] },
  "style2": { "xUsername": "user2", "tweetCount": 15, "isOwnAccount": false, "fetchedAt": "...", "tweets": [...] }
}
```

Possible errors include `400 missing_params` and `404 style_not_found`.

---

### Analyze performance

`GET /styles/{id}/performance`

Get current engagement metrics for tweets in a cached style. This call is metered.

This is a metered private read. Show the label or username and usage estimate.
Proceed only after explicit approval for that exact read.

For a 200 response, the API returns:

```json
{
  "xUsername": "elonmusk",
  "tweetCount": 20,
  "tweets": [
    {
      "id": "1893456789012345678",
      "text": "The future is now.",
      "likeCount": 42000,
      "retweetCount": 8500,
      "replyCount": 3200,
      "quoteCount": 1100,
      "viewCount": 5000000,
      "bookmarkCount": 2400
    }
  ]
}
```

Possible errors include `404 style_not_found`.

---
