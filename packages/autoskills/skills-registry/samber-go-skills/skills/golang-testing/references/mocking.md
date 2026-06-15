# Mocking and Test Fixtures

## Mocks with testify/mock

Create interfaces for your dependencies, then mock them.

> For the full testify/mock API (argument matchers, call modifiers, verification), see the `samber/cc-skills-golang@golang-stretchr-testify` skill.

```go
// Define the interface
type Database interface {
    GetUser(id string) (*User, error)
    CreateUser(user *User) error
}

// Mock implementation
type MockDatabase struct {
    mock.Mock
}

func (m *MockDatabase) GetUser(id string) (*User, error) {
    args := m.Called(id)
    if args.Get(0) == nil {
        return nil, args.Error(1)
    }
    return args.Get(0).(*User), args.Error(1)
}

func (m *MockDatabase) CreateUser(user *User) error {
    args := m.Called(user)
    return args.Error(0)
}

// Usage in tests
func TestService_GetUser(t *testing.T) {
    is := assert.New(t)

    mockDB := new(MockDatabase)
    service := NewService(mockDB)

    expectedUser := &User{ID: "1", Name: "John"}
    mockDB.On("GetUser", "1").Return(expectedUser, nil)

    user, err := service.GetUser("1")

    is.NoError(err)
    is.Equal(expectedUser, user)
    mockDB.AssertExpectations(t)
}

func TestService_GetUser_NotFound(t *testing.T) {
    is := assert.New(t)

    mockDB := new(MockDatabase)
    service := NewService(mockDB)

    mockDB.On("GetUser", "999").Return(nil, ErrNotFound)

    user, err := service.GetUser("999")

    is.Error(err)
    is.ErrorIs(err, ErrNotFound)
    is.Nil(user)
    mockDB.AssertExpectations(t)
}
```

## Mock Organization

For larger codebases, organize mocks alongside the code they mock:

```go
// user_service.go
type UserService struct {
    db    Database
    email EmailService
}
type Database interface {
    GetUser(id string) (*User, error)
    CreateUser(user *User) error
}
type EmailService interface {
    SendWelcomeEmail(to string) error
}
```

```go
// user_service_test.go
package mypackage_test

import (
    "testing"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/mock"
    "path/to/mypackage"
)

// MockDatabase implements mypackage.Database
type MockDatabase struct {
    mock.Mock
}
func (m *MockDatabase) GetUser(id string) (*mypackage.User, error) {
    args := m.Called(id)
    if args.Get(0) == nil { return nil, args.Error(1) }
    return args.Get(0).(*mypackage.User), args.Error(1)
}
func (m *MockDatabase) CreateUser(user *mypackage.User) error {
    return m.Called(user).Error(0)
}

// MockEmailService implements mypackage.EmailService
type MockEmailService struct {
    mock.Mock
}
func (m *MockEmailService) SendWelcomeEmail(to string) error {
    return m.Called(to).Error(0)
}

func TestUserService_CreateUser(t *testing.T) {
    mockDB := new(MockDatabase)
    mockEmail := new(MockEmailService)
    service := mypackage.NewUserService(mockDB, mockEmail)

    user := &mypackage.User{Name: "Test", Email: "test@example.com"}
    mockDB.On("CreateUser", user).Return(nil)
    mockEmail.On("SendWelcomeEmail", "test@example.com").Return(nil)

    err := service.CreateUser(user)

    assert.NoError(t, err)
    mockDB.AssertExpectations(t)
    mockEmail.AssertExpectations(t)
}
```

## Test Fixtures

Create reusable test data in a separate package or file:

```go
package fixtures

import "time"

var (
    DefaultUser = &User{
        ID:        "user-123",
        Name:      "Jane Doe",
        Email:     "jane@example.com",
        CreatedAt: time.Date(2024, 1, 1, 0, 0, 0, 0, time.UTC),
    }

    AdminUser = &User{
        ID:        "admin-1",
        Name:      "Admin User",
        Email:     "admin@example.com",
        Role:      "admin",
        CreatedAt: time.Date(2024, 1, 1, 0, 0, 0, 0, time.UTC),
    }
)

func NewUser(name, email string) *User {
    return &User{
        ID:        "user-" + uuid.New().String(),
        Name:      name,
        Email:     email,
        CreatedAt: time.Now(),
    }
}
```

## Time Mocking

Use `clockwork` to test time-dependent code without `time.Sleep()`:

```go
import (
    "testing"
    "time"
    "github.com/jonboulle/clockwork"
    "github.com/stretchr/testify/assert"
)

func TestScheduler_AddJob(t *testing.T) {
    is := assert.New(t)

    fakeClock := clockwork.NewFakeClock()
    scheduler := NewScheduler(fakeClock)

    job := &Job{ID: "1", RunAt: time.Now().Add(1 * time.Hour)}
    scheduler.AddJob(job)

    is.Equal(1, scheduler.PendingCount())

    // Advance fake time
    fakeClock.Advance(2 * time.Hour)

    is.Equal(0, scheduler.PendingCount())
}
```

Install clockwork:

```bash
go get github.com/jonboulle/clockwork
```
