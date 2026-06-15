# Cobra Documentation and Scaffolding Generators

## Doc generation

Cobra can generate documentation from your command tree in multiple formats. Import the `cobra/doc` sub-package:

```bash
go get github.com/spf13/cobra/doc
```

### Markdown

```go
import "github.com/spf13/cobra/doc"

err := doc.GenMarkdownTree(rootCmd, "/tmp/docs/")
// generates /tmp/docs/myapp.md, /tmp/docs/myapp_serve.md, etc.

// Single command
var buf bytes.Buffer
doc.GenMarkdown(rootCmd, &buf)
```

### Man pages

```go
header := &doc.GenManHeader{
    Title:   "MYAPP",
    Section: "1",
    Date:    &time.Time{},
    Source:  "myapp v1.0.0",
    Manual:  "User Commands",
}
err := doc.GenManTree(rootCmd, header, "/usr/local/share/man/man1/")
```

### YAML

```go
err := doc.GenYamlTree(rootCmd, "/tmp/docs/")
```

### RST (reStructuredText)

```go
err := doc.GenReSTTree(rootCmd, "/tmp/docs/")
```

## cobra-cli scaffolder

`cobra-cli` generates command files and wires them into your project:

```bash
go get -tool github.com/spf13/cobra-cli@latest

# Initialize a new cobra project
go tool cobra-cli init myapp

# Add a subcommand
go tool cobra-cli add serve
go tool cobra-cli add migrate

# Add with a parent other than root
cobra-cli add list --parent serve
```

Generated files follow the standard pattern:

```go
// cmd/serve.go
var serveCmd = &cobra.Command{
    Use:   "serve",
    Short: "A brief description of your command",
    RunE: func(cmd *cobra.Command, args []string) error {
        return nil
    },
}

func init() {
    rootCmd.AddCommand(serveCmd)
}
```

`cobra-cli` is optional — many teams write command files by hand following the same pattern.

## Help and usage template customization

Override the default help template:

```go
rootCmd.SetHelpTemplate(`
Usage:  {{.UseLine}}
{{if .HasAvailableSubCommands}}
Commands:
{{range .Commands}}{{if .IsAvailableCommand}}  {{rpad .Name .NamePadding }} {{.Short}}
{{end}}{{end}}{{end}}
Flags:
{{.LocalFlags.FlagUsages | trimRightSpace}}
`)
```

Override the usage function entirely:

```go
rootCmd.SetUsageFunc(func(cmd *cobra.Command) error {
    fmt.Fprintf(cmd.OutOrStdout(), "Custom usage for %s\n", cmd.Name())
    return nil
})
```

Common template functions available: `rpad`, `trimRightSpace`, `gt`, `eq`.
