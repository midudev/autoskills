# Logging Security Rules

Logging sensitive information can lead to data exposure and compliance violations.

**Rules:**

1. PII MUST NEVER be logged — filter passwords, tokens, emails, and personal data.
2. Log injection MUST be prevented — sanitize user input before logging.
3. Error messages MUST NOT expose internals to users — log details server-side, return generic messages.

---

## Sensitive Data in Logs — Medium

**Bad:**

```go
type User struct {
    ID       string
    Username string
    Password string
    Token    string
}

func logUserLogin(user *User) {
    log.Printf("User logged in: %+v\n", user)  // DON'T: Logs password, token
}
```

**Good:**

```go
import "log/slog"

func logUserLogin(logger *slog.Logger, user *User) {
    logger.Info("user_login",
        "user_id", user.ID,
        "username", user.Username,
        // Don't log: password, token
    )
}
```

---

## Log Injection — Low

User input in logs can lead to log injection attacks.

**Bad:**

```go
log.Printf("User logged in: %s\n", username)  // DON'T: No sanitization
```

**Good:**

```go
import "log/slog"

// Sanitize user input before logging
func sanitizeLogInput(input string) string {
    // Remove control characters
    var result strings.Builder
    for _, r := range input {
        if !unicode.IsControl(r) || r == '\n' || r == '\t' {
            result.WriteRune(r)
        }
    }
    return result.String()
}

func logUsername(logger *slog.Logger, username string) {
    sanitized := sanitizeLogInput(username)
    logger.Info("user_login", "username", sanitized)
}
```

---

## Information Leakage in Error Messages — Medium

**Bad:**

```go
func handleDatabaseError(err error) error {
    return fmt.Errorf("database error: %v", err)  // DON'T: Leaks internal details
}

func dbErrorToHTTP(err error) {
    http.Error(w, "Error: "+err.Error(), 500)  // DON'T
}
```

**Good:**

```go
func handleDatabaseError(logger *slog.Logger, err error) error {
    // Log detailed error for debugging
    logger.Error("database_error", "error", err.Error())
    // Return generic message to client
    return errors.New("database operation failed")
}

func dbErrorToHTTP(w http.ResponseWriter, logger *slog.Logger, err error) {
    logger.Error("database_error", "error", err.Error())
    http.Error(w, "Internal server error", http.StatusInternalServerError)
}
```

---

## General Logger Security — Low

**Bad:**

```go
import "log"
log.Println("User logged in:", user.ID, password)  // DON'T: Logs password
fmt.Printf("DEBUG: %+v\n", data)  // DON'T: Raw data
```

**Good:**

```go
import "log/slog"

handler := slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
    Level:     slog.LevelInfo,
    AddSource: false,
})
logger := slog.New(handler)

logger.Info("user_login",
    "user_id", userID,
    "ip_address", request.RemoteIP,
)
```

---

## Log Security Checklist

- [ ] No passwords, tokens, or secrets in logs
- [ ] No PII/PHI in production logs
- [ ] Sanitize user input before logging
- [ ] Use structured logging (JSON)
- [ ] Implement log level strategy
- [ ] Separate access logs from error logs
- [ ] Log file permissions restricted (e.g., 600)
- [ ] Log rotation prevents disk exhaustion
- [ ] Generic error messages to clients
- [ ] Detailed errors only in internal logs

---

## CWE References

- **CWE-532**: Insertion of Sensitive Information into Log File
- **CWE-117**: Improper Output Neutralization for Logs
- **CWE-209**: Information Exposure Through an Error Message
- **CWE-200**: Exposure of Sensitive Information
- **CWE-312**: Cleartext Storage of Sensitive Information
