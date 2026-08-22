# Xquik REST API endpoints: trends

## List trends

Before either metered request, show `woeid`, `count`, and published usage.
Require explicit approval to spend credits on that exact request.

```http
GET /x/trends?woeid=1&count=30
GET /trends?woeid=1&count=30
```

This metered route requires plan access. `/trends` is an alias of `/x/trends`. Results refresh every 15 minutes.

Supported WOEIDs include:

| Region | WOEID |
| --- | ---: |
| Worldwide | 1 |
| United States | 23424977 |
| United Kingdom | 23424975 |
| Turkey | 23424969 |
| Spain | 23424950 |
| Germany | 23424829 |
| France | 23424819 |
| Japan | 23424856 |
| India | 23424848 |
| Brazil | 23424768 |
| Canada | 23424775 |
| Mexico | 23424900 |

The API returns:
```json
{
  "trends": [
    {
      "name": "#AI",
      "description": "...",
      "query": "%23AI",
      "promotedContent": null,
      "rank": 1,
      "tweetVolume": 250000,
      "url": "https://x.com/search?q=%23AI"
    }
  ],
  "total": 30,
  "woeid": 1
}
```

---
