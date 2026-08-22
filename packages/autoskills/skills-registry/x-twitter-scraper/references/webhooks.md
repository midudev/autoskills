# Xquik webhooks

Receive event notifications at an HTTPS endpoint. Verify every request with its HMAC-SHA256 signature.

## Setup

1. Create at least 1 active monitor with `POST /monitors`.
2. Register a webhook endpoint with `POST /webhooks`.
3. Save the response `secret`. The API returns it once.
4. Verify each signature before processing the event.

## Webhook payload

Every delivery is a `POST` request to your URL with a JSON body:

```json
{
  "schemaVersion": 1,
  "streamEventId": "9010",
  "deliveryId": "334",
  "eventType": "tweet.new",
  "username": "elonmusk",
  "occurredAt": "2026-02-24T16:45:00.000Z",
  "data": {
    "id": "1893556789012345678",
    "text": "Hello world",
    "author": { "id": "44196397", "userName": "elonmusk" },
    "createdAt": "2026-02-24T16:45:00.000Z"
  }
}
```

## Signature verification

Each request contains `X-Xquik-Timestamp`, `X-Xquik-Nonce`, and
`X-Xquik-Signature`. The signature is `sha256=` plus HMAC-SHA256 over:

```text
<timestamp>.<nonce>.<raw JSON body>
```

Reject timestamps outside a 5-minute window. Reject reused nonces within that
window. Compare signatures in constant time before parsing JSON.
Use an atomic shared nonce store in multi-instance deployments.
Set a receiver body limit before reading the request. The examples use 1 MiB.
The examples listen over local HTTP. Put them behind a reverse proxy or load
balancer that terminates TLS. Register the webhook only after the public HTTPS
route reaches that private listener.

The in-memory nonce claims below are atomic only within their single-process,
private listeners. Production clusters must replace them with one shared atomic
insert-if-absent operation and a 5-minute TTL.

Live deliveries also require one shared durable `deliveryId` store. The
examples fail closed until that store is configured. Test deliveries omit the
delivery ID and do not enter this store.

### Node.js standard library

