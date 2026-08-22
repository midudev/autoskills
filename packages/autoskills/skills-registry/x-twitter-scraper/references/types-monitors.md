# Xquik TypeScript types: monitors

```typescript

interface Monitor {
  id: string;
  username: string;
  xUserId: string;
  eventTypes: EventType[];
  isActive: boolean;
  createdAt: string;
  nextBillingAt: string;
  pausedReason?: "x_user_not_found";
  pausedAt?: string;
}

interface KeywordMonitor {
  id: string;
  query: string;
  eventTypes: KeywordEventType[];
  isActive: boolean;
  createdAt: string;
  nextBillingAt: string;
}

type KeywordEventType =
  | "tweet.new"
  | "tweet.quote"
  | "tweet.reply"
  | "tweet.retweet"
  | "tweet.media"
  | "tweet.link"
  | "tweet.poll"
  | "tweet.mention"
  | "tweet.hashtag"
  | "tweet.longform";

type EventType =
  | KeywordEventType
  | "profile.avatar.changed"
  | "profile.banner.changed"
  | "profile.name.changed"
  | "profile.username.changed"
  | "profile.bio.changed"
  | "profile.location.changed"
  | "profile.url.changed"
  | "profile.verified.changed"
  | "profile.protected.changed"
  | "profile.pinned_tweet.changed"
  | "profile.unavailable.changed";

```

Keyword monitor requests accept only `KeywordEventType`. The shared OpenAPI
event array also serves account monitors and webhooks. It therefore includes
profile events. Never pass a `profile.*` value to a keyword monitor request.
