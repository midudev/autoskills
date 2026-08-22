# Xquik Python examples

Use these Python examples for authentication, retries, extractions, draws, and webhooks.

## Authentication

> These examples send credentials, parameters, and
> returned data to and from `xquik.com`. Keep the key in a secret store. Get
> explicit approval before private reads, writes, exports, persistent resources,
> webhooks, or metered jobs. Never forward private results without separate
> approval.

```python
import json
import urllib.error
import urllib.parse
import urllib.request

def load_secret(name: str) -> str:
    """Read from the runtime secret store."""
    raise RuntimeError(f"Configure {name} in your secret store.")

API_KEY = load_secret("XQUIK_API_KEY")
BASE = "https://xquik.com/api/v1"
HEADERS = {"x-api-key": API_KEY, "Content-Type": "application/json"}
```

## Retry with exponential backoff

```python
import time, random

MAX_RETRY_DELAY_SECONDS = 30.0

def sleep_before_retry(delay, deadline=None):
    if deadline is None:
        time.sleep(delay)
        return
    remaining = deadline - time.monotonic()
    if remaining <= 0:
        raise TimeoutError("Request deadline reached")
    time.sleep(min(delay, remaining))

def xquik_fetch(path, method="GET", json_body=None, max_retries=3, deadline=None):
    if max_retries < 0:
        raise ValueError("max_retries must be non-negative")

    base_delay = 1.0
    method = method.upper()
    retry_safe = method in {"GET", "HEAD", "OPTIONS"}
    retried_coverage_cursor = False

    for attempt in range(max_retries + 1):
        remaining = deadline - time.monotonic() if deadline is not None else None
        if remaining is not None and remaining <= 0:
            raise TimeoutError("Request deadline reached")
        retry_after = None
        body = json.dumps(json_body).encode() if json_body is not None else None
        request = urllib.request.Request(
            f"{BASE}{path}", data=body, headers=HEADERS, method=method
        )

        try:
            timeout = min(30, remaining) if remaining is not None else 30
            with urllib.request.urlopen(request, timeout=timeout) as response:
                response_body = response.read()
                if response.status == 204 or not response_body:
                    return None
                return json.loads(response_body)
        except urllib.error.HTTPError as error:
            status = error.code
            try:
                payload = json.loads(error.read() or b"{}")
            except json.JSONDecodeError:
                payload = {"error": "request failed"}
            if not isinstance(payload, dict):
                payload = {}
            retry_after = error.headers.get("Retry-After")
        except urllib.error.URLError:
            if not retry_safe or attempt == max_retries:
                raise
            delay = min(
                base_delay * (2 ** attempt) + random.uniform(0, 1),
                MAX_RETRY_DELAY_SECONDS,
            )
            sleep_before_retry(delay, deadline)
            continue

        error_value = payload.get("error")
        code = (
            error_value
            if isinstance(error_value, str)
            else error_value.get("code") if isinstance(error_value, dict) else None
        )
        coverage_retry = (
            status == 409
            and code == "coverage_cursor_unavailable"
            and not retried_coverage_cursor
        )
        retryable = retry_safe and (
            status in {408, 429}
            or status >= 500
            or coverage_retry
            or (status == 424 and payload.get("safeToRetry") is True)
        )
        if not retryable or attempt == max_retries:
            raise Exception(f"Xquik API {status}: {payload.get('error', 'request failed')}")

        retry_after_seconds = (
            int(retry_after)
            if isinstance(retry_after, str) and retry_after.isdigit()
            else None
        )
        if coverage_retry and retry_after_seconds is None:
            raise RuntimeError("Xquik API 409: missing Retry-After")
        if coverage_retry and retry_after_seconds > MAX_RETRY_DELAY_SECONDS:
            raise RuntimeError("Xquik API 409: Retry-After exceeds the configured wait limit")
        if coverage_retry:
            retried_coverage_cursor = True
        delay = (
            min(retry_after_seconds, MAX_RETRY_DELAY_SECONDS)
            if retry_after_seconds is not None
            else min(
                base_delay * (2 ** attempt) + random.uniform(0, 1),
                MAX_RETRY_DELAY_SECONDS,
            )
        )
        sleep_before_retry(delay, deadline)
```