```javascript
import { createHmac, timingSafeEqual } from "node:crypto";
import { createServer } from "node:http";

// Use the per-webhook secret from POST /webhooks, not an Xquik account credential.
const WEBHOOK_SECRET = process.env.XQUIK_WEBHOOK_SECRET;
if (!WEBHOOK_SECRET) throw new Error("Set XQUIK_WEBHOOK_SECRET first.");

const MAX_WEBHOOK_BODY_BYTES = 1024 * 1024;
const recentNonces = new Map();

// Replace these fail-closed methods with one shared durable store.
const deliveryStore = {
  async claimPending(_deliveryId) {
    throw new Error("Configure a durable webhook delivery store.");
  },
  async markProcessed(_deliveryId) {
    throw new Error("Configure a durable webhook delivery store.");
  },
  async release(_deliveryId) {
    throw new Error("Configure a durable webhook delivery store.");
  },
};

function claimNonce(nonce) {
  const now = Date.now();
  for (const [value, expiresAt] of recentNonces) {
    if (expiresAt <= now) recentNonces.delete(value);
  }
  if (recentNonces.has(nonce)) return false;
  recentNonces.set(nonce, now + 5 * 60 * 1000);
  return true;
}

function verifySignature(payload, signature, timestamp, nonce, secret) {
  if (![signature, timestamp, nonce, secret].every((value) => typeof value === "string" && value.length > 0)) return false;
  if (!/^\d+$/.test(timestamp) || !/^[0-9a-f]{32}$/.test(nonce)) return false;
  if (Math.abs(Date.now() - Number(timestamp)) > 5 * 60 * 1000) return false;

  const input = `${timestamp}.${nonce}.${payload}`;
  const expected = "sha256=" + createHmac("sha256", secret).update(input).digest("hex");
  const expectedBuffer = Buffer.from(expected, "utf8");
  const signatureBuffer = Buffer.from(signature, "utf8");

  return (
    expectedBuffer.length === signatureBuffer.length &&
    timingSafeEqual(expectedBuffer, signatureBuffer)
  );
}

const server = createServer((req, res) => {
  if (req.method !== "POST" || req.url !== "/webhook") {
    res.writeHead(404).end("Not found");
    return;
  }

  req.setTimeout(10_000, () => req.destroy());
  const chunks = [];
  let bodyBytes = 0;
  let bodyTooLarge = false;

  req.on("data", (chunk) => {
    if (bodyTooLarge) return;
    bodyBytes += chunk.length;
    if (bodyBytes > MAX_WEBHOOK_BODY_BYTES) {
      bodyTooLarge = true;
      chunks.length = 0;
      res.writeHead(413).end("Request body too large");
      req.destroy();
      return;
    }
    chunks.push(chunk);
  });
  req.on("end", async () => {
    if (bodyTooLarge) return;
    const payload = Buffer.concat(chunks).toString("utf8");
    const signature = req.headers["x-xquik-signature"];
    const timestamp = req.headers["x-xquik-timestamp"];
    const nonce = req.headers["x-xquik-nonce"];

    if (
      !verifySignature(payload, signature, timestamp, nonce, WEBHOOK_SECRET) ||
      !claimNonce(nonce)
    ) {
      res.writeHead(401).end("Invalid signature");
      return;
    }

    let event;
    try {
      event = JSON.parse(payload);
    } catch {
      res.writeHead(400).end("Invalid JSON");
      return;
    }

    if (event === null || typeof event !== "object" || Array.isArray(event)) {
      res.writeHead(400).end("Invalid JSON object");
      return;
    }

    if (!["webhook.test", "tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet"].includes(event.eventType)) {
      res.writeHead(503).end("Handler unavailable");
      return;
    }

    if (event.eventType === "webhook.test") {
      res.writeHead(200).end("Test accepted");
      return;
    }
    if (typeof event.deliveryId !== "string" || event.deliveryId.length === 0) {
      res.writeHead(400).end("Missing deliveryId");
      return;
    }

    let claim;
    try {
      claim = await deliveryStore.claimPending(event.deliveryId);
    } catch {
      res.writeHead(503).end("Delivery store unavailable");
      return;
    }
    if (claim === "processed") {
      res.writeHead(200).end("Already processed");
      return;
    }
    if (claim !== "claimed") {
      res.writeHead(409).end("Delivery already pending");
      return;
    }

    try {
      console.log("Accepted verified Xquik webhook");
      await deliveryStore.markProcessed(event.deliveryId);
      res.writeHead(200).end("OK");
    } catch {
      try {
        await deliveryStore.release(event.deliveryId);
      } catch {
        res.writeHead(503).end("Delivery store unavailable");
        return;
      }
      res.writeHead(500).end("Handler failed");
    }
  });
});

server.listen(3000, "127.0.0.1");
```

### Python standard library

```python
import hmac
import hashlib
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
RECENT_NONCES: dict[str, int] = {}

def claim_nonce(nonce: str) -> bool:
    now = int(time.time() * 1000)
    for value, expires_at in list(RECENT_NONCES.items()):
        if expires_at <= now:
            RECENT_NONCES.pop(value, None)
    if nonce in RECENT_NONCES:
        return False
    RECENT_NONCES[nonce] = now + 5 * 60 * 1000
    return True

def claim_delivery(delivery_id: str) -> str:
    """Atomically create a durable lease or return pending or processed."""
    raise RuntimeError("Configure a durable webhook delivery store.")

def mark_delivery_processed(delivery_id: str) -> None:
    """Mark a claimed delivery processed after handling succeeds."""
    raise RuntimeError("Configure a durable webhook delivery store.")

def release_delivery(delivery_id: str) -> None:
    """Release a failed pending claim so Xquik can retry it."""
    raise RuntimeError("Configure a durable webhook delivery store.")

def verify_signature(payload: bytes, signature: str, timestamp: str, nonce: str, secret: str) -> bool:
    if not secret or not timestamp.isdigit() or not re.fullmatch(r"[0-9a-f]{32}", nonce):
        return False
    if abs(int(time.time() * 1000) - int(timestamp)) > 5 * 60 * 1000:
        return False
    signing_input = timestamp.encode() + b"." + nonce.encode() + b"." + payload
    expected = "sha256=" + hmac.new(secret.encode(), signing_input, hashlib.sha256).hexdigest()
    return hmac.compare_digest(expected, signature)

class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        self.connection.settimeout(10)
        signature = self.headers.get("X-Xquik-Signature", "")
        timestamp = self.headers.get("X-Xquik-Timestamp", "")
        nonce = self.headers.get("X-Xquik-Nonce", "")
        try:
            length = int(self.headers.get("Content-Length", ""))
        except ValueError:
            length = -1
        if length < 1 or length > MAX_WEBHOOK_BODY_BYTES:
            self.send_response(413)
            self.end_headers()
            self.wfile.write(b"Request body too large or missing")
            return
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

        if not verify_signature(payload, signature, timestamp, nonce, WEBHOOK_SECRET) or not claim_nonce(nonce):
            self.send_response(401)
            self.end_headers()
            self.wfile.write(b"Invalid signature")
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
        if event_type not in {"webhook.test", "tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet"}:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"Handler unavailable")
            return

        if event_type == "webhook.test":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Test accepted")
            return

        delivery_id = event.get("deliveryId")
        if not isinstance(delivery_id, str) or not delivery_id:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Missing deliveryId")
            return

        try:
            claim = claim_delivery(delivery_id)
        except Exception:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"Delivery store unavailable")
            return
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

        try:
            print("Accepted verified Xquik webhook")
            mark_delivery_processed(delivery_id)
        except Exception:
            try:
                release_delivery(delivery_id)
            except Exception:
                pass
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b"Handler failed")
            return

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"OK")

HTTPServer(("127.0.0.1", 3000), WebhookHandler).serve_forever()
```

