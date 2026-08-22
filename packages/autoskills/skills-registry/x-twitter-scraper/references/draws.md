# Xquik giveaway draws

Run giveaway draws from tweet replies with explicit filters and a stable draw ID.

## Create draw

Call `POST /draws` with a required `tweetUrl` and optional filters:

Before the call, show the exact tweet, filters, estimated entries, intended
audience, and retention period. Wait for explicit approval for that bounded
draw.

| Field | Type | Description |
|-------|------|-------------|
| `tweetUrl` | string | Required full tweet URL, such as `https://x.com/user/status/ID` |
| `winnerCount` | number | Winners to select; defaults to 1 |
| `backupCount` | number | Backup winners to select |
| `uniqueAuthorsOnly` | boolean | Count only one entry per author |
| `mustRetweet` | boolean | Require participants to have retweeted |
| `mustFollowUsername` | string | Username participants must follow |
| `filterMinFollowers` | number | Minimum follower count |
| `filterAccountAgeDays` | number | Minimum account age in days |
| `filterLanguage` | string | Language code, such as `"en"` |
| `requiredKeywords` | string[] | Words that must appear in the reply |
| `requiredHashtags` | string[] | Required hashtags, such as `["#giveaway"]` |
| `requiredMentions` | string[] | Required usernames, such as `["@xquik"]` |

## Create and review a draw

```javascript
const BASE = "https://xquik.com/api/v1";

function requireExplicitApproval(scope) {
  throw new Error(`Approval required for ${scope}. Implement the approval gate first.`);
}

requireExplicitApproval(
  "the tweet, filters, estimated entries, intended audience, and retention period",
);

// Create a filtered draw.
const draw = await xquikFetch("/draws", {
  method: "POST",
  body: JSON.stringify({
    tweetUrl: "https://x.com/burakbayir/status/1893456789012345678",
    winnerCount: 3,
    backupCount: 2,
    uniqueAuthorsOnly: true,
    mustRetweet: true,
    mustFollowUsername: "burakbayir",
    filterMinFollowers: 50,
    filterAccountAgeDays: 30,
    filterLanguage: "en",
    requiredHashtags: ["#giveaway"],
  }),
});

// Get the winners and draw details.
const details = await xquikFetch(`/draws/${draw.id}`);
// details.winners: [
//   { position: 1, authorUsername: "winner1", tweetId: "...", isBackup: false },
//   ...
// ]

// Approve the exact format, audience, and retention before materializing it.
requireExplicitApproval("the draw export format, audience, and retention period");
const exportUrl = `${BASE}/draws/${draw.id}/export?format=csv`;
```

## Twitter giveaway draw usage

Metered per participant entry.
