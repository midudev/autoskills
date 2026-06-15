// cmd/myapp/root.go
package main

import (
	"fmt"
	"log/slog"
	"os"
	"strings"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var cfgFile string

var rootCmd = &cobra.Command{
	Use:   "myapp",
	Short: "A brief description of your application",
	Long:  "A longer description with usage examples.",
	PersistentPreRunE: func(cmd *cobra.Command, args []string) error {
		return initConfig()
	},
	SilenceUsage:  true, // don't print usage on errors from RunE
	SilenceErrors: true, // handle error printing yourself
}

func Execute() error {
	return rootCmd.Execute()
}

func init() {
	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default $HOME/.myapp.yaml)")
	rootCmd.PersistentFlags().String("log-level", "info", "log level (debug, info, warn, error)")
	viper.BindPFlag("log-level", rootCmd.PersistentFlags().Lookup("log-level"))
}

func initConfig() error {
	if cfgFile != "" {
		viper.SetConfigFile(cfgFile)
	} else {
		home, err := os.UserHomeDir()
		if err != nil {
			return fmt.Errorf("finding home directory: %w", err)
		}
		viper.AddConfigPath(home)
		viper.AddConfigPath(".")
		viper.SetConfigName(".myapp")
		viper.SetConfigType("yaml")
	}

	viper.SetEnvPrefix("MYAPP")
	viper.SetEnvKeyReplacer(strings.NewReplacer("-", "_"))
	viper.AutomaticEnv()

	if err := viper.ReadInConfig(); err != nil {
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			return fmt.Errorf("reading config: %w", err)
		}
	}

	// Set up logging based on config
	level := slog.LevelInfo
	switch strings.ToLower(viper.GetString("log-level")) {
	case "debug":
		level = slog.LevelDebug
	case "warn":
		level = slog.LevelWarn
	case "error":
		level = slog.LevelError
	}
	slog.SetDefault(slog.New(slog.NewTextHandler(os.Stderr, &slog.HandlerOptions{Level: level})))

	return nil
}
