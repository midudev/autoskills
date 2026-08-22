# Xquik TypeScript types: tweet style cache

```typescript

interface TweetStyleCache {
  xUsername: string;
  tweetCount: number;
  isOwnAccount: boolean;
  fetchedAt: string; // ISO 8601
  tweets: CachedTweet[];
}

interface CachedTweet {
  id: string;
  text: string;
  authorUsername: string;
  createdAt: string; // ISO 8601
  media?: TweetMediaItem[];
}

interface TweetStyleSummary {
  xUsername: string;
  tweetCount: number;
  isOwnAccount: boolean;
  fetchedAt: string;
}

interface StyleComparison {
  style1: TweetStyleCache;
  style2: TweetStyleCache;
}

interface StylePerformance {
  xUsername: string;
  tweetCount: number;
  tweets: PerformanceTweet[];
}

interface PerformanceTweet {
  id: string;
  text: string;
  likeCount: number;
  retweetCount: number;
  replyCount: number;
  quoteCount: number;
  viewCount: number;
  bookmarkCount: number;
}

```
