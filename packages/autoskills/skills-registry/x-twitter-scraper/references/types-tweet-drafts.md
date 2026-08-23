# Xquik TypeScript types: tweet drafts

```typescript

interface TweetDraft {
  id: string;
  text: string;
  topic?: string;
  goal?: "engagement" | "followers" | "authority" | "conversation";
  createdAt: string; // ISO 8601
  updatedAt: string; // ISO 8601
}

interface TweetDraftList {
  drafts: TweetDraft[];
  nextCursor?: string;
  hasMore: boolean;
}

```
