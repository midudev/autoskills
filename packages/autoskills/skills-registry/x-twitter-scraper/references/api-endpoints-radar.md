# Xquik REST API endpoints: radar

## List radar items

```http
GET /radar
```

Get trending topics and news from supported trend and news sources.

Use these query parameters:

| Parameter | Type | Description |
|-------|------|-------------|
| `after` | string | Previous `nextCursor` |
| `source` | string | `github`, `google_trends`, `hacker_news`, `polymarket`, `reddit`, `trustmrr`, or `wikipedia` |
| `category` | string | `general`, `tech`, `dev`, `science`, `culture`, `politics`, `business`, or `entertainment` |
| `limit` | number | Items per page from 1-100; defaults to 50 |
| `hours` | number | Look-back window from 1-72 hours; defaults to 6 |
| `region` | string | `US`, `GB`, `TR`, `ES`, `DE`, `FR`, `JP`, `IN`, `BR`, `CA`, `MX`, or `global`; defaults to `global` |

Pass `nextCursor` as `after` for the next page:

```javascript
const originalQuery = new URLSearchParams({
  source: "hacker_news",
  category: "tech",
  limit: "50",
  hours: "6",
  region: "global",
});
const query = new URLSearchParams(originalQuery);
query.set("after", nextCursor);
const nextPath = `/radar?${query}`;
```

The API returns:
```json
{
  "items": [
    {
      "id": "12345",
      "title": "Claude 4.6 released",
      "description": "Anthropic releases Claude 4.6.",
      "url": "https://example.com/article",
      "imageUrl": "https://example.com/image.png",
      "source": "hacker_news",
      "sourceId": "hn_12345",
      "category": "tech",
      "region": "global",
      "language": "en",
      "score": 450,
      "metadata": { "points": 450, "numberComments": 132, "author": "pgdev" },
      "publishedAt": "2026-03-05T10:00:00.000Z",
      "createdAt": "2026-03-05T10:05:00.000Z"
    }
  ],
  "hasMore": true,
  "nextCursor": "NDUwfDIwMjYtMDMtMDRUMDg6MzA6MDAuMDAwWnwxMjM0NQ=="
}
```

Each item contains `id`, `title`, `source`, `sourceId`, `category`, `region`, `language`, `score`, `metadata`, `publishedAt`, and `createdAt`. It may include `description`, `url`, and `imageUrl`. The response also returns `hasMore` and `nextCursor`.

---
