# Xquik TypeScript types: draws

```typescript

interface Draw {
  id: string;
  tweetId: string;
  tweetUrl: string;
  tweetText: string;
  tweetAuthorUsername: string;
  tweetLikeCount: number;
  tweetRetweetCount: number;
  tweetReplyCount: number;
  tweetQuoteCount: number;
  status: "pending" | "running" | "completed" | "failed";
  totalEntries: number;
  validEntries: number;
  createdAt: string;
  drawnAt?: string;
}

interface DrawListItem {
  id: string;
  tweetUrl: string;
  status: "pending" | "running" | "completed" | "failed";
  totalEntries: number;
  validEntries: number;
  createdAt: string;
  drawnAt?: string;
}

interface DrawWinner {
  position: number;
  authorUsername: string;
  tweetId: string;
  isBackup: boolean;
}

interface DrawDetails {
  draw: Draw;
  winners: DrawWinner[];
}

interface DrawList {
  draws: DrawListItem[];
  hasMore: boolean;
  nextCursor?: string;
}

interface CreateDrawRequest {
  tweetUrl: string;
  winnerCount?: number;
  backupCount?: number;
  uniqueAuthorsOnly?: boolean;
  mustRetweet?: boolean;
  mustFollowUsername?: string;
  filterMinFollowers?: number;
  filterAccountAgeDays?: number;
  filterLanguage?: string;
  requiredKeywords?: string[];
  requiredHashtags?: string[];
  requiredMentions?: string[];
}

```
