# Integration Testing

## Docker Compose Fixture

Create `pkg/myfeature/testdata/docker-compose.yml` for test services:

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: test
      POSTGRES_PASSWORD: test
      POSTGRES_DB: testdb
    ports:
      - "5433:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U test"]
      interval: 5s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6380:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 5s
      timeout: 5s
      retries: 5
```

## SQL Schema Fixture

Create `pkg/myfeature/testdata/schema.sql` for database initialization:

```sql
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Test Data Fixture

Create `pkg/myfeature/testdata/testdata.sql`:

```sql
INSERT INTO users (name, email) VALUES
    ('Alice Johnson', 'alice@example.com'),
    ('Bob Smith', 'bob@example.com'),
    ('Charlie Brown', 'charlie@example.com');

INSERT INTO orders (user_id, amount, status) VALUES
    (1, 100.00, 'completed'),
    (1, 50.00, 'pending'),
    (2, 200.00, 'completed');
```

## Using Fixtures in Tests

```go
//go:build integration

package database_test

import (
    "database/sql"
    "os"
    "os/exec"
    "testing"
    "time"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/suite"
)

type DatabaseTestSuite struct {
    suite.Suite
    db *sql.DB
}

func (s *DatabaseTestSuite) SetupSuite() {
    cmd := exec.Command("docker-compose", "-f", "testdata/docker-compose.yml", "up", "-d")
    if err := cmd.Run(); err != nil {
        s.T().Fatalf("failed to start docker-compose: %v", err)
    }

    time.Sleep(5 * time.Second)

    db, err := sql.Open("postgres", "postgres://test:test@localhost:5433/testdb?sslmode=disable")
    if err != nil {
        s.T().Fatalf("failed to connect to database: %v", err)
    }
    s.db = db

    schema, _ := os.ReadFile("testdata/schema.sql")
    _, err = db.Exec(string(schema))
    if err != nil {
        s.T().Fatalf("failed to run schema: %v", err)
    }
}

func (s *DatabaseTestSuite) TearDownSuite() {
    cmd := exec.Command("docker-compose", "-f", "testdata/docker-compose.yml", "down", "-v")
    _ = cmd.Run()
}

func (s *DatabaseTestSuite) SetupTest() {
    _, err := s.db.Exec("TRUNCATE TABLE orders, users CASCADE")
    if err != nil {
        s.T().Fatalf("failed to clear database: %v", err)
    }

    testdata, _ := os.ReadFile("testdata/testdata.sql")
    _, err = s.db.Exec(string(testdata))
    if err != nil {
        s.T().Fatalf("failed to load test data: %v", err)
    }
}

func (s *DatabaseTestSuite) TestUserCount() {
    is := assert.New(s.T())

    var count int
    err := s.db.QueryRow("SELECT COUNT(*) FROM users").Scan(&count)
    is.NoError(err)
    is.Equal(3, count)
}

func (s *DatabaseTestSuite) TestOrderSum() {
    is := assert.New(s.T())

    var sum float64
    err := s.db.QueryRow("SELECT SUM(amount) FROM orders").Scan(&sum)
    is.NoError(err)
    is.InDelta(350.0, sum, 0.01)
}

func TestDatabaseTestSuite(t *testing.T) {
    suite.Run(t, new(DatabaseTestSuite))
}
```

## Test Helper with Embedded Fixtures

```go
package myfeature

import (
    "database/sql"
    "embed"
)

//go:embed testdata/schema.sql testdata/testdata.sql
var fixtures embed.FS

func SetupDB(db *sql.DB) error {
    schema, err := fixtures.ReadFile("testdata/schema.sql")
    if err != nil {
        return err
    }
    if _, err := db.Exec(string(schema)); err != nil {
        return err
    }

    data, err := fixtures.ReadFile("testdata/testdata.sql")
    if err != nil {
        return err
    }
    if _, err := db.Exec(string(data)); err != nil {
        return err
    }
    return nil
}
```
