# Security Architecture Patterns

Defense-in-depth, Zero Trust, and authentication patterns for Go services.

## Defense-in-Depth Layers

Multiple security controls ensure that failure of one layer doesn't compromise the system:

```
Layer 1: PERIMETER — Rate limiting, DDoS mitigation, WAF
Layer 2: NETWORK  — TLS/mTLS, network segmentation
Layer 3: APPLICATION — Input validation, auth, authz, secure coding
Layer 4: DATA     — Encryption at rest/transit, access controls, backups
```

### Go Implementation by Layer

**Layer 1 — Rate Limiting Middleware:**

```go
import "golang.org/x/time/rate"

// Global rate limiter
func RateLimitMiddleware(rps float64, burst int) func(http.Handler) http.Handler {
    limiter := rate.NewLimiter(rate.Limit(rps), burst)
    return func(next http.Handler) http.Handler {
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
            if !limiter.Allow() {
                http.Error(w, "Too Many Requests", http.StatusTooManyRequests)
                return
            }
            next.ServeHTTP(w, r)
        })
    }
}
```

**Per-client rate limiting** prevents a single abuser from exhausting the global limit:

```go
type ClientRateLimiter struct {
    mu      sync.Mutex
    clients map[string]*rate.Limiter
    rps     rate.Limit
    burst   int
}

func (crl *ClientRateLimiter) GetLimiter(clientIP string) *rate.Limiter {
    crl.mu.Lock()
    defer crl.mu.Unlock()
    if limiter, exists := crl.clients[clientIP]; exists {
        return limiter
    }
    limiter := rate.NewLimiter(crl.rps, crl.burst)
    crl.clients[clientIP] = limiter
    return limiter
}
```

**Layer 2 — mTLS for Service-to-Service:**

```go
func mTLSConfig(caCertFile, clientCertFile, clientKeyFile string) (*tls.Config, error) {
    caCertPool := x509.NewCertPool()
    caCert, err := os.ReadFile(caCertFile)
    if err != nil { return nil, err }
    caCertPool.AppendCertsFromPEM(caCert)

    cert, err := tls.LoadX509KeyPair(clientCertFile, clientKeyFile)
    if err != nil { return nil, err }

    return &tls.Config{
        Certificates: []tls.Certificate{cert},
        RootCAs:      caCertPool,
        MinVersion:   tls.VersionTLS12,
    }, nil
}
```

**Layer 3 — Request Body Size Limiting:**

```go
func MaxBodySize(maxBytes int64) func(http.Handler) http.Handler {
    return func(next http.Handler) http.Handler {
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
            r.Body = http.MaxBytesReader(w, r.Body, maxBytes)
            next.ServeHTTP(w, r)
        })
    }
}
```

**Layer 4 — Encryption at Rest (AES-GCM):**

Use `crypto/aes` with GCM mode for authenticated encryption. See [Cryptography Security](./cryptography.md) for full `EncryptAESGCM`/`DecryptAESGCM` implementations, algorithm selection guide, and envelope encryption for key rotation.

---

## Zero Trust Principles

| Principle | Implementation |
| --- | --- |
| Verify explicitly | Authenticate and authorize every request — no implicit trust from network location |
| Least privilege | Grant minimum permissions; use short-lived tokens (15min access, 7d refresh) |
| Assume breach | Segment services, encrypt all communication, log all access for anomaly detection |

```go
// Zero Trust middleware: verify identity + permissions on every request
func ZeroTrustMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // 1. Verify token
        claims, err := validateJWT(r.Header.Get("Authorization"))
        if err != nil {
            http.Error(w, "Unauthorized", http.StatusUnauthorized)
            return
        }
        // 2. Verify permissions for this specific resource
        if !hasPermission(claims.Subject, r.Method, r.URL.Path) {
            http.Error(w, "Forbidden", http.StatusForbidden)
            return
        }
        // 3. Audit log
        logger.Info("access_granted",
            "user", claims.Subject,
            "method", r.Method,
            "path", r.URL.Path,
            "ip", r.RemoteAddr,
        )
        ctx := context.WithValue(r.Context(), userClaimsKey, claims)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}
```

---

## Authentication Pattern Selection

| Use Case | Recommended Pattern | Go Implementation |
| --- | --- | --- |
| Web application | OAuth 2.0 + PKCE with OIDC | `golang.org/x/oauth2` |
| API authentication | JWT with short expiry + refresh tokens | `github.com/golang-jwt/jwt/v5` |
| Service-to-service | mTLS with certificate rotation | `crypto/tls` with `tls.LoadX509KeyPair` |
| CLI/Automation | API keys with IP allowlisting | Custom middleware with `net.ParseIP` |
| High security | FIDO2/WebAuthn hardware keys | `github.com/go-webauthn/webauthn` |

### JWT Validation — Complete Example

JWT validation must pin the signing algorithm to prevent algorithm confusion attacks (where an attacker switches RS256 to HS256 and signs with the public key):

