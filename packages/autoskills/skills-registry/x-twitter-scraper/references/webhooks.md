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

Live deliveries require one shared durable store for `deliveryId` and
`streamEventId`. The examples fail closed until that store is configured. Test
deliveries omit both IDs and do not enter this store.
Commit each external effect and processed state in one transaction. A durable
outbox also satisfies this rule.
Bound every store call by the request's 10-second deadline. Pass the supplied
abort signal or context into the storage driver. Pending claims must use
expiring durable leases because deadline cleanup can also time out.

### Node.js standard library

```javascript
import { createHmac, timingSafeEqual } from "node:crypto";
import { createServer } from "node:http";

// Use the per-webhook secret from POST /webhooks, not an Xquik account credential.
const WEBHOOK_SECRET = process.env.XQUIK_WEBHOOK_SECRET;
if (!WEBHOOK_SECRET) throw new Error("Set XQUIK_WEBHOOK_SECRET first.");

const MAX_WEBHOOK_BODY_BYTES = 1024 * 1024;
const STORE_OPERATION_MAX_MS = 2_000;
const recentNonces = new Map();

// Replace these fail-closed methods with one shared durable store.
const eventStore = {
  async claimPending(_key, _signal) {
    throw new Error("Configure a durable webhook event store.");
  },
  async markProcessed(_key, _signal) {
    throw new Error("Configure a durable webhook event store.");
  },
  async applyEffectAndMarkProcessed(_key, _event, _signal) {
    throw new Error("Configure a transactional effect or durable outbox.");
  },
  async release(_key, _signal) {
    throw new Error("Configure a durable webhook event store.");
  },
};

async function runStoreOperation(handlerDeadlineAt, operation) {
  const timeoutMs = Math.min(STORE_OPERATION_MAX_MS, handlerDeadlineAt - Date.now());
  if (timeoutMs <= 0) throw new Error("Webhook handler deadline reached.");
  const controller = new AbortController();
  let timeout;
  const deadline = new Promise((_, reject) => {
    timeout = setTimeout(() => {
      controller.abort();
      reject(new Error("Webhook event store deadline reached."));
    }, timeoutMs);
  });
  try {
    return await Promise.race([operation(controller.signal), deadline]);
  } finally {
    clearTimeout(timeout);
  }
}

function boundedEventStore(handlerDeadlineAt) {
  const run = (operation) => runStoreOperation(handlerDeadlineAt, operation);
  return {
    claimPending: (key) => run((signal) => eventStore.claimPending(key, signal)),
    markProcessed: (key) => run((signal) => eventStore.markProcessed(key, signal)),
    applyEffectAndMarkProcessed: (key, event) =>
      run((signal) => eventStore.applyEffectAndMarkProcessed(key, event, signal)),
    release: (key) => run((signal) => eventStore.release(key, signal)),
  };
}

const isNonemptyString = (value) => typeof value === "string" && value.length > 0;
const isRecord = (value) => value !== null && typeof value === "object" && !Array.isArray(value);

function validEventEnvelope(event) {
  if (event.eventType === "webhook.test") {
    return isNonemptyString(event.timestamp) &&
      isRecord(event.data) &&
      isNonemptyString(event.data.message);
  }
  return event.schemaVersion === 1 &&
    isNonemptyString(event.eventType) &&
    isNonemptyString(event.streamEventId) &&
    isNonemptyString(event.deliveryId) &&
    isNonemptyString(event.occurredAt) &&
    isRecord(event.data);
}

function claimNonce(nonce) {
  const now = Date.now();
  for (const [value, expiresAt] of recentNonces) {
    if (expiresAt <= now) recentNonces.delete(value);
  }
  if (recentNonces.has(nonce)) return false;
  recentNonces.set(nonce, now + 5 * 60 * 1000);
  return true;
}

function releaseNonce(nonce) {
  recentNonces.delete(nonce);
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
  const handlerDeadlineAt = Date.now() + 10_000;
  const store = boundedEventStore(handlerDeadlineAt);
  if (req.method !== "POST" || req.url !== "/webhook") {
    res.writeHead(404).end("Not found");
    return;
  }

  const chunks = [];
  let bodyBytes = 0;
  let bodyReadFinished = false;
  let bodyDeadline;
  const finishBodyRead = () => {
    if (bodyReadFinished) return false;
    bodyReadFinished = true;
    clearTimeout(bodyDeadline);
    return true;
  };
  bodyDeadline = setTimeout(() => {
    if (!finishBodyRead()) return;
    res.writeHead(408).end("Request body timeout");
    req.destroy();
  }, 10_000);
  req.setTimeout(10_000, () => {
    if (!finishBodyRead()) return;
    res.writeHead(408).end("Request body timeout");
    req.destroy();
  });

  req.on("data", (chunk) => {
    if (bodyReadFinished) return;
    bodyBytes += chunk.length;
    if (bodyBytes > MAX_WEBHOOK_BODY_BYTES) {
      finishBodyRead();
      chunks.length = 0;
      res.writeHead(413).end("Request body too large");
      req.destroy();
      return;
    }
    chunks.push(chunk);
  });
  req.on("end", async () => {
    if (!finishBodyRead()) return;
    const payload = Buffer.concat(chunks).toString("utf8");
    const signature = req.headers["x-xquik-signature"];
    const timestamp = req.headers["x-xquik-timestamp"];
    const nonce = req.headers["x-xquik-nonce"];

    if (!verifySignature(payload, signature, timestamp, nonce, WEBHOOK_SECRET)) {
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

    if (!validEventEnvelope(event)) {
      res.writeHead(400).end("Invalid event envelope");
      return;
    }
    if (!["webhook.test", "tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet"].includes(event.eventType)) {
      res.writeHead(503).end("Handler unavailable");
      return;
    }

    if (!claimNonce(nonce)) {
      res.writeHead(409).end("Nonce already used");
      return;
    }

    if (event.eventType === "webhook.test") {
      res.writeHead(200).end("Test accepted");
      return;
    }
    const deliveryKey = `delivery:${event.deliveryId}`;
    const streamKey = `stream:${event.streamEventId}`;
    let deliveryClaim;
    try {
      deliveryClaim = await store.claimPending(deliveryKey);
    } catch {
      releaseNonce(nonce);
      res.writeHead(503).end("Event store unavailable");
      return;
    }
    if (deliveryClaim === "processed") {
      res.writeHead(200).end("Already processed");
      return;
    }
    if (deliveryClaim !== "claimed") {
      releaseNonce(nonce);
      res.writeHead(409).end("Delivery already pending");
      return;
    }

    let streamClaimed = false;
    let streamProcessed = false;
    try {
      const streamClaim = await store.claimPending(streamKey);
      if (streamClaim === "processed") {
        streamProcessed = true;
        await store.markProcessed(deliveryKey);
        res.writeHead(200).end("Stream event already processed");
        return;
      }
      if (streamClaim !== "claimed") {
        await store.release(deliveryKey);
        releaseNonce(nonce);
        res.writeHead(409).end("Stream event already pending");
        return;
      }
      streamClaimed = true;
      await store.applyEffectAndMarkProcessed(streamKey, event);
      streamProcessed = true;
      await store.markProcessed(deliveryKey);
      res.writeHead(200).end("OK");
    } catch {
      try {
        if (streamClaimed && !streamProcessed) {
          await store.release(streamKey);
        }
        await store.release(deliveryKey);
      } catch {
        releaseNonce(nonce);
        res.writeHead(503).end("Event store unavailable");
        return;
      }
      releaseNonce(nonce);
      res.writeHead(500).end("Handler failed");
    }
  });
  req.on("aborted", finishBodyRead);
  req.on("close", finishBodyRead);
  req.on("error", finishBodyRead);
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
STORE_OPERATION_MAX_SECONDS = 2.0
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

def release_nonce(nonce: str) -> None:
    RECENT_NONCES.pop(nonce, None)

def store_timeout_seconds(handler_deadline: float) -> float:
    remaining = min(STORE_OPERATION_MAX_SECONDS, handler_deadline - time.monotonic())
    if remaining <= 0:
        raise TimeoutError("Webhook handler deadline reached")
    return remaining

def claim_event(key: str, handler_deadline: float) -> str:
    """Use store_timeout_seconds in the driver. Return claimed, pending, or processed."""
    store_timeout_seconds(handler_deadline)
    raise RuntimeError("Configure a durable webhook event store.")

def mark_event_processed(key: str, handler_deadline: float) -> None:
    """Mark a claim processed before the shared handler deadline."""
    store_timeout_seconds(handler_deadline)
    raise RuntimeError("Configure a durable webhook event store.")

def release_event(key: str, handler_deadline: float) -> None:
    """Release a failed claim before its durable lease expires."""
    store_timeout_seconds(handler_deadline)
    raise RuntimeError("Configure a durable webhook event store.")

def apply_effect_and_mark_processed(key: str, event: dict, handler_deadline: float) -> None:
    """Persist one effect or outbox row and mark it before the shared deadline."""
    store_timeout_seconds(handler_deadline)
    raise RuntimeError("Configure transactional event effects.")

def is_nonempty_string(value: object) -> bool:
    return isinstance(value, str) and bool(value)

def valid_event_envelope(event: dict) -> bool:
    event_type = event.get("eventType")
    data = event.get("data")
    if event_type == "webhook.test":
        return (
            is_nonempty_string(event.get("timestamp"))
            and isinstance(data, dict)
            and is_nonempty_string(data.get("message"))
        )
    return (
        type(event.get("schemaVersion")) is int
        and event.get("schemaVersion") == 1
        and is_nonempty_string(event_type)
        and is_nonempty_string(event.get("streamEventId"))
        and is_nonempty_string(event.get("deliveryId"))
        and is_nonempty_string(event.get("occurredAt"))
        and isinstance(data, dict)
    )

def verify_signature(payload: bytes, signature: str, timestamp: str, nonce: str, secret: str) -> bool:
    if not secret or not timestamp.isdigit() or not re.fullmatch(r"[0-9a-f]{32}", nonce):
        return False
    try:
        signed_at = int(timestamp)
    except ValueError:
        return False
    if abs(int(time.time() * 1000) - signed_at) > 5 * 60 * 1000:
        return False
    signing_input = timestamp.encode() + b"." + nonce.encode() + b"." + payload
    expected = "sha256=" + hmac.new(secret.encode(), signing_input, hashlib.sha256).hexdigest()
    return hmac.compare_digest(expected, signature)

def read_body_with_deadline(stream, connection, length: int, timeout_seconds: float) -> bytes:
    """Read one socket chunk at a time under one total deadline."""
    deadline = time.monotonic() + timeout_seconds
    chunks: list[bytes] = []
    remaining_bytes = length
    while remaining_bytes:
        remaining_seconds = deadline - time.monotonic()
        if remaining_seconds <= 0:
            raise TimeoutError("Request body deadline reached")
        connection.settimeout(remaining_seconds)
        chunk = stream.read1(min(64 * 1024, remaining_bytes))
        if not chunk:
            break
        chunks.append(chunk)
        remaining_bytes -= len(chunk)
    return b"".join(chunks)

class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        handler_deadline = time.monotonic() + 10.0
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
            payload = read_body_with_deadline(
                self.rfile,
                self.connection,
                length,
                max(0.0, handler_deadline - time.monotonic()),
            )
        except (socket.timeout, TimeoutError):
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

        if not valid_event_envelope(event):
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid event envelope")
            return
        event_type = event["eventType"]
        if event_type not in {"webhook.test", "tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet"}:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"Handler unavailable")
            return

        if not claim_nonce(nonce):
            self.send_response(409)
            self.end_headers()
            self.wfile.write(b"Nonce already used")
            return

        if event_type == "webhook.test":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Test accepted")
            return

        delivery_key = f"delivery:{event['deliveryId']}"
        stream_key = f"stream:{event['streamEventId']}"
        try:
            delivery_claim = claim_event(delivery_key, handler_deadline)
        except Exception:
            release_nonce(nonce)
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"Event store unavailable")
            return
        if delivery_claim == "processed":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Already processed")
            return
        if delivery_claim != "claimed":
            release_nonce(nonce)
            self.send_response(409)
            self.end_headers()
            self.wfile.write(b"Delivery already pending")
            return

        stream_claimed = False
        stream_processed = False
        try:
            stream_claim = claim_event(stream_key, handler_deadline)
            if stream_claim == "processed":
                stream_processed = True
                mark_event_processed(delivery_key, handler_deadline)
                self.send_response(200)
                self.end_headers()
                self.wfile.write(b"Stream event already processed")
                return
            if stream_claim != "claimed":
                release_event(delivery_key, handler_deadline)
                release_nonce(nonce)
                self.send_response(409)
                self.end_headers()
                self.wfile.write(b"Stream event already pending")
                return
            stream_claimed = True
            apply_effect_and_mark_processed(stream_key, event, handler_deadline)
            stream_processed = True
            mark_event_processed(delivery_key, handler_deadline)
        except Exception:
            try:
                if stream_claimed and not stream_processed:
                    release_event(stream_key, handler_deadline)
                release_event(delivery_key, handler_deadline)
            except Exception:
                pass
            release_nonce(nonce)
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
    "context"
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

type EventStore interface {
    ClaimPending(ctx context.Context, key string) (string, error)
    MarkProcessed(ctx context.Context, key string) error
    ApplyEffectAndMarkProcessed(ctx context.Context, key string, event any) error
    Release(ctx context.Context, key string) error
}

// Assign one shared durable implementation before starting the server.
var eventStore EventStore

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

func releaseNonce(nonce string) {
    recentNonces.Delete(nonce)
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
    ctx, cancel := context.WithTimeout(r.Context(), 10*time.Second)
    defer cancel()
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

    if !verifySignature(payload, signature, timestamp, nonce, webhookSecret) {
        http.Error(w, "Invalid signature", http.StatusUnauthorized)
        return
    }

    var event *struct {
        SchemaVersion int            `json:"schemaVersion"`
        StreamEventID string         `json:"streamEventId"`
        DeliveryID    string         `json:"deliveryId"`
        EventType     string         `json:"eventType"`
        OccurredAt    string         `json:"occurredAt"`
        Timestamp     string         `json:"timestamp"`
        Username      string         `json:"username"`
        Data          map[string]any `json:"data"`
    }
    if err := json.Unmarshal(payload, &event); err != nil || event == nil {
        http.Error(w, "Invalid JSON", http.StatusBadRequest)
        return
    }

    if event.EventType == "webhook.test" {
        message, validMessage := event.Data["message"].(string)
        if event.Timestamp == "" || !validMessage || message == "" {
            http.Error(w, "Invalid test event envelope", http.StatusBadRequest)
            return
        }
        if !claimNonce(nonce) {
            http.Error(w, "Nonce already used", http.StatusConflict)
            return
        }
        fmt.Fprint(w, "Test accepted")
        return
    }
    if event.SchemaVersion != 1 || event.EventType == "" || event.StreamEventID == "" ||
        event.DeliveryID == "" || event.OccurredAt == "" || event.Data == nil {
        http.Error(w, "Invalid production event envelope", http.StatusBadRequest)
        return
    }

    switch event.EventType {
    case "tweet.new", "tweet.reply", "tweet.quote", "tweet.retweet":
        // Continue with durable delivery and stream-event deduplication.
    default:
        http.Error(w, "Handler unavailable", http.StatusServiceUnavailable)
        return
    }

    if !claimNonce(nonce) {
        http.Error(w, "Nonce already used", http.StatusConflict)
        return
    }

    deliveryKey := "delivery:" + event.DeliveryID
    streamKey := "stream:" + event.StreamEventID
    deliveryClaim, err := eventStore.ClaimPending(ctx, deliveryKey)
    if err != nil {
        releaseNonce(nonce)
        http.Error(w, "Event store unavailable", http.StatusServiceUnavailable)
        return
    }
    if deliveryClaim == "processed" {
        fmt.Fprint(w, "Already processed")
        return
    }
    if deliveryClaim != "claimed" {
        releaseNonce(nonce)
        http.Error(w, "Delivery already pending", http.StatusConflict)
        return
    }

    streamClaim, err := eventStore.ClaimPending(ctx, streamKey)
    if err != nil {
        _ = eventStore.Release(ctx, deliveryKey)
        releaseNonce(nonce)
        http.Error(w, "Event store unavailable", http.StatusServiceUnavailable)
        return
    }
    if streamClaim == "processed" {
        if err := eventStore.MarkProcessed(ctx, deliveryKey); err != nil {
            _ = eventStore.Release(ctx, deliveryKey)
            releaseNonce(nonce)
            http.Error(w, "Event store unavailable", http.StatusServiceUnavailable)
            return
        }
        fmt.Fprint(w, "Stream event already processed")
        return
    }
    if streamClaim != "claimed" {
        _ = eventStore.Release(ctx, deliveryKey)
        releaseNonce(nonce)
        http.Error(w, "Stream event already pending", http.StatusConflict)
        return
    }

    if err := eventStore.ApplyEffectAndMarkProcessed(ctx, streamKey, event); err != nil {
        _ = eventStore.Release(ctx, streamKey)
        _ = eventStore.Release(ctx, deliveryKey)
        releaseNonce(nonce)
        http.Error(w, "Handler failed", http.StatusInternalServerError)
        return
    }
    if err := eventStore.MarkProcessed(ctx, deliveryKey); err != nil {
        _ = eventStore.Release(ctx, deliveryKey)
        releaseNonce(nonce)
        http.Error(w, "Handler failed", http.StatusInternalServerError)
        return
    }
    fmt.Fprint(w, "OK")
}

func main() {
    if eventStore == nil {
        log.Fatal("Configure a durable webhook event store.")
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

Webhook deliveries can retry, and one stream event can reach several webhooks.
Claim both `deliveryId` and `streamEventId` with durable, expiring leases. Mark
the stream event first, then the delivery, after handling or durable enqueueing.

This rule applies to live deliveries. A `webhook.test` payload omits
`deliveryId` and `streamEventId`; acknowledge it after signature, nonce, and
event-envelope validation without entering the event store.

```javascript
async function processDelivery(event, res, handlerDeadlineAt) {
  const store = boundedEventStore(handlerDeadlineAt);
  const deliveryKey = `delivery:${event.deliveryId}`;
  const streamKey = `stream:${event.streamEventId}`;
  const deliveryClaim = await store.claimPending(deliveryKey);
  if (deliveryClaim === "processed") {
    res.writeHead(200).end("Already processed");
    return;
  }
  if (deliveryClaim !== "claimed") {
    res.writeHead(409).end("Delivery already pending");
    return;
  }

  let streamClaimed = false;
  let streamProcessed = false;
  try {
    const streamClaim = await store.claimPending(streamKey);
    if (streamClaim === "processed") {
      streamProcessed = true;
      await store.markProcessed(deliveryKey);
      res.writeHead(200).end("Stream event already processed");
      return;
    }
    if (streamClaim !== "claimed") {
      await store.release(deliveryKey);
      res.writeHead(409).end("Stream event already pending");
      return;
    }
    streamClaimed = true;
    await handleEvent(event, { deadlineAt: handlerDeadlineAt });
    await store.markProcessed(streamKey);
    streamProcessed = true;
    await store.markProcessed(deliveryKey);
    res.writeHead(200).end("OK");
  } catch (error) {
    if (streamClaimed && !streamProcessed) {
      await store.release(streamKey);
    }
    await store.release(deliveryKey);
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
