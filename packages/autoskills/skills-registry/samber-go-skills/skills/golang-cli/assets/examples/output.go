package main

import (
	"encoding/json"
	"fmt"
	"os"
	"text/tabwriter"

	"github.com/fatih/color"
	"github.com/spf13/cobra"
)

// === stdout vs stderr ===
// stdout: Program output (data, results). This is what gets piped.
// stderr: Logs, progress, errors, diagnostics. Not piped by default.

func outputExample(cmd *cobra.Command, result string, err error) {
	// Output data to stdout (pipeable)
	fmt.Fprintln(cmd.OutOrStdout(), result)

	// Logs and errors to stderr (use slog)
	// slog.Error("operation failed", "error", err)
}

// === Detecting Pipe vs Terminal ===

func isTerminal() bool {
	fi, err := os.Stdout.Stat()
	if err != nil {
		return false
	}
	return fi.Mode()&os.ModeCharDevice != 0
}

// === Machine-Readable Output ===
// Support --output flag for different output formats.

type User struct {
	ID   string
	Name string
}

func printUsers(cmd *cobra.Command, users []User) error {
	format, _ := cmd.Flags().GetString("output")
	switch format {
	case "json":
		enc := json.NewEncoder(cmd.OutOrStdout())
		enc.SetIndent("", "  ")
		return enc.Encode(users)
	case "plain":
		for _, u := range users {
			fmt.Fprintf(cmd.OutOrStdout(), "%s\t%s\n", u.ID, u.Name)
		}
	default: // "table"
		w := tabwriter.NewWriter(cmd.OutOrStdout(), 0, 0, 2, ' ', 0)
		fmt.Fprintln(w, "ID\tNAME")
		for _, u := range users {
			fmt.Fprintf(w, "%s\t%s\n", u.ID, u.Name)
		}
		w.Flush()
	}
	return nil
}

// === Colors ===
// Use fatih/color — it auto-disables when output is not a terminal.

func colorExamples(cmd *cobra.Command, env string, err error) {
	color.Green("Success: deployed to %s", env)
	color.Red("Error: %v", err)

	// Or for reusable styles
	success := color.New(color.FgGreen, color.Bold).SprintFunc()
	fmt.Fprintf(cmd.OutOrStdout(), "%s deployed\n", success("v1.2.3"))
}
