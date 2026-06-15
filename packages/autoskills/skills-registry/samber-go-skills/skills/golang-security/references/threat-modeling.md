# Threat Modeling Guide

Systematic methodology for identifying and prioritizing security threats in Go applications.

## STRIDE Methodology

Apply STRIDE to every element in your system's data flow diagram. Each element type is susceptible to specific threat categories:

### STRIDE per Element Matrix

| DFD Element                           | S   | T   | R   | I   | D   | E   |
| ------------------------------------- | --- | --- | --- | --- | --- | --- |
| External Entity (user, API client)    | X   |     | X   |     |     |     |
| Process (HTTP handler, gRPC service)  | X   | X   | X   | X   | X   | X   |
| Data Store (database, cache, file)    |     | X   | X   | X   | X   |     |
| Data Flow (HTTP, gRPC, message queue) |     | X   |     | X   | X   |     |

### Go-Specific STRIDE Analysis

**Spoofing** — Can an attacker impersonate a user or service?

```go
// Check: Is every endpoint behind authentication?
// Check: Are JWT tokens validated (algorithm, issuer, expiry)?
// Check: Is mTLS configured for service-to-service calls?
r.Use(authMiddleware) // every route group must have auth
```

**Tampering** — Can data be modified in transit or at rest?

```go
// Check: Are all external inputs validated?
// Check: Is HMAC used for webhook/callback verification?
mac := hmac.New(sha256.New, key)
mac.Write(payload)
expected := mac.Sum(nil)
if !hmac.Equal(signature, expected) {
    return errors.New("tampered payload")
}
```

**Repudiation** — Can a user deny performing an action?

```go
// Check: Are all security-relevant actions logged with structured data?
logger.Info("action_performed",
    "user_id", userID,
    "action", "delete_account",
    "ip", r.RemoteAddr,
    "timestamp", time.Now().UTC(),
)
```

**Information Disclosure** — Can sensitive data leak?

```go
// Check: Are error messages generic to clients?
// Check: Are logs free of PII?
// Check: Is TLS configured (no InsecureSkipVerify)?
// Check: Are debug endpoints (pprof) disabled in production?
```

**Denial of Service** — Can the service be overwhelmed?

```go
// Check: Are timeouts set on the HTTP server?
// Check: Are request body sizes limited?
// Check: Is rate limiting in place?
server := &http.Server{
    ReadTimeout:    5 * time.Second,
    WriteTimeout:   10 * time.Second,
    MaxHeaderBytes: 1 << 20, // 1MB
}
```

**Elevation of Privilege** — Can a user gain unauthorized access?

```go
// Check: Is authorization checked server-side on every request?
// Check: Are object references validated (no IDOR)?
// Check: Are admin routes properly protected?
if !user.HasPermission("admin:write") {
    http.Error(w, "Forbidden", http.StatusForbidden)
    return
}
```

---

## DREAD Risk Scoring

Score each identified threat to prioritize remediation:

| Factor | 1-3 (Low) | 4-6 (Medium) | 7-10 (High) |
| --- | --- | --- | --- |
| **D**amage | Minor info disclosure | Partial data breach | Full system compromise, data destruction |
| **R**eproducibility | Timing-dependent, hard to reproduce | Reproducible with some effort | Always reproducible, automated tools exist |
| **E**xploitability | Custom exploit, advanced skills needed | Basic tools available | No skills required, public exploit exists |
| **A**ffected users | Individual user | Subset of users | All users |
| **D**iscoverability | Requires insider knowledge | Found via scanning | Publicly documented, obvious |

**Score** = (D + R + E + A + D) / 5. Risk levels: **8-10 Critical**, **6-7.9 High**, **4-5.9 Medium**, **1-3.9 Low**.

### Example: SQL Injection in Login Handler

| Factor          | Score | Justification                              |
| --------------- | ----- | ------------------------------------------ |
| Damage          | 9     | Full database access, credential theft     |
| Reproducibility | 9     | Consistent, automated tools exist (sqlmap) |
| Exploitability  | 8     | Well-documented attack, easy tooling       |
| Affected Users  | 10    | All users with accounts                    |
| Discoverability | 7     | Automated scanners detect easily           |

**DREAD Score: 8.6 — Critical. Immediate remediation required.**

---

## Trust Boundary Analysis

Map where untrusted data enters your Go application:

```
                        ┌─────────────────────────────────────┐
                        │           TRUST BOUNDARY             │
                        │                                      │
Internet ──→ [LB/WAF] ──→ [Go HTTP Server]                   │
                        │        │                             │
                        │   [Middleware]                        │
                        │   - Auth (JWT/session)               │
                        │   - Rate limiting                    │
                        │   - Input validation                 │
                        │   - Security headers                 │
                        │        │                             │
                        │   [Service Layer] ──→ [Cache]        │
                        │        │                             │
                        │   [Database] (parameterized queries) │
                        │                                      │
                        └──────────┬──────────────────────────┘
                                   │
                          External APIs (mTLS)
```

Every arrow crossing the trust boundary needs:

1. **Authentication** — who is making this request?
2. **Input validation** — is the data well-formed and within bounds?
3. **Authorization** — is this caller allowed to perform this action on this resource?

---

## OWASP Top 10 Mapping for Go

| Rank | Vulnerability | STRIDE | Go Defense |
| --- | --- | --- | --- |
| A01 | Broken Access Control | E | Server-side authz middleware, RBAC, IDOR checks |
| A02 | Cryptographic Failures | I | `crypto/aes` GCM, `crypto/rand`, TLS 1.2+ |
| A03 | Injection | T, E | `database/sql` placeholders, `exec.Command` separate args, `html/template` |
| A04 | Insecure Design | All | Threat modeling with STRIDE, defense-in-depth |
| A05 | Security Misconfiguration | I, E | Server timeouts, TLS config, no `InsecureSkipVerify`, no exposed pprof |
| A06 | Vulnerable Components | All | `govulncheck`, Dependabot/Renovate, `go.sum` verification |
| A07 | Authentication Failures | S, E | Argon2id/bcrypt, JWT validation (algorithm pinning), MFA |
| A08 | Software/Data Integrity | T | Module checksums (`go.sum`), signed releases, CI verification |
| A09 | Logging Failures | R | Structured logging (`log/slog`), audit trails, no PII |
| A10 | SSRF | I, T | URL allowlists, block internal IPs and metadata endpoints |

---

## Conducting a Threat Model

1. **Scope** — identify system boundaries, assets to protect, and threat actors
2. **Diagram** — draw a data flow diagram with trust boundaries (external entities, processes, data stores, data flows)
3. **STRIDE** — apply STRIDE to each DFD element using the matrix above
4. **Score** — rate each threat with DREAD
5. **Prioritize** — fix Critical/High first; document accepted risks with explicit justification
6. **Verify** — run `gosec ./...`, `govulncheck ./...`, `go test -race ./...` to validate mitigations
7. **Iterate** — update the model when the system changes (new endpoints, new data flows, new integrations)

---

## Vulnerability Severity Matrix

Use when no DREAD data is available — cross-reference impact with exploitability:

| Impact \ Exploitability | Easy     | Moderate | Difficult |
| ----------------------- | -------- | -------- | --------- |
| Critical                | Critical | Critical | High      |
| High                    | Critical | High     | Medium    |
| Medium                  | High     | Medium   | Low       |
| Low                     | Medium   | Low      | Low       |
