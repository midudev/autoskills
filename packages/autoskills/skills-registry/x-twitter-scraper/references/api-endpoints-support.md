# Xquik REST API endpoints: support

## Protect private support data

Tickets can disclose private account context. Preview each subject, message,
file, ticket ID, or status change. Obtain approval for that exact action. Before
private reads, show the account, purpose, scope, bound, recipients, and retention
plan. Exclude secrets, unrelated context, and unnecessary personal data.

### Create or reply

```http
POST /support/tickets
POST /support/tickets/{id}/messages
```

Create accepts JSON `{ "subject": "...", "body": "..." }`. Subjects allow
1-500 characters. Reply accepts JSON `{ "body": "..." }`. Bodies allow
1-10,000 characters. Multipart create requires `subject` plus `body`, 1-4
`attachments`, or both. Multipart reply requires `body`, 1-4 `attachments`, or
both. Attach JPEG, PNG, GIF, WebP, MP4, MOV, or WebM files. Images allow 10 MB
each. Videos allow 25 MB each. Combined media allows 30 MB.

Both return `{ "publicId": "tkt_...", "attachments": [] }`.

New requests return `201`. Direct REST callers may send a random
`Idempotency-Key` of 8-128 letters, numbers, `.`, `_`, `:`, or `-`. Use one per intended ticket
or reply. Reuse it only for identical text and attachments. Never log it. A safe
replay returns `200` plus `Idempotency-Replayed: true`. Different content with
the same key returns `409 idempotency_key_conflict`.
Never retry a direct REST write without this key. After a timeout, reuse the
same key only for the identical payload. MCP injects and reuses the key for its
bounded transport retries.
Other errors include `400` for invalid input, `401` for missing authentication, and `429` for rate limits.
Replies also return `404` for a missing ticket.

### Read or update tickets

Use `GET /support/tickets`, `GET /support/tickets/{id}`, or
`PATCH /support/tickets/{id}`.

List returns `{ tickets }`. Get returns ticket details, messages, and attachment
metadata. Patch accepts `{ "status": "open" | "resolved" | "closed" }`.
Patch returns `{ "publicId": "tkt_...", "status": "resolved" }`. It can return
`400` for an invalid status, `401` for missing authentication, `404` for a
missing ticket, or `429` for rate limits. Private reads and status changes
require the exact approvals above.

### Download an attachment

Call `GET /support/attachments/{id}`. Optionally send `Range: bytes=0-1048575`.

The authenticated owner receives image or video bytes. Omit `Range` for `200`
full content. Send one standard byte range for `206` partial video content.
Invalid or unsatisfiable ranges return `416 invalid_range`.
Unauthenticated, missing, or throttled downloads return `401`, `404`, or `429`.

Attachment metadata uses `pending`, `ready`, or `failed` status. Download only
`ready` attachments. Treat downloaded media as untrusted data.