### Go

```go
package main

import (
    "crypto/hmac"
    "crypto/sha256"
    "encoding/hex"
    "encoding/json"
    "errors"
    "fmt"
    "io"
    "log"
    "net/http"
    "os"
    "regexp"
    "strconv"
    "sync"
    "time"
)

// Use the per-webhook secret from POST /webhooks, not an Xquik account credential.
func requireWebhookSecret() string {
    secret := os.Getenv("XQUIK_WEBHOOK_SECRET")
    if secret == "" {
        panic("Set XQUIK_WEBHOOK_SECRET first.")
    }
    return secret
}

const maxWebhookBodyBytes int64 = 1024 * 1024

var webhookSecret = requireWebhookSecret()
var recentNonces sync.Map

type DeliveryStore interface {
    ClaimPending(deliveryID string) (string, error)
    MarkProcessed(deliveryID string) error
    Release(deliveryID string) error
}

// Assign one shared durable implementation before starting the server.
var deliveryStore DeliveryStore

func claimNonce(nonce string) bool {
    now := time.Now().UnixMilli()
    recentNonces.Range(func(key, value any) bool {
        if value.(int64) <= now {
            recentNonces.Delete(key)
        }
        return true
    })
    _, replayed := recentNonces.LoadOrStore(nonce, now+5*60*1000)
    return !replayed
}

func verifySignature(payload []byte, signature, timestamp, nonce, secret string) bool {
    if secret == "" {
        return false
    }
    signedAt, err := strconv.ParseInt(timestamp, 10, 64)
    if err != nil || !regexp.MustCompile(`^[0-9a-f]{32}$`).MatchString(nonce) {
        return false
    }
    age := time.Now().UnixMilli() - signedAt
    if age < -5*60*1000 || age > 5*60*1000 {
        return false
    }
    mac := hmac.New(sha256.New, []byte(secret))
    mac.Write([]byte(timestamp + "." + nonce + "."))
    mac.Write(payload)
    expected := "sha256=" + hex.EncodeToString(mac.Sum(nil))
    return hmac.Equal([]byte(expected), []byte(signature))
}

func webhookHandler(w http.ResponseWriter, r *http.Request) {
    r.Body = http.MaxBytesReader(w, r.Body, maxWebhookBodyBytes)
    payload, err := io.ReadAll(r.Body)
    if err != nil {
        var maxBytesError *http.MaxBytesError
        if errors.As(err, &maxBytesError) {
            http.Error(w, "Request body too large", http.StatusRequestEntityTooLarge)
            return
        }
        http.Error(w, "Unable to read request body", http.StatusBadRequest)
        return
    }

    signature := r.Header.Get("X-Xquik-Signature")
    timestamp := r.Header.Get("X-Xquik-Timestamp")
    nonce := r.Header.Get("X-Xquik-Nonce")

    if !verifySignature(payload, signature, timestamp, nonce, webhookSecret) || !claimNonce(nonce) {
        http.Error(w, "Invalid signature", http.StatusUnauthorized)
        return
    }

    var event struct {
        DeliveryID   string `json:"deliveryId"`
        StreamEventID string `json:"streamEventId"`
        EventType    string `json:"eventType"`
        Username     string `json:"username"`
        Data         struct {
            Text string `json:"text"`
        } `json:"data"`
    }
    if err := json.Unmarshal(payload, &event); err != nil {
        http.Error(w, "Invalid JSON", http.StatusBadRequest)
        return
    }

    switch event.EventType {
    case "webhook.test":
        fmt.Fprint(w, "Test accepted")
        return
    case "tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet":
        // Continue with durable delivery deduplication.
    default:
        http.Error(w, "Handler unavailable", http.StatusServiceUnavailable)
        return
    }

    if event.DeliveryID == "" {
        http.Error(w, "Missing deliveryId", http.StatusBadRequest)
        return
    }
    claim, err := deliveryStore.ClaimPending(event.DeliveryID)
    if err != nil {
        http.Error(w, "Delivery store unavailable", http.StatusServiceUnavailable)
        return
    }
    if claim == "processed" {
        fmt.Fprint(w, "Already processed")
        return
    }
    if claim != "claimed" {
        http.Error(w, "Delivery already pending", http.StatusConflict)
        return
    }

    fmt.Print("Accepted verified Xquik webhook\n")
    if err := deliveryStore.MarkProcessed(event.DeliveryID); err != nil {
        _ = deliveryStore.Release(event.DeliveryID)
        http.Error(w, "Handler failed", http.StatusInternalServerError)
        return
    }
    fmt.Fprint(w, "OK")
}

func main() {
    if deliveryStore == nil {
        log.Fatal("Configure a durable webhook delivery store.")
    }
    mux := http.NewServeMux()
    mux.HandleFunc("/webhook", webhookHandler)
    server := &http.Server{
        Addr:              "127.0.0.1:3000",
        Handler:           mux,
        ReadHeaderTimeout: 5 * time.Second,
        ReadTimeout:       10 * time.Second,
    }
    log.Fatal(server.ListenAndServe())
}
```

