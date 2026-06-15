# Secrets Management Security Rules

Hardcoded secrets, credentials, and sensitive data in source code is a major security vulnerability.

**Rules:**

1. Secrets MUST be loaded from environment variables or secret managers.
2. NEVER commit secrets to VCS.
3. `.gitignore` MUST exclude secret files (`.env`, `*.key`, `*.pem`).

---

## Hardcoded Secrets and Credentials — Critical

**Bad:**

```go
const (
    AWS_ACCESS_KEY    = "AKIAIOSFODNN7EXAMPLE"  // DON'T
    AWS_SECRET_KEY    = "wJalrXUtnFEMI/K7MDENG"  // DON'T
    DATABASE_PASSWORD = "SuperSecret123!"         // DON'T
    JWT_SECRET        = "my-super-secret-jwt-key" // DON'T
)

var config = Config{
    APIKey:  "abc123-xyz789-secret-key", // DON'T
    Secret:  "my-super-secret-value",    // DON'T
    DatabaseURL: "user:passw0rd!@localhost:5432/db", // DON'T
}
```

**Good:**

```go
import "os"

type Config struct {
    AWSAccessKey     string
    AWSSecretKey     string
    DatabasePassword string
    JWTSecret        string
}

func LoadConfig() (*Config, error) {
    cfg := &Config{
        AWSAccessKey:     os.Getenv("AWS_ACCESS_KEY_ID"),
        AWSSecretKey:     os.Getenv("AWS_SECRET_ACCESS_KEY"),
        DatabasePassword: os.Getenv("DATABASE_PASSWORD"),
        JWTSecret:        os.Getenv("JWT_SECRET"),
    }

    if cfg.JWTSecret == "" {
        return nil, errors.New("JWT_SECRET is required")
    }
    return cfg, nil
}
```

---

## Hardcoded Database Passwords — Critical

**Bad:**

```go
// MySQL
dsn := "user:Password123!@tcp(localhost:3306)/dbname" // DON'T

// PostgreSQL
dsn := "user=postgres password=P@ssw0rd! dbname=mydb host=localhost" // DON'T
```

**Good:**

```go
// MySQL
func connectMySQL() (*sql.DB, error) {
    user := os.Getenv("DB_USER")
    password := os.Getenv("DB_PASSWORD")
    if password == "" {
        return nil, errors.New("DB_PASSWORD required")
    }
    host := getEnvWithDefault("DB_HOST", "localhost")
    port := getEnvWithDefault("DB_PORT", "3306")
    addr := net.JoinHostPort(host, port)
    dsn := fmt.Sprintf("%s:%s@tcp(%s)/%s",
        user, password, addr, getEnvWithDefault("DB_NAME", "mydb"))
    return sql.Open("mysql", dsn)
}

// PostgreSQL
func connectPostgres() (*sql.DB, error) {
    connStr := os.Getenv("DATABASE_URL")
    if connStr == "" {
        return nil, errors.New("DATABASE_URL required")
    }
    return sql.Open("postgres", connStr)
}
```

---

## Secrets Storage Best Practices

### Environment Variables

```go
type EnvSecretLoader struct{}

func (l *EnvSecretLoader) Load(required []string) (map[string]string, error) {
    secrets := make(map[string]string)
    missing := []string{}
    for _, name := range required {
        value := os.Getenv(name)
        if value == "" {
            missing = append(missing, name)
            continue
        }
        secrets[name] = value
    }
    if len(missing) > 0 {
        return nil, fmt.Errorf("missing: %v", missing)
    }
    return secrets, nil
}
```

### Secret Managers

```go
type SecretManager interface {
    GetSecret(name string) (string, error)
}

// AWS Secrets Manager
type AWSSecretsManager struct {
    client *secretsmanager.Client
}

func (m *AWSSecretsManager) GetSecret(name string) (string, error) {
    result, err := m.client.GetSecretValue(context.TODO(), &secretsmanager.GetSecretValueInput{
        SecretId: aws.String(name),
    })
    if err != nil {
        return "", err
    }
    if result.SecretString != nil {
        return *result.SecretString, nil
    }
    return string(result.SecretBinary), nil
}
```

### .gitignore Patterns

```
# Secrets
.env
.env.local
.env.*.local
*.key
*.pem
*.p12
*.pfx
secrets/
credentials/
```

---

## Secret Detection Patterns

| Pattern         | Example                         |
| --------------- | ------------------------------- |
| API Keys        | `Key = "sk_live_..."`           |
| Passwords       | `password = "..."`              |
| Tokens          | `token = "..."`                 |
| Private Keys    | `BEGIN PRIVATE KEY`             |
| AWS Credentials | `AWS_ACCESS_KEY_ID = "AKIA..."` |
| JWT Secrets     | `jwtSecret = "..."`             |

---

## CWE References

- **CWE-798**: Use of Hard-coded Credentials
- **CWE-312**: Cleartext Storage of Sensitive Information
- **CWE-532**: Insertion of Sensitive Information into Log File
- **CWE-359**: Exposure of Private Personal Information
