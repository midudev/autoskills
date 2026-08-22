# Xquik TypeScript types: X API

```typescript

interface TweetMediaItem {
  mediaUrl: string;
  type: "photo" | "video" | "animated_gif";
  url: string;
  adultContent?: boolean; allowDownload?: boolean;
  altText?: string; availabilityReason?: string;
  aspectRatio?: number[]; availabilityStatus?: string;
  description?: string; displayUrl?: string;
  durationMillis?: number; expandedUrl?: string;
  embeddable?: boolean;
  faceRects?: Record<string, unknown>; focusRects?: Array<Record<string, number>>;
  grokPostId?: string; height?: number; id?: string;
  indices?: number[];
  mediaKey?: string; monetizable?: boolean;
  sizes?: Record<string, unknown>;
  sourceStatusId?: string; sourceUserId?: string;
  tags?: Array<Record<string, string>>;
  title?: string;
  videoVariants?: Array<Record<string, unknown>>;
  watchNowUrl?: string; visitSiteUrl?: string;
  width?: number;
}

interface Tweet {
  id: string;
  text: string;
  author?: TweetAuthor;
  createdAt?: string;
  inReplyToId?: string;
  retweetCount: number;
  replyCount: number;
  likeCount: number;
  quoteCount: number;
  viewCount: number;
  bookmarkCount: number;
  media?: TweetMediaItem[];
  article?: Record<string, unknown>;
  card?: Record<string, unknown>;
  communityNote?: Record<string, unknown>;
  edit?: Record<string, unknown>;
  isTranslatable?: boolean;
  noteTweet?: Record<string, unknown>;
  place?: Record<string, unknown>;
  possiblySensitive?: boolean;
  previousCounts?: Record<string, number>;
  viewState?: string;
}

interface ProfileRichness {
  affiliatesHighlightedLabel?: Record<string, unknown>;
  businessAccountAffiliatesCount?: number; creatorSubscriptionsCount?: number;
  hasGraduatedAccess?: boolean;
  hasHiddenSubscriptionsOnProfile?: boolean;
  highlightsInfo?: Record<string, unknown>; identityVerification?: Record<string, unknown>;
  isProfileTranslatable?: boolean;
  parodyCommentaryFanLabel?: string;
  profileDescriptionLanguage?: string; profileImageShape?: string;
  profileInterstitialType?: string; profileSortEnabled?: boolean;
  profileTranslatorType?: string;
  superFollowEligible?: boolean;
  withheldScope?: string; professional?: Record<string, unknown>;
  grokTranslatedBio?: Record<string, unknown>;
  superFollowsUserProfileActive?: boolean;
  tipJar?: Record<string, unknown>;
}

interface TweetAuthor extends ProfileRichness {
  id: string;
  username: string;
  name: string;
  followers: number;
  verified: boolean;
  profilePicture?: string;
}

interface TweetSearchResult {
  id: string;
  text: string;
  createdAt?: string;
  likeCount: number;    // Zero can mean X did not report the count
  retweetCount: number; // Zero can mean X did not report the count
  replyCount: number;   // Zero can mean X did not report the count
  media?: TweetMediaItem[];
  author?: UserProfile;
}

interface UserProfile extends ProfileRichness {
  id: string; username: string; name: string;
  description?: string;
  followers?: number; following?: number; verified?: boolean;
  profilePicture?: string; location?: string; createdAt?: string;
  statusesCount?: number;
}

interface FollowerCheck {
  sourceUsername: string;
  targetUsername: string;
  isFollowing: boolean;
  isFollowedBy: boolean;
}

interface ReplyCoverageDiagnostic {
  complete: boolean;
  reportedReplyCount: number;
  targetDirectReplies: number;
  uniqueDirectReplies: number;
  coveragePercentage: number;
  nestedReplyCount: number;
  pagesAttempted: number;
  strategiesAttempted: Array<Record<string, unknown>>;
  duplicateCount: number;
  cursorFailures: number;
  repeatedCursorCount: number;
  emptyFalseProgressPages: number;
  malformedCount: number;
  unrelatedCount: number;
  missingResponseModulesOrFields: string[];
  recommendedFallback: string;
  richness: Record<string, number>;
  responseTruncated: boolean;
}

interface TweetReplies {
  tweets: Tweet[];
  nested_replies: Tweet[];
  has_next_page: boolean;
  next_cursor: string;
  diagnostic?: ReplyCoverageDiagnostic;
}

```

Optional fields appear only when X supplies them. Never infer missing values.
Fetching-account action and permission state stays private. Follow-relationship
state appears only through an explicitly requested
`GET /api/v1/x/followers/check` lookup.

Use `mode=complete&limit=25000` for bounded maximum-coverage reply collection.
Count direct replies only when `inReplyToId` equals the root tweet ID. Keep
`nested_replies` separate. On `424 replies_incomplete`, retain safe partial rows
and follow `diagnostic.recommendedFallback`.
