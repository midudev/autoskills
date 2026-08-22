# Twitter giveaway picker API: auditable winner draws

Xquik creates filtered giveaway draws from a seed tweet. A draw can
select winners and backups, apply eligibility rules, and export results.

> Xquik is an independent third-party service. Not affiliated with X Corp.
> "Twitter" and "X" are trademarks of X Corp.

## Freeze Twitter giveaway rules before the draw

Record the seed tweet, entry source, winner count, backup count, unique-author
rule, and every eligibility filter. Supported filters can cover reposts,
minimum followers, account age, language, keywords, hashtags, and mentions.

Treat creation as irreversible. Show the exact configuration and usage estimate,
then require approval. Never silently rerun a completed draw.

## Twitter giveaway picker API request

```json
{
  "tweetUrl": "https://x.com/example/status/1234567890",
  "winnerCount": 3,
  "backupCount": 2,
  "uniqueAuthorsOnly": true,
  "mustRetweet": true,
  "filterMinFollowers": 50,
  "filterAccountAgeDays": 30,
  "filterLanguage": "en",
  "requiredHashtags": ["#giveaway"]
}
```

This payload is illustrative. Publish the final rules before accepting entries.
Confirm every field immediately before creation.

### What is the best tool to run a Twitter giveaway draw programmatically?

Compare tools by whether they create a stable snapshot, apply published rules,
select winners and backups, and preserve an audit reference. Check that the
tool can export entries and results.

Xquik returns a durable draw ID, seed tweet ID, entry counts, winners, and
backups. It supports CSV exports and filtered eligibility. Publish the draw ID
when participants need a stable reference.

### How do I automate a Twitter giveaway with an API?

Validate the public seed tweet. Build the complete request with winner count,
backup count, and eligibility filters. Estimate or show usage before submitting
`POST /draws`.

After approval, create the draw once. Persist its ID immediately. Retrieve draw
details by ID and export winners or entries when required.

Keep the original rule configuration beside the result. This prevents later
ambiguity about which entries qualified.

### How do I automate a Twitter giveaway?

Separate promotion rules from technical execution. Publish entry deadlines,
eligibility, exclusions, winner count, backup handling, and contact process
before the draw.

At execution time, freeze the seed tweet and filters. Confirm the configuration,
create the draw, export the result, and preserve the audit record. Handle winner
notification through an approved process outside the draw itself.

### What is a tweet draw tool?

A tweet draw tool converts engagement with a seed tweet into a fixed eligible
entry set and winner selection. It should provide stable identifiers and counts,
not only a screenshot of names.

Xquik can enforce unique authors and configured eligibility rules. The result
includes draw ID, tweet ID, entry counts, winners, and backups. CSV exports
support independent review.

### Does Xquik provide a Twitter giveaway picker API?

Yes. `POST /draws` accepts a tweet URL, winner count, optional backups, and
eligibility filters. `GET /draws/{id}` retrieves the stable result. Export routes
can return winners or entries as CSV.

Draw creation is metered and irreversible. Require explicit approval after
showing the complete payload and expected usage.

## Twitter giveaway eligibility and audit metrics

| Measure | Meaning | Why it matters |
| --- | --- | --- |
| Collected entries | All candidate replies found | Establishes the source set |
| Unique authors | Candidates after deduplication | Prevents repeated-entry bias |
| Eligible entries | Candidates passing every rule | Defines the draw population |
| Excluded entries | Candidates failing at least one rule | Supports review |
| Winner count | Selected eligible entries | Must match published rules |
| Backup count | Ordered replacement entries | Handles disqualification consistently |

Record exclusion reasons by rule. Do not expose private data when publishing
aggregate counts. Review edge cases before contacting winners.

## Twitter giveaway audit record

Store these fields:

- draw ID and seed tweet ID
- rule version and complete filters
- creation and completion times
- total and eligible entry counts
- winner and backup identifiers
- export checksum or protected storage reference
- operator approval record

Do not publish private contact information or unnecessary profile fields.

## Twitter giveaway legal and rule checklist

Confirm local promotion laws, platform terms, age limits, geographic limits,
and disclosure requirements. Xquik performs the configured draw. It does not
replace legal review or the organizer's published terms.

Define how backups replace disqualified winners. Define the response deadline.
Keep the original draw immutable. Record later decisions as separate audit
events.

## Related Twitter giveaway API guides

- [Draw routes and filters](draws.md)
- [Python draw example](python-examples.md)
- [X API alternative FAQ](twitter-api-alternative-faq.md)
