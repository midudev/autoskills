// cmd/myapp/serve.go
package main

import (
	"fmt"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var serveCmd = &cobra.Command{
	Use:   "serve",
	Short: "Start the HTTP server",
	RunE: func(cmd *cobra.Command, args []string) error {
		port := viper.GetInt("port")
		fmt.Fprintf(cmd.OutOrStdout(), "listening on :%d\n", port)
		// start server...
		return nil
	},
}

func init() {
	rootCmd.AddCommand(serveCmd)
	serveCmd.Flags().IntP("port", "p", 8080, "port to listen on")
	viper.BindPFlag("port", serveCmd.Flags().Lookup("port"))
}

// For command groups, use AddGroup and set GroupID on commands:
//
//   rootCmd.AddGroup(&cobra.Group{ID: "management", Title: "Management Commands:"})
//   serveCmd.GroupID = "management"
