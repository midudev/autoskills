# Cobra Flags Reference

Cobra delegates all flag parsing to `github.com/spf13/pflag`. `cobra.Command` exposes two `*pflag.FlagSet`s:

- `cmd.Flags()` — local flags, only available on this command.
- `cmd.PersistentFlags()` — inherited by all subcommands.

## Common flag types

```go
// String
cmd.Flags().String("name", "default", "description")
cmd.Flags().StringP("name", "n", "default", "description")  // with shorthand

// With pointer binding (no Lookup needed later)
var name string
cmd.Flags().StringVar(&name, "name", "default", "description")
cmd.Flags().StringVarP(&name, "name", "n", "default", "description")

// Other types follow the same pattern:
cmd.Flags().Int / IntVar / IntVarP
cmd.Flags().Bool / BoolVar / BoolVarP
cmd.Flags().Float64 / Float64Var
cmd.Flags().Duration / DurationVar       // parses "1h30m", "500ms"
cmd.Flags().StringSlice / StringSliceVar // comma-separated or repeated flags
cmd.Flags().StringArray / StringArrayVar // repeated flags only (no comma splitting)
cmd.Flags().IntSlice / IntSliceVar
cmd.Flags().StringToString                // --label key=value --label k2=v2
```

## StringSlice vs StringArray

| Flag type     | Input                 | Result                            |
| ------------- | --------------------- | --------------------------------- |
| `StringSlice` | `--tags a,b --tags c` | `["a", "b", "c"]` — commas split  |
| `StringArray` | `--tags a,b --tags c` | `["a,b", "c"]` — commas NOT split |

Use `StringArray` when values may legitimately contain commas.

## Flag constraints

```go
// Fail if flag not provided
cmd.MarkFlagRequired("output")

// Fail if both provided
cmd.MarkFlagsMutuallyExclusive("json", "yaml", "table")

// Fail if none provided
cmd.MarkFlagsOneRequired("file", "stdin")

// Require flag only if another flag is set
cmd.MarkFlagsMutuallyExclusive("tls", "no-tls")
```

## Persistent flag patterns

```go
func init() {
    // global flags on root
    rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default: $HOME/.myapp.yaml)")
    rootCmd.PersistentFlags().StringVar(&logLevel, "log-level", "info", "log level (debug, info, warn, error)")

    // bind to viper immediately after defining
    viper.BindPFlag("config", rootCmd.PersistentFlags().Lookup("config"))
    viper.BindPFlag("log-level", rootCmd.PersistentFlags().Lookup("log-level"))
}
```

## Custom flag value types

Implement `pflag.Value` to parse arbitrary types:

```go
type enumValue struct {
    val     string
    allowed []string
}

func (e *enumValue) String() string { return e.val }
func (e *enumValue) Type() string   { return "enum" }
func (e *enumValue) Set(s string) error {
    for _, a := range e.allowed {
        if s == a {
            e.val = s
            return nil
        }
    }
    return fmt.Errorf("must be one of %v", e.allowed)
}

var outputFmt = &enumValue{val: "table", allowed: []string{"table", "json", "yaml"}}
cmd.Flags().Var(outputFmt, "output", "output format (table, json, yaml)")
```

## Flag groups (required together)

Mark a set of flags that must all be provided if any one of them is provided:

```go
cmd.Flags().String("tls-cert", "", "TLS certificate file")
cmd.Flags().String("tls-key", "", "TLS key file")
cmd.MarkFlagsRequiredTogether("tls-cert", "tls-key")
```

## Accessing flag values

Prefer pointer binding (`StringVar`, `IntVar`, etc.) for type-safe access. When you need the flag post-parse:

```go
port, err := cmd.Flags().GetInt("port")
name, err := cmd.Flags().GetString("name")
tags, err := cmd.Flags().GetStringSlice("tags")
```

## Flag changed vs default

```go
if cmd.Flags().Changed("port") {
    // user explicitly provided --port
    // useful when distinguishing "user set 0" from "flag not provided"
}
```

`Changed()` is also how viper knows which flags are explicit overrides — it only promotes a flag to the highest precedence layer if `Changed()` is true.
