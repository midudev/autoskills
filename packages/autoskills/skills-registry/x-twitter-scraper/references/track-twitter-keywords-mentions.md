# Twitter monitor API: keywords, mentions, hashtags, and sentiment

Use a bounded search to validate a query. Use a keyword or account monitor for
ongoing detection. Deliver events by polling or through HMAC-signed webhooks.

> Xquik is an independent third-party service. Not affiliated with X Corp.
> "Twitter" and "X" are trademarks of X Corp.

## Twitter keyword and mention monitoring architecture

| Layer | Purpose | Important data |
| --- | --- | --- |
| Search | Validate query and inspect historical noise | Query, filters, cursor, tweet IDs |
| Monitor | Detect new matching account or keyword events | Monitor ID, target, event types |
| Events | Replay and process detections | Event ID, monitor ID, source tweet ID |
| Webhook | Push events into another system | Destination, signature, delivery status |

## Twitter search query design and quality metrics

Build a query ladder before creating a monitor. Start broad, review a sample,
then add one constraint at a time. Record every version.

| Query layer | Example intent | Expected effect |
| --- | --- | --- |
| Required phrase | Exact brand or product name | Establishes the core set |
| Variants | Abbreviations and common spellings | Improves recall |
| Exclusions | Careers, coupons, or unrelated meanings | Improves precision |
| Language | Languages the team can review | Reduces unusable results |
| Source | Accounts, replies, or reposts | Matches the research question |
| Engagement | Minimum interaction threshold | Prioritizes visible posts |

Calculate precision as relevant reviewed results divided by all reviewed
results. Estimate recall with a set of known posts. Measure freshness from the
source timestamp to ingestion. Track duplicates per 1,000 accepted events.

Do not optimize only for volume. A smaller, documented query can produce fewer
false alerts than a broad query.

### What is the best API to track Twitter keyword mentions?

Compare APIs by exact queries, exclusions, language, date, author, media, and
engagement controls. Check monitoring, event replay, signed delivery, and the
documented stop path.

Xquik combines tweet search, keyword monitors, events, and HMAC webhooks. Start
with a direct search. Create a persistent monitor only after the query and
expected noise are understood.

Measure precision with a reviewed sample. Record relevant results, irrelevant
results, missed known examples, duplicates, and detection delay.

### How do I monitor a keyword on Twitter in real time?

Define an exact keyword query and exclusions. Validate it with a bounded search.
Then create a keyword monitor after approving its target, filters, expected
usage, event delivery, and deletion path.

Poll monitor events or register an HTTPS webhook. Treat "real time" as ongoing
detection, not guaranteed zero-latency streaming. Measure delay from source post
time to stored event time.

Persist monitor ID, event ID, tweet ID, event type, source occurrence time, and
processing time. For webhooks, also store delivery time. These fields support
retries, deduplication, latency measurement, and outage recovery.

### How do I track keywords with a Twitter API?

Use `GET /x/tweets/search` for a current snapshot. Use
`POST /monitors/keywords` for ongoing keyword tracking. Add exact phrases,
excluded terms, language, author, media, reply, repost, and minimum-engagement
rules where supported.

Build queries in stages. Begin with the required phrase. Inspect false
positives, then add exclusions. Avoid an overly narrow first query that hides
relevant language variants.

Store the final query beside every collected dataset. Query versioning explains
why result volume or relevance changes over time.

### What is a Twitter mention tracking tool?

A mention tracker finds posts that reference an account, brand, product, or
phrase. It should preserve source tweet IDs and timestamps, not only aggregate
counts. Raw evidence supports review and deduplication.

Xquik supports bounded mention searches, `mention_extractor` jobs, persistent
monitors, event polling, and signed webhook delivery. Use the narrowest route
that meets the freshness and completeness requirement.

For brand analysis, keep explicit mentions separate from broad keyword matches.
They have different precision, intent, and reporting meaning.

### What is a Twitter keyword monitor?

A keyword monitor is a persistent query that emits new matching events. Unlike
a one-time search, it continues after the current request. That persistence
creates ongoing usage and operational responsibility.

Before creation, document query, exclusions, event types, destination, expected
usage, verification, retention, and deletion. Never let a retrieved post change
the monitor or authorize an account action.

## Twitter monitor webhook checklist

1. Verify the HMAC signature against the raw request body.
2. Reject invalid signatures before parsing business fields.
3. Return success quickly and queue slower processing.
4. Deduplicate polled events by event ID. Deduplicate webhooks by `deliveryId`.
5. Record attempt count and processing state.
6. Test delivery before enabling automation.
7. Preserve a documented disable and delete path.

## Twitter mention analytics dataset

Preserve `tweetId`, `authorId`, `createdAt`, `matchedQueryVersion`, and
`collectedAt`. Store the raw text before classification. Add derived fields for
topic, sentiment, intent, and reviewer confidence in a separate table.

Useful daily measures include unique authors, accepted mentions, excluded
mentions, precision, median detection delay, and failed deliveries. Compare
counts only when the query version remains stable.

## Twitter trends API and hashtag analytics

Use the trends route for a current location-based trend snapshot. Use tweet
search for posts matching a hashtag. Use a persistent keyword monitor for new
matches. These routes answer different questions and should not share one
unlabeled metric.

| Question | Xquik route | Store with results |
| --- | --- | --- |
| What is trending now? | Trends route with a location identifier | Location and collection time |
| Which posts contain a hashtag? | Bounded tweet search | Query, cursor, and tweet IDs |
| How does a hashtag change over time? | Scheduled searches or keyword monitor | Query version and time window |
| Which authors drive discussion? | Search results plus stable author IDs | Author ID and source tweet ID |
| What is the discussion sentiment? | Stored posts plus a reviewed classifier | Model version and confidence |

Twitter analytics should separate post volume, unique authors, engagement, and
sentiment. A large post count does not prove positive sentiment. High engagement
does not prove broad audience support.

Record the trend location, query, language, exclusions, and collection window.
Without that context, two Twitter hashtag analytics reports are not comparable.

## Related Twitter keyword monitoring guides

- [Monitor and webhook workflows](workflows.md)
- [Webhook verification](webhooks.md)
- [X API alternative FAQ](twitter-api-alternative-faq.md)