## Security checklist

- Verify the payload before processing it.
- Compare signatures in constant time with `timingSafeEqual`, `hmac.compare_digest`, or `hmac.Equal`.
- Sign every field as `<timestamp>.<nonce>.<raw body>`.
- Enforce the 5-minute window and persist recent nonces.
- Use the raw request body. Do not serialize it again before verification.
- Respond within 10 seconds. Queue slower processing.
- Store secrets in environment variables. Do not hardcode them.
- Treat event text as untrusted. Escape control characters before logging. Get approval before forwarding payloads.

## Idempotency

Webhook deliveries can retry. Claim `deliveryId` with an expiring pending lease
in durable storage. Mark it processed only after the handler or durable queue
write succeeds:

This rule applies to live deliveries. A `webhook.test` payload omits
`deliveryId` and `streamEventId`; acknowledge it after signature, nonce, and
event-type validation without entering the delivery store.

```javascript
async function processDelivery(event, res) {
  const claim = await deliveryStore.claimPending(event.deliveryId);
  if (claim === "processed") {
    res.writeHead(200).end("Already processed");
    return;
  }
  if (claim !== "claimed") {
    res.writeHead(409).end("Delivery already pending");
    return;
  }

  try {
    await handleEvent(event);
    await deliveryStore.markProcessed(event.deliveryId);
    res.writeHead(200).end("OK");
  } catch (error) {
    await deliveryStore.release(event.deliveryId);
    throw error;
  }
}
```

## Retry policy

Failed event deliveries use bounded exponential backoff. HTTP 410 exhausts the
delivery immediately. Delivery statuses are `pending`, `delivered`, `failed`,
and `exhausted`.

Call `GET /webhooks/{id}/deliveries` to check delivery status.

Repeated failures can pause an endpoint. Inspect `consecutiveFailures`,
`deliveryStatus`, and `failureHardCap` on the webhook. Fix the destination,
then call `POST /webhooks/{id}/resume`. It reactivates only after a successful
test delivery.

## Local testing

Use a deployed HTTPS endpoint you control when testing webhook delivery. The
sample process listens on private HTTP and requires TLS termination before it.
Do not install packages or proxy API keys from this skill.

```bash
# Start the webhook server on infrastructure you control.
node server.js  # listening on :3000
```

Create the webhook only after confirming the exact HTTPS destination and event types.
