# Xquik extraction tools

Xquik provides 23 bulk data extraction tools. Each tool requires a specific target.

## Privacy and acceptable use

Bulk extraction and export can collect large amounts of public identity,
activity, and relationship data. Before creating a job, confirm the lawful
purpose, target, `resultsLimit`, intended recipients, and retention period.
Follow X rules and applicable privacy law. Do not use these tools for
credential collection, private data, surveillance, discrimination, harassment,
doxxing, or unrelated secondary use. Delete exported data when the approved
purpose ends.

Every extraction requires an estimate and explicit approval for the exact
bounded job. Never infer approval from a general request or increase a bound
without renewed approval.

The API accepts an omitted `resultsLimit`. This Skill must always send an
explicit finite positive bound. Use the same bound for estimate and create.

First send the bounded body to `POST /extractions/estimate`. Review
`creditsRequired`, `creditsAvailable`, and `allowed`. Create nothing when
`allowed` is false. When it is true, show the exact estimate and wait for
explicit approval. Only then send the same body to `POST /extractions`.

## Tool types

### Tweet-based tools

These tools require `targetTweetId`.

| Tool type | Description |
|-----------|-------------|
| `reply_extractor` | Extract users who replied to a tweet |
| `repost_extractor` | Extract users who retweeted a tweet |
| `quote_extractor` | Extract users who quote-tweeted a tweet |
| `thread_extractor` | Extract all tweets in a thread |
| `article_extractor` | Extract article content linked in a tweet |
| `favoriters` | Extract users who favorited a tweet |

For example:

```json
{
  "toolType": "reply_extractor",
  "targetTweetId": "1893704267862470862",
  "resultsLimit": 100
}
```

### User-based tools

These tools require `targetUsername`.

| Tool type | Description |
|-----------|-------------|
| `follower_explorer` | Extract followers of an account |
| `following_explorer` | Extract accounts followed by a user |
| `verified_follower_explorer` | Extract verified followers of an account |
| `mention_extractor` | Extract tweets mentioning an account |
| `post_extractor` | Extract posts from an account |

For example:

```json
{
  "toolType": "follower_explorer",
  "targetUsername": "elonmusk",
  "resultsLimit": 100
}
```

The `@` prefix is automatically stripped if included.

### User timeline tools

These tools require `targetUsername`.

| Tool type | Description |
|-----------|-------------|
| `user_likes` | Extract tweets liked by a user |
| `user_media` | Extract media tweets from a user |

For example:

```json
{
  "toolType": "user_likes",
  "targetUsername": "elonmusk",
  "resultsLimit": 100
}
```

### Community-based tools

These tools require `targetCommunityId`.

| Tool type | Description |
|-----------|-------------|
| `community_extractor` | Extract members of a community |
| `community_moderator_explorer` | Extract moderators of a community |
| `community_post_extractor` | Extract posts from a community |
| `community_search` | Search posts within a community (also requires `searchQuery`) |

For example:

```json
{
  "toolType": "community_extractor",
  "targetCommunityId": "1234567890",
  "resultsLimit": 100
}
```

### List-based tools

These tools require `targetListId`.

| Tool type | Description |
|-----------|-------------|
| `list_member_extractor` | Extract members of a list |
| `list_post_extractor` | Extract posts from a list |
| `list_follower_explorer` | Extract followers of a list |

For example:

```json
{
  "toolType": "list_member_extractor",
  "targetListId": "1234567890",
  "resultsLimit": 100
}
```

### Space-based tools

These tools require `targetSpaceId`.

| Tool type | Description |
|-----------|-------------|
| `space_explorer` | Extract participants of a Space |

For example:

```json
{
  "toolType": "space_explorer",
  "targetSpaceId": "1YqKDqDXAbwKV",
  "resultsLimit": 100
}
```

### Search-based tools

These tools require `searchQuery`.

| Tool type | Description |
|-----------|-------------|
| `people_search` | Search for users by keyword |
| `tweet_search_extractor` | Search and extract tweets by keyword or hashtag |

For a people search:

```json
{
  "toolType": "people_search",
  "searchQuery": "machine learning engineer",
  "resultsLimit": 100
}
```

For a tweet search:

```json
{
  "toolType": "tweet_search_extractor",
  "searchQuery": "#AI",
  "resultsLimit": 100
}
```

### Tweet search filters

`tweet_search_extractor` accepts structured filters. It combines them with
`searchQuery` before collection.

