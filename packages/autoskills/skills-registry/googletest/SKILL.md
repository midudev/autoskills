---
name: googletest
description: "Write and run C++ unit tests with Google Test and Google Mock. Use when creating test files, writing assertions, mocking classes, parameterized tests, or integrating GTest with CMake. Covers GTest 1.14+."
metadata:
  version: "1.0"
  source: "autoskills"
---

# Google Test (GTest + GMock)

## When to Use

- Writing unit tests for C/C++ code
- Creating test fixtures for shared setup/teardown
- Mocking classes and functions with Google Mock
- Parameterized testing
- Setting up test suites with CMake integration
- Writing death tests for crash/assertion handling

## Quick Reference

### Essential Patterns

| Pattern | Macro/Class | Notes |
|---------|-------------|-------|
| Test | `TEST(Suite, Name)` | Simple test case |
| Test fixture | `TEST_F(Fixture, Name)` | Shared state |
| Assertion | `EXPECT_EQ`, `ASSERT_TRUE` | Non-fatal / fatal |
| Mock | `MOCK_METHOD` | Define mock methods |
| Death test | `EXPECT_DEATH` | Test crashes/assertions |
| Parameterized | `TEST_P` | Data-driven tests |
| Type parameterized | `TYPED_TEST` | Generic tests |

## Writing Tests

### Basic Test

```cpp
#include <gtest/gtest.h>
#include "mylib.h"

TEST(MathTest, Addition) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(MathTest, DivisionByZero) {
    EXPECT_THROW(divide(1, 0), std::invalid_argument);
}
```

### Test Fixtures

```cpp
class DatabaseTest : public ::testing::Test {
protected:
    void SetUp() override {
        db_.connect(":memory:");
        db_.execute("CREATE TABLE users (id INT, name TEXT)");
    }

    void TearDown() override {
        db_.disconnect();
    }

    Database db_;
};

TEST_F(DatabaseTest, InsertAndQuery) {
    db_.execute("INSERT INTO users VALUES (1, 'Alice')");
    auto result = db_.query("SELECT name FROM users WHERE id=1");
    EXPECT_EQ(result.size(), 1u);
    EXPECT_EQ(result[0]["name"], "Alice");
}
```

### Google Mock

```cpp
class Logger {
public:
    virtual ~Logger() = default;
    virtual void log(const std::string& msg) = 0;
    virtual void flush() = 0;
};

class MockLogger : public Logger {
public:
    MOCK_METHOD(void, log, (const std::string& msg), (override));
    MOCK_METHOD(void, flush, (), (override));
};

TEST(ServiceTest, LogsOnFailure) {
    MockLogger logger;
    Service service(&logger);

    EXPECT_CALL(logger, log(testing::HasSubstr("error")))
        .Times(1);
    EXPECT_CALL(logger, flush()).Times(1);

    service.processInvalidInput();
}
```

### Argument Matchers

```cpp
using testing::_;
using testing::Eq;
using testing::HasSubstr;
using testing::Return;
using testing::NotNull;
using testing::AllOf;
using testing::Ge;
using testing::Le;

EXPECT_CALL(mock, func(HasSubstr("hello")));
EXPECT_CALL(mock, func(AllOf(Ge(0), Le(100))));
EXPECT_CALL(mock, func(_)).WillRepeatedly(Return(true));
```

### Parameterized Tests

```cpp
class PrimeTest : public ::testing::TestWithParam<int> {};

TEST_P(PrimeTest, IsPrime) {
    EXPECT_TRUE(isPrime(GetParam()));
}

INSTANTIATE_TEST_SUITE_P(
    Primes,
    PrimeTest,
    ::testing::Values(2, 3, 5, 7, 11, 13, 17, 19, 23, 29));
```

### Type Parameterized Tests

```cpp
template<typename T>
class NumericTest : public ::testing::Test {};

TYPED_TEST(NumericTest, ZeroIsZero) {
    using T = TypeParam;
    T zero = 0;
    EXPECT_EQ(zero + zero, zero);
}

TYPED_TEST_SUITE(NumericTest, ::testing::Types<int, float, double>);
```

### Death Tests

```cpp
TEST(AbortTest, AssertionCausesAbort) {
    EXPECT_DEATH(std::abort(), ".*");
}
```

## CMake Integration

```cmake
include(FetchContent)
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG v1.14.0
)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_executable(tests test_main.cpp test_mylib.cpp)
target_link_libraries(tests PRIVATE GTest::gtest_main mylib)

include(GoogleTest)
gtest_discover_tests(tests)
```

## Command Line

```bash
# Run all tests
./tests

# Run specific test
./tests --gtest_filter=MathTest.Addition

# Run all tests matching pattern
./tests --gtest_filter=MathTest.*

# List available tests
./tests --gtest_list_tests

# Repeat N times
./tests --gtest_repeat=100

# Print non-fatal failures
./tests --gtest_print_time=1

# Shuffle tests
./tests --gtest_shuffle
```

## Best Practices

- Use `EXPECT_*` (non-fatal) over `ASSERT_*` (fatal) when possible
- One logical assertion per test — but multiple `EXPECT_*` is fine
- Use descriptive test names: `TEST_F(ServiceTest, ReturnsErrorWhenDatabaseUnavailable)`
- Keep `SetUp`/`TearDown` simple — avoid complex logic in fixtures
- Use `NiceMock<T>` to suppress unexpected call warnings
- Use `TEST_P` for data-driven tests with many input combinations
- Use `testing::StrictMock<T>` to fail on any unexpected call

## Common Gotchas

- `ASSERT_*` aborts the current function on failure — use sparingly
- Mock expectations are checked at destruction time (end of test scope)
- Use `WillOnce` for exact call counts, `WillRepeatedly` for default behavior
- `EXPECT_CALL` order matters — later expectations take precedence
- Link against `GTest::gtest_main` to skip writing your own `main()`
- `gtest_discover_tests` requires CMake 3.10+ and CTest

## Verification Checklist

- [ ] All tests pass with `ctest` or `./tests`
- [ ] No memory leaks (ASan clean)
- [ ] Mock expectations are verified (no uninteresting mock warnings)
- [ ] Death tests cover critical invariants
- [ ] Test names are descriptive
