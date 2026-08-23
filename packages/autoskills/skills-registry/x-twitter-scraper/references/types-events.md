# Xquik TypeScript types: events

```typescript

interface XquikEventBase {
  id: string;
  type: EventType;
  // Account monitor ID or keyword monitor ID, based on monitorType.
  monitorId: string;
  occurredAt: string;
  data: Record<string, unknown>;
}

type XquikEvent = XquikEventBase & (
  | {
      monitorType: "account";
      username: string;
      query?: never;
      keywordMonitorId?: never;
    }
  | {
      monitorType: "keyword";
      username?: never;
      query: string;
      keywordMonitorId: string;
    }
);

type XquikEventDetail = XquikEvent & {
  xEventId?: string;
};

interface EventList {
  events: XquikEvent[];
  hasMore: boolean;
  nextCursor?: string;
}

```
