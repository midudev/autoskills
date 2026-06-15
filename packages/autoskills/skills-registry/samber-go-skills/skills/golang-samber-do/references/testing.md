# Testing with samber/do

## Container Cloning

Clone containers for isolated tests:

```go
func TestUserService(t *testing.T) {
    // Create test container by cloning main container
    testInjector := mainInjector.Clone()

    // Override with mocks
    mockDB := &MockDatabase{}
    do.OverrideValue(testInjector, mockDB)

    // Test with mocked dependencies
    service := do.MustInvoke[UserService](testInjector)
    // ... test code
}
```

## Reusable Test Helpers

```go
func SetupTestContainer(t *testing.T) do.Injector {
    injector := do.New()

    do.Provide(injector, func(i do.Injector) (Database, error) {
        return &MockDatabase{}, nil
    })

    return injector
}
```

## Quick Reference

### Testing & Overrides

| Function                         | Purpose                         |
| -------------------------------- | ------------------------------- |
| `injector.Clone()`               | Clone container for testing     |
| `injector.CloneWithOpts()`       | Clone with custom options       |
| `do.Override[T]()`               | Replace service (use in tests)  |
| `do.OverrideNamed[T]()`          | Replace named service           |
| `do.OverrideValue[T]()`          | Replace value service           |
| `do.OverrideNamedValue[T]()`     | Replace named value             |
| `do.OverrideTransient[T]()`      | Replace transient factory       |
| `do.OverrideNamedTransient[T]()` | Replace named transient factory |
