# Testing Cobra Commands

## Basic test pattern

```go
func TestServeCmd(t *testing.T) {
    stdout := new(bytes.Buffer)
    stderr := new(bytes.Buffer)

    rootCmd.SetOut(stdout)
    rootCmd.SetErr(stderr)
    rootCmd.SetArgs([]string{"serve", "--port", "9090", "--dry-run"})

    err := rootCmd.Execute()
    require.NoError(t, err)
    assert.Contains(t, stdout.String(), "listening on :9090")
    assert.Empty(t, stderr.String())
}
```

## Isolation between tests

Cobra accumulates flag state across `Execute()` calls on the same command instance. Tests must be isolated.

### Option 1: Re-create the command tree per test (recommended for unit tests)

```go
func newRootCmd() *cobra.Command {
    root := &cobra.Command{Use: "myapp", SilenceUsage: true, SilenceErrors: true}
    root.AddCommand(newServeCmd())
    return root
}

func TestServeCmd(t *testing.T) {
    root := newRootCmd()
    root.SetArgs([]string{"serve", "--port", "9090"})
    err := root.Execute()
    require.NoError(t, err)
}
```

### Option 2: Reset flags between tests

```go
func TestWithReset(t *testing.T) {
    t.Cleanup(func() {
        rootCmd.ResetFlags()
        // re-define flags if needed
    })
}
```

Re-creating is safer — `ResetFlags` only clears the flag set, not subcommand state.

## Testing commands that write output

Commands must use `cmd.OutOrStdout()` / `cmd.ErrOrStderr()` instead of `os.Stdout` / `os.Stderr` for this to work.

```go
// In command handler:
func runServe(cmd *cobra.Command, args []string) error {
    fmt.Fprintln(cmd.OutOrStdout(), "Server started")
    fmt.Fprintln(cmd.ErrOrStderr(), "Debug: listening on port 8080")
    return nil
}

// In test:
buf := new(bytes.Buffer)
rootCmd.SetOut(buf)
rootCmd.Execute()
assert.Contains(t, buf.String(), "Server started")
```

## Golden file tests

For commands with structured or lengthy output, use golden files:

```go
func TestOutputFormat(t *testing.T) {
    buf := new(bytes.Buffer)
    rootCmd.SetOut(buf)
    rootCmd.SetArgs([]string{"list", "--output", "json"})
    require.NoError(t, rootCmd.Execute())

    golden := "testdata/list-json.golden"
    if *update {  // -update flag
        os.WriteFile(golden, buf.Bytes(), 0644)
    }
    want, _ := os.ReadFile(golden)
    assert.Equal(t, string(want), buf.String())
}
```

Run with `-update` to regenerate golden files after intentional output changes.

## Testing error paths

```go
func TestInvalidArgs(t *testing.T) {
    stderr := new(bytes.Buffer)
    rootCmd.SetErr(stderr)
    rootCmd.SetArgs([]string{"delete"})  // missing required arg

    err := rootCmd.Execute()
    assert.Error(t, err)
    assert.Contains(t, err.Error(), "accepts 1 arg")
}
```

## Table-driven command tests

```go
tests := []struct {
    name    string
    args    []string
    wantOut string
    wantErr bool
}{
    {"no flags", []string{"serve"}, "listening on :8080", false},
    {"custom port", []string{"serve", "--port", "9090"}, "listening on :9090", false},
    {"invalid port", []string{"serve", "--port", "abc"}, "", true},
}

for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) {
        root := newRootCmd()  // fresh command tree per test
        buf := new(bytes.Buffer)
        root.SetOut(buf)
        root.SetArgs(tt.args)
        err := root.Execute()
        if tt.wantErr {
            assert.Error(t, err)
        } else {
            require.NoError(t, err)
            assert.Contains(t, buf.String(), tt.wantOut)
        }
    })
}
```

## Testing completions

```go
func TestCompletion(t *testing.T) {
    root := newRootCmd()
    buf := new(bytes.Buffer)
    root.SetOut(buf)
    root.SetArgs([]string{"__complete", "delete", ""})
    root.Execute()

    assert.Contains(t, buf.String(), "pod")
    assert.Contains(t, buf.String(), "service")
}
```
