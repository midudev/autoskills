# Viper WatchConfig and Hot Reload

## Basic setup

```go
viper.WatchConfig()
viper.OnConfigChange(func(e fsnotify.Event) {
    log.Printf("config changed: %s (op: %s)", e.Name, e.Op)
    // re-read affected values and apply them
})
```

`WatchConfig` starts a background goroutine that watches the config file using fsnotify. Call it after `ReadInConfig`.

## The atomic-rename trap

Most editors (vim, neovim, many CI tools) write config files by creating a new file and then renaming it over the old one. This replaces the inode that fsnotify is watching — the watch may not fire, or may fire with `Op: RENAME` instead of `Op: WRITE`, or may fire twice.

**Test hot reload with direct file writes, not editor saves:**

```go
// reliable in tests:
os.WriteFile("config.yaml", newContent, 0644)

// unreliable for testing:
// opening vim and :w — may trigger RENAME instead of WRITE
```

In production, this is less of an issue if your config management tool (Kubernetes ConfigMap volume mount, Consul Template, etc.) is aware of inode behavior.

## Race-safe reload pattern

Config reload happens in a background goroutine. Any shared state updated in `OnConfigChange` must be synchronized:

```go
type Config struct {
    mu       sync.RWMutex
    LogLevel string `mapstructure:"log_level"`
    MaxConn  int    `mapstructure:"max_conn"`
}

var cfg Config

viper.OnConfigChange(func(e fsnotify.Event) {
    var newCfg Config
    if err := viper.Unmarshal(&newCfg); err != nil {
        log.Printf("error reloading config: %v", err)
        return  // keep old config on error
    }

    cfg.mu.Lock()
    cfg.LogLevel = newCfg.LogLevel
    cfg.MaxConn = newCfg.MaxConn
    cfg.mu.Unlock()

    log.Printf("config reloaded: log_level=%s", newCfg.LogLevel)
})
```

Reads use `appCfg.mu.RLock()`. Never read directly from viper in hot paths during reload — the window between `OnConfigChange` firing and viper updating its internal state is non-deterministic.

## Debouncing rapid changes

Some filesystems fire multiple events per save. Debounce to avoid reloading multiple times:

```go
var reloadTimer *time.Timer
var reloadMu sync.Mutex

viper.OnConfigChange(func(e fsnotify.Event) {
    reloadMu.Lock()
    defer reloadMu.Unlock()
    if reloadTimer != nil {
        reloadTimer.Stop()
    }
    reloadTimer = time.AfterFunc(100*time.Millisecond, func() {
        applyNewConfig()
    })
})
```

## Validating config before applying

Always validate reloaded config before applying it — an invalid config mid-reload should keep the previous working config:

```go
viper.OnConfigChange(func(e fsnotify.Event) {
    var candidate Config
    if err := viper.Unmarshal(&candidate); err != nil {
        log.Printf("reload: invalid config, keeping previous: %v", err)
        return
    }
    if err := validate(candidate); err != nil {
        log.Printf("reload: validation failed, keeping previous: %v", err)
        return
    }
    applyConfig(candidate)
})
```

## Stopping the watcher

There is no documented way to stop `WatchConfig` once started. Design your application so that the watcher's lifetime matches the process lifetime. For testing, create a new `viper.New()` instance per test — the watcher is per-instance and is garbage-collected with the instance.
