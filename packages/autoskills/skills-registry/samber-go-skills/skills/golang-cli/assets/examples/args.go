package main

import (
	"fmt"

	"github.com/spf13/cobra"
)

// Cobra provides built-in validators for positional arguments.
// See the table in SKILL.md for all available validators.
var deployCmd = &cobra.Command{
	Use:   "deploy [environment]",
	Short: "Deploy to an environment",
	Args:  cobra.ExactArgs(1),
	RunE: func(cmd *cobra.Command, args []string) error {
		env := args[0]
		_ = env
		// deploy...
		return nil
	},
}

// Custom validation example:
var deployWithValidationCmd = &cobra.Command{
	Use:   "deploy [environment]",
	Short: "Deploy to an environment",
	Args: func(cmd *cobra.Command, args []string) error {
		if len(args) != 1 {
			return fmt.Errorf("expected exactly 1 argument, got %d", len(args))
		}
		valid := map[string]bool{"dev": true, "staging": true, "prod": true}
		if !valid[args[0]] {
			return fmt.Errorf("invalid environment %q, must be one of: dev, staging, prod", args[0])
		}
		return nil
	},
	RunE: func(cmd *cobra.Command, args []string) error {
		// deploy...
		return nil
	},
}
