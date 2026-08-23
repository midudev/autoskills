# Xquik REST API endpoints: drafts

## Require approval for drafts

`GET` operations expose private saved content. State the exact draft scope and
obtain explicit approval immediately before each read. `POST` and `DELETE`
operations are non-default writes. Show the exact draft text or draft ID and
obtain explicit approval immediately before each write. Never infer approval
from an earlier request or retry a failed write automatically.

### Create draft

`POST /drafts`

Save a tweet draft for later.

Get approval first. Preview the complete text and metadata. Create the draft
only after the user explicitly approves that exact payload.

Send this request body:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `text` | string | Yes | The draft tweet text |
| `topic` | string | No | Topic the tweet is about |
| `goal` | string | No | `engagement`, `followers`, `authority`, or `conversation` |

For a 201 response, the API returns:

```json
{
  "id": "123",
  "text": "draft text",
  "topic": "product launch",
  "goal": "engagement",
  "createdAt": "2026-02-24T10:30:00.000Z",
  "updatedAt": "2026-02-24T10:30:00.000Z"
}
```

---

### List drafts

`GET /drafts`

List saved tweet drafts with cursor pagination.

This is a private read. Show the account scope, page size, starting `afterCursor`
or lack of one, and maximum page count. List drafts only after explicit approval
for that exact scope. Stop at the approved page limit. Obtain new approval before
following any `nextCursor` beyond it.

Use these query parameters:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `limit` | number | No | 50 | Results per page; maximum 50 |
| `afterCursor` | string | No | - | Pagination cursor from previous response |

For a 200 response, the API returns:

```json
{
  "drafts": [
    {
      "id": "123",
      "text": "draft text",
      "topic": "product launch",
      "goal": "engagement",
      "createdAt": "2026-02-24T10:30:00.000Z",
      "updatedAt": "2026-02-24T10:30:00.000Z"
    }
  ],
  "nextCursor": "cursor_string",
  "hasMore": true
}
```

The final page omits `nextCursor` when `hasMore` is `false`.

---

### Get draft

`GET /drafts/{id}`

Get a specific draft by ID.

This is a private read. Show the draft ID. Fetch it only after explicit approval for
that exact read, including any preview before deletion.

For a 200 response, the API returns 1 draft object.

Possible errors include `400 invalid_id` and `404 draft_not_found`.

---

### Delete draft

```http
DELETE /drafts/{id}
```

This action is destructive. Deletion is permanent and cannot be recovered through
this API. Show the draft ID and text, then obtain explicit approval immediately
before deleting it. Returns `204 No Content`.

Possible errors include `400 invalid_id` and `404 draft_not_found`.

---
