package main

import (
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

func flagExamples() {
	// === Persistent vs Local ===

	// Persistent — inherited by all subcommands
	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file path")

	// Local — only for this command
	serveCmd.Flags().IntP("port", "p", 8080, "port to listen on")

	// === Required Flags ===

	serveCmd.Flags().String("host", "", "hostname to bind to")
	serveCmd.MarkFlagRequired("host")

	// Mutually exclusive flags
	rootCmd.MarkFlagsMutuallyExclusive("json", "yaml")

	// At least one required
	rootCmd.MarkFlagsOneRequired("output-file", "stdout")

	// === Flag Validation with RegisterFlagCompletionFunc ===

	serveCmd.Flags().String("env", "dev", "environment (dev, staging, prod)")
	serveCmd.RegisterFlagCompletionFunc("env", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		return []string{"dev", "staging", "prod"}, cobra.ShellCompDirectiveNoFileComp
	})

	// === Always Bind Flags to Viper ===
	// This ensures viper.GetInt("port") returns the flag value, env var MYAPP_PORT,
	// or config file value — whichever has highest precedence.

	serveCmd.Flags().IntP("port", "p", 8080, "port to listen on")
	viper.BindPFlag("port", serveCmd.Flags().Lookup("port"))
}
