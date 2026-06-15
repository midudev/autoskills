---
name: golang-stretchr-testify
description: "Comprehensive guide to stretchr/testify for Golang testing. Covers assert, require, mock, and suite packages in depth. Use when writing tests with testify, creating mocks, setting up test suites, or choosing between assert and require. Covers testify assertions, mock expectations, argument matchers, call verification, suite lifecycle, and advanced patterns like Eventually, JSONEq, and custom matchers. Apply when the codebase imports github.com/stretchr/testify."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.0"
  openclaw:
    emoji: "✅"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
        - gotests
    install:
      - kind: go
        package: github.com/cweill/gotests/...@latest
        bins: [gotests]
    skill-library-version: "1.11.1"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs Bash(gotests:*) AskUserQuestion
---

**Persona:** You are a Go engineer who treats tests as executable specifications. You write tests to constrain behavior and make failures self-explanatory — not to hit coverage targets.

**Modes:**

- **Write mode** — adding new tests or mocks to a codebase.
- **Review mode** — auditing existing test code for testify misuse.

# stretchr/testify

testify complements Go's `testing` package with readable assertions, mocks, and suites. It does not replace `testing` — always use `*testing.T` as the entry point.

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

## assert vs require

Both offer identical assertions. The difference is failure behavior:

- **assert**: records failure, continues — see all failures at once
- **require**: calls `t.FailNow()` — use for preconditions where continuing would panic or mislead

Use `assert.New(t)` / `require.New(t)` for readability. Name them `is` and `must`:

```go
func TestParseConfig(t *testing.T) {
    is := assert.New(t)
    must := require.New(t)

    cfg, err := ParseConfig("testdata/valid.yaml")
    must.NoError(err)    // stop if parsing fails — cfg would be nil
    must.NotNil(cfg)

    is.Equal("production", cfg.Environment)
    is.Equal(8080, cfg.Port)
    is.True(cfg.TLS.Enabled)
}
```

**Rule**: `require` for preconditions (setup, error checks), `assert` for verifications. Never mix randomly.

## Core Assertions

```go
is := assert.New(t)

// Equality
is.Equal(expected, actual)              // DeepEqual + exact type
is.NotEqual(unexpected, actual)
is.EqualValues(expected, actual)        // converts to common type first
is.EqualExportedValues(expected, actual)

// Nil / Bool / Emptiness
is.Nil(obj)                  is.NotNil(obj)
is.True(cond)                is.False(cond)
is.Empty(collection)         is.NotEmpty(collection)
is.Len(collection, n)

// Contains (strings, slices, map keys)
is.Contains("hello world", "world")
is.Contains([]int{1, 2, 3}, 2)
is.Contains(map[string]int{"a": 1}, "a")

// Comparison
is.Greater(actual, threshold)     is.Less(actual, ceiling)
is.Positive(val)                  is.Negative(val)
is.Zero(val)

// Errors
is.Error(err)                     is.NoError(err)
is.ErrorIs(err, ErrNotFound)      // walks error chain
is.ErrorAs(err, &target)
is.ErrorContains(err, "not found")

// Type
is.IsType(&User{}, obj)
is.Implements((*io.Reader)(nil), obj)
```

**Argument order**: always `(expected, actual)` — swapping produces confusing diff output.

## Advanced Assertions

```go
is.ElementsMatch([]string{"b", "a", "c"}, result)             // unordered comparison
is.InDelta(3.14, computedPi, 0.01)                            // float tolerance
is.JSONEq(`{"name":"alice"}`, `{"name": "alice"}`)             // ignores whitespace/key order
is.WithinDuration(expected, actual, 5*time.Second)
is.Regexp(`^user-[a-f0-9]+$`, userID)

// Async polling
is.Eventually(func() bool {
    status, _ := client.GetJobStatus(jobID)
    return status == "completed"
}, 5*time.Second, 100*time.Millisecond)

// Async polling with rich assertions
is.EventuallyWithT(func(c *assert.CollectT) {
    resp, err := client.GetOrder(orderID)
    assert.NoError(c, err)
    assert.Equal(c, "shipped", resp.Status)
}, 10*time.Second, 500*time.Millisecond)
```

## testify/mock

Mock interfaces to isolate the unit under test. Embed `mock.Mock`, implement methods with `m.Called()`, always verify with `AssertExpectations(t)`.

Key matchers: `mock.Anything`, `mock.AnythingOfType("T")`, `mock.MatchedBy(func)`. Call modifiers: `.Once()`, `.Times(n)`, `.Maybe()`, `.Run(func)`.

For defining mocks, argument matchers, call modifiers, return sequences, and verification, see [Mock reference](./references/mock.md).

## testify/suite

Suites group related tests with shared setup/teardown.

### Lifecycle

```
SetupSuite()    → once before all tests
  SetupTest()   → before each test
    TestXxx()
  TearDownTest() → after each test
TearDownSuite() → once after all tests
```

### Example

```go
type TokenServiceSuite struct {
    suite.Suite
    store   *MockTokenStore
    service *TokenService
}

func (s *TokenServiceSuite) SetupTest() {
    s.store = new(MockTokenStore)
    s.service = NewTokenService(s.store)
}

func (s *TokenServiceSuite) TestGenerate_ReturnsValidToken() {
    s.store.On("Save", mock.Anything, mock.Anything).Return(nil)
    token, err := s.service.Generate("user-42")
    s.NoError(err)
    s.NotEmpty(token)
    s.store.AssertExpectations(s.T())
}

// Required launcher
func TestTokenServiceSuite(t *testing.T) {
    suite.Run(t, new(TokenServiceSuite))
}
```

Suite methods like `s.Equal()` behave like `assert`. For require: `s.Require().NotNil(obj)`.

## Common Mistakes

- **Forgetting `AssertExpectations(t)`** — mock expectations silently pass without verification
- **`is.Equal(ErrNotFound, err)`** — fails on wrapped errors. Use `is.ErrorIs` to walk the chain
- **Swapped argument order** — testify assumes `(expected, actual)`. Swapping produces backwards diffs
- **`assert` for guards** — test continues after failure and panics on nil dereference. Use `require`
- **Missing `suite.Run()`** — without the launcher function, zero tests execute silently
- **Comparing pointers** — `is.Equal(ptr1, ptr2)` compares addresses. Dereference or use `EqualExportedValues`

## Linters

Use `testifylint` to catch wrong argument order, assert/require misuse, and more. See `samber/cc-skills-golang@golang-lint` skill.

## Cross-References

- → See `samber/cc-skills-golang@golang-testing` skill for general test patterns, table-driven tests, and CI
- → See `samber/cc-skills-golang@golang-lint` skill for testifylint configuration
