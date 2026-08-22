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

function assertSupportContent(content: SupportContent): void {
  if (content.body === undefined && content.attachments === undefined) {
    throw new TypeError("body or attachments is required.");
  }
  if (content.body !== undefined && (content.body.length < 1 || content.body.length > 10_000)) {
    throw new TypeError("body must contain 1 to 10,000 characters.");
  }
  if (content.attachments !== undefined &&
      (content.attachments.length < 1 || content.attachments.length > 4)) {
    throw new TypeError("attachments must contain 1 to 4 files.");
  }
}

function assertCreateTicketRequest(request: CreateTicketRequest): void {
  assertSupportContent(request);
  if (request.subject.length > 500 || !/\S/.test(request.subject)) {
    throw new TypeError("subject must contain 1 to 500 characters, including non-whitespace.");
  }
}
```
