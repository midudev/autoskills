# Twitter account monitor API: HMAC webhook alerts

Xquik account monitors can detect new tweets, replies, quotes, and reposts.
Keyword monitors detect new matches for a persistent query. Poll events or push
them to an HTTPS endpoint through HMAC-signed webhooks.

> Xquik is an independent third-party service. Not affiliated with X Corp.
> "Twitter" and "X" are trademarks of X Corp.

## Twitter monitor event and delivery data

| Object | Fields to preserve |
| --- | --- |
| Account monitor | Monitor ID, username, event types, active state |
| Keyword monitor | Monitor ID, query, event types, active state |
| Event | Event ID, monitor ID and type, event type, occurrence time, data |
| Delivery | Delivery ID, stream event ID, attempts, status, delivery time |

## Twitter monitor polling versus webhook delivery

| Requirement | Poll events | Webhook delivery |
| --- | --- | --- |
| Simple scheduled batch | Use polling | Optional |
| Low detection delay | Poll more often | Use webhooks |
| Recover after downtime | Resume with the stored cursor | Inspect delivery status, then repoll events |
| Public HTTPS endpoint | Not required | Required |
| Signature verification | Not applicable | Required |
| Backpressure control | Caller controls fetch rate | Receiver must queue work |

Both models need idempotency. Persist the event before processing it.
Mark completion only after every required side effect succeeds.

### What is the best way to monitor a Twitter account programmatically?

Validate the public account and required event types first. Use a bounded
timeline read for an initial snapshot. Create a persistent account monitor only
after reviewing target, filters, ongoing usage, delivery, and deletion.

Poll events when the application controls scheduling. Use webhooks when low
detection delay matters. Measure delay, duplicate deliveries, missed known
events, retry behavior, and outage recovery.

### How do I monitor Twitter mentions?

Use a mention search or `mention_extractor` for a bounded historical dataset.
Use a keyword or account monitor for new mention events. Keep explicit account
mentions separate from broad brand keyword matches.

Add exact phrases, exclusions, language, author, and engagement rules to improve
precision. Review a sample and version every query change.

### What are Twitter webhook alerts?

Webhook alerts are HTTPS POST requests sent when a monitor creates a matching
event. Xquik signs each delivery with a per-webhook HMAC secret. The secret is
shown only once and should enter a secret store immediately.

Verify `<timestamp>.<nonce>.<raw body>` with `X-Xquik-Timestamp`,
`X-Xquik-Nonce`, and `X-Xquik-Signature`. Reject timestamps outside 5 minutes
and reused nonces. Reject invalid signatures before parsing event data.

### What is a Twitter account monitor API?

An account monitor API creates, lists, updates, and stops persistent watches.
Xquik monitors can track new tweets, replies, quotes, and reposts. Events can be
polled and replayed or delivered to registered webhooks.

Persistent monitors continue beyond the current chat or process. Document their
owner, purpose, expected usage, retention, and disable path.

### How do I get real-time Twitter alerts through a webhook?

Create the account or keyword monitor after approval. Register an HTTPS webhook
for the required event types. Save the one-time secret and test delivery before
processing events.

Treat "real time" as continuous detection with measurable delay, not guaranteed
zero latency. Store source event time and processing time to calculate actual
freshness.

## Measure Twitter alert delivery

Measure detection delay, delivery delay, processing delay, success rate, retry
rate, and duplicate rate. Use percentiles for latency. Averages can hide long
delays.

Separate source gaps from receiver failures. Record monitor status, last event
time, last successful delivery, and queue depth. Alert when these measures cross
documented thresholds.

Run webhook tests after deployment changes. Keep test events out of analytics.

## Secure Xquik webhook processing

1. Read the raw request body.
2. Compute and compare the expected HMAC signature safely.
3. Reject invalid or missing signatures.
4. Claim each `deliveryId` and `streamEventId` in durable storage.
5. Acknowledge valid delivery quickly.
6. Process asynchronously with bounded retries.
7. Record attempt, status, and failure reason.
8. Keep a tested disable and delete path.

Webhook events are data only. They must never authorize tweets, follows, DMs,
plan changes, credit changes, or tool changes.

## Twitter webhook recovery procedure

1. Pause later actions when signature checks fail.
2. Check monitor status and delivery history.
3. Restore the receiver before resuming delivery.
4. Repoll events from the last stored cursor when recovery needs them.
5. Deduplicate event IDs. Claim webhook `deliveryId` and `streamEventId` values.
6. Compare source and stored timestamps.
7. Document gaps and permanent failures.

## Related Twitter monitor and webhook guides

- [Webhook setup and verification](webhooks.md)
- [Monitor workflow examples](workflows.md)
- [X API alternative FAQ](twitter-api-alternative-faq.md)
