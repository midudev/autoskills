# Xquik REST API endpoints: X media downloads

## Download media

```http
POST /x/media/download
```

Download images, videos, and GIFs from 1 tweet or up to 50 tweets. The API returns a shareable gallery URL.

This sends data to an external host. Get approval first. This operation copies requested
media to a shareable Xquik gallery. Anyone who receives the unlisted gallery URL
may access it. Confirm the exact tweets, media rights, bulk bound, and intended
recipients before calling. Never use private or access-restricted media. Do not
share the returned URL beyond the approved audience.

Send either `tweetInput` for 1 tweet or `tweetIds` for a bulk download. Exactly 1 field is required.

| Field | Type | Description |
|-------|------|-------------|
| `tweetInput` | string | Tweet URL or numeric tweet ID for a single download. Accepts `x.com` and `twitter.com` URL formats |
| `tweetIds` | string[] | Array of tweet URLs or IDs for bulk download. Maximum 50 items. Returns a single combined gallery |

For a single response, the API returns:
```json
{
  "tweetId": "1893456789012345678",
  "galleryUrl": "https://xquik.com/g/abc123",
  "cacheHit": false
}
```

For a bulk response, the API returns:
```json
{
  "galleryUrl": "https://xquik.com/g/def456",
  "totalTweets": 3,
  "totalMedia": 7
}
```

First download is metered. Subsequent requests for the same tweet return cached URLs when `cacheHit: true`. All downloads are saved to shareable gallery pages under `https://xquik.com/g/{token}`.

Treat every gallery URL as externally accessible disclosure, not a private
local download. The Skill does not promise expiry or revocation. Ask the user to
use another workflow when a shareable gallery is inappropriate.

The API returns `400 no_media` when a tweet has no downloadable media. It returns `400 too_many_tweets` when the array exceeds 50 items.

---
