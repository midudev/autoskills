# Rails Security Review — Pitfalls

| Pitfall | Reality |
|---------|---------|
| "Only internal users access this" | Internal tools get compromised — apply the same standards |
| `permit!` "just for now" | It will ship. Whitelist from day one |
| "Rails handles CSRF automatically" | Only if `protect_from_forgery` is active and tokens are verified |
| String interpolation in SQL | SQL injection — always use parameterized queries |
| `html_safe` on user content | XSS — only call on developer-controlled strings |
| Secrets in committed files | Use encrypted credentials. Rotate immediately if exposed |
| No authorization before destructive actions | Always check permissions, even for internal routes |
| Background job inputs not validated | Jobs are entry points — validate inputs like a controller |
