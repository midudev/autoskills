# Injection Security Rules

Injection vulnerabilities allow attackers to execute arbitrary code, queries, or commands.

**Rules:**

1. SQL queries MUST use parameterized placeholders — NEVER concatenate user input.
2. Command execution MUST use `exec.Command` with separate args — NEVER shell interpolation.
3. HTML output MUST use `html/template` for automatic escaping.
4. SSRF: outbound URLs MUST be validated against an allowlist.

---

## SQL Injection — Critical

Building SQL queries by concatenating user input. Always use prepared statements with placeholders.

**Bad:**

```go
query := fmt.Sprintf("SELECT * FROM users WHERE name = '%s'", input)
query := "SELECT * FROM users WHERE id = " + id
query := "DELETE FROM orders WHERE id = " + strconv.Itoa(orderID) // safe but inconsistent — use placeholders everywhere
```

**Good:**

```go
// Placeholder syntax varies by driver: $1 (pgx/lib/pq), ? (MySQL/SQLite)
db.QueryRow("SELECT * FROM users WHERE name = $1", input)
db.Exec("DELETE FROM orders WHERE id = $1", orderID)
```

### Dynamic IN clauses

Never build `IN (...)` by joining user strings. Generate numbered placeholders.

**Bad:**

```go
query := fmt.Sprintf("SELECT * FROM users WHERE id IN (%s)", strings.Join(ids, ","))
```

**Good:**

```go
// Build placeholders: $1, $2, $3, ...
placeholders := make([]string, len(ids))
args := make([]any, len(ids))
for i, id := range ids {
    placeholders[i] = fmt.Sprintf("$%d", i+1)
    args[i] = id
}
query := fmt.Sprintf("SELECT * FROM users WHERE id IN (%s)", strings.Join(placeholders, ","))
rows, err := db.Query(query, args...)
```

With `sqlx`:

```go
query, args, err := sqlx.In("SELECT * FROM users WHERE id IN (?)", ids)
query = db.Rebind(query) // converts ? to $1,$2,... for postgres
rows, err := db.Query(query, args...)
```

### Dynamic column names and ORDER BY

Placeholders only work for **values**, not identifiers (table/column names) or SQL keywords. Allowlist identifiers explicitly.

**Bad:**

```go
query := fmt.Sprintf("SELECT * FROM users ORDER BY %s", sortCol) // SQL injection
```

**Good:**

```go
allowed := map[string]string{
    "name": "name", "created": "created_at", "email": "email",
}
col, ok := allowed[sortCol]
if !ok {
    col = "created_at"
}
query := fmt.Sprintf("SELECT * FROM users ORDER BY %s", col) // safe: col is from allowlist
```

### Dynamic WHERE filters

Build queries incrementally; parameterize every user-supplied value.

```go
var conditions []string
var args []any
idx := 1

if name != "" {
    conditions = append(conditions, fmt.Sprintf("name = $%d", idx))
    args = append(args, name)
    idx++
}
if minAge > 0 {
    conditions = append(conditions, fmt.Sprintf("age >= $%d", idx))
    args = append(args, minAge)
    idx++
}

query := "SELECT * FROM users"
if len(conditions) > 0 {
    query += " WHERE " + strings.Join(conditions, " AND ")
}
rows, err := db.Query(query, args...)
```

### Prefer `sqlx` or `pgx` over raw `database/sql`

Libraries like `sqlx` and `pgx` provide safer ergonomics (named parameters, `IN` clause expansion, struct scanning) while still using prepared statements under the hood. They reduce the temptation to fall back to string concatenation for complex queries.

---

## XPath Injection — High

XPath injection allows manipulation of XML data queries.

**Bad:**

```go
xpathQuery := "//user[@username='" + username + "']" // Vulnerable
```

**Good:**

```go
// Use numeric ID
xpathQuery := fmt.Sprintf("//user[@id='%d']", userID)

// Or parse XML without XPath
```

---

## Code Injection — Critical

Generating code from unvalidated user input.

**Bad:**

```go
template := "func handle" + resourceName + "() {...}" // DON'T
```

**Good:**

```go
// Validate resource name matches whitelist
if !allowedResources[resourceName] {
    return errors.New("invalid resource")
}
// Use predefined templates
```

---

## Command Injection — Critical

Passing unvalidated input to shell commands.

**Bad:**

```go
cmd := exec.Command("sh", "-c", "rm -f /tmp/"+filename) // DON'T
```

**Good:**

```go
cmd := exec.Command("rm", "-f", filepath.Join("/tmp", filename))

// Better: validate filename
if filepath.Base(filename) != filename {
    return errors.New("invalid filename")
}
```

---

## Template Injection — High

Using untrusted input in templates.

**Bad:**

```go
data := r.URL.Query().Get("user") // Untrusted input
t.Execute(w, data)
```

**Good:**

```go
// Validate input
user := strings.TrimSpace(r.URL.Query().Get("user"))
if !allowedRoles[role] {
    role = "user"
}
t.Execute(w, data)
```

---

## Cross-Site Scripting (XSS) — High

XSS allows attackers to execute malicious scripts.

**Bad:**

```go
w.Write([]byte(fmt.Sprintf("<div>%s</div>", data))) // DON'T
```

**Good:**

```go
import "html/template"
t := template.Must(template.New("safe").Parse("<div>{{.}}</div>"))
t.Execute(w, data) // Auto-escapes
```

---

## HTML Tag Injection — High

Injecting HTML tags through unvalidated input.

**Bad:**

```go
fmt.Fprintf(w, "<div>Welcome, %s!</div>", input) // DON'T
```

**Good:**

```go
import "html"
escaped := html.EscapeString(input)
fmt.Fprintf(w, "<div>Welcome, %s!</div>", escaped)
```

---

## Server-Side Request Forgery (SSRF) — High

Forcing the server to make requests to unintended endpoints.

**Bad:**

```go
url := r.URL.Query().Get("url")
resp, _ := http.Get(url) // DON'T: No validation
```

**Good:**

```go
u, err := url.Parse(targetURL)
// Block non-HTTP/S protocols
if u.Scheme != "http" && u.Scheme != "https" {
    return errors.New("invalid scheme")
}
// Block internal hosts
if isInternalIP(u.Hostname()) {
    return errors.New("internal host not allowed")
}
// Block metadata endpoints
if strings.Contains(u.Hostname(), "metadata.") {
    return errors.New("metadata endpoint blocked")
}
```

---

## Unsafe Deserialization — Critical

Deserializing untrusted input can lead to resource exhaustion, type confusion, or unsafe object construction.

**Bad:**

```go
dec := gob.NewDecoder(r.Body) // DON'T: gob is not hardened for adversarial input
var user interface{}
dec.Decode(&user)
```

**Good:**

```go
import "encoding/json"
dec := json.NewDecoder(r.Body)
var user User
dec.Decode(&user) // JSON doesn't execute code
// Validate fields
```

---

## CWE References

- **CWE-78**: OS Command Injection
- **CWE-89**: SQL Injection
- **CWE-94**: Code Injection
- **CWE-79**: Cross-site Scripting (XSS)
- **CWE-918**: Server-Side Request Forgery (SSRF)
- **CWE-502**: Deserialization of Untrusted Data
- **CWE-20**: Improper Input Validation
