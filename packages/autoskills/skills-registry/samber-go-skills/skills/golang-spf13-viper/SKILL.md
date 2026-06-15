---
name: golang-spf13-viper
description: "Golang configuration library using spf13/viper — layered precedence (flag > env > file > KV > default), BindPFlag/BindPFlags, SetEnvPrefix + SetEnvKeyReplacer + AutomaticEnv, ReadInConfig + ConfigFileNotFoundError, Unmarshal + mapstructure struct tags, Sub for sub-trees, WatchConfig + OnConfigChange for hot reload, viper.New() for test isolation, and remote KV integration. Apply when using or adopting spf13/viper, or when the codebase imports `github.com/spf13/viper`. For CLI command structure alongside viper, see the `samber/cc-skills-golang@golang-spf13-cobra` skill. For general CLI architecture, see `samber/cc-skills-golang@golang-cli`."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.0.1"
  openclaw:
    emoji: "🔧"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
    skill-library-version: "1.21.0"
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch mcp__context7__resolve-library-id mcp__context7__query-docs
---

**Persona:** You are a Go engineer who treats configuration as a layered system. Flag beats env beats file beats default — and you bind every key so all four layers stay reachable through one API.

# Using spf13/viper for layered configuration in Go

Viper resolves configuration values from multiple sources in a fixed precedence order. It has no user-facing surface — it doesn't define commands or flags. Its job is to answer "what is the value of key X right now?" by walking its source layers from highest to lowest priority.

**Official Resources:**

