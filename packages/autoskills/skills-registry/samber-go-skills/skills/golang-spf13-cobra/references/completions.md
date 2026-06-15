# Cobra Shell Completions Reference

Cobra generates shell completion scripts for bash, zsh, fish, and PowerShell automatically. Subcommand names and flag names are completed for free. You add completions for flag values and positional arguments.

## Built-in completion command

Cobra registers a `completion` subcommand automatically:

```bash
myapp completion bash   # generate bash script
myapp completion zsh    # generate zsh script
myapp completion fish   # generate fish script
myapp completion powershell

# Install (example for zsh):
myapp completion zsh > "${fpath[1]}/_myapp"
```

## ShellCompDirective

The `ShellCompDirective` controls shell behavior after your completion function returns:

| Directive | Meaning |
| --- | --- |
| `ShellCompDirectiveDefault` | Fall back to file completion after your results |
| `ShellCompDirectiveNoFileComp` | Disable file completion fallback |
| `ShellCompDirectiveNoSpace` | Don't add a space after the completion |
| `ShellCompDirectiveFilterFileExt(exts)` | Only show files with given extensions |
| `ShellCompDirectiveFilterDirs(dirs)` | Only show directories |
| `ShellCompDirectiveError` | Signal an error (show no completions) |

Combine with bitwise OR: `cobra.ShellCompDirectiveNoFileComp | cobra.ShellCompDirectiveNoSpace`.

Use `ShellCompDirectiveNoFileComp` whenever your list is exhaustive — it prevents the shell from appending irrelevant files.

## Static arg completions

```go
var getCmd = &cobra.Command{
    Use:       "get <resource>",
    ValidArgs: []string{"pod", "service", "deployment", "configmap"},
    Args:      cobra.OnlyValidArgs,
    RunE: func(cmd *cobra.Command, args []string) error { /* ... */ },
}
```

## Dynamic arg completions

```go
var getCmd = &cobra.Command{
    ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
        if len(args) > 0 {
            // first arg already provided — no more completions
            return nil, cobra.ShellCompDirectiveNoFileComp
        }
        resources, err := listResources(toComplete)
        if err != nil {
            return nil, cobra.ShellCompDirectiveError
        }
        return resources, cobra.ShellCompDirectiveNoFileComp
    },
}
```

`toComplete` is the prefix the user has typed so far — filter your results by it for responsive completions.

## Flag value completions

```go
func init() {
    rootCmd.RegisterFlagCompletionFunc("output", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
        return []string{"json\tJSON output", "yaml\tYAML output", "table\tTable output"}, cobra.ShellCompDirectiveNoFileComp
    })

    rootCmd.RegisterFlagCompletionFunc("namespace", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
        ns, err := listNamespaces()
        if err != nil {
            return nil, cobra.ShellCompDirectiveError
        }
        return ns, cobra.ShellCompDirectiveNoFileComp
    })
}
```

Descriptions after `\t` are shown in zsh and fish menus.

## Completion annotations

Mark a flag to complete as a file or directory:

```go
cmd.Flags().String("config", "", "config file")
cmd.MarkFlagFilename("config", "yaml", "yml", "json")  // only those extensions

cmd.Flags().String("dir", "", "output directory")
cmd.MarkFlagDirname("dir")
```

## Testing completions

```go
func TestCompletion(t *testing.T) {
    rootCmd.SetArgs([]string{"__complete", "get", ""})
    buf := new(bytes.Buffer)
    rootCmd.SetOut(buf)
    rootCmd.Execute()
    assert.Contains(t, buf.String(), "pod")
    assert.Contains(t, buf.String(), "service")
}
```

`__complete` is cobra's internal completion request verb. Pass the partial args as additional arguments.

## Disabling the completion command

```go
rootCmd.CompletionOptions.DisableDefaultCmd = true   // remove the completion subcommand
rootCmd.CompletionOptions.HiddenDefaultCmd = true    // keep it but hide from help
```
