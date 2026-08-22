# Xquik TypeScript types: support

```typescript
type SupportTicketStatus = "open" | "in_progress" | "resolved" | "closed";
type SupportAttachmentStatus = "pending" | "ready" | "failed";

interface SupportAttachmentReceipt {
  publicId: string;
  status: SupportAttachmentStatus;
}

interface SupportAttachment extends SupportAttachmentReceipt {
  filename: string;
  contentType: "image/jpeg" | "image/png" | "image/gif" | "image/webp"
    | "video/mp4" | "video/quicktime" | "video/webm";
  kind: "image" | "video";
  sizeBytes: number;
  url: string;
}

interface SupportMessage {
  body: string;
  sender: "user" | "support" | "system";
  createdAt: string;
  attachments: SupportAttachment[];
}

interface SupportTicket {
  publicId: string;
  subject: string;
  status: SupportTicketStatus;
  createdAt: string;
  updatedAt: string;
  messageCount?: number;
  messages?: SupportMessage[];
}

interface SupportMutationResponse {
  publicId: string;
  attachments: SupportAttachmentReceipt[];
}

type SupportAttachments =
  | [Blob]
  | [Blob, Blob]
  | [Blob, Blob, Blob]
  | [Blob, Blob, Blob, Blob];

type SupportContent =
  | { body: string; attachments?: SupportAttachments }
  | { body?: string; attachments: SupportAttachments };
type CreateTicketRequest = SupportContent & { subject: string };
type ReplyToTicketRequest = SupportContent;

function assertSupportContent(content: unknown): asserts content is SupportContent {
  if (typeof content !== "object" || content === null) {
    throw new TypeError("support content must be an object.");
  }
  const candidate = content as { body?: unknown; attachments?: unknown };
  if (candidate.body === undefined && candidate.attachments === undefined) {
    throw new TypeError("body or attachments is required.");
  }
  if (candidate.body !== undefined &&
      (typeof candidate.body !== "string" ||
       candidate.body.length < 1 || candidate.body.length > 10_000)) {
    throw new TypeError("body must contain 1 to 10,000 characters.");
  }
  if (candidate.attachments !== undefined &&
      (!Array.isArray(candidate.attachments) ||
       candidate.attachments.length < 1 || candidate.attachments.length > 4 ||
       candidate.attachments.some((attachment) => !(attachment instanceof Blob)))) {
    throw new TypeError("attachments must contain 1 to 4 files.");
  }
}

function assertCreateTicketRequest(request: unknown): asserts request is CreateTicketRequest {
  assertSupportContent(request);
  const subject = (request as SupportContent & { subject?: unknown }).subject;
  if (typeof subject !== "string" ||
      subject.length < 1 || subject.length > 500 || !/\S/.test(subject)) {
    throw new TypeError("subject must contain 1 to 500 characters, including non-whitespace.");
  }
}
```
