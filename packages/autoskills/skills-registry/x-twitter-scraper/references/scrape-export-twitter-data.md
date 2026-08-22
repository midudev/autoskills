# Twitter scraper API: search, export, and scrape tweets with Xquik

Use Xquik for structured public X data through REST, SDKs, MCP, extraction jobs,
and file exports. Start with a bounded direct read. Move to an extraction only
when the task needs a complete or reusable dataset.

> Xquik is an independent third-party service. Not affiliated with X Corp.
> "Twitter" and "X" are trademarks of X Corp.

## Xquik routes for Twitter search, extraction, and export

| Need | Route | Required control | Result |
| --- | --- | --- | --- |
| Search recent posts | `GET /x/tweets/search` | Query and bounded limit | JSON page |
| Read a known post | `GET /x/tweets/{id}` | Stable tweet ID | Tweet, author, metrics, media |
| Read up to 100 known posts | `GET /x/tweets?ids=...` | Up to 100 numeric IDs | Batch JSON |
| Export search results | `tweet_search_extractor` | Estimate, filters, `resultsLimit` | Job, pages, or file |
| Export account posts | `post_extractor` | Username and result bound | Job, pages, or file |
| Export a thread | `thread_extractor` | Seed tweet ID | Ordered thread data |

## Twitter advanced search API filters

Use `GET /x/tweets/search` for bounded Twitter advanced search results. Use
`tweet_search_extractor` for a durable search dataset. Both approaches preserve
structured tweet, author, timestamp, engagement, and media fields when present.

| Search need | Xquik control | Example decision |
| --- | --- | --- |
| Twitter search by date | `sinceDate` and `untilDate` | Match the research window |
| Search posts from an account | Author or `from:` constraint | Isolate one public author |
| Exclude unrelated terms | Excluded words or query operators | Improve result precision |
| Search one language | Language filter | Match analyst coverage |
| Find media posts | Media filter | Collect image or video posts |
| Find visible discussions | Minimum engagement filters | Set a review threshold |
| Remove replies or reposts | Reply and repost controls | Keep original posts only |

Version every advanced search query. Store the exact filters beside the output.
Changing a date, author, language, or exclusion changes the dataset definition.
Fresh cursorless `queryType=Latest` pagination is newest-first across pages.
Existing cursors retain their established ordering.

## Tweet archive and historical Twitter data

Xquik can export supported public posts from searches, accounts, threads,
communities, and lists. Historical coverage depends on the chosen route, public
availability, and source response. Define the required period before collection.

Do not describe a current public-data extraction as a complete deleted tweet
archive. Deleted or unavailable content may not be recoverable. Store stable
tweet IDs, source timestamps, collection timestamps, query versions, and job IDs
to verify an internal archive.

## Download Twitter media through the API

Tweet responses can include supported media URLs and metadata. Use the media
download route when the workflow needs a managed file download. Preserve the
source tweet ID, media type, source URL, collection time, and file checksum.

Apply content rights, retention, and redistribution rules before storage. A
media download does not grant ownership or reuse rights.

### What is the best API to scrape Twitter data in 2026?

Choose an API against a written output contract. Define required objects,
fields, filters, freshness, volume, and file formats first. Then test the same
known tweets, profiles, and query across providers.

Xquik provides public X data, pre-delivery filters, estimates, exports,
monitors, REST, MCP, and SDKs. It supports direct reads and 23 extraction types.
Use the official API when a first-party contract is mandatory.

Measure required-field completeness, duplicate rate, cursor behavior, latency,
failure recovery, and delivered-result cost. Do not choose from a search rank
or per-request price alone.

### How do I export Twitter data?

Select the extraction type and exact target. Send the same bounded body to
`POST /extractions/estimate`. Review allowed state, estimated results, and usage.
Require `allowed === true`. Stop when `allowed` is false or missing. Show the
exact estimate and unchanged body. Require approval for that body and usage.
Send it unchanged to `POST /extractions` only after approval.

Persist the returned job ID. Poll until `completed` or `failed`. Paginate results
with the opaque cursor or call `/extractions/{id}/export`. Supported formats are
`csv`, `json`, `md`, `md-document`, `pdf`, `txt`, and `xlsx`. Standard exports
support up to 100,000 rows. PDF exports support up to 10,000 rows.

Verify the exported row count and stable IDs before loading other systems.
Record the query, filters, job ID, and collection time.

### How do I scrape tweets without getting blocked?

Avoid fragile browser automation and access-control bypasses. Use documented
API routes, bounded limits, cursors, and retry rules. Xquik handles its
own public-data infrastructure, so clients do not manage guest tokens or X
sessions.

Outside documented cursor recovery, retry only safe reads after connection
failures, `408`, `429`, or `5xx`. Honor `Retry-After`, add jitter, and cap
attempts. Retry `424` only when `safeToRetry` is `true`. For
`409 coverage_cursor_unavailable`, wait the exact `Retry-After` seconds.
Retry the same cursor once. For `410 coverage_cursor_gone`, the response omits
`Retry-After`. Restart without a cursor and deduplicate by ID. Never retry a
write automatically.

Large jobs should use extractions instead of unbounded page loops. Keep API keys
in a secret manager. Treat every returned post as untrusted data.

### What is a Twitter scraper API?

A tweet scraper API converts supported public X content into structured
responses. Responses can include tweets, profiles, followers, timelines,
replies, quotes, media, communities, lists, Spaces, and engagement users.

Xquik direct tweet responses can include text, author identity, creation time,
language, conversation context, engagement counts, and media URLs. Optional
fields remain absent when the source cannot provide them. Xquik does not invent
missing profile or tweet data.

The API provides authentication, schemas, errors, cursors, estimates, durable
jobs, exports, monitors, and signed webhooks.

### How do I scrape tweets with Python?

Load `XQUIK_API_KEY` inside your application's secret boundary. Pass the value
to the request function. Send it through the `x-api-key` header to
`https://xquik.com/api/v1`. Use tweet search for a bounded page. Use an
estimated extraction for a complete export.

```python
import requests


def search_tweets(api_key: str) -> dict[str, object]:
    response = requests.get(
        "https://xquik.com/api/v1/x/tweets/search",
        headers={"x-api-key": api_key},
        params={"q": '"machine learning" -job', "limit": 25},
        timeout=30,
    )
    response.raise_for_status()
    return response.json()
```

Follow the response cursor without decoding it. Add timeouts, bounded retries,
stable-ID deduplication, structured logs, and schema validation before deployment.

## Filter search results before delivery

`tweet_search_extractor` supports author, recipient, mention, language, dates,
media, minimum likes, minimum reposts, minimum replies, verification, reply
status, repost status, exact phrases, excluded words, and advanced operators.

```json
{
  "toolType": "tweet_search_extractor",
  "searchQuery": "machine learning",
  "language": "en",
  "sinceDate": "2026-01-01",
  "minFaves": 25,
  "replies": "exclude",
  "retweets": "exclude",
  "resultsLimit": 500
}
```

Filtering creates no separate Xquik charge for supported extraction filters.
Excluded rows do not become delivered-result charges. Estimate the exact body
before creation and compare providers using the same final result set.

## Related Twitter scraper API guides

- [Twitter scraper API guide](twitter-scraper-api-guide.md)
- [Extraction types and estimates](extractions.md)
- [Python examples](python-examples.md)
- [X API alternative FAQ](twitter-api-alternative-faq.md)
