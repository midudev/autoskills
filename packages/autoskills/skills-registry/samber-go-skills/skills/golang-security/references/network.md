# Network/Web Security Rules

Network and web security vulnerabilities can lead to data leakage and unauthorized access.

**Rules:**

1. Redirects MUST be validated against an allowlist of domains.
2. HTTP servers MUST configure `ReadTimeout`, `WriteTimeout`, and `IdleTimeout`.
3. Pprof endpoints MUST NEVER be exposed publicly.
4. XML parsers MUST disable XXE — reject `<!DOCTYPE` and `<!ENTITY` declarations.

---

## Open Redirect Vulnerability — Medium

Redirects to unvalidated URLs can be used for phishing.

**Bad:**

```go
target := r.URL.Query().Get("url")
http.Redirect(w, r, target, http.StatusFound) // DON'T
```

**Good:**

```go
target := r.URL.Query().Get("url")
u, _ := url.Parse(target)
// Only allow http/https
if u.Scheme != "http" && u.Scheme != "https" {
    return errors.New("invalid scheme")
}
// Block javascript/data schemes
if strings.HasPrefix(target, "javascript:") || strings.HasPrefix(target, "data:") {
    return errors.New("blocked scheme")
}
// Check against whitelist
if !isAllowedDomain(u.Host) {
    return errors.New("invalid domain")
}
http.Redirect(w, r, target, http.StatusFound)
```

---

## Bind to All Interfaces — Medium

Binding to 0.0.0.0 exposes services to all network interfaces.

**Bad:**

```go
listener, _ := net.Listen("tcp", "0.0.0.0:8080") // DON'T: Exposes all interfaces
```

**Good:**

```go
// Bind only to localhost
listener, _ := net.Listen("tcp", "127.0.0.1:8080")

// Or specific internal IP
listener, _ := net.Listen("tcp", "10.0.1.5:8080")
```

---

## Slowloris Attack Vulnerability — Medium

Slowloris attacks exhaust connection pools.

**Bad:**

```go
server := &http.Server{
    Addr: ":8080",
    // Missing ReadTimeout, WriteTimeout, IdleTimeout
}
```

**Good:**

```go
server := &http.Server{
    Addr:         ":8080",
    ReadTimeout:  5 * time.Second,
    WriteTimeout: 10 * time.Second,
    IdleTimeout:  120 * time.Second,
    MaxHeaderBytes: 1 << 20, // Limit header size to 1MB
}
```

---

## Insecure HTTP Server Configuration — Medium

Running HTTP servers without proper security settings.

**Bad:**

```go
http.ListenAndServe(":8080", handler) // DON'T: No security hardening
```

**Good:**

```go
server := &http.Server{
    Addr:         ":443",
    ReadTimeout:  5 * time.Second,
    WriteTimeout: 10 * time.Second,
    IdleTimeout:  120 * time.Second,
    MaxHeaderBytes: 1 << 20,
}
server.ListenAndServeTLS("cert.pem", "key.pem")
```

---

## Observable Timing (Timing Attacks) — Medium

Timing differences can leak sensitive information.

**Bad:**

```go
func checkPassword(input, secret string) bool {
    return input == secret // DON'T: Short-circuit leaks length
}
```

**Good:**

```go
import "crypto/subtle"

// For comparing fixed-length tokens or hashes:
func checkToken(input, expected string) bool {
    // ConstantTimeCompare already handles unequal lengths without leaking timing
    return subtle.ConstantTimeCompare([]byte(input), []byte(expected)) == 1
}

// For passwords, use Argon2id (preferred) or bcrypt — they handle hashing
// and constant-time comparison internally:
// argon2: hash := argon2.IDKey([]byte(password), salt, 3, 64*1024, 4, 32)
// bcrypt: err := bcrypt.CompareHashAndPassword([]byte(storedHash), []byte(password))

// For HMAC verification:
import "crypto/hmac"
func verifyHMAC(message, messageMAC, key []byte) bool {
    mac := hmac.New(sha256.New, key)
    mac.Write(message)
    expectedMAC := mac.Sum(nil)
    return hmac.Equal(messageMAC, expectedMAC) // Constant-time
}
```

---

## Exposed pprof Profiling Endpoints — High

Debug pprof endpoints expose sensitive runtime information.

**Bad:**

```go
import _ "net/http/pprof" // DON'T: Automatically registers /debug/pprof
http.ListenAndServe(":8080", handler)
```

**Good:**

```go
// Option 1: Use build tags to exclude pprof from production builds
// File: debug_pprof.go
//go:build !production

package main

import _ "net/http/pprof"

// Option 2: Serve pprof on a separate internal-only listener
func startDebugServer() {
    debugMux := http.NewServeMux()
    debugMux.HandleFunc("/debug/pprof/", pprof.Index)
    debugMux.HandleFunc("/debug/pprof/cmdline", pprof.Cmdline)
    debugMux.HandleFunc("/debug/pprof/profile", pprof.Profile)
    debugMux.HandleFunc("/debug/pprof/symbol", pprof.Symbol)
    debugMux.HandleFunc("/debug/pprof/trace", pprof.Trace)
    go http.ListenAndServe("127.0.0.1:6060", debugMux) // localhost only
}
```

---

## XXE Vulnerability — High

XML parsers that process external entity references.

**Bad:**

```go
decoder := xml.NewDecoder(bytes.NewReader(xmlData))
decoder.Decode(&person) // DON'T: May process external entities
```

**Good:**

```go
decoder := xml.NewDecoder(bytes.NewReader(xmlData))
decoder.Strict = true

// Block DTD declarations
xmlStr := string(xmlData)
if strings.Contains(xmlStr, "<!DOCTYPE") || strings.Contains(xmlStr, "<!ENTITY") {
    return errors.New("XML contains DTD - potential XXE")
}
decoder.Decode(&person)
```

---

## Permissive Regex Validation — Low

Weak regex validation can allow malicious input.

**Bad:**

```go
matched, _ := regexp.MatchString(`.+@.+\..+`, email) // DON'T: Too permissive
```

**Good:**

```go
var emailRegex = regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)
if !emailRegex.MatchString(email) {
    return errors.New("invalid email")
}
// Also block injection patterns
```

---

## CWE References

- **CWE-601**: Open Redirect
- **CWE-208**: Observable Timing Discrepancy
- **CWE-611**: Improper Restriction of XML External Entity Reference
- **CWE-770**: Allocation of Resources Without Limits
- **CWE-20**: Improper Input Validation
- **CWE-200**: Exposure of Sensitive Information