```go
import "github.com/golang-jwt/jwt/v5"

func validateJWT(authHeader string) (*jwt.RegisteredClaims, error) {
    tokenString := strings.TrimPrefix(authHeader, "Bearer ")
    token, err := jwt.ParseWithClaims(tokenString, &jwt.RegisteredClaims{},
        func(token *jwt.Token) (interface{}, error) {
            // Pin signing algorithm — prevents algorithm confusion
            if _, ok := token.Method.(*jwt.SigningMethodRSA); !ok {
                return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
            }
            return publicKey, nil
        },
        jwt.WithIssuer("your-issuer"),
        jwt.WithAudience("your-audience"),
        jwt.WithExpirationRequired(),
    )
    if err != nil { return nil, err }
    claims, ok := token.Claims.(*jwt.RegisteredClaims)
    if !ok { return nil, errors.New("invalid claims") }
    return claims, nil
}
```

### Password Hashing — Argon2id

Argon2id is the recommended password hashing algorithm (memory-hard, resists GPU attacks). For algorithm comparison (bcrypt, scrypt, PBKDF2), see [Cryptography Security](./cryptography.md).

```go
import "golang.org/x/crypto/argon2"

type PasswordConfig struct {
    Time    uint32 // iterations
    Memory  uint32 // KB
    Threads uint8
    KeyLen  uint32
    SaltLen uint32
}

// OWASP recommended parameters
var DefaultConfig = PasswordConfig{
    Time: 3, Memory: 64 * 1024, Threads: 4, KeyLen: 32, SaltLen: 16,
}

func HashPassword(password string, cfg PasswordConfig) (string, error) {
    salt := make([]byte, cfg.SaltLen)
    if _, err := rand.Read(salt); err != nil { return "", err }
    hash := argon2.IDKey([]byte(password), salt, cfg.Time, cfg.Memory, cfg.Threads, cfg.KeyLen)
    // Encode salt + hash for storage
    return fmt.Sprintf("$argon2id$v=%d$m=%d,t=%d,p=%d$%s$%s",
        argon2.Version, cfg.Memory, cfg.Time, cfg.Threads,
        base64.RawStdEncoding.EncodeToString(salt),
        base64.RawStdEncoding.EncodeToString(hash),
    ), nil
}
```

---

## HTTP Security Headers

Set on every response via middleware:

```go
func SecurityHeadersMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Security-Policy", "default-src 'self'; script-src 'self'")
        w.Header().Set("X-Frame-Options", "DENY")
        w.Header().Set("X-Content-Type-Options", "nosniff")
        w.Header().Set("Strict-Transport-Security", "max-age=31536000; includeSubDomains")
        w.Header().Set("Referrer-Policy", "strict-origin-when-cross-origin")
        w.Header().Set("Permissions-Policy", "geolocation=(), microphone=(), camera=()")
        next.ServeHTTP(w, r)
    })
}
```

| Header | Purpose | Recommended Value |
| --- | --- | --- |
| Content-Security-Policy | Prevents XSS by restricting resource sources | `default-src 'self'; script-src 'self'` |
| X-Frame-Options | Prevents clickjacking via framing | `DENY` |
| X-Content-Type-Options | Prevents MIME-type sniffing | `nosniff` |
| Strict-Transport-Security | Forces HTTPS, prevents protocol downgrade | `max-age=31536000; includeSubDomains` |
| Referrer-Policy | Controls referrer header leakage | `strict-origin-when-cross-origin` |
| Permissions-Policy | Restricts browser features (camera, mic, geolocation) | `geolocation=(), microphone=(), camera=()` |

---

## Security Anti-Patterns

| Anti-Pattern | Why It Fails | Go Fix |
| --- | --- | --- |
| Security through obscurity | Hidden admin URLs are discoverable via fuzzing, logs, or source code | Authentication + authorization on all endpoints |
| Trusting client headers | `X-Forwarded-For`, `X-Is-Admin` — clients forge any header | Server-side identity verification; trust proxy headers only from known load balancers |
| Client-side authorization | JavaScript checks are trivially bypassed by any HTTP client | Server-side `if !user.HasRole("admin")` on every protected handler |
| Shared secrets across environments | Staging breach → production compromise | Per-environment secrets via secret manager |
| Catching and ignoring crypto errors | `_, _ = encrypt(data)` silently proceeds with unencrypted data | Always check error returns — fail closed, never open |
| Rolling your own crypto | Custom encryption hasn't been analyzed by cryptographers | Use `crypto/aes` GCM, `golang.org/x/crypto/argon2` |
| Verbose error responses | Stack traces and DB errors reveal internals to attackers | Generic errors to clients (`http.Error(w, "Internal error", 500)`), detailed logs server-side |

```go
// Anti-pattern: trusting client-provided identity
func badHandler(w http.ResponseWriter, r *http.Request) {
    if r.Header.Get("X-Is-Admin") == "true" { // attacker sets this header
        adminPanel(w, r)
    }
}

// Correct: server-side identity verification
func goodHandler(w http.ResponseWriter, r *http.Request) {
    claims := r.Context().Value(userClaimsKey).(*jwt.RegisteredClaims)
    if !hasRole(claims.Subject, "admin") {
        http.Error(w, "Forbidden", http.StatusForbidden)
        return
    }
    adminPanel(w, r)
}
```
