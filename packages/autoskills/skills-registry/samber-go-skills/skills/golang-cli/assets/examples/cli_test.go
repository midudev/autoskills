package main

import (
	"bytes"
	"testing"

	"github.com/spf13/cobra"
)

// Test commands by executing them programmatically and capturing output.
// Use cmd.OutOrStdout() and cmd.ErrOrStderr() in commands (instead of
// os.Stdout / os.Stderr) so output can be captured in tests.

func executeCommand(root *cobra.Command, args ...string) (string, error) {
	buf := new(bytes.Buffer)
	root.SetOut(buf)
	root.SetErr(buf)
	root.SetArgs(args)
	err := root.Execute()
	return buf.String(), err
}

func TestServeCommand(t *testing.T) {
	tests := []struct {
		name    string
		args    []string
		want    string
		wantErr bool
	}{
		{
			name: "default port",
			args: []string{"serve"},
			want: "listening on :8080\n",
		},
		{
			name: "custom port",
			args: []string{"serve", "--port", "9090"},
			want: "listening on :9090\n",
		},
		{
			name:    "missing required flag",
			args:    []string{"serve", "--host", ""},
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := executeCommand(rootCmd, tt.args...)
			if (err != nil) != tt.wantErr {
				t.Errorf("error = %v, wantErr %v", err, tt.wantErr)
			}
			if !tt.wantErr && got != tt.want {
				t.Errorf("output = %q, want %q", got, tt.want)
			}
		})
	}
}
