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
const apiKey = process.env.XQUIK_API_KEY;
if (!apiKey) throw new Error("Set XQUIK_API_KEY first.");

async function xquikFetch(path, options = {}) {
  const response = await fetch(`${BASE}${path}`, {
    ...options,
    headers: {
      "Content-Type": "application/json",
      "x-api-key": apiKey,
      ...options.headers,
    },
  });
  const body = await response.text();
  if (!response.ok) throw new Error(`Xquik API ${response.status}: ${body}`);
  return body ? JSON.parse(body) : null;
}

const approvalProvider = globalThis.xquikApprovalProvider;
if (typeof approvalProvider !== "function") {
  throw new Error("Configure xquikApprovalProvider before running a draw.");
}

async function requireExplicitApproval(proposal) {
  const approvalScope = structuredClone(proposal);
  if ((await approvalProvider(approvalScope)) !== true) {
    throw new Error("Approval denied.");
  }
  return approvalScope;
}

const drawRequest = {
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
};
const usageLimitation = {
  exactPreflightEstimateAvailable: false,
  billingBasis: "Metered per participant entry.",
};
const approval = await requireExplicitApproval({
  request: drawRequest,
  usageLimitation,
  purpose: "Select 3 winners and 2 backups from eligible replies.",
  dataScope: "Public replies to the source tweet.",
  recipients: ["Giveaway administrator"],
  retention: "Delete the participant export after 30 days.",
});
if (JSON.stringify(approval.request) !== JSON.stringify(drawRequest)) {
  throw new Error("Approved draw request changed. Request approval again.");
}

const draw = await xquikFetch("/draws", {
  method: "POST",
  body: JSON.stringify(drawRequest),
});
if (
  draw === null ||
  typeof draw !== "object" ||
  typeof draw.id !== "string" ||
  !draw.id
) {
  throw new Error("Invalid draw response.");
}

// Get the winners and draw details.
const details = await xquikFetch(`/draws/${draw.id}`);
if (details === null || typeof details !== "object" || !Array.isArray(details.winners)) {
  throw new Error("Invalid draw details response.");
}
// details.winners: [
//   { position: 1, authorUsername: "winner1", tweetId: "...", isBackup: false },
//   ...
// ]

const exportProposal = {
  request: { drawId: draw.id, format: "csv", type: "winners" },
  destination: "Restricted giveaway administration storage.",
  recipients: ["Giveaway administrator"],
  retention: "Delete the export after 30 days.",
};
const approvedExport = await requireExplicitApproval(exportProposal);
if (JSON.stringify(approvedExport) !== JSON.stringify(exportProposal)) {
  throw new Error("Approved draw export changed. Request approval again.");
}
const exportUrl = `${BASE}/draws/${draw.id}/export?format=csv&type=winners`;
```

## Twitter giveaway draw usage

Metered per participant entry.
