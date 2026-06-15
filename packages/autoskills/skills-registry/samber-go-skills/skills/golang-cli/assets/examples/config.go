package main

import (
	"fmt"
	"log/slog"
	"os"
	"strings"

	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
)

// === Complete Cobra + Viper Integration ===

func initConfigComplete() error {
	// 1. Config file
	if cfgFile != "" {
		viper.SetConfigFile(cfgFile) // explicit path
	} else {
		home, _ := os.UserHomeDir()
		viper.AddConfigPath(home) // search $HOME
		viper.AddConfigPath(".")  // search current dir
		viper.SetConfigName(".myapp")
		viper.SetConfigType("yaml")
	}

	// 2. Environment variables
	viper.SetEnvPrefix("MYAPP")                            // MYAPP_PORT, MYAPP_LOG_LEVEL
	viper.SetEnvKeyReplacer(strings.NewReplacer("-", "_")) // log-level → MYAPP_LOG_LEVEL
	viper.AutomaticEnv()                                   // bind all env vars automatically

	// 3. Read config file (ignore "not found")
	if err := viper.ReadInConfig(); err != nil {
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			return fmt.Errorf("reading config: %w", err)
		}
	}

	return nil
}

// === Unmarshaling into Structs ===

type Config struct {
	Port     int    `mapstructure:"port"`
	Host     string `mapstructure:"host"`
	LogLevel string `mapstructure:"log-level"`
	Database struct {
		DSN     string `mapstructure:"dsn"`
		MaxConn int    `mapstructure:"max-conn"`
	} `mapstructure:"database"`
}

func loadConfig() (Config, error) {
	var cfg Config
	if err := viper.Unmarshal(&cfg); err != nil {
		return Config{}, fmt.Errorf("unmarshaling config: %w", err)
	}
	return cfg, nil
}

// === Watching Config File Changes ===
// For long-running CLIs (servers, daemons):

func watchConfig() {
	viper.OnConfigChange(func(e fsnotify.Event) {
		slog.Info("config file changed", "file", e.Name)
		// re-read and apply config
	})
	viper.WatchConfig()
}
