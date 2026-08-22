# Xquik TypeScript types: extractions

```typescript

type ExtractionToolType =
  | "article_extractor" | "community_extractor"
  | "community_moderator_explorer" | "community_post_extractor"
  | "community_search" | "favoriters"
  | "follower_explorer" | "following_explorer"
  | "list_follower_explorer" | "list_member_extractor"
  | "list_post_extractor" | "mention_extractor"
  | "people_search" | "post_extractor"
  | "quote_extractor" | "reply_extractor"
  | "repost_extractor" | "space_explorer"
  | "thread_extractor" | "tweet_search_extractor"
  | "user_likes" | "user_media"
  | "verified_follower_explorer";

type ExtractionStatus = "pending" | "running" | "completed" | "failed";

interface CreateExtractionResponse {
  id: string;
  toolType: ExtractionToolType;
  status: ExtractionStatus;
}

interface ExtractionJob {
  id: string;
  toolType: ExtractionToolType;
  status: ExtractionStatus;
  totalResults: number;
  targetTweetId?: string; targetUsername?: string;
  targetCommunityId?: string; targetListId?: string;
  targetSpaceId?: string; searchQuery?: string;
  resultsLimit?: number;
  errorMessage?: string;
  createdAt: string;
  completedAt?: string;
}

interface ExtractionResult {
  id: string;
  xUserId: string; xUsername?: string; xDisplayName?: string;
  xFollowersCount?: number; xVerified?: boolean;
  xProfileImageUrl?: string;
  tweetId?: string; tweetText?: string; tweetCreatedAt?: string;
  createdAt: string;
}

interface ExtractionList {
  extractions: ExtractionJob[];
  hasMore: boolean;
  nextCursor?: string;
}

interface ExtractionEstimate {
  allowed: boolean; estimatedResults: number;
  creditsAvailable: string; creditsRequired: string;
  source: "replyCount" | "retweetCount" | "quoteCount" | "followers" | "unknown";
  resolvedXUserId?: string; error?: string;
}

type ExtractionMixedTarget = string | {
  kind: "favoriters" | "list" | "profile" | "profile_likes" | "profile_media" |
    "profile_replies" | "quotes" | "replies" | "retweeters" | "search" |
    "thread" | "tweet";
  value: string;
};

interface ExtractionRelationTarget {
  relation: "community_members" | "followers" | "following" |
    "list_followers" | "list_members" | "verified_followers";
  value: string;
}

interface CreateExtractionRequest {
  toolType: ExtractionToolType;
  targetTweetId?: string; targetTweetIds?: string[];
  targetUsername?: string; targetUsernames?: string[];
  targetCommunityId?: string; targetCommunityIds?: string[];
  targetListId?: string; targetListIds?: string[];
  targetSpaceId?: string;
  searchQuery?: string; searchQueries?: string[];
  targets?: ExtractionMixedTarget[];
  relationTargets?: ExtractionRelationTarget[];
  resultsLimit: number; // This Skill always sends a finite positive bound.
  queryType?: "Latest" | "Top" | "Both";
  maxItemsPerTarget?: number; maxPagesPerTarget?: number;
  startCursor?: string;
  dedupeAcrossTargets?: boolean;
  dedupeMode?: "none" | "first" | "merge";
  overlapMode?: boolean;
  includeSearchTerms?: boolean; includeTargetMetadata?: boolean;
  collectionStrategy?: "auto" | "complete" | "direct" | "search" | "thread";
  scope?: "all" | "direct" | "nested";
  maxDepth?: number;
  sort?: "relevance" | "latest" | "oldest" | "likes";
  excludeOriginalAuthor?: boolean; includeOriginalPost?: boolean;
  hasMediaOnly?: boolean;
  sinceTime?: string | number; untilTime?: string | number;
  // Used only by tweet_search_extractor.
  fromUser?: string; toUser?: string; mentioning?: string;
  language?: string;
  sinceDate?: string; untilDate?: string; // YYYY-MM-DD
  mediaType?: 'images' | 'videos' | 'gifs' | 'media' | 'links' | 'none';
  minFaves?: number; minRetweets?: number;
  minReplies?: number; minQuotes?: number;
  minViews?: number; minBookmarks?: number;
  maxLikes?: number; maxRetweets?: number;
  maxReplies?: number; maxQuotes?: number;
  blueVerifiedOnly?: boolean;
  cardName?: string;
  source?: string; excludeSource?: string;
  geocode?: string;
  sinceId?: string; maxId?: string;
  near?: string; within?: string; withinTime?: string;
  nativeRetweets?: boolean;
  safe?: boolean;
  news?: boolean;
  verifiedOnly?: boolean;
  replies?: 'include' | 'exclude' | 'only';
  retweets?: 'include' | 'exclude' | 'only';
  quotes?: 'include' | 'exclude' | 'only';
  exactPhrase?: string; excludeWords?: string; anyWords?: string;
  hashtags?: string; cashtags?: string;
  url?: string;
  conversationId?: string; inReplyToTweetId?: string;
  quotesOfTweetId?: string; retweetsOfTweetId?: string;
  listId?: string;
  place?: string; placeCountry?: string;
  pointRadius?: string; boundingBox?: string;
  advancedQuery?: string;
  // Filters for extractions that return profiles.
  minFollowers?: number; maxFollowers?: number;
  minFollowing?: number; maxFollowing?: number;
  minPosts?: number; maxPosts?: number;
  minAccountAgeDays?: number;
  verifiedType?: string;
  hasWebsite?: boolean;
  hasLocation?: boolean;
  bioContains?: string; locationContains?: string; usernameContains?: string;
}

function assertCreateExtractionRequest(request: CreateExtractionRequest): void {
  if (!Number.isFinite(request.resultsLimit) || request.resultsLimit <= 0) {
    throw new TypeError("resultsLimit must be finite and greater than zero.");
  }
}

```
