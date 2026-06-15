// cmd/myapp/version.go
package main

import (
	"fmt"
	"runtime/debug"

	"github.com/spf13/cobra"
)

// Set via ldflags
var (
	version = "dev"
	commit  = "unknown"
	date    = "unknown"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print version information",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Fprintf(cmd.OutOrStdout(), "myapp %s (commit: %s, built: %s)\n", version, commit, date)

		if info, ok := debug.ReadBuildInfo(); ok {
			fmt.Fprintf(cmd.OutOrStdout(), "go: %s\n", info.GoVersion)
		}
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}

// Build with:
//
//   go build -ldflags "-X github.com/you/myapp/cmd/myapp.version=1.2.3 \
//     -X github.com/you/myapp/cmd/myapp.commit=$(git rev-parse --short HEAD) \
//     -X github.com/you/myapp/cmd/myapp.date=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
//     -o bin/myapp ./cmd/myapp
