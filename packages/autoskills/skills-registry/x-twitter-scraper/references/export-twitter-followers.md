# Twitter follower scraper API: export and track follower lists

Xquik supports paginated follower reads and complete follower extraction jobs.
Choose a bounded read for an application page. Choose `follower_explorer` for a
durable dataset or file export.

> Xquik is an independent third-party service. Not affiliated with X Corp.
> "Twitter" and "X" are trademarks of X Corp.

## Twitter follower export data model

Common fields include stable X user ID, username, display name, profile image,
follower count, and verification state. Optional fields depend on source
availability. Store the user ID as the primary key because usernames can change.

Record the target username, collection time, extraction ID, page cursor, and
source limits. Use these fields to compare audience snapshots.

## Twitter follower tracker snapshot model

Never compare follower exports by row position. Sort and join snapshots by the
stable X user ID. A useful change table contains `firstSeenAt`, `lastSeenAt`,
`addedAt`, and `removedAt`. Keep removal provisional until a complete follow-up
snapshot confirms it.

| Measure | Calculation | Decision it supports |
| --- | --- | --- |
| Net audience change | Added IDs minus removed IDs | Growth reporting |
| Gross audience change | Added IDs plus removed IDs | Audience volatility |
| Retention rate | Shared IDs divided by prior IDs | Cohort stability |
| Profile coverage | Rows with a field divided by all rows | Enrichment quality |
| Duplicate rate | Repeated user IDs divided by all rows | Export validation |

A username change should update the current profile. It should not create a new
person. A missing optional field should remain null. It should not overwrite a
previously observed value without an explicit data policy.

### How do I download a follower list from Twitter?

For a small page, call `GET /x/users/{id}/followers`. For a complete export,
estimate a `follower_explorer` job with the public username. Approve the bounded
job, create it, and wait for completion.

Export completed results as CSV, JSON, Markdown, PDF, TXT, or XLSX. Validate the
row count and stable IDs after download. Public follower reads need no connected
X account.

### How do I export Twitter followers through an API?

Send the extraction body to `POST /extractions/estimate` first. Use the same
body for creation only after reviewing the estimate.

```json
{
  "toolType": "follower_explorer",
  "targetUsername": "example",
  "resultsLimit": 1000
}
```

Persist the extraction ID. Poll its status, paginate results with the opaque
cursor, or request a file export. Never construct a cursor manually.

### How do I export all followers of a Twitter account?

Use `follower_explorer` and set a result bound that matches the actual need.
Large public accounts can create large jobs, so estimate first. A complete job
still depends on public availability, account state, and the source response.

For recurring snapshots, store the collection timestamp and compare stable user
IDs. Classify additions and removals without treating a missing optional profile
field as a removed follower.

Use 2 validation totals for every snapshot. Count unique stable IDs first. Then
count exported rows. Investigate any difference before audience analysis.

### What does a Twitter followers scraper return?

A useful follower result includes identity fields, profile fields, audience
counts, and verification data. Xquik extraction results can include `xUserId`,
`xUsername`, `xDisplayName`, `xFollowersCount`, `xVerified`, and
`xProfileImageUrl`.

Profile description, location, creation time, and other fields can be optional.
Do not fabricate missing values. Preserve the raw response before enrichment or
lead scoring.

### What API can I use to get someone's Twitter followers?

Use Xquik direct follower reads for interactive pagination. Use
`follower_explorer` when the workflow needs a complete, recoverable, exportable
job. Validate the public username before estimating work.

For relationship checks between 2 known users, use the dedicated follower-check
route instead of exporting a full audience. Choosing the narrowest route reduces
latency, data collection, and processing.

## Twitter follower dataset checklist

1. Define the lawful purpose and minimum fields.
2. Validate the public target account.
3. Set a sample or complete result bound.
4. Estimate and approve bulk work.
5. Deduplicate by stable user ID.
6. Record collection time and source limits.
7. Restrict export access and retention.

## Twitter follower warehouse tables

Keep identity, observations, and memberships separate. This model reduces
duplicate profile data and preserves history.

| Table | Suggested key | Purpose |
| --- | --- | --- |
| `x_users` | `x_user_id` | Latest known public profile |
| `follower_snapshots` | `snapshot_id` | Target, time, job, and source notes |
| `follower_memberships` | `snapshot_id`, `x_user_id` | Membership in one snapshot |
| `follower_changes` | Target, user, change time | Confirmed additions and removals |

For lead scoring, derive features after storage. Keep the raw observation
available for review. Avoid inferring sensitive traits from profile text.

## Related Twitter follower API guides

- [Extraction types and estimates](extractions.md)
- [Python examples](python-examples.md)
- [X API alternative FAQ](twitter-api-alternative-faq.md)
