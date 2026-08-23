# Xquik REST API endpoints: extractions

## Protect extracted data

Extraction creation and export can collect and disclose large datasets. First
confirm the lawful purpose, exact target, `resultsLimit`, recipients, and
retention period. Estimate usage, show the estimate, and obtain explicit
approval for that exact bounded job. Never use extraction for private data,
surveillance, discrimination, harassment, doxxing, or unrelated secondary use.
Extraction history and results are account-scoped private reads. Require
exact-scope approval before listing jobs or retrieving results.

## Create extraction

```http
POST /extractions
```

Run a bulk data extraction job. See `references/extractions.md` for all 23 tools.

Build the exact creation body first. Send that body to the estimate endpoint
before requesting creation approval. Show the returned usage and stop when
`allowed` is not `true`. Then require approval for the exact target, bound,
estimated usage, recipients, and data-handling plan. Create only after approval.

Send this body:
```json
{
  "toolType": "reply_extractor",
  "targetTweetId": "1893704267862470862",
  "resultsLimit": 500
}
```

The API accepts an omitted `resultsLimit`. This Skill must always send an
explicit finite positive bound. The bound stops early and limits usage.

The request accepts single or batch targets, mixed targets, relation targets,
deduplication controls, output metadata, and current result filters. See
[Extraction Tools](extractions.md) and the OpenAPI schema. Send the same body
to estimate and create.

The API returns:
```json
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "toolType": "reply_extractor",
  "status": "running"
}
```

## Estimate extraction

```http
POST /extractions/estimate
```

Preview usage before running. Same body as create.

The API returns:
```json
{
  "allowed": true,
  "creditsAvailable": "50000",
  "creditsRequired": "150",
  "source": "replyCount",
  "estimatedResults": 150
}
```

## List extractions

```http
GET /extractions
```

Cursor-paginated. Use `limit` from 1 to 100, plus `after`, `status`, and
`toolType`. A page returns `extractions`, `hasMore`, and optional `nextCursor`.
Pass each `nextCursor` unchanged as the next request's `after` value while
`hasMore` is true.

```javascript
const params = new URLSearchParams({ limit: "100" });
if (typeof nextCursor === "string" && nextCursor) {
  params.set("after", nextCursor);
}
const page = await xquikFetch(`/extractions?${params}`);
```

This is a private read. Show the exact account, purpose, requested filters, and page
scope. Also show recipients and the retention plan. List jobs only
after explicit approval for that exact read.

## Get extraction

```http
GET /extractions/{id}
```

Returns job details with up to 1,000 results per page.
Use `limit` from 1 to 1,000 and `after`. The response contains `job`,
`results`, `hasMore`, and optional `nextCursor`. Pass `nextCursor` as `after`
for the next page. Optional result-shaping parameters are `outputMode`,
`outputPreset`, and `fieldStyle`. `includeRaw` is deprecated.

```javascript
const params = new URLSearchParams({ limit: "1000" });
if (typeof nextCursor === "string" && nextCursor) {
  params.set("after", nextCursor);
}
const page = await xquikFetch(`/extractions/${extractionId}?${params}`);
```

This is a private read. Show the exact account, job ID, purpose, and page scope. Also
show recipients and the retention plan. Retrieve results only after
explicit approval for that exact read.

## Export extraction

```http
GET /extractions/{id}/export?format=csv
```

Choose `csv`, `json`, `md`, `md-document`, `pdf`, `txt`, or `xlsx`.
Exports can include enrichment columns not present in paginated API results.

Use documented row filters for follower, following, post, engagement, profile,
media, language, search, and date fields. The endpoint does not project fields.

Get approval first. Show the job, filters, format, row count, schema,
recipients, storage, and retention. Create or send the export only
after explicit approval.

---