| Field | Type | Description |
|-------|------|-------------|
| `fromUser` | string | Author username |
| `toUser` | string | Directed to user |
| `mentioning` | string | Mentions user |
| `language` | string | Language code (e.g., `en`) |
| `sinceDate` | string | Start date (YYYY-MM-DD) |
| `untilDate` | string | End date (YYYY-MM-DD) |
| `mediaType` | string | `images`, `videos`, `gifs`, `media`, `links`, or `none` |
| `minFaves` | number | Minimum likes |
| `minRetweets` | number | Minimum retweets |
| `minReplies` | number | Minimum replies |
| `minQuotes` | number | Minimum quote count |
| `minViews` | number | Minimum view count |
| `minBookmarks` | number | Minimum bookmark count |
| `maxLikes` | number | Maximum likes |
| `maxRetweets` | number | Maximum reposts |
| `maxReplies` | number | Maximum replies |
| `maxQuotes` | number | Maximum quotes |
| `blueVerifiedOnly` | boolean | Blue-verified authors only |
| `cardName` | string | Match the Tweet card name |
| `source` | string | Match the source application |
| `excludeSource` | string | Exclude a source application |
| `geocode` | string | Match latitude, longitude, and radius |
| `sinceId` | string | Tweets newer than this ID |
| `maxId` | string | Tweets older than this ID |
| `near` | string | Match a place name |
| `within` | string | Radius for the `near` filter |
| `withinTime` | string | Recent time window |
| `nativeRetweets` | boolean | Native reposts only |
| `safe` | boolean | Enable safe search |
| `news` | boolean | News results only |
| `verifiedOnly` | boolean | Verified authors only |
| `replies` | string | `include`, `exclude`, or `only` |
| `retweets` | string | `include`, `exclude`, or `only` |
| `quotes` | string | `include`, `exclude`, or `only` |
| `exactPhrase` | string | Exact match text |
| `excludeWords` | string | Comma-separated words to exclude |
| `anyWords` | string | Terms where any one can match |
| `hashtags` | string | Hashtags separated by spaces, commas, or lines |
| `cashtags` | string | Cashtags separated by spaces, commas, or lines |
| `url` | string | URL substring or domain |
| `conversationId` | string | Conversation ID |
| `inReplyToTweetId` | string | Replies to one Tweet ID |
| `quotesOfTweetId` | string | Quotes of one Tweet ID |
| `retweetsOfTweetId` | string | Reposts of one Tweet ID |
| `listId` | string | Search within a list |
| `place` | string | Search within a place ID |
| `placeCountry` | string | Search within a country code |
| `pointRadius` | string | Geographic point and radius |
| `boundingBox` | string | Geographic bounding box |
| `advancedQuery` | string | Raw X search operators appended to query |

For example, apply filters:

```json
{
  "toolType": "tweet_search_extractor",
  "searchQuery": "AI",
  "fromUser": "elonmusk",
  "minFaves": 100,
  "sinceDate": "2026-01-01",
  "mediaType": "videos",
  "resultsLimit": 500
}
```

The API makes `resultsLimit` optional. This Skill requires a finite positive
value. Pass the same value to `POST /extractions/estimate` and
`POST /extractions`.

### Profile filters

Profile-producing extractions also accept `minFollowers`, `maxFollowers`,
`minFollowing`, `maxFollowing`, `minPosts`, `maxPosts`,
`minAccountAgeDays`, `verifiedType`, `hasWebsite`, `hasLocation`,
`bioContains`, `locationContains`, and `usernameContains`.

## Response

```json
{
  "id": "77777",
  "toolType": "reply_extractor",
  "status": "completed",
  "totalResults": 150
}
```

The status is `pending`, `running`, `completed`, or `failed`.

## Retrieving results

```http
GET /extractions/{id}?limit=1000&cursor=<nextCursor>
```

The endpoint returns up to 1,000 results per page. When `hasMore` is true, send
the returned `nextCursor` unchanged as the next request's `cursor`. Each result
includes:

- `xUserId`, `xUsername`, `xDisplayName`
- `xFollowersCount`, `xVerified`, `xProfileImageUrl`
- `tweetId`, `tweetText`, `tweetCreatedAt` (for tweet-based extractions)

## Exporting results

```http
GET /extractions/{id}/export?format=csv
```

Choose `csv`, `json`, `md`, `md-document`, `pdf`, `txt`, or `xlsx`. Exports support 100,000 rows, except PDF supports 10,000.

Exports include enrichment columns not present in the API response.

The endpoint supports follower, following, post, engagement, profile, media,
language, search, and date filters. It does not project individual fields.

Get approval first. Set the smallest approved `resultsLimit` when creating
the job. Before export, show the job, filters, format, row count, schema,
recipients, storage, and retention. Materialize or transmit the dataset only
after explicit approval. Delete it when the approved purpose ends.

## Estimating usage

```http
POST /extractions/estimate
```

Same body as create. Response:

```json
{
  "allowed": true,
  "source": "replyCount",
  "estimatedResults": 150,
  "creditsRequired": "150",
  "creditsAvailable": "50000"
}
```

If `allowed` is `false`, do not create the extraction. The current balance does
not cover the estimate.

For common mistakes and tool selection rules, see [mcp-tools.md](mcp-tools.md#common-mistakes).
