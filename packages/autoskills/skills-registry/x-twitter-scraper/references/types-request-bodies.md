# Xquik TypeScript types: request bodies

```typescript

interface CreateMonitorRequest {
  username: string;
  eventTypes: EventType[];
}

interface UpdateMonitorRequest {
  eventTypes?: EventType[];
  isActive?: boolean;
}

interface CreateKeywordMonitorRequest {
  query: string;
  eventTypes: KeywordEventType[];
}

interface UpdateKeywordMonitorRequest {
  eventTypes?: KeywordEventType[];
  isActive?: boolean;
}

interface CreateWebhookRequest {
  url: string;
  eventTypes: EventType[];
}

interface UpdateWebhookRequest {
  url?: string;
  eventTypes?: EventType[];
  isActive?: boolean;
}

interface CreateApiKeyRequest {
  name?: string;
}

```