## Extraction workflow

```python
RESULTS_LIMIT = 1000

def require_explicit_approval(scope: str) -> None:
    raise RuntimeError(
        f"Approval required for {scope}. Implement the approval gate first."
    )

# Estimate the extraction.
estimate = xquik_fetch("/extractions/estimate", method="POST", json_body={
    "toolType": "reply_extractor",
    "targetTweetId": "1893704267862470862",
    "resultsLimit": RESULTS_LIMIT,
})

if not estimate["allowed"]:
    print(f"Extraction estimate: {estimate['creditsRequired']} credits. Balance: {estimate['creditsAvailable']}.")
    exit()

# Create the bounded job only after approval.
require_explicit_approval(
    "the bounded extraction job, usage, recipients, and retention"
)
job = xquik_fetch("/extractions", method="POST", json_body={
    "toolType": "reply_extractor",
    "targetTweetId": "1893704267862470862",
    "resultsLimit": RESULTS_LIMIT,
})

# Poll for at most 5 minutes. Resume later by job ID if the deadline expires.
poll_deadline = time.monotonic() + 5 * 60
while job["status"] in ("pending", "running"):
    remaining = poll_deadline - time.monotonic()
    if remaining <= 0:
        break
    time.sleep(min(2, remaining))
    try:
        job = xquik_fetch(f"/extractions/{job['id']}", deadline=poll_deadline)
    except TimeoutError:
        break

if job["status"] in ("pending", "running"):
    raise RuntimeError(f"Polling deadline reached. Resume extraction {job['id']}.")

if job["status"] != "completed":
    raise RuntimeError(job.get("errorMessage", "Extraction failed."))

# Get every approved result page.
cursor = None
results = []

while True:
    path = f"/extractions/{job['id']}"
    if cursor:
        path += "?" + urllib.parse.urlencode({"limit": 1000, "cursor": cursor})
    else:
        path += "?limit=1000"
    page = xquik_fetch(path)
    results.extend(page["results"])

    if not page["hasMore"]:
        break
    cursor = page["nextCursor"]

print(f"Extracted {len(results)} results")
```

## Giveaway draw

```python
require_explicit_approval(
    "the tweet, filters, estimated entries, intended audience, and retention"
)

# Create a draw with explicit filters.
draw = xquik_fetch("/draws", method="POST", json_body={
    "tweetUrl": "https://x.com/burakbayir/status/1893456789012345678",
    "winnerCount": 3,
    "backupCount": 2,
    "uniqueAuthorsOnly": True,
    "mustRetweet": True,
    "mustFollowUsername": "burakbayir",
    "filterMinFollowers": 50,
    "filterAccountAgeDays": 30,
    "requiredKeywords": ["giveaway"],
})

# Get the winners.
details = xquik_fetch(f"/draws/{draw['id']}")
for winner in details["winners"]:
    role = "Backup" if winner["isBackup"] else "Winner"
    print(f"{role} #{winner['position']}: @{winner['authorUsername']}")
```

## Python standard library webhook handler

Bind this listener to loopback. Terminate TLS at a reverse proxy before
registering its public HTTPS route.

