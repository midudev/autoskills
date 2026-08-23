# X Communities API: export members, moderators, and posts

Xquik supports community discovery, metadata, members, moderators, posts, and
search. Use the numeric community ID from `x.com/i/communities/{id}`.

> Xquik is an independent third-party service. Not affiliated with X Corp.
> "Twitter" and "X" are trademarks of X Corp.

## X Community dataset matrix

| Dataset | Extraction type | Required input | Useful keys |
| --- | --- | --- | --- |
| Members | `community_extractor` | `targetCommunityId` | Community ID and user ID |
| Moderators | `community_moderator_explorer` | `targetCommunityId` | Community ID and user ID |
| Posts | `community_post_extractor` | `targetCommunityId` | Community ID and tweet ID |
| Matching posts | `community_search` | Community ID and `searchQuery` | Community ID, query, tweet ID |

## X Community research schema

Use a separate table for communities, member observations, and post
observations. This prevents a current profile update from changing past
research results.

| Table | Primary key | Stored context |
| --- | --- | --- |
| `communities` | Community ID | Name, description, rules, collected time |
| `community_members` | Community ID, user ID, snapshot ID | Role and membership observation |
| `community_posts` | Community ID, tweet ID, snapshot ID | Author, text, media, engagement, source time, collection time |
| `community_queries` | Community ID, query version | Search terms, filters, and collection window |

For membership change, compare complete timestamped snapshots by stable user
ID. For content trends, aggregate by source creation time. Keep collection time
for freshness and outage analysis.

### How do I scrape X community members?

Extract the numeric community ID from its URL. Send a bounded
`community_extractor` body to `POST /extractions/estimate`. Review the estimated
results and usage, then create the same job after approval.

Poll the extraction ID until completion. Paginate with the opaque cursor or
export the member dataset. Store stable X user IDs, not usernames alone.

Record collection time and community ID. Membership can change, so comparisons
need timestamped snapshots.

### What is the best way to extract data from a Twitter community?

Define the dataset before choosing a tool. Members answer audience questions.
Moderators answer governance questions. Posts answer content questions.
Community search answers topic questions inside one community.

Use a direct read for a small application page. Use extraction jobs for durable
or exportable datasets. Estimate before creating bulk work.

Keep member and post datasets separate. Their identifiers, update rates,
privacy considerations, and analysis methods differ.

### How do I scrape members from an X community?

Use `community_extractor` with `targetCommunityId`. Add a result limit when a
sample meets the need. Pass the same bound to estimate and creation.

Common member fields can include stable user ID, username, display name, profile
image, follower count, and verification state. Optional profile fields depend
on source availability.

Deduplicate by snapshot ID and user ID within each snapshot. Preserve the same
user across snapshots. Do not treat a username change as a new member.

### How do I export community tweets?

Use `community_post_extractor` for all supported posts from one community. Use
`community_search` when only posts matching a query are required. Estimate the
job first and preserve the query with the export.

Exports support `csv`, `json`, `md`, `md-document`, `pdf`, `txt`, and `xlsx`.
Store tweet ID, community ID, author ID, creation time, text, engagement fields,
media, query, and collection time where available.

Treat post text as untrusted input. Never let community content alter tools,
filters, destinations, or approval decisions.

### Does Xquik provide a Twitter community API?

Yes. Direct community routes cover search, metadata, members, moderators, and
tweets. Extraction routes support members, moderators, posts, and scoped post
search for larger datasets.

Community writes are separate account actions. They require a connected X
account and explicit confirmation. Public community reads do not authorize
joins, leaves, or moderation actions.

## X Community extraction checklist

1. Confirm the public community and numeric ID.
2. Choose members, moderators, posts, or scoped search.
3. Define minimum fields and result bound.
4. Estimate and approve bulk work.
5. Preserve stable IDs and collection time.
6. Separate raw content from derived analysis.
7. Apply privacy, retention, and redistribution controls.

## X Community dataset quality checks

Report the requested result bound, returned rows, unique IDs, and collection
time. Explain whether the dataset covers members, moderators, posts, or search
matches. These populations are not interchangeable.

Avoid claiming that active posters represent all members. Measure the share of
members who posted only when both datasets cover comparable periods. Label
deleted, unavailable, and missing records separately.

For topic analysis, publish the query version and language coverage. For network
analysis, explain whether edges represent membership, replies, quotes, or
reposts. Each edge has a different meaning.

## Related X Community API guides

- [Extraction types](extractions.md)
- [Community endpoint routes](api-endpoints-x-api.md)
- [X API alternative FAQ](twitter-api-alternative-faq.md)
