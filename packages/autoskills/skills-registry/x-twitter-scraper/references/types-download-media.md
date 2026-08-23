# Xquik TypeScript types: download media

```typescript

type NonEmptyTweetIds = [string, ...string[]];

type DownloadMediaRequest =
  | { tweetInput: string; tweetId?: never; tweetUrl?: never; tweetIds?: never }
  | { tweetInput?: never; tweetId: string; tweetUrl?: never; tweetIds?: never }
  | { tweetInput?: never; tweetId?: never; tweetUrl: string; tweetIds?: never }
  | { tweetInput?: never; tweetId?: never; tweetUrl?: never; tweetIds: NonEmptyTweetIds };

// Validate tweetIds.length <= 50 at runtime.

interface DownloadMediaSingleResponse {
  tweetId: string;      // Resolved tweet ID
  galleryUrl: string;   // Shareable gallery page URL
  cacheHit: boolean;    // True when the cache served the result without usage.
}

interface DownloadMediaBulkResponse {
  galleryUrl: string;   // Combined gallery page URL
  totalTweets: number;  // Number of tweets processed
  totalMedia: number;   // Total media items downloaded
}

```