- [pkg.go.dev/github.com/spf13/viper](https://pkg.go.dev/github.com/spf13/viper)
- [github.com/spf13/viper](https://github.com/spf13/viper)

This skill is not exhaustive. Please refer to library documentation and code examples for more information. Context7 can help as a discoverability platform.

```bash
go get github.com/spf13/viper@latest
```

## Viper vs. cobra

Cobra owns the command tree — subcommands, flags, arg validation, completions. Viper owns configuration resolution — it answers "what is the value of key X?" by walking its source layers. Viper has no user-facing surface; it is purely a key-value resolver. Use cobra alone for flag-only CLIs; viper alone for config-file daemons; both when you need both, binding flags at `PersistentPreRunE` via `BindPFlag`.

→ See `samber/cc-skills-golang@golang-spf13-cobra` for the cobra side of this integration.

## The precedence pipeline

Viper resolves a key by walking sources in this order (first set value wins):

```
1. explicit Set()      — viper.Set("key", val)    highest priority
2. flag                — bound pflag.Flag
3. env var             — BindEnv / AutomaticEnv
4. config file         — ReadInConfig / MergeInConfig
5. KV remote           — etcd / Consul
6. default             — viper.SetDefault("key", val)   lowest priority
```

This pipeline is fixed and cannot be reordered. Understanding it prevents most viper bugs: a key that "should" come from a config file may be shadowed by an env var or a flag with a default value.

## Sources and config files

```go
viper.SetConfigName("config")
viper.AddConfigPath("$HOME/.myapp")
if err := viper.ReadInConfig(); err != nil {
    var notFound *viper.ConfigFileNotFoundError
    if !errors.As(err, &notFound) {
        return fmt.Errorf("reading config: %w", err) // propagate real errors only
    }
}
```

`ConfigFileNotFoundError` must be handled gracefully — config files are usually optional. An unhandled error from a missing file crashes programs that are perfectly valid when run with only flags or env vars.

For supported formats (JSON, TOML, YAML, HCL, INI, properties), `MergeInConfig`, and remote KV, see [sources-and-formats.md](references/sources-and-formats.md).

## Env binding and key replacers

This is the highest-bug-density area in viper. All three settings must be wired together — missing any one breaks nested key resolution:

```go
// ✓ Good — all three wired together at startup
viper.SetEnvPrefix("MYAPP")                             // prevent collisions: PORT → MYAPP_PORT
viper.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))  // database.host → MYAPP_DATABASE_HOST
viper.AutomaticEnv()

// ✗ Bad — without SetEnvKeyReplacer, viper looks for MYAPP_DATABASE.HOST (dot preserved)
```

For `BindEnv`, `AllowEmptyEnv`, and env-vs-default interaction, see [binding-and-env.md](references/binding-and-env.md).

## Flag binding (the cobra seam)

Bind cobra flags to viper in `init()` or `PersistentPreRunE` — never in `RunE` (config loading in `PersistentPreRunE` already ran before `RunE`, so bindings set in `RunE` are missed):

```go
func init() {
    rootCmd.PersistentFlags().Int("port", 8080, "listen port")
    viper.BindPFlag("port", rootCmd.PersistentFlags().Lookup("port"))
    // viper.BindPFlags(cmd.Flags()) — bind an entire FlagSet at once
}
```

For `AllowEmptyEnv` and flag/env interaction details, see [binding-and-env.md](references/binding-and-env.md).

## Unmarshaling into structs

`viper.Unmarshal` maps the resolved configuration into a struct using `mapstructure`:

```go
type Config struct {
    Port     int `mapstructure:"port"`
    Database struct {
        MaxConn int `mapstructure:"max_conn"` // explicit tag: mapstructure won't convert underscore→camelCase
    } `mapstructure:"database"`
}
var cfg Config
viper.Unmarshal(&cfg)
```

**Always use `mapstructure` tags** — implicit mapping is fragile for nested structs and underscore-named fields. Prefer `UnmarshalKey("database", &dbCfg)` over `Sub("database").Unmarshal` — it avoids the nil-check `Sub` requires when the key is missing.

For `time.Duration` / `net.IP` / slice decoders and custom `DecodeHook` registration, see [unmarshal.md](references/unmarshal.md).

## Sub-trees

`viper.Sub("database")` returns a new `*viper.Viper` scoped to the prefix, or **nil** if the key does not exist — always nil-check before calling methods on the result. Prefer `UnmarshalKey("database", &dbCfg)` which avoids the nil risk entirely.

## Hot reload

```go
viper.WatchConfig()
viper.OnConfigChange(func(e fsnotify.Event) { /* re-apply changed values */ })
```

`WatchConfig` uses fsnotify and watches inodes. Editors that write atomically via rename (vim, neovim) replace the inode — the callback may not fire. Test hot-reload with `echo >> config.yaml`, not editor saves. For race-safe reload patterns, see [watch-and-reload.md](references/watch-and-reload.md).

## Test isolation

**Never use the global viper in tests** — state leaks across test cases. Use `viper.New()` per test so each instance is isolated:

```go
v := viper.New()
v.SetConfigFile("testdata/config.yaml")
require.NoError(t, v.ReadInConfig())
```

For `t.Setenv` interactions and `Reset()` limitations, see [testing-and-isolation.md](references/testing-and-isolation.md).

## Best Practices

1. **Set prefix + key replacer + AutomaticEnv together** — missing any one causes nested env keys to silently not resolve (`database.host` → `DATABASE.HOST` instead of `DATABASE_HOST`).
2. **Handle `ConfigFileNotFoundError` gracefully** — a missing config file should not crash a service that runs with only flags and env vars.
3. **Always use `mapstructure` tags on config structs** — implicit mapping silently misses nested and underscore-named fields.
4. **Use `viper.New()` in tests, never the global** — the global accumulates state across test runs; per-test instances are isolated.
5. **Bind flags before `Execute()`** — binding in `RunE` is too late; cobra parses flags before `RunE` runs.

## Common Mistakes

| Mistake | Why it fails | Fix |
| --- | --- | --- |
| `AutomaticEnv` without `SetEnvKeyReplacer` | `database.host` looks for `MYAPP_DATABASE.HOST` (dot preserved) — never matches | Add `SetEnvKeyReplacer(strings.NewReplacer(".", "_"))` before `AutomaticEnv` |
| No `mapstructure` tags on struct fields | Silently misses nested and underscore-named fields | Add `mapstructure:"key_name"` to every field |
| Using global viper in tests | State from one test contaminates the next, causing flaky ordering | Create `viper.New()` per test |
| Missing `ConfigFileNotFoundError` check | Missing config file crashes a service that should run on flags/env alone | `errors.As(err, &notFound)` — only propagate non-not-found errors |

## Further Reading

- [sources-and-formats.md](references/sources-and-formats.md) — supported file formats, multi-path search, MergeInConfig, remote KV (etcd/Consul)
- [binding-and-env.md](references/binding-and-env.md) — BindEnv, AutomaticEnv, SetEnvPrefix, SetEnvKeyReplacer, AllowEmptyEnv, timing rules
- [unmarshal.md](references/unmarshal.md) — Unmarshal, UnmarshalKey, mapstructure tags, custom DecodeHooks (Duration, IP, slice)
- [watch-and-reload.md](references/watch-and-reload.md) — WatchConfig, OnConfigChange, fsnotify caveats, atomic-rename trap, race-safe patterns
- [testing-and-isolation.md](references/testing-and-isolation.md) — viper.New() per test, t.Setenv interactions, Reset() limitations, snapshot/restore

## Cross-References

- → See `samber/cc-skills-golang@golang-cli` skill for general CLI architecture — project layout, exit codes, signal handling, cobra+viper integration
- → See `samber/cc-skills-golang@golang-spf13-cobra` skill for the cobra side of this integration (flag definition and binding)
- → See `samber/cc-skills-golang@golang-testing` skill for general Go testing patterns

If you encounter a bug or unexpected behavior in spf13/viper, open an issue at <https://github.com/spf13/viper/issues>.
