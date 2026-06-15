# Security Review Checklist

Severity: Critical, High, Medium, Low

## Input Handling

- [ ] **High** All user input validated at system boundaries — internal code trusts the boundary
- [ ] **High** Input uses allowlists, not blocklists — blocklists always miss something
- [ ] **High** Sanitized on output (HTML, SQL, shell) — context-dependent escaping
- [ ] **Medium** Length limits enforced — prevents buffer abuse and DoS

## Database

- [ ] **Critical** SQL queries use parameterized placeholders — keeps data and code separate
- [ ] **Critical** ORM/library protects against SQL injection
- [ ] **Critical** No direct SQL construction with user input

## Code Execution

- [ ] **Critical** No `exec.Command()` with shell arguments — metacharacters enable injection
- [ ] **Critical** No eval, reflection on untrusted input — arbitrary code execution risk
- [ ] **Critical** No deserialization of untrusted data — can trigger arbitrary constructors

## Cryptography

- [ ] **High** Uses `crypto/rand` for security-critical randomness — `math/rand` is predictable
- [ ] **High** Uses vetted algorithms (AES-GCM, Argon2id, bcrypt) — custom crypto hasn't been analyzed
- [ ] **Critical** Proper key management — hardcoded secrets leak through VCS, logs, and backups
- [ ] **Medium** HMAC for message authentication — prevents tampering

## Web Security

- [ ] **High** TLS 1.2+ configured correctly — older versions have known attacks
- [ ] **Medium** Security headers set (HSTS, CSP, X-Frame-Options) — prevents framing, sniffing, downgrade
- [ ] **Medium** CSRF protection for state-changing requests — prevents cross-origin action forgery
- [ ] **Medium** Open redirects validated — attackers use your domain to redirect to phishing
- [ ] **High** XSS protected via `html/template` auto-escaping

## Authentication/Authorization

- [ ] **High** Passwords hashed with Argon2id (preferred) or bcrypt — intentionally slow to resist brute-force
- [ ] **High** Sessions use secure tokens from `crypto/rand`
- [ ] **High** Authorization checked on every privileged action — not just at login
- [ ] **High** JWT tokens validated (algorithm, claims, expiry) — unsigned JWTs bypass auth
- [ ] **High** Expired/invalid sessions invalidated server-side

## Error Handling

- [ ] **Medium** Generic error messages to users — detailed errors help attackers map your system
- [ ] **Medium** Detailed errors logged server-side only
- [ ] **Medium** Stack traces not leaked to clients
- [ ] **Medium** Database errors not exposed — reveals schema and query structure

## Dependency Security

- [ ] **High** `govulncheck` passes — catches known CVEs in your dependency tree
- [ ] **High** Dependencies updated regularly — unpatched deps are the #1 attack vector
- [ ] **Medium** Third-party libraries reviewed for security posture

## HTTP Security Headers

- [ ] **Medium** `Content-Security-Policy` set — restricts resource sources to prevent XSS
- [ ] **Medium** `X-Frame-Options: DENY` — prevents clickjacking via iframe embedding
- [ ] **Medium** `X-Content-Type-Options: nosniff` — prevents MIME-type sniffing attacks
- [ ] **Medium** `Strict-Transport-Security` with `includeSubDomains` — forces HTTPS, prevents downgrade
- [ ] **Low** `Referrer-Policy` set — controls referrer header leakage to external sites
- [ ] **Low** `Permissions-Policy` set — restricts browser features (camera, mic, geolocation)

## Rate Limiting & DoS Prevention

- [ ] **Medium** HTTP server has `ReadTimeout`, `WriteTimeout`, `IdleTimeout` — prevents Slowloris
- [ ] **Medium** Request body size limited with `http.MaxBytesReader` — prevents memory exhaustion
- [ ] **Medium** Rate limiting on authentication endpoints — prevents brute-force and credential stuffing
- [ ] **Medium** Rate limiting on expensive operations (search, export, file upload)

## Concurrency

- [ ] **High** `-race` detector passes — races cause data corruption and can bypass auth checks
- [ ] **High** Shared state properly synchronized
- [ ] **High** No data races on global variables
