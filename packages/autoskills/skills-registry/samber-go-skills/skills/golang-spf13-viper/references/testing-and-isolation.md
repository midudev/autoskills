# Viper Test Isolation

## The global state problem

The top-level `viper.*` functions operate on a global `*viper.Viper` instance shared across all tests in the same process. Tests that call `viper.SetConfigFile`, `viper.Set`, or `viper.ReadInConfig` pollute this global state, causing flaky test ordering.

```go
// ✗ Bad — sets global state that affects later tests
func TestPortConfig(t *testing.T) {
    viper.SetDefault("port", 8080)
    viper.Set("port", 9090)
    assert.Equal(t, 9090, viper.GetInt("port"))
    // global viper now has port=9090 for all subsequent tests
}
```

## viper.New() per test (correct approach)

```go
func TestPortConfig(t *testing.T) {
    v := viper.New()
    v.SetDefault("port", 8080)
    v.Set("port", 9090)
    assert.Equal(t, 9090, v.GetInt("port"))
}

func TestDefaultPort(t *testing.T) {
    v := viper.New()
    v.SetDefault("port", 8080)
    assert.Equal(t, 8080, v.GetInt("port"))  // clean — not affected by TestPortConfig
}
```

## Injecting viper into your app

For test isolation to work, your application code must accept a `*viper.Viper` instead of calling the global functions directly:

```go
// ✓ Good — accepts a viper instance
type Server struct {
    cfg *viper.Viper
}

func NewServer(v *viper.Viper) *Server {
    return &Server{cfg: v}
}

func (s *Server) Port() int {
    return s.cfg.GetInt("port")
}

// In tests:
func TestServer(t *testing.T) {
    v := viper.New()
    v.Set("port", 9090)
    s := NewServer(v)
    assert.Equal(t, 9090, s.Port())
}

// In main:
func main() {
    // viper setup...
    s := NewServer(viper.GetViper())  // pass the global instance in production
}
```

## Reading config files in tests

```go
func TestReadConfig(t *testing.T) {
    v := viper.New()
    v.SetConfigFile("testdata/config.yaml")
    require.NoError(t, v.ReadInConfig())
    assert.Equal(t, "localhost", v.GetString("host"))
}
```

Use `testdata/` for config files. Go test tooling sets the working directory to the package directory, so relative paths work reliably.

## t.Setenv interactions

`t.Setenv` sets an env var for the duration of a test and restores it on cleanup. Combined with `viper.New()` + `AutomaticEnv`, this lets you test env var binding without global pollution:

```go
func TestEnvBinding(t *testing.T) {
    t.Setenv("MYAPP_PORT", "9090")

    v := viper.New()
    v.SetEnvPrefix("MYAPP")
    v.AutomaticEnv()

    assert.Equal(t, 9090, v.GetInt("port"))
    // t.Setenv restores original MYAPP_PORT (or unsets it) after this test
}
```

## viper.Reset() — use with caution

`viper.Reset()` resets the global viper instance to its zero state. It is rarely the right solution:

- It affects all code running concurrently that also uses the global viper.
- It does not stop any active `WatchConfig` goroutines.
- Using it in `TestMain` or `t.Cleanup` makes tests order-dependent.

Prefer `viper.New()` per test. Reserve `Reset()` for tools that call into viper-based libraries and must restore state between runs.

## Snapshot and restore pattern

When you cannot refactor to inject `*viper.Viper` and must use the global:

```go
func snapshotViper() map[string]interface{} {
    return viper.AllSettings()
}

func restoreViper(snapshot map[string]interface{}) {
    viper.Reset()
    for k, v := range snapshot {
        viper.Set(k, v)
    }
}

func TestWithGlobalViper(t *testing.T) {
    snapshot := snapshotViper()
    t.Cleanup(func() { restoreViper(snapshot) })

    viper.Set("port", 9090)
    // test code...
}
```

This approach is fragile — `AllSettings()` only captures the resolved values, not the binding state (defaults, env bindings, etc.). Prefer injection.