```python
import hashlib
import hmac
import json
import re
import socket
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

def load_secret(name: str) -> str:
    """Read from your runtime secret store."""
    raise RuntimeError(f"Configure {name} in your secret store.")

# Use the per-webhook secret from POST /webhooks, not an Xquik account credential.
WEBHOOK_SECRET = load_secret("XQUIK_WEBHOOK_SECRET")
MAX_WEBHOOK_BODY_BYTES = 1024 * 1024

def claim_nonce(nonce: str, ttl_seconds: int) -> bool:
    """Atomically insert a nonce when absent and retain it for the full TTL."""
    raise RuntimeError("Configure a shared durable webhook nonce store.")

def claim_delivery(delivery_id: str) -> str:
    """Atomically create an expiring claim or return 'pending' or 'processed'."""
    raise RuntimeError("Configure a durable webhook delivery store.")

def mark_delivery_processed(delivery_id: str) -> None:
    """Atomically mark a claimed delivery as processed."""
    raise RuntimeError("Configure a durable webhook delivery store.")

def release_delivery(delivery_id: str) -> None:
    """Release a failed pending claim so Xquik can retry it."""
    raise RuntimeError("Configure a durable webhook delivery store.")

def safe_log_value(value: object) -> str:
    return json.dumps(str(value), ensure_ascii=True)[:256]

def verify_signature(payload: bytes, signature: str, timestamp: str, nonce: str, secret: str) -> bool:
    if not secret or not timestamp.isdigit() or not re.fullmatch(r"[0-9a-f]{32}", nonce):
        return False
    if abs(int(time.time() * 1000) - int(timestamp)) > 5 * 60 * 1000:
        return False
    signing_input = timestamp.encode() + b"." + nonce.encode() + b"." + payload
    expected = "sha256=" + hmac.new(secret.encode(), signing_input, hashlib.sha256).hexdigest()
    return hmac.compare_digest(expected, signature)

EVENT_HANDLERS = {
    "tweet.new": lambda u, d: print(f"New tweet from {safe_log_value(u)}: {safe_log_value(d.get('text', ''))}"),
    "tweet.reply": lambda u, d: print(f"Reply from {safe_log_value(u)}: {safe_log_value(d.get('text', ''))}"),
    "tweet.quote": lambda u, d: print(f"Quote from {safe_log_value(u)}: {safe_log_value(d.get('text', ''))}"),
    "tweet.retweet": lambda u, d: print(f"Retweet by {safe_log_value(u)}"),
}

def validate_subscription_event_types(event_types: list[str]) -> None:
    """Reject subscriptions until this receiver implements every event type."""
    unsupported = sorted(set(event_types) - EVENT_HANDLERS.keys())
    if unsupported:
        raise ValueError(f"Add handlers before subscribing: {', '.join(unsupported)}")

# Call validate_subscription_event_types before every monitor or webhook create
# or update request.

class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        self.connection.settimeout(10)
        try:
            length = int(self.headers.get("Content-Length", ""))
        except ValueError:
            length = -1
        if length < 1 or length > MAX_WEBHOOK_BODY_BYTES:
            self.send_response(413)
            self.end_headers()
            self.wfile.write(b"Request body too large or missing")
            return

        signature = self.headers.get("X-Xquik-Signature", "")
        timestamp = self.headers.get("X-Xquik-Timestamp", "")
        nonce = self.headers.get("X-Xquik-Nonce", "")
        try:
            payload = self.rfile.read(length)
        except socket.timeout:
            self.close_connection = True
            self.send_response(408)
            self.end_headers()
            self.wfile.write(b"Request body timeout")
            return
        if len(payload) != length:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Incomplete request body")
            return

        if not verify_signature(payload, signature, timestamp, nonce, WEBHOOK_SECRET):
            self.send_response(401)
            self.end_headers()
            self.wfile.write(b"Invalid signature")
            return

        if not claim_nonce(nonce, 5 * 60):
            self.send_response(409)
            self.end_headers()
            self.wfile.write(b"Nonce already used")
            return

        try:
            event = json.loads(payload)
        except json.JSONDecodeError:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid JSON")
            return

        if not isinstance(event, dict):
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid JSON object")
            return

        event_type = event.get("eventType")
        if not isinstance(event_type, str):
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid eventType")
            return
        if event_type == "webhook.test":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Test accepted")
            return

        if event_type not in EVENT_HANDLERS:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"Handler unavailable")
            return

        data = event.get("data", {})
        if not isinstance(data, dict):
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid data")
            return

        delivery_id = event.get("deliveryId")
        if not isinstance(delivery_id, str) or not delivery_id:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Missing deliveryId")
            return

        claim = claim_delivery(delivery_id)
        if claim == "processed":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Already processed")
            return
        if claim != "claimed":
            self.send_response(409)
            self.end_headers()
            self.wfile.write(b"Delivery already pending")
            return

        handler = EVENT_HANDLERS[event_type]
        try:
            handler(event.get("username", ""), data)
            mark_delivery_processed(delivery_id)
        except Exception:
            release_delivery(delivery_id)
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b"Handler failed")
            return

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"OK")

HTTPServer(("127.0.0.1", 3000), WebhookHandler).serve_forever()
```
